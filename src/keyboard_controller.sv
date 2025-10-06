// `include "flexcounter_if.svh" // CANNOT be included in the package, must be here

module keyboard_controller #(parameter int CLOCKDIVISOR = 1000) (
    input logic clk,
    nRST,
    input logic [7:0] keyValues,
    output logic [7:0] savedByte,
    output logic keyReady
);

  // localparam int CLOCKDIVISOR = 1000;  // placeholder value until I figure out what should be used
  localparam int CLOCKDIVIDERWIDTH = $clog2(CLOCKDIVISOR);
  localparam int STEADYCOUNTTHRESHOLD = 7; // how many counts need to be completed before the next one moves on
  typedef logic [7:0] myByte_t;

  logic [3:0] steadyCount; // counts how many periods of length CLOCKDIVISOR testingByte has held steady
  myByte_t testingByte; // the byte that is being tested to see if it is valid or still bouncing

  myByte_t n_savedByte;
  myByte_t n_testingByte;
  logic [3:0] n_steadyCount;
  logic  n_keyReady;

  // flexcounter_if #(.COUNTSIZE(CLOCKDIVISOR)) fcif (.clk(clk));
    flexcounter_if #(CLOCKDIVISOR) fcif (clk);
    flexcounter fc (fcif);
    assign fcif.nRST = nRST;
    assign fcif.enableCounter = 1;
    assign fcif.maxCount = CLOCKDIVISOR;

  always_comb begin : savedByteUpdater


    n_savedByte = savedByte;
    n_testingByte = testingByte;
    n_steadyCount = steadyCount;
    n_keyReady = 0;

    if(fcif.strobe) begin

      if(keyValues == testingByte) begin
        n_steadyCount = steadyCount + 1;
      end
      else begin
        n_steadyCount = 0;
        n_testingByte = keyValues;
      end

    end

    if(steadyCount == STEADYCOUNTTHRESHOLD) begin
      if(testingByte != savedByte) begin
        n_keyReady = 1;
        n_savedByte = testingByte;
        n_steadyCount = 0;
      end
    end
   

  end

  always_ff @(posedge clk) begin : keyboard_controller_ff
    if(!nRST) begin
      savedByte <= '0;
      testingByte <= '0;
      steadyCount <= '0;
      keyReady <= 0;
    end
    else begin
      savedByte <= n_savedByte;
      testingByte <= n_testingByte;
      steadyCount <= n_steadyCount;
      keyReady <= n_keyReady;
    end
  end

endmodule

  //
  // logic [CLOCKDIVIDERWIDTH-1:0] counter;
  // always_ff @(posedge clk, negedge nRST) begin : clockDivider
  //   if (!nRST) begin
  //     counter <= 0;
  //   end else if (counter == CLOCKDIVISOR) begin
  //     counter <= 0;
  //   end else begin
  //     counter <= counter + 1;
  //   end
  // end
  //
  // myByte_t savedByte;
  // myByte_t n_savedByte;
  // myByte_t [7:0] historyArray;
  // myByte_t [7:0] n_historyArray;
  //
  // always_ff @(posedge clk, negedge nRST) begin : keyHistoryUpdate
  //   if (!nRST) begin
  //     savedByte <= '0;
  //     historyArray <= '0;
  //   end else begin
  //     savedByte <= savedByte;
  //     historyArray <= n_historyArray;
  //   end
  //
  // end
  //
  //
  // generate
  //   genvar i;
  //   for (i = 0; i < 8; i++) begin : g_debounceArrayFiller
  //     assign n_historyArray[i] = (counter == 0) ? {historyArray[i][6:0], keyValues[i] } : historyArray[i];
  //     assign keysValid[i] = (historyArray[i] == 0) || (historyArray[i] == 8'hFF);
  //   end
  // endgenerate
  //
  // always_comb begin : newKeyDetector
  //   n_savedByte = savedByte;
  //   keyReady = 0;
  //   if ((keysValid == 8'hFF) && (savedByte != keyValues)) begin
  //     n_savedByte = keyValues;
  //     keyReady = 1;
  //   end
  // end
  //

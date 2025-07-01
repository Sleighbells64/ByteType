
module keyboard_controller (
    input logic clk,
    nRST,
    input logic [7:0] keyValues,
    output logic [7:0] savedByte,
    output logic keyReady
);

  localparam int CLOCKDIVISOR = 1000;  // placeholder value until I figure out what should be used
  localparam int CLOCKDIVIDERWIDTH = $clog2(CLOCKDIVISOR);
  typedef logic [7:0] myByte_t;

  logic [CLOCKDIVIDERWIDTH-1:0] counter;
  always_ff @(posedge clk, negedge nRST) begin : clockDivider
    if (!nRST) begin
      counter <= 0;
    end else if (counter == CLOCKDIVISOR) begin
      counter <= 0;
    end else begin
      counter <= counter + 1;
    end
  end

  myByte_t savedByte;
  myByte_t n_savedByte;
  myByte_t [7:0] historyArray;
  myByte_t [7:0] n_historyArray;

  always_ff @(posedge clk, negedge nRST) begin : keyHistoryUpdate
    if (!nRST) begin
      savedByte <= '0;
      historyArray <= '0;
    end else begin
      savedByte <= savedByte;
      historyArray <= n_historyArray;
    end

  end


  generate
    genvar i;
    for (i = 0; i < 8; i++) begin : g_debounceArrayFiller
      assign n_historyArray[i] = (counter == 0) ? {historyArray[i][6:0], keyValues[i] } : historyArray[i];
      assign keysValid[i] = (historyArray[i] == 0) || (historyArray[i] == 8'hFF);
    end
  endgenerate

  always_comb begin : newKeyDetector
    n_savedByte = savedByte;
    keyReady = 0;
    if ((keysValid == 8'hFF) && (savedByte != keyValues)) begin
      n_savedByte = keyValues;
      keyReady = 1;
    end
  end

endmodule

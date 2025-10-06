// includes gone due to vivado
module ps2_controller #(
  int CLKDIV = 1500; // 30MHZ / 3000 = 20khz (10khz due to 2 clk edges)
  ) (
input logic clk, nRST,
input logic keyReady,
input logic [7:0] savedByte,

input  logic kbClkIn, kbDataIn,
output logic kbClkOut, kbDataOut
);
  typedef enum logic [3:0] {IDLE, RECEIVING, RESPONDING, TRANSMITTING} state_e;

  logic enableCounter;
  flexcounter_if fcif #(CLKDIV) (clk);
  assign fcif.nRST = nRST;
  assign fcif.enableCounter = enableCounter;
  assign fcif.clear = !enableCounter;
  assign fcif.maxCount = CLKDIV;

  flexcounter fc (fcif);

  logic n_kbClkOut;
  logic [7:0] scanCode;

  ps2lut u1 (.key(savedByte[6:0]), .value(scanCode));


  always_ff @(posedge clk, negedge nRST) begin
    if(!nRST) begin
      kbClkOut = 1'b1;
      kbDataOut = 1'b0;

    end
    else begin

    end
    
  end


endmodule

  /*
  * pull the data line low, 
  * send the 8 data bits, 
  * send the parity bit, send
  * the stop bit
  */

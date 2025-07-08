`ifndef FLEXCOUNTER_IF
`define FLEXCOUNTER_IF


interface flexcounter_if #(
    int COUNTSIZE  = 1024
);
  localparam int COUNTWIDTH = $clog2(COUNTSIZE);
  logic clk, nRST;
  logic enableCounter;
  logic [COUNTWIDTH-1:0] maxCount;

  logic strobe;
  logic [COUNTWIDTH-1:0] count;

  modport counter(
      input clk,
      input nRST,
      input enableCounter,
      input maxCount,
      output strobe,
      output count
  );

  modport controller(
      output clk,
      output nRST,
      output enableCounter,
      output maxCount,
      input strobe,
      input count
  );

endinterface


`endif  // FLEXCOUNTER_IF

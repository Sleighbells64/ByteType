

interface flexcounter_if #(
    int COUNTSIZE  = 1024,
    int COUNTWIDTH = $clog2(COUNTSIZE)
)
( input logic clk);
  logic nRST;
  logic enableCounter;
  logic [COUNTWIDTH-1:0] maxCount;

  logic strobe;
  logic [COUNTWIDTH-1:0] count;

  modport counter(
      input nRST,
      input enableCounter,
      input maxCount,
      output strobe,
      output count
  );

  modport controller(
      output nRST,
      output enableCounter,
      output maxCount,
      input strobe,
      input count
  );

endinterface



`timescale 1ns / 1ps
// `include "flexcounter_if"

module flexcounter (
    flexcounter_if.counter fcif
);

  logic [fcif.COUNTWIDTH-1:0] n_count;


  always_comb begin : comb_flexcounter
    fcif.strobe = 0;
    n_count = 0;
    if (fcif.enableCounter) begin
      n_count = fcif.count + 1;
      if (fcif.count >= fcif.maxCount) begin  // >= in case maxCount moves
        n_count = 0;
        fcif.strobe = 1;  // strobe isn't registered explicitly, could cause trouble
      end
    end

  end


  always_ff @(posedge fcif.clk, negedge fcif.nRST) begin : ff_flexcounter
    if (!fcif.nRST) begin
      fcif.count <= 0;
    end else begin
      fcif.count <= n_count;
    end
  end

endmodule

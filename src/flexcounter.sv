`timescale 1ns / 1ps
// `include "flexcounter_if"

module flexcounter (
    flexcounter_if.counter fcif
);

  logic [fcif.COUNTWIDTH-1:0] n_count;


  always_comb begin : comb_flexcounter

    n_count = fcif.count;
    if(fcif.clear) begin
      n_count = 0;
    end
    else if (fcif.enableCounter) begin
      n_count = fcif.count + 1;
    end
    if (fcif.count >= fcif.maxCount) begin  // >= in case maxCount moves
      n_count = 1;
    end
  end


  always_ff @(posedge fcif.clk, negedge fcif.nRST) begin : ff_flexcounter
    if (!fcif.nRST) begin
      fcif.count <= 0;
    end else begin
      fcif.count <= n_count;

      if( fcif.enableCounter && (n_count == fcif.maxCount) ) begin
        fcif.strobe <= 1;
      end else begin
        fcif.strobe <= 0;
      end

    end
  end

endmodule

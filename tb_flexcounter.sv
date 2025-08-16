`timescale 1ns / 1ps

// `include "counterTest.svh"
// `include "flexcounter_if.svh" // CANNOT be included in the package, must be here
`include "counterUVM_pkg.sv"
// `include "flexcounter.sv"
import uvm_pkg::*;
import counterUVM_pkg::*;

module tb_flexcounter ();


  logic tb_clk = 0;
  initial begin
    forever #(PERIOD / 2) begin
      cycleCounter += tb_clk == 0; // increments the count when clk is low, so when it is a posedge
      tb_clk <= !tb_clk;  // cool oneliner to generate a clock
    end
  end


  flexcounter_if #(COUNTSIZE) fcif (tb_clk);

  flexcounter DUT (fcif);


  task automatic fillInterface(
  // fillInterface(.fcif(), .nRST(), .enableCounter(), .maxCount() )
    input logic nRST, input logic enableCounter,
    input logic [COUNTWIDTH-1:0] maxCount);
    fcif.nRST = nRST;
    fcif.enableCounter = enableCounter;
    fcif.maxCount = maxCount;
  endtask


  task automatic resetDUT();
    fillInterface(.nRST(1), .enableCounter(0), .maxCount(0));
    #(PERIOD * 1);  // wait a full cycle to make sure it resets
    @(negedge tb_clk);  // release on a negedge
    fcif.nRST = 1'b0;
  endtask

  initial begin
    $display("PERIOD is %d", PERIOD);
    uvm_config_db#(virtual flexcounter_if #(COUNTSIZE) )::set(null, "", "flexcounter_if", fcif); // needs to go first
    run_test("counterTest");
  end
  //   initial begin
  //     $dumpfile("waveform.vcd");
  //     $dumpvars(0, DUT);
  //     resetDUT();
  //     $display("%d", fcif.strobe);
  //
  //     // normal counting
  //     fillInterface(fcif, 1, 2);
  //     @(negedge tb_clk);
  //     @(negedge tb_clk);
  //     if (~fcif.strobe) begin
  //       $display("fcif.strobe = %d, failed to display", fcif.strobe);
  //     end
  //
  //     @(negedge tb_clk);
  //     if (fcif.strobe) begin
  //       $display("fcif.strobe = %d, failed to clear", fcif.strobe);
  //     end
  //     @(negedge tb_clk);
  //     @(negedge tb_clk);
  //     if (~fcif.strobe) begin
  //       $display("fcif.strobe = %d, failed to display 2nd time", fcif.strobe);
  //     end
  //
  //
  //     #100 $finish;
  //   end
  //
endmodule

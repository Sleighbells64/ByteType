`timescale 1ns / 1ps
int PERIOD = 20ns; // may want to define this globally in the future

module tb_keyboard_controller ();
  
logic tb_clk = 0;
logic tb_nRST = 0;
logic [7:0] tb_keyValues;
logic [7:0] tb_savedByte;
logic tb_keyReady;

int cycleCounter = 0;

int TB_CLOCKDIVISOR = 10;  // actual CLOCKDIVISOR will probably be O(1000)
int TB_CLOCKDIVIDERWIDTH = $clog2(TB_CLOCKDIVISOR); // take from DUT
int TB_STEADYCOUNTTHRESHOLD = 7; // take from DUT

keyboard_controller #(TB_CLOCKDIVISOR) DUT (.clk(tb_clk), .nRST(tb_nRST), .keyValues(tb_keyValues), .savedByte(tb_savedByte), .keyReady(tb_keyReady));


  initial begin
    forever #(PERIOD / 2) begin
      cycleCounter += tb_clk == 0; // increments the count when clk is low, so when it is a posedge
      tb_clk <= !tb_clk;  // cool oneliner to generate a clock
    end
  end

  task automatic resetDUT();
    tb_nRST = 0;
    @(negedge tb_clk);  // wait a full cycle to make sure it resets
    tb_nRST = 1;
  endtask

  always @(posedge tb_keyReady) begin
    $display($sformatf("keyReady high on cycle %d", cycleCounter) );
  end

  initial begin
    resetDUT();
    tb_keyValues = 8'h48;
    #(PERIOD * 90 ); // tb_keyReady should pulse on 81


  end

endmodule

`timescale 1ns / 1ps
int PERIOD = 20ns; // may want to define this globally in the future

module tb_keyboard_controller ();
  
logic tb_clk = 0;
logic tb_nRST = 0;
logic [7:0] tb_keyValues;
logic [7:0] tb_savedByte;
logic tb_keyReady;

int cycleCounter = 0;

localparam int TBCLOCKDIVISOR = 10;  // actual CLOCKDIVISOR will probably be O(1000)
int TB_CLOCKDIVIDERWIDTH = $clog2(TBCLOCKDIVISOR); // take from DUT
int TB_STEADYCOUNTTHRESHOLD = 7; // take from DUT

keyboard_controller #(TBCLOCKDIVISOR) DUT (.clk(tb_clk), .nRST(tb_nRST), .keyValues(tb_keyValues), .savedByte(tb_savedByte), .keyReady(tb_keyReady));


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

  // BEGIN ASSERTIONS ******************************
  // sequence help_keyValueStable;
  //   @(posedge tb_clk);
  //  ( $stable(tb_keyValues) [*70] );
  // endsequence
  property mustPulse;
    @(posedge tb_clk) ( !($stable(tb_keyValues)) |-> ##[72:82] $rose(tb_keyReady) ) or ( not ( ##1 $stable(tb_keyValues) [*80]) ); // if it is stable for 80 clock cycles, then it must pulse
  endproperty
  a_mustPulse: assert property(mustPulse);

  property stableTime;
    @(posedge tb_clk) ($stable(tb_keyValues) [*70]) or ##70 !(tb_keyReady); // all tb_keyReady pulses must have at least 70 cycles of stable tb_keyValues
  endproperty
  a_stableTime: assert property(stableTime);

  property noRepeats;
    @(posedge tb_clk) $rose(tb_keyReady) |-> ##1 $fell(tb_keyReady) |-> ##[69:$] $rose(tb_keyReady);
  endproperty
  a_noRepeats: assert property(noRepeats);
  // END ASSERTIONS ********************************



  initial begin
    resetDUT();
    tb_keyValues = 8'h48;
    // $display($sformatf("simulation should end here on cycle %d", cycleCounter) );
    #(PERIOD * 90 ); // tb_keyReady should pulse on 83
    tb_keyValues = 8'h45;
    #(PERIOD * 69 ); // tb_keyReady should NOT pulse
    tb_keyValues = 8'h4c;
    #(PERIOD * 80 ); // tb_keyReady should pulse
    tb_keyValues = 8'h4f;
    #(PERIOD * 160 ); // tb_keyReady should only pulse once

    $finish;
  end

endmodule

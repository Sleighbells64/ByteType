`timescale 1ns / 1ps
`include "uvm_macros.svh"
package counterUVM_pkg;

  import uvm_pkg::*;
  import counterUVM_pkg::COUNTSIZE;

  // set parameters for the testbench here so they can be used in the UVM
  parameter int PERIOD = 20;  // ns
  parameter int COUNTSIZE = 10000;
  parameter int COUNTWIDTH = $clog2(COUNTSIZE);
  int cycleCounter = 0;

  // forward declare all classees so it doesn't yell at me
  typedef class counterSeqItem;
  typedef class counterSequencer;
  typedef class counterDriver;
  typedef class counterMonitor;
  typedef class counterAgent;
  typedef class counterEnv;
  typedef class counterTest;
  typedef class counterSequence;
  typedef class counterScoreboard;


  // actually declare all classes
  `include "counterSeqItem.svh"
  `include "counterSequence.svh"
  `include "counterSequencer.svh"
  `include "counterDriver.svh"
  `include "counterMonitor.svh"
  `include "counterAgent.svh"
  `include "counterEnv.svh"
  `include "counterTest.svh"
  `include "counterScoreboard.svh"

endpackage

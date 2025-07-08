package counterUVM_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "flexcounter_if.svh"

  // forward declare all classees so it doesn't yell at me
  typedef class counterSeqItem;
  typedef class counterSequencer;
  typedef class counterDriver;
  typedef class counterAgent;
  typedef class counterEnv;
  typedef class counterTest;


  // actually declare all classes
  `include "counterAgent.svh"
  `include "counterDriver.svh"
  `include "counterEnv.svh"
  `include "counterSeqItem.svh"
  `include "counterSequencer.svh"
  `include "counterTest.svh"

endpackage

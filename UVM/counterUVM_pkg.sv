package counterUVM_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"


  // forward declare all classees so it doesn't yell at me
  typedef class counterSeqItem;
  typedef class counterSequencer;
  typedef class counterDriver;
  typedef class counterAgent;
  typedef class counterEnv;
  typedef class counterTest;
  typedef class counterSequence;


  // actually declare all classes
  `include "counterSeqItem.svh"
  `include "counterSequence.svh"
  `include "counterSequencer.svh"
  `include "counterDriver.svh"
  `include "counterAgent.svh"
  `include "counterEnv.svh"
  `include "counterTest.svh"

endpackage

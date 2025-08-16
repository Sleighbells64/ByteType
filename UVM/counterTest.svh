// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterEnv.svh"

class counterTest extends uvm_test;
  `uvm_component_utils(counterTest)


  counterEnv counterEnv_h; // _h stands for handle
  counterSequence counterSequence_h;
  function new(string name = "counterTest", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    counterEnv_h = counterEnv::type_id::create("counterEnv_h", this);
    counterSequence_h = counterSequence::type_id::create("counterSequence_h", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Hello World from counterTest", UVM_HIGH); // get_type_name == counterTest

    phase.raise_objection(this, "starting sequence in test run phase"); // I have spent about 5 hours debugging before realizing this raise_objection needed to be here.
      counterSequence_h.start(counterEnv_h.counterAgent_h.counterSequencer_h); // TODO make sure this line works
      #10;
    phase.drop_objection(this, "end of sequence in test run phase");
      

  endtask

endclass: counterTest


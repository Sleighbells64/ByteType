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
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterTest", UVM_INFO); // get_name == counterTest

    counterSequence_h.start(counterEnv_h.counterAgent_h.counterSequencer_h); // TODO make sure this line works

    phase.drop_objection(this);
  endtask

endclass: counterTest


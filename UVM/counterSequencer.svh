// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterSeqItem.svh"

class counterSequencer extends uvm_sequencer #(counterSeqItem);
  `uvm_component_utils(counterSequencer)

  function new(string name = "counterSequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterSequencer", UVM_INFO);
    phase.drop_objection(this);
  endtask : run_phase

endclass

// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterSeqItem.svh"

class counterDriver extends uvm_driver #(counterSeqItem);
    `uvm_component_utils(counterDriver)

  function new(string name = "counterDriver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterDriver", UVM_INFO);  // get_name=the handle == "counterDriver"
    phase.drop_objection(this);

    counterSeqItem seqItemObject;
    seq_item_port.get_next_item(seqItemObject);
    `uvm_info(get_name(), "received object", UVM_INFO);
    seq_item_port.item_done();

  endtask : run_phase

endclass : counterDriver

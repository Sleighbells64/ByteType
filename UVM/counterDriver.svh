// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterSeqItem.svh"

class counterDriver extends uvm_driver #(counterSeqItem);
    `uvm_component_utils(counterDriver)

  counterSeqItem seqItemObject;
  virtual flexcounter_if vif;

  function new(string name = "counterDriver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(virtual flexcounter_if)::get(this, "", "flexcounter_if", vif) ) begin
      `uvm_info(get_name(), "Driver successfully received the vif", UVM_INFO);
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterDriver", UVM_INFO);  // get_name=the handle == "counterDriver"
    phase.drop_objection(this);

    seq_item_port.get_next_item(seqItemObject);
      `uvm_info(get_name(), "received object", UVM_INFO);
    seq_item_port.item_done();

    $display("does the execute_seq_item task run?");
    execute_seq_item(seqItemObject);

  endtask : run_phase

  task execute_seq_item(counterSeqItem seqItem);
    @(negedge vif.clk);
    `uvm_info(get_name(), "execute_seq_item", UVM_INFO);
    seqItemObject.print();

  endtask

endclass : counterDriver

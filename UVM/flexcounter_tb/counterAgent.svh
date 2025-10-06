// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterDriver.svh"
// `include "counterSequencer.svh"

class counterAgent extends uvm_agent;
    `uvm_component_utils(counterAgent)
    counterSeqItem testSequenceItem;
    counterDriver counterDriver_h;
    counterSequencer counterSequencer_h;
    counterMonitor counterMonitor_h;

  function new(string name = "counterAgent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    counterDriver_h = counterDriver::type_id::create("counterDriver_h", this);
    counterSequencer_h = counterSequencer::type_id::create("counterSequencer_h", this);
    counterMonitor_h = counterMonitor::type_id::create("counterMonitor_h", this);

  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    counterDriver_h.seq_item_port.connect(counterSequencer_h.seq_item_export);

  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Hello World from counterAgent", UVM_HIGH);  // get_name=the handle == "counterAgent"

    // `uvm_create(testSequenceItem);
    testSequenceItem = counterSeqItem::type_id::create("testSequenceItem");
    // `uvm_do(testSequenceItem) // not sure this will work since I don't have a driver

  endtask : run_phase

endclass : counterAgent

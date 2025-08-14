import uvm_pkg::*;
import counterUVM_pkg::COUNTSIZE;
// `include "uvm_macros.svh"
// `include "counterSeqItem.svh"

class counterDriver extends uvm_driver #(counterSeqItem);
    `uvm_component_utils(counterDriver)

  counterSeqItem seqItemObject;
  virtual flexcounter_if #(COUNTSIZE) vif;

  function new(string name = "counterDriver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(virtual flexcounter_if #(COUNTSIZE))::get(this, "", "flexcounter_if", vif) ) begin
      `uvm_info(get_type_name(), "driver successfully received the vif", UVM_INFO);
    end
    else begin
      `uvm_error(get_type_name(), "failure driver did not receive the vif");
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "hello world from counterDriver", UVM_INFO);  // get_type_name=the handle == "counterDriver"

    seq_item_port.get_next_item(seqItemObject);
      `uvm_info(get_type_name(), "received object", UVM_INFO);
    $display("does the execute_seq_item task run?");
    // execute_seq_item(seqItemObject);
    seqItemObject.debugPrint;
    seq_item_port.item_done();
    vif.enableCounter = seqItemObject.enable;
    vif.maxCount = seqItemObject.maxCount;
    vif.enableCounter = seqItemObject.enable;
    for(int i = 0; i < seqItemObject.testLength; i++) begin
      @(negedge vif.clk);
    end
    #20; // make sure that this is outside of the forever loop


  endtask : run_phase

endclass : counterDriver

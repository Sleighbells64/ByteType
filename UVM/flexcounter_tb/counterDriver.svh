import uvm_pkg::*;
import counterUVM_pkg::COUNTSIZE;
import counterUVM_pkg::cycleCounter;
// `include "uvm_macros.svh"
// `include "counterSeqItem.svh"

class counterDriver extends uvm_driver #(counterSeqItem);
  `uvm_component_utils(counterDriver)

  counterSeqItem seqItemObject;
  counterSeqItem seqItemObjectCopy;
  virtual flexcounter_if #(COUNTSIZE) vif;
  uvm_analysis_port #(counterSeqItem) testcase_ap;


  function new(string name = "counterDriver", uvm_component parent);
    super.new(name, parent);
  endfunction : new


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(uvm_config_db#(virtual flexcounter_if #(COUNTSIZE))::get(this, "", "flexcounter_if", vif) ) begin
      `uvm_info(get_type_name(), "driver successfully received the vif", UVM_HIGH);
    end
    else begin
      `uvm_fatal(get_type_name(), "failure driver did not receive the vif");
    end

    testcase_ap = new("testcase_ap", this);

  endfunction : build_phase


  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "hello world from counterDriver", UVM_HIGH);  // get_type_name=the handle == "counterDriver"


    DUT_reset();
    forever begin
      seq_item_port.get_next_item(seqItemObject);
        `uvm_info(get_type_name(), "received object", UVM_HIGH);
        seqItemObject.debugPrint;

      // vif.enableCounter = seqItemObject.enable;
      // vif.maxCount = seqItemObject.maxCount;
      set_testcase();

      for(int i = 0; i < seqItemObject.testLength; i++) begin
        `uvm_info(get_type_name(), $sformatf("on cycle %d of %d", i, seqItemObject.testLength), UVM_HIGH);
        @(negedge vif.clk);
      end

      seq_item_port.item_done();
    end


  endtask : run_phase


  task DUT_reset();
    @(negedge vif.clk);
    vif.nRST = 0;
    @(negedge vif.clk);
    vif.nRST = 1;
  endtask: DUT_reset
  

  task set_testcase();
      vif.enableCounter = seqItemObject.enable;
      vif.maxCount = seqItemObject.maxCount;
      seqItemObject.CountAtStart = cycleCounter; // sets the starting point of the testcase
      seqItemObject.currentCount = vif.count; // lets the scoreboard know the starting point of the testcase

      seqItemObjectCopy = counterSeqItem::type_id::create("seqItemObjectCopy");
      seqItemObjectCopy.copy(seqItemObject);
      testcase_ap.write(seqItemObjectCopy);
  endtask: set_testcase


endclass : counterDriver

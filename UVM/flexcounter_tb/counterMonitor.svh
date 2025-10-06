import uvm_pkg::*;
import counterUVM_pkg::COUNTSIZE;
import counterUVM_pkg::cycleCounter;
class counterMonitor extends uvm_monitor;
  `uvm_component_utils(counterMonitor);

  uvm_analysis_port #(counterSeqItem) result_ap;
  virtual flexcounter_if #(COUNTSIZE) vif;

  function new(string name = "counterMonitor", uvm_component parent);
    super.new(name, parent);
    result_ap = new("result_ap", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(virtual flexcounter_if #(COUNTSIZE) )::get(this, "", "flexcounter_if", vif) ) begin
        `uvm_info(get_type_name(), "monitor successfully got vif", UVM_HIGH);
    end
    else begin
        `uvm_error(get_type_name(), "FAILURE monitor did not get vif");
    end
    
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    counterSeqItem transaction;
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Hello World from counterMonitor", UVM_HIGH);  // get_type_name == "counterMonitor"

      // @(posedge vif.clk); // delay 1 clock cycle to read after the driver sets it on the negedge
    forever begin
      @(posedge vif.clk);
      #1ns; // sample after the clock edge
        
      transaction = counterSeqItem::type_id::create("transaction");
      transaction.enable = vif.enableCounter;
      transaction.clear = vif.clear;
      transaction.currentCount = vif.count;
      transaction.strobe = vif.strobe;
      transaction.CountAtStart = cycleCounter;
      result_ap.write(transaction);

      // `uvm_info(get_type_name(), $sformatf("current cycle count = %d", cycleCounter), UVM_HIGH);

    end
    
  endtask : run_phase

  
endclass

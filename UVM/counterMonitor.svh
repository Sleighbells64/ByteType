import uvm_pkg::*;
import counterUVM_pkg::COUNTSIZE;
class counterMonitor extends uvm_monitor;
  `uvm_component_utils(counterMonitor);

  uvm_analysis_port #(counterSeqItem) result_ap;
  virtual flexcounter_if #(COUNTSIZE) vif;

  function new(string name = "counterMonitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(uvm_config_db#(virtual flexcounter_if #(COUNTSIZE) )::get(this, "", "flexcounter_if", vif) ) begin
        `uvm_info(get_type_name(), "monitor successfully got vif", UVM_LOW);
    end
    else begin
        `uvm_error(get_type_name(), "FAILURE monitor did not get vif");
    end
    
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Hello World from counterMonitor", UVM_LOW);  // get_type_name == "counterMonitor"
    // counterSeqItem transaction;

    forever begin
      @(posedge vif.clk);
      // transaction = counterSeqItem::type_id::create(.name("monitorTransaction"), .contxt(get_full_name()));
        
        `uvm_info(get_type_name(), "monitor should run here", UVM_LOW);
    end
    
  endtask : run_phase
  
endclass

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
        `uvm_info(get_type_name(), "monitor successfully got vif", UVM_INFO);
    end
    else begin
        `uvm_error(get_type_name(), "FAILURE monitor did not get vif");
    end
    
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Hello World from counterMonitor", UVM_INFO);  // get_type_name == "counterMonitor"

    forever begin
      @(posedge vif.clk);
        $display("monitor should run here");
    end
    
  endtask : run_phase
  
endclass

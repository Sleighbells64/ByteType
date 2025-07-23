class counterMonitor extends uvm_monitor;
  
  
  `uvm_component_utils(counterMonitor);

  function new(string name = "counterMonitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterMonitor", UVM_INFO);  // get_name=the handle == "counterAgent"
    phase.drop_objection(this);
    
  endtask : run_phase
  
endclass

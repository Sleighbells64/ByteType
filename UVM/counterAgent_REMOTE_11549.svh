import uvm_pkg::*;
`include "uvm_macros.svh"

class counterAgent extends uvm_agent;

  function new(string name = "counterAgent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_name(), "Hello World from counterAgent",
              UVM_INFO);  // get_name=the handle == "counterAgent"
    phase.drop_objection(this);
  endtask : run_phase

endclass : counterAgent


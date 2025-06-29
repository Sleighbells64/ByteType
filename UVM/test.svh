import uvm_pkg::*;
`include "uvm_macros.svh"

class mytest extends uvm_test;
  `uvm_component_utils(mytest)

  function new(string name = "mytest", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("ID_I", "Hello World", UVM_INFO);
    $display("hello world part 2");
    phase.drop_objection(this);

  endtask

endclass: mytest

import uvm_pkg::*
`include "uvm_macros.svh"

class test extends uvm_test;
  `uvm_component_utils(test)

  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("ID_I", "Hello World", UVM_INFO);
    $display("hello world part 2");
    phase.drop_objection(this);

  endfunction

endclass: test

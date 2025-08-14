// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterAgent.svh"

class counterEnv extends uvm_env;
    `uvm_component_utils(counterEnv)
    counterAgent counterAgent_h;
    // counterScoreboard counterScoreboard_h;

    function new(string name = "counterEnv", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        counterAgent_h = counterAgent::type_id::create("counterAgent_h", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
            `uvm_info(get_type_name(), "Hello World from counterEnv", UVM_INFO); // get_type_name=the handle == "counterEnv"
    endtask: run_phase


endclass: counterEnv


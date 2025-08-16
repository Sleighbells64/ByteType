// import uvm_pkg::*;
// `include "uvm_macros.svh"
// `include "counterAgent.svh"

class counterEnv extends uvm_env;
    `uvm_component_utils(counterEnv)
    counterAgent counterAgent_h;
    counterScoreboard counterScoreboard_h;

    function new(string name = "counterEnv", uvm_component parent);
        super.new(name, parent);


        set_report_verbosity_level_hier(UVM_MEDIUM); // set the verbosity here


    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        counterAgent_h = counterAgent::type_id::create("counterAgent_h", this);
        counterScoreboard_h = counterScoreboard::type_id::create("counterScoreboard_h", this);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      counterAgent_h.counterMonitor_h.result_ap.connect(counterScoreboard_h.resultPort);
      counterAgent_h.counterDriver_h.testcase_ap.connect(counterScoreboard_h.testcasePort);
      
    endfunction : connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
            `uvm_info(get_type_name(), "Hello World from counterEnv", UVM_HIGH); // get_type_name=the handle == "counterEnv"
    endtask: run_phase


endclass: counterEnv


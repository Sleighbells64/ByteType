// import uvm_pkg::*;
// `include "uvm_macros.svh"

class counterSeqItem extends uvm_sequence_item;
    // Control
    rand bit enable;
    rand int maxCount; // the max number to count to before setting strobe
    // Payload
    int currentCount;
    bit strobe; // = cycleCounter == enable && (startCount + maxCount)
    // Configuration
    rand int testLength; // the number of clock cycles this test will run for
    // Analysis
    int CountAtStart; // pulls from cycleCounter global variable, the global clock count at start


    `uvm_object_utils(counterSeqItem)

    function new(string name = "counterSeqItem");
      super.new(name);
      $display("Hello World from counterSeqItem"); // can't do 'uvm_info in noncomponents
    endfunction: new

    constraint positivelength_c {
    testLength > 0;
    }
    constraint positivemaxcount_c {
    maxCount > 0;
    }
endclass: counterSeqItem

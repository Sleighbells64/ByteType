// import uvm_pkg::*;
// `include "uvm_macros.svh"

class counterSeqItem extends uvm_sequence_item;
    // Control
    rand bit enable;
    rand bit clear;
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
      // $display("Hello World from counterSeqItem"); // can't do 'uvm_info in noncomponents
    endfunction: new

    function void debugPrint();
      $display("counterSeqItem debugPrint");
      $display("enable %d", enable);
      $display("maxCount %d", maxCount);
      $display("currentCount %d", currentCount);
      $display("testLength %d", testLength);
      $display("CountAtStart %d", CountAtStart);
      $display("strobe %d", strobe);
    endfunction

    constraint positivelength_c {
      testLength > 0;
    }
    constraint modestlength_c {
      testLength < 30;
    }

    constraint positivemaxcount_c {
      maxCount > 0;
    }
    constraint modestmaxcount_c {
      maxCount < 30;
    }



    virtual function void copy(counterSeqItem rhs);
      clear = rhs.clear;
      enable = rhs.enable;
      maxCount = rhs.maxCount;
      currentCount = rhs.currentCount;
      strobe = rhs.strobe;
      testLength = rhs.testLength;
      CountAtStart = rhs.CountAtStart;
    endfunction: copy 



endclass: counterSeqItem


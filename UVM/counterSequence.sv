import uvm_pkg::*;
`include "uvm_macros"

class counterSeqItem extends uvm_sequence_item;
    rand int startCount; // pulls from cycleCounter global variable, the global clock count when the test started
    rand int testLength; // the number of clock cycles this test will run for

    rand bit enable;
    rand bit strobe; // = cycleCounter == enable && (startCount + maxCount)
    rand int maxCount; // the max number to count to before setting strobe
endclass
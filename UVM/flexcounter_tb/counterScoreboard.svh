/* NOTE ABOUT THIS TESTBENCH
  * this testbench was written before I learned SVA.
  * while it is functional, it could be written more cleanly with SVA,
  * particularly the strobe detection, and count properties.
  * I believe the UVM architecture remains useful.
  * Usually a Scoreboard is divided into a predictor and comparator, I didn't
  * feel that was necessary for such a simple component
  * As this is a basic component, refactoring the code felt unnecessary.
*/

 class counterScoreboard extends uvm_scoreboard;
  `uvm_component_utils(counterScoreboard)
  `uvm_analysis_imp_decl(_TESTCASE)
  `uvm_analysis_imp_decl(_RESULT)

  uvm_analysis_imp_TESTCASE #(counterSeqItem, counterScoreboard) testcasePort;
  uvm_analysis_imp_RESULT #(counterSeqItem, counterScoreboard) resultPort;

  counterSeqItem currentTestCase;
  int carryOverCycles = 0;
  int nextCarryOverCycles = 0;

  function new(string name = "counterScoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    testcasePort = new("testcasePort", this);
    resultPort = new("resultPort", this);
    currentTestCase = counterSeqItem::type_id::create("currentTestCase");
    
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "hello world from counterScoreboard", UVM_HIGH);  // get_type_name=the handle == "counterScoreboard"
  endtask : run_phase




  virtual function write_TESTCASE(counterSeqItem seqItemObject);
    // seqItemObject.debugPrint();
    `uvm_info(get_type_name(), "write_TESTCASE runs now", UVM_HIGH);
    currentTestCase.copy(seqItemObject);

    carryOverCycles = (nextCarryOverCycles <= seqItemObject.maxCount) ? nextCarryOverCycles : 0;
    nextCarryOverCycles = (seqItemObject.clear == 1) ? 0 : (seqItemObject.enable == 1) ? (carryOverCycles + seqItemObject.testLength) % seqItemObject.maxCount : carryOverCycles; // clear -> 0, enabled -> (carry + len) % maxCount, NOT enabled -> carry
    // nextCarryOverCycles = (seqItemObject.enable == 1) ? (carryOverCycles + seqItemObject.testLength) % seqItemObject.maxCount : 0; // OLD FROM BEFORE ENABLE PAUSED

  endfunction: write_TESTCASE

  virtual function write_RESULT(counterSeqItem resultItem);
    // seqItemObject.debugPrint();
    int countError = 0;
    int strobeError = 0;
    int elapsedCycles = resultItem.CountAtStart - currentTestCase.CountAtStart + carryOverCycles;
    `uvm_info(get_type_name(), "write_RESULT runs now", UVM_HIGH);

    if(currentTestCase.enable == 0) begin
      if(resultItem.currentCount != carryOverCycles) begin // the current Count should stay at whatever carryOverCycles is for the entire testcase
        if( !(carryOverCycles == 0 && resultItem.currentCount == 1) ) begin // ignore when it rolls over, thats supposed to happen
          countError = 1;
        end
      end

      if(resultItem.strobe != 0) begin
        strobeError = 1;
      end
    end
    else begin

      if(resultItem.currentCount != elapsedCycles % currentTestCase.maxCount) begin
        if(  !( (elapsedCycles % currentTestCase.maxCount == 0) && (resultItem.currentCount == currentTestCase.maxCount) )  ) begin // makes sure it isn't just at the maxCount
          countError = 1;
        end
      end

      if(resultItem.strobe == 1) begin
        if( !(elapsedCycles % currentTestCase.maxCount == 0) ) begin 
          strobeError = 1;
        end
      end else if(elapsedCycles % currentTestCase.maxCount == 0) begin // strobe == 0
        if(elapsedCycles % currentTestCase.maxCount != 0) begin
          strobeError = 1;
        end
      end

    end

    if(strobeError) begin
      `uvm_error(get_type_name, $sformatf("strobe error on cycle %d", elapsedCycles) );
      
      `uvm_info(get_type_name(), "current Test Case", UVM_HIGH);
      currentTestCase.debugPrint();
      `uvm_info(get_type_name(), "current Result", UVM_HIGH);
      resultItem.debugPrint();

      `uvm_fatal(get_type_name, "crashout worthy");
    end
    if(countError) begin
      `uvm_error(get_type_name, $sformatf("count error on cycle %d, carryOverCycles = %d", elapsedCycles, carryOverCycles) ); //!TODO demote this back down to uvm_error after debugging
      // `uvm_error(get_type_name, $sformatf("count error on cycle %d", elapsedCycles) ) //!TODO demote this back down to uvm_error after debugging
      
      `uvm_info(get_type_name(), "current Test Case", UVM_HIGH);
      currentTestCase.debugPrint();
      `uvm_info(get_type_name(), "current Result", UVM_HIGH);
      resultItem.debugPrint();

      `uvm_fatal(get_type_name, "crashout worthy");
    end
  endfunction: write_RESULT

endclass


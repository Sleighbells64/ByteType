
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
    nextCarryOverCycles = (seqItemObject.enable == 1) ? (carryOverCycles + seqItemObject.testLength) % seqItemObject.maxCount : 0;

  endfunction: write_TESTCASE

  virtual function write_RESULT(counterSeqItem resultItem);
    // seqItemObject.debugPrint();
    int countError = 0;
    int strobeError = 0;
    int elapsedCycles = resultItem.CountAtStart - currentTestCase.CountAtStart + carryOverCycles;
    `uvm_info(get_type_name(), "write_RESULT runs now", UVM_HIGH);

    if(currentTestCase.enable == 0) begin
      if(resultItem.currentCount != 0) begin
        countError = 1;
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
        if(elapsedCycles != 0) begin
          strobeError = 1;
        end
      end

    end

    if(strobeError) begin
      `uvm_error(get_type_name, $sformatf("strobe error on cycle %d", elapsedCycles) )
      
      `uvm_info(get_type_name(), "current Test Case", UVM_HIGH);
      currentTestCase.debugPrint();
      `uvm_info(get_type_name(), "current Result", UVM_HIGH);
      resultItem.debugPrint();

    end
    if(countError) begin
      `uvm_error(get_type_name, $sformatf("count error on cycle %d", elapsedCycles) )
      
      `uvm_info(get_type_name(), "current Test Case", UVM_HIGH);
      currentTestCase.debugPrint();
      `uvm_info(get_type_name(), "current Result", UVM_HIGH);
      resultItem.debugPrint();

    end
  endfunction: write_RESULT

endclass


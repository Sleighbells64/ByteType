class counterSequence extends uvm_sequence #(counterSeqItem);
  `uvm_object_utils(counterSequence);

  counterSeqItem testItem;
  covergroup cg;
    enable_cp: coverpoint testItem.enable {
        bins enableSeq[] = (0,1 => 0,1); // checks to see if all sequences of enabled -> disabled have occurred
      }
    overflow_cp: coverpoint (testItem.maxCount < testItem.testLength) {
      bins overflowSeq[] = (0,1 => 0,1); // checks to see if all 2 level sequences of maxCount < testLength have appeared
    }

    combined_group : cross enable_cp, overflow_cp;

  endgroup


  function new(string name = "counterSequence");
    super.new(name);
    cg = new();
  endfunction: new

  task body();

    while(cg.get_coverage() < 95) begin // set it less than 1 to account for rounding errors in floats

      $display("coverage = %f", cg.get_coverage());
      testItem = counterSeqItem::type_id::create("testItem");
      start_item(testItem);
        testItem.randomize();
        cg.sample();
      finish_item(testItem);

    end
    // testItem = counterSeqItem::type_id::create("testItem");
    // start_item(testItem);
    // testItem.randomize();
    // testItem.maxCount = 30;
    // testItem.testLength = 40;
    // testItem.enable = 1;
    // finish_item(testItem);
    //
    // start_item(testItem);
    // testItem.randomize();
    // testItem.maxCount = 30;
    // testItem.testLength = 40;
    // testItem.enable = 1;
    // finish_item(testItem);
  endtask: body

endclass: counterSequence

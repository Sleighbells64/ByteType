class counterSequence extends uvm_sequence #(counterSeqItem);
  `uvm_object_utils(counterSequence);

  function new(string name = "counterSequence");
    super.new(name);
  endfunction

  task body();

    counterSeqItem testItem;
    testItem = counterSeqItem::type_id::create("testItem");
    start_item(testItem);
    testItem.randomize();
    finish_item(testItem);

  endtask

endclass

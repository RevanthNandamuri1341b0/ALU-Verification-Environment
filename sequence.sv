/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 21 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Sequence item 
*File Name : sequence.sv
*File ID : 777628
*Modified by : #your name#
*/

class base_sequence extends uvm_sequence#(alu_trans);
    int unsigned item_count;
      `uvm_object_utils(base_sequence);
  
      function new(string name = "base_sequence");
          super.new(name);
        set_automatic_phase_objection(1);//uvm-1.2 only
      endfunction: new
      
      extern virtual task pre_start();
      extern virtual task body();
  
  endclass: base_sequence
  
  task base_sequence::pre_start();
      if(!uvm_config_db#(int)::get(null, this.get_full_name, "item_count", item_count))
      begin
          `uvm_info(get_full_name(), "Item Count is not set in base test so default is set to 10", UVM_MEDIUM)
          item_count=10;
      end
  endtask: pre_start
  
  task base_sequence::body();
      bit[31:0] count;
      alu_trans ref_pkt;
      ref_pkt=alu_trans::type_id::create("ref_pkt");
      repeat(item_count)
      begin
          `uvm_create(req);
          assert (ref_pkt.randomize);
          req.copy(ref_pkt);
          start_item(req);
          finish_item(req);
          count++;
      end
  endtask: body
  
  
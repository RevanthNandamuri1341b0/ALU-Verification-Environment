/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Stimulus Driver
*File Name : drive.sv
*File ID : 161067
*Modified by : #your name#
*/


class driver extends uvm_driver#(alu_trans);
   `uvm_component_utils(driver);

   bit[31:0] pkt_id;
   virtual alu_if.tb vif;

   function new(string name = "driver", uvm_component parent);
       super.new(name, parent);
   endfunction: new

   extern task run_phase(uvm_phase phase);
   extern function void build_phase(uvm_phase phase);
   extern task drive(input alu_trans pkt);
   extern task reset_phase(uvm_phase phase);
   
endclass: driver

task driver::run_phase(uvm_phase phase);
   forever 
   begin
       seq_item_port.get_next_item(req);
       pkt_id++;
       `uvm_info("DRVR", $sformatf("Received transaction[%0d] From TLM port", pkt_id), UVM_MEDIUM)
       drive(req);
       seq_item_port.item_done();
       `uvm_info("DRVR", $sformatf("Transaction[%0d] DONE", pkt_id), UVM_MEDIUM)        
   end
endtask: run_phase

function void driver::build_phase(uvm_phase phase);
   super.build_phase(phase);
   uvm_config_db#(virtual alu_if.tb)::get(get_parent(), "", "drvr_if", vif);
   assert (vif!=null) else  `uvm_fatal(get_type_name(), "Virtual Interface is NULL");    
endfunction: build_phase

task driver::drive(input alu_trans pkt);
   @(vif.cb);
   `uvm_info(get_type_name(), "Transaction Started.....", UVM_HIGH)
   vif.cb.op_code  <= pkt.op;
   vif.cb.inp1     <= pkt.inp1;
   vif.cb.inp2     <= pkt.inp2;
   `uvm_info(get_type_name(), "Transaction Started.....", UVM_HIGH)
endtask: drive

task driver::reset_phase(uvm_phase phase);
   phase.raise_objection(this,"RESET obj RAISED");
   `uvm_info("RESET", "<Reset_phase> started, objection raised.", UVM_NONE)
   vif.reset<=1;
   repeat(2)@(vif.cb);
   vif.reset<=0;
   phase.drop_objection(this,"RESET obj DROPPED");
   `uvm_info("RESET", "<Reset_phase> finished, objection dropped.", UVM_NONE)
endtask: reset_phase



 
 
 
/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Test Case Creation
*File Name : test.sv
*File ID : 093282
*Modified by : #your name#
*/

class b_test extends uvm_test;
    `uvm_component_utils(b_test);
    //int item_count=50;
    environment env;

    function new(string name = "b_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual function void final_phase(uvm_phase phase);
    
endclass: b_test

function void b_test::build_phase(uvm_phase phase);

    super.build_phase(phase);
    env=environment::type_id::create("env",this);
    uvm_config_db#(virtual alu_if.tb)::set(this,"env.m_agent","drvr_if",top.alu_if_inst.tb);
    uvm_config_db#(virtual alu_if.tb_mon_in)::set(this,"env.m_agent","iMon_if",top.alu_if_inst.tb_mon_in);
    uvm_config_db#(virtual alu_if.tb_mon_out)::set(this,"env.s_agent","oMon_if",top.alu_if_inst.tb_mon_out);
    uvm_config_db#(int)::set(this,"env.m_agent.seqr.*", "item_count", 50);
    uvm_config_db#(uvm_object_wrapper)::set(this,"env.m_agent.seqr.main_phase","default_sequence",base_sequence::get_type());
endfunction: build_phase

task b_test::main_phase(uvm_phase phase);
    uvm_objection objection;
    super.main_phase(phase);
    objection =phase.get_objection();
    objection.set_drain_time(this,50ns);
endtask: main_phase

function void b_test::final_phase(uvm_phase phase);
    super.final_phase(phase);
endfunction: final_phase


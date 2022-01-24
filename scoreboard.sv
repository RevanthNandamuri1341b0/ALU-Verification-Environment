/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Match Mismatch Scoreboard
*File Name : scoreboard.sv
*File ID : 234118
*Modified by : #your name#
*/


class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard);

   uvm_analysis_port#(alu_trans)mon_in;
   uvm_analysis_port#(alu_trans)mon_out;
   uvm_in_order_class_comparator#(alu_trans)m_comp;

   function new(string name = "scoreboard", uvm_component parent);
       super.new(name, parent);
   endfunction: new

   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void report_phase(uvm_phase phase);
   

endclass: scoreboard

function void scoreboard::build_phase(uvm_phase phase);
   super.build_phase(phase);
   m_comp=uvm_in_order_class_comparator#(alu_trans)::type_id::create("m_comp",this);
   mon_in=new("mon_in",this);
   mon_out=new("mon_out",this);
endfunction: build_phase

function void scoreboard::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   mon_in.connect(m_comp.before_export);
   mon_out.connect(m_comp.after_export);
endfunction: connect_phase

function void scoreboard::report_phase(uvm_phase phase);
   super.report_phase(phase);
   `uvm_info(get_type_name(),$sformatf("Scoreboard completed with matches=%0d mismatches=%0d ",m_comp.m_matches,m_comp.m_mismatches),UVM_NONE);
endfunction: report_phase

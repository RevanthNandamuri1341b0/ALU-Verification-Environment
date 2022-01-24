/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Slave agent with passive agent
*File Name : slave_agent.sv
*File ID : 436225
*Modified by : #your name#
*/

class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent);

  oMonitor oMon;
uvm_analysis_port#(alu_trans) ap;

  function new(string name = "slave_agent", uvm_component parent);
      super.new(name, parent);
  endfunction: new

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);       

endclass: slave_agent

function void slave_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  ap=new("sagent_ap",this);
if(is_active==UVM_ACTIVE)begin   end
  oMon=oMonitor::type_id::create("oMon",this);
endfunction: build_phase

function void slave_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
if(is_active==UVM_ACTIVE)begin   end
  oMon.analysis_port.connect(this.ap);
endfunction: connect_phase


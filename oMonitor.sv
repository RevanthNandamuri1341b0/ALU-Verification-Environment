
/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Output Monitor
*File Name : oMonitor.sv
*File ID : 280188
*Modified by : #your name#
*/

class oMonitor extends uvm_component;
    `uvm_component_utils(oMonitor);
    virtual alu_if.tb_mon_out vif;
    uvm_analysis_port #(alu_trans) analysis_port;
    alu_trans pkt;
    
    function new(string name = "oMonitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new
 
    extern task run_phase(uvm_phase phase);
    extern function void build_phase(uvm_phase phase);
    
 endclass: oMonitor
 
 function void oMonitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual alu_if.tb_mon_out)::get(get_parent(),"","oMon_if",vif))
    begin `uvm_fatal(get_type_name(), "oMonitor SUT interface is not set") end
    analysis_port=new("oMon_analysis_port",this);
 endfunction: build_phase
 
 
      
 task oMonitor::run_phase(uvm_phase phase);
    forever begin
    @(vif.cb_mon_out.alu_out);
   if(vif.cb_mon_out.alu_out === 'z || vif.cb_mon_out.alu_out === 'x)
       continue;
    if(vif.reset==1) continue;
      
   pkt = alu_trans::type_id::create("pkt",this);
   pkt.alu_out= vif.cb_mon_out.alu_out;//output data
        `uvm_info(get_type_name(),$sformatf("pkt.alu_out=%0d",pkt.alu_out),UVM_MEDIUM);
   analysis_port.write(pkt);
     end
 
 endtask 
 
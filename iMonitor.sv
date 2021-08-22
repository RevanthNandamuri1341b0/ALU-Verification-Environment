/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Input Monitor
*File Name : iMonitor.sv
*File ID : 545064
*Modified by : #your name#
*/

class iMonitor extends uvm_monitor;
    `uvm_component_utils(iMonitor);
 
    virtual alu_if.tb_mon_in vif;
    
    uvm_analysis_port #(alu_trans) analysis_port;
    alu_trans pkt;
    
    function new(string name = "iMonitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new
 
    extern virtual task run_phase(uvm_phase phase);
    extern virtual function void build_phase(uvm_phase phase);
 
 endclass: iMonitor
 
 function void iMonitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual alu_if.tb_mon_in )::get(get_parent(), "", "iMon_if",vif))
    begin `uvm_fatal(get_type_name(), "iMonitor DUT interface is not set") end
    analysis_port=new("analysis_port",this);
 endfunction: build_phase
 
 task iMonitor::run_phase(uvm_phase phase);
    forever 
    begin
        @(vif.cb_mon_in.inp1 or vif.cb_mon_in.inp2 or vif.cb_mon_in.op_code);
        pkt=alu_trans::type_id::create("pkt",this);
        pkt.inp1 = vif.cb_mon_in.inp1;
        pkt.inp2 = vif.cb_mon_in.inp2;
        pkt.op   = vif.cb_mon_in.op_code;
        `uvm_info(get_type_name(),pkt.input2string(), UVM_MEDIUM);        
      analysis_port.write(pkt);
    end
 endtask: run_phase
 
 
 
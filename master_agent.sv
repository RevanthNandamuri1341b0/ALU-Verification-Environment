/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment 
*Domain : UVM
*Description : Master agent Which is active agent
*File Name : master_agent.sv
*File ID : 961033
*Modified by : #your name#
*/

class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent);
    driver drvr;
    iMonitor iMon;
    sequencer seqr;
  uvm_analysis_port#(alu_trans) ap;
 
    function new(string name = "master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new
 
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
 
 endclass: master_agent
 
 function void master_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap=new("magent_ap",this);
    if(is_active==UVM_ACTIVE)
    begin
        seqr=sequencer::type_id::create("seqr",this);
        drvr=driver::type_id::create("drvr",this);
    end
    iMon=iMonitor::type_id::create("iMon",this);
 endfunction: build_phase
 
 function void master_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active==UVM_ACTIVE)
    begin
        drvr.seq_item_port.connect(seqr.seq_item_export);
    end
    iMon.analysis_port.connect(this.ap);
 endfunction: connect_phase
 
 
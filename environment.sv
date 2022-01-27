/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Verification Environment to connect all component
*File Name : environment.sv
*File ID : 461758
*Modified by : #your name#
*/


class environment extends uvm_env;
    `uvm_component_utils(environment);

    bit[31:0] exp_drop_count;
    master_agent m_agent;
    slave_agent s_agent;
    scoreboard scb;
  	predictor pred_h;

    function new(string name = "environment", uvm_component parent);
        super.new(name, parent);
    endfunction: new

	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
	extern virtual function void extract_phase(uvm_phase phase);
	extern virtual function void report_phase(uvm_phase phase);
	
endclass: environment

function void environment::build_phase(uvm_phase phase);
	super.build_phase(phase);
	m_agent=master_agent::type_id::create("m_agent",this);
	s_agent=slave_agent::type_id::create("s_agent",this);
	scb=scoreboard::type_id::create("scb",this);
	pred_h=predictor::type_id::create("pred_h",this);
endfunction

function void environment::connect_phase(uvm_phase phase);
    m_agent.ap.connect(pred_h.analysis_export);
    pred_h.analysis_scb_port.connect(scb.mon_in);
    s_agent.ap.connect(scb.mon_out);
endfunction:connect_phase

function void environment::extract_phase(uvm_phase phase);
uvm_config_db#(bit [31:0])::get(this,"","exp_dropped_count",exp_drop_count);
endfunction:extract_phase

function void environment::report_phase(uvm_phase phase);
    //super.report_phase(phase);
    bit [31:0] exp_pkt_count,scb_received_pkt_count;
    uvm_config_db#(int)::get(null,"uvm_test_top.env.m_agent.seqr.*","item_count",exp_pkt_count);
    scb_received_pkt_count=scb.m_comp.m_mismatches+ scb.m_comp.m_matches;
    if((scb_received_pkt_count+exp_drop_count) != exp_pkt_count) 
    begin
        `uvm_info("env","==================================================",UVM_NONE);
        `uvm_error("FAILED","Test FAILED Due to packet count mismatch");
        `uvm_info("env",$sformatf("expected=%0d received_in_scb=%0d",exp_pkt_count,scb_received_pkt_count),UVM_NONE);
        `uvm_info("env",$sformatf("pkts_matched=%0d pkts_mismatched=%0d dropped=%0d",scb.m_comp.m_matches,scb.m_comp.m_mismatches,exp_drop_count),UVM_NONE);
        `uvm_info("env","==================================================",UVM_NONE);
    end
    else if(scb.m_comp.m_mismatches) 
    begin
        `uvm_info("env","==================================================",UVM_NONE);
        `uvm_error(get_type_name(),"Test FAILED ");
        `uvm_info("env",$sformatf("pkts_matched=%0d pkts_mismatched=%0d dropped=%0d",scb.m_comp.m_matches,scb.m_comp.m_mismatches,exp_drop_count),UVM_NONE);
        `uvm_info("env",$sformatf("pkts_matched=%0d pkts_mismatched=%0d",scb.m_comp.m_matches,scb.m_comp.m_mismatches),UVM_NONE);
        `uvm_info("env","==================================================",UVM_NONE);
    end 
    else
    begin 
        `uvm_info("env","==================================================",UVM_NONE);
        `uvm_info("PASSED","Test PASSED",UVM_NONE);
        `uvm_info("env",$sformatf("expected=%0d received_in_scb=%0d",exp_pkt_count,scb_received_pkt_count),UVM_NONE);
        `uvm_info("env",$sformatf("pkts_matched=%0d pkts_mismatched=%0d dropped=%0d",scb.m_comp.m_matches,scb.m_comp.m_mismatches,exp_drop_count),UVM_NONE);
        `uvm_info("env","==================================================",UVM_NONE);
    end
endfunction: report_phase
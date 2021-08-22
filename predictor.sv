/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Output stimulus predictor
*File Name : predictor.sv
*File ID : 586073
*Modified by : #your name#
*/


class predictor extends uvm_subscriber#(alu_trans);
    `uvm_component_utils(predictor);
 
    uvm_analysis_port#(alu_trans) analysis_scb_port;
    bit [31:0] prev_out;
    bit init_check;
    bit[31:0]exp_drop_count,pkt_id;
 
    function new(string name = "predictor", uvm_component parent);
        super.new(name, parent);
    endfunction: new
 
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void write(T t);
    extern virtual function void extract_phase(uvm_phase phase);
    
 endclass: predictor
 
 function void predictor::build_phase(uvm_phase phase);
    analysis_scb_port=new("predictor_port",this);
 endfunction: build_phase
 
 function void predictor::write(T t);
    alu_trans pkt;
    $cast(pkt, t.clone());
    pkt_id++;
    `uvm_info("Predictor", $sformatf("Received pkt[%0d] in Predictor",pkt_id), UVM_MEDIUM);
    pkt.alu_out=alu_dpi_model(pkt.inp1,pkt.inp2,pkt.op);
 
    if (prev_out == pkt.alu_out) 
    begin
       `uvm_warning("pkt_Drop","Previous output matches with current output");
        `uvm_info("pkt_Drop",$sformatf("Packet (%0d) will not be detected in output monitor",pkt_id),UVM_MEDIUM);
        `uvm_info("Drop",$sformatf("previous_output=%0d current_output=%0d",prev_out, pkt.alu_out),UVM_MEDIUM);
        exp_drop_count++;
    end
    else 
    begin
        `uvm_info("Predict OUT", pkt.input2string(), UVM_MEDIUM);
      analysis_scb_port.write(pkt);
    end
    prev_out=pkt.alu_out;
 endfunction: write
 
 function void predictor::extract_phase(uvm_phase phase);
  uvm_config_db#(bit[31:0])::set(null, "uvm_test_top.env", "exp_dropped_count", exp_drop_count);
 endfunction: extract_phase
 
 
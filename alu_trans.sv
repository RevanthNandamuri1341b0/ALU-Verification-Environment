/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 21 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Transaction packet
*File Name : alu_trans.sv
*File ID : 154147
*Modified by : #your name#
*/


`define WIDTH  4

class alu_trans extends uvm_sequence_item;
    typedef enum bit[2:0] {ADD=0,SUB=1,MUL=2,DIV=3,NOP=4} op_code_enum_t;
    
    
    //input stimulus
    rand logic[`WIDTH-1:0] inp1,inp2;
    randc logic [2:0] op;
    
    op_code_enum_t op_e;//control nope
    
    logic [(2*`WIDTH)-1:0] alu_out; //dut OP for comparison
    
    bit[`WIDTH-1:0]prev_inp1,prev_inp2;
    
    constraint valid 
    {
        inp1 inside {[1:5]};
        inp2 inside {[1:5]};
        op inside {[0:3]};
        inp1 != prev_inp1;
        inp2 != prev_inp2;
    }
    
    
    extern function void post_randomize();
    
    
    `uvm_object_utils_begin(alu_trans)
    `uvm_field_int(inp1,UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(inp2,UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(op,UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(alu_out,UVM_ALL_ON)
    `uvm_object_utils_end    
    
    extern virtual function string input2string();
    extern virtual function string convert2string();
    
    function new(string name = "alu_trans");
        super.new(name);
    endfunction: new
    
endclass: alu_trans

function string alu_trans::convert2string();
    return $sformatf("alu_out=%0d",alu_out);
endfunction: convert2string

function string alu_trans::input2string();
    op_e  = op_code_enum_t'(op);
    return $sformatf("op_code=%0s inp1=%0d inp2=%0d alu_out=%0d",op_e.name(),inp1,inp2,alu_out);
endfunction: input2string

function void alu_trans::post_randomize();
    prev_inp1=inp1;
    prev_inp2=inp2;
endfunction: post_randomize

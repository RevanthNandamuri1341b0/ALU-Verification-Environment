/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : ALU port Interface
*File Name : alu_if.sv
*File ID : 689125
*Modified by : #your name#
*/

interface alu_if (input clk);

    parameter reg [31:0] N=4;
    
    logic [N-1:0] inp1,inp2;
    logic [2:0]   op_code;
    logic         reset;
    
    logic [(2*N) -1:0] alu_out;
    
    //Driver clocking block
    clocking cb @(posedge clk);
    //Directions are w.r.t to testbench
    output  inp1,inp2;
    output  op_code;
    endclocking
    
    //Master monitor clocking block
    clocking cb_mon_in @(posedge clk);
    input  inp1,inp2;
    input  op_code;
    endclocking
    
    //Slave monitor clocking block
    clocking cb_mon_out @(posedge clk);
    input  alu_out;
    endclocking
    
    //modport for specifying directions
    modport tb      (clocking cb,output reset);
    modport tb_mon_in  (clocking cb_mon_in);
    modport tb_mon_out  (clocking cb_mon_out,input reset);
    
endinterface
/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Top Module
*File Name : top.sv
*File ID : 010879
*Modified by : #your name#
*/

`include "alu.v"
`include "if_alu.sv"
`include "program_alu.sv"

module top;

parameter reg [31:0] N=4;

bit clk;

always #10 clk=!clk;

alu_if   #(N) alu_if_inst (clk);
alu      #(N) dut_inst    (.clk(clk),
                           .reset(alu_if_inst.reset),
                           .op_code(alu_if_inst.op_code),
		           .inp1(alu_if_inst.inp1),
		           .inp2(alu_if_inst.inp2),
		           .outp(alu_if_inst.alu_out)
		           );

program_alu pgm_inst ();

endmodule

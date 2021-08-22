/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : ALU DUT in Verilog
*File Name : alu.v
*File ID : 831536
*Modified by : #your name#
*/

module alu(clk,reset,op_code,inp1,inp2,outp);
parameter N = 4;
input clk,reset;
input [N-1:0] inp1,inp2;
input [2:0] op_code;
output [(2*N)-1:0] outp;
reg [(2*N)-1:0] outp;

//parameter  ADD=2'b00, SUB=2'b01,MUL=2'b10,DIV=2'b11;
parameter  ADD=3'b000,SUB=3'b001,MUL=3'b010,DIV=3'b011,LOR=3'b100,LAND=3'b101;

always @ (posedge clk or posedge reset) begin
  if(reset) outp='0;
   else begin
    case (op_code)
	ADD :  outp= inp1 +  inp2;
	MUL :  outp= inp1 *  inp2;
	SUB :  outp= inp1 -  inp2;
    DIV :  outp= inp1 /  inp2;
	//LOR :  outp= inp1 | inp2;
	//AND : outp= inp1 & inp2;
	default outp = 'bz;
    endcase
   end
end


endmodule

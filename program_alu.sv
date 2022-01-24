/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 24 January 2022
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Program Block to overcome races conditions
*File Name : program_alu.sv
*File ID : 813882
*Modified by : #your name#
*/


`include "alu_env_pkg.pkg"
program program_alu();
    import uvm_pkg::*;
    import alu_env_pkg::*;

    `include "test.sv"

    initial 
    begin
        $timeformat(-9, 1, "ns", 10);
      run_test();
    end

endprogram //program_alu
/*
*Author : Revanth Sai Nandamuri
*GitHUB : https://github.com/RevanthNandamuri1341b0
*Date of update : 22 August 2021
*Project name : ALU Verification Environment
*Domain : UVM
*Description : Golden Reference To compare the output of the DUT
*File Name : alu_cmodel.c
*File ID : 073734
*Modified by : #your name#
*/

#include <svdpi.h>

unsigned int alu_dpi_model (unsigned int opa, unsigned int opb, unsigned int op)
{
  switch (op) {
    case 0: return opa + opb;
    case 1: return opa - opb;
    case 2: return opa * opb;
    case 3: return opa / opb;
  default: return 0;
  }
  return 0;
}
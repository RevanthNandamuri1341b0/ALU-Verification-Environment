# ALU-Verification-Environment

Development UVM Verification Environment for ALU DUT

## Setting in EDAPlayground

* Open [EDAPlayground](https://www.edaplayground.com/)

* Choose `SystemVerilog/Verilog` in **Testbench + Design**

* Choose `UVM 1.2 ` in  **OVM / UVM**

* Choose  ``Synopsys VCS 2020.03`` in **Tools and Simulator** 

* Add below code in **Compile options** 

    * `-timescale=1ns/1ns +vcs+flush+all +warn=all  -sverilog alu_cmodel.c`

* Add below code in **Run options**

    * `+UVM_TESTNAME=b_test`

#

### FOR REFERENCE CHECKOUT THIS LINK ---> [Master Reference](https://www.edaplayground.com/x/sbCN)
#

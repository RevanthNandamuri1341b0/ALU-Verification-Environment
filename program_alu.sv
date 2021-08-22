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
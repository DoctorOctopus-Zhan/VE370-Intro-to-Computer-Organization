`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 15:34:38
// Design Name: 
// Module Name: single_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_bench;
    reg clk;
    //reg [4:0] ReadReg;
    //wire [31:0] ReadRegData, ReadPC;
    parameter half_period=10;
    integer i = 0;
    initial begin
        clk=0;
    end
    pipeline UUT(clk);
    //#100 ReadReg = 8;
    always #half_period begin clk=~clk; 
    $display("Time: %d ns, Clock = %d, PC = 0x%H", i, clk, UUT.PC);
            $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", UUT.reg_file_block.reg_file[16], UUT.reg_file_block.reg_file[17], UUT.reg_file_block.reg_file[18]);
            $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", UUT.reg_file_block.reg_file[19], UUT.reg_file_block.reg_file[20], UUT.reg_file_block.reg_file[21]);
            $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", UUT.reg_file_block.reg_file[22], UUT.reg_file_block.reg_file[23], UUT.reg_file_block.reg_file[8]);
            $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", UUT.reg_file_block.reg_file[9], UUT.reg_file_block.reg_file[10], UUT.reg_file_block.reg_file[11]);
            $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H", UUT.reg_file_block.reg_file[12], UUT.reg_file_block.reg_file[13], UUT.reg_file_block.reg_file[14]);
            $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H", UUT.reg_file_block.reg_file[15], UUT.reg_file_block.reg_file[24], UUT.reg_file_block.reg_file[25]);
            $display("----------------------------------------------------------");
     i = i + 10;
    end
endmodule

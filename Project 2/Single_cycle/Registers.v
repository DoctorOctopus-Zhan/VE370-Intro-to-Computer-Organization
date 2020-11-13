`timescale 1ns / 1ps

module Registers(clk, RegWrite, Read_reg1, Read_reg2, Write_reg, Write_data, Read_data1, Read_data2);
    input clk, RegWrite;
    input [4:0] Read_reg1, Read_reg2, Write_reg;
    input [31:0] Write_data;
    output [31:0] Read_data1, Read_data2;
    reg [31:0] memory [31:0];
    integer i;
    initial begin 
        for (i = 0; i < 32; i = i + 1)
            memory[i] = 0;
    end
    assign Read_data1 = memory[Read_reg1];
    assign Read_data2 = memory[Read_reg2];
    always @ (posedge clk) begin
        if (RegWrite == 1)
            memory[Write_reg] <= Write_data;
        end
endmodule
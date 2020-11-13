`timescale 1ns / 1ps

module Data_memory(clk, MemRead, MemWrite, addr, Write_data, Read_data);
    input clk, MemRead, MemWrite;
    input [31:0] addr, Write_data;
    output [31:0] Read_data;
    reg [31:0] memory [63:0];
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            memory[i] = 0;
    end
    always @ (addr) begin
        if (MemWrite) memory[addr / 4] = Write_data;
    end
    assign Read_data = (MemRead) ? memory[addr / 4] : 0;
endmodule
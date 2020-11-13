`timescale 1ns / 1ps

module Ins_memory(Read_addr, Instruction);
    input [31:0] Read_addr;
    output reg [31:0] Instruction;
    reg [31:0] ins_memory [63:0];
    integer i;
    initial begin 
        for (i = 0; i < 64; i = i + 1) ins_memory[i] = 0;
        $readmemb("E:/zhan/VE370/Project/Project2/single_Demo.txt", ins_memory);
    end
    always @ (Read_addr) begin
        Instruction = ins_memory[Read_addr/4];
    end
    //assign Instruction = ins_memory[Read_addr/4];
endmodule

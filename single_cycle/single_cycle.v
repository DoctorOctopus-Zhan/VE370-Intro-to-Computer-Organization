`timescale 1ns / 1ps

module single_cycle(clk);
    input clk;
    wire RegDst, beq, bne, jump, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, zero, Branch;
    wire [1:0] ALUop;
    wire [3:0] ALUcontrol;
    wire [4:0] Write_reg;
    wire [31:0] PC_in, PC_out, instruction, PC_next, jump_addr, branch_addr, Read_data1, Read_data2, Write_data, sign_extend, ALU_in, ALU_result, Read_data, Add1, Add2, branch_out;
    
    assign jump_addr = {Add1[31:28], instruction[25:0], 2'b00};

    Add add1(PC_out, 4, Add1);
    Add add2(Add1, sign_extend * 4, Add2);
    
    Mux_2to1 #(32) branch(((beq && zero) | (bne && ~zero)), Add1, Add2, branch_out);
    Mux_2to1 #(32) Jump(jump, branch_out, jump_addr, PC_in); 
    Mux_2to1 #(5) write_reg(RegDst, instruction[20:16], instruction[15:11], Write_reg);
    Mux_2to1 #(32) ALUin(ALUSrc, Read_data2, sign_extend, ALU_in);
    Mux_2to1 #(32) write_data(MemtoReg, ALU_result, Read_data, Write_data);  
    
    PC pc(clk, PC_in, PC_out);    
    Ins_memory IM(PC_out, instruction);
    Control control(instruction[31:26], RegDst, beq, bne, jump, MemRead, MemtoReg, MemWrite, ALUop, ALUSrc, RegWrite);      
    Registers Reg_file(clk, RegWrite, instruction[25:21], instruction[20:16], Write_reg, Write_data, Read_data1, Read_data2);
    Sign_extend sign(instruction[15:0], sign_extend);
    ALU_control ALUctrl(ALUop, instruction[5:0], ALUcontrol);
    ALU alu(Read_data1, ALU_in, ALUcontrol, zero, ALU_result);
    Data_memory datamem(clk, MemRead, MemWrite, ALU_result, Read_data2, Read_data);
endmodule

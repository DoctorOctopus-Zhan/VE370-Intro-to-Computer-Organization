`timescale 1ns / 1ps

module Control(op, RegDst, beq, bne, jump, MemRead, MemtoReg, MemWrite, ALUop, ALUSrc, RegWrite);
    input [5:0] op;
    output reg RegDst, beq, bne, jump, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    output reg [1:0] ALUop;
    initial begin
        RegDst = 0;
        beq = 0;
        bne = 0;
        jump = 0; 
        MemRead = 0; 
        MemtoReg = 0; 
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUop = 0;
    end
    always @ (op) begin
        case (op)
            // R
            6'b000000: begin 
                RegDst <= 1;
                beq <= 0;
                bne <= 0;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 1;
                ALUop <= 2'b10;
            end
            // j
            6'b000010: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 0;
                jump <= 1; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                ALUop <= 2'b10;
            end
            // beq
            6'b000100: begin 
                RegDst <= 0;
                beq <= 1;
                bne <= 0;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                ALUop <= 2'b01;
            end
            // bne
            6'b000101: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 1;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 0;
                RegWrite <= 0;
                ALUop <= 2'b01;
            end
            // addi
            6'b001000: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 0;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                ALUop <= 2'b00;
            end 
            // andi
            6'b001100: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 0;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                ALUop <= 2'b11;
            end
            // lw
            6'b100011: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 0;
                jump <= 0; 
                MemRead <= 1; 
                MemtoReg <= 1; 
                MemWrite <= 0;
                ALUSrc <= 1;
                RegWrite <= 1;
                ALUop <= 2'b00;
            end
            // sw
            6'b101011: begin 
                RegDst <= 0;
                beq <= 0;
                bne <= 0;
                jump <= 0; 
                MemRead <= 0; 
                MemtoReg <= 0; 
                MemWrite <= 1;
                ALUSrc <= 1;
                RegWrite <= 0;
                ALUop <= 2'b00;
            end                                                
        endcase
    end
endmodule
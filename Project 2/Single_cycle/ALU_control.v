`timescale 1ns / 1ps

module ALU_control(ALUop, funct, out_control);
    input [1:0] ALUop;
    input [5:0] funct;
    output reg [3:0] out_control;
    always @ (*) begin
        case(ALUop)
            // lw, sw, addi
            2'b00: out_control = 4'b0010; // add
            // beq and bne
            2'b01: out_control = 4'b0110; // subtract
            // R-type
            2'b10: begin
                case (funct)
                    6'b100000: out_control = 4'b0010; // add
                    6'b100010: out_control = 4'b0110; // subtract
                    6'b100100: out_control = 4'b0000; // and
                    6'b100101: out_control = 4'b0001; // or
                    6'b101010: out_control = 4'b0111; // stl
                endcase
            end
            // andi
            2'b11: out_control = 4'b0000; // and
        endcase
    end
endmodule
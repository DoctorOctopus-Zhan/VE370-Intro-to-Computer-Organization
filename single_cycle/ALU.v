`timescale 1ns / 1ps

module ALU(a, b, control, zero, result);
    input [31:0] a, b;
    input [3:0] control;   
    output zero;
    output reg [31:0] result;
    initial begin
        result = 0;
    end
    always @ * begin
        case (control)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b0111: begin
                if (a < b)
                    result = 1;
                else
                    result = 0;
            end
            4'b1100: result = ~(a | b);
        endcase
    end
    assign zero = (result) ? 0 : 1;    
endmodule
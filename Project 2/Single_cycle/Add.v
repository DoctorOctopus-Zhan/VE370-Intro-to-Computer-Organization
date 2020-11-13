`timescale 1ns / 1ps

module Add(a, b, sum);
    input [31:0] a, b;
    output reg [31:0] sum;
    always @ (*) begin
        sum = a + b;
    end 
endmodule

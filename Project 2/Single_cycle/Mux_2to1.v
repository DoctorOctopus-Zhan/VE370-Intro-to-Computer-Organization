`timescale 1ns / 1ps

module Mux_2to1(sel, data1, data2, result);
    parameter N = 32;
    input sel;
    input [N - 1:0] data1, data2;
    output reg [N - 1:0] result;
    always @ (*) begin
        result = (sel == 0) ? data1:data2;
    end
endmodule

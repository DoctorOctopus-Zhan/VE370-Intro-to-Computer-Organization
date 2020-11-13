`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/08 02:41:42
// Design Name: 
// Module Name: PC
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

module PC(clk, PC_in, PC_out);
    input clk;
    input [31:0] PC_in;
    output reg [31:0] PC_out;
    initial begin
        PC_out = 0;
    end
    always @ (posedge clk) begin
        PC_out <= PC_in;
    end
endmodule

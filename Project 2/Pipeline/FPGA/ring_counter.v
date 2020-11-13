`timescale 1ns / 1ps

module RingCounter(clk, counter);
    input clk;
    output [1:0] counter;
    reg [1:0] counter;
    
    initial begin
        counter = 2'b00;
    end
    
    always @(posedge clk)
    begin
        counter <= counter+1;
    end
endmodule

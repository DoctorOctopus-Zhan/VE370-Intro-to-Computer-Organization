`timescale 1ns / 1ps

module ClockDivider(clk_in, clk_out);
    input clk_in;
    output clk_out;
    
    reg clk_out;
    reg [17:0] count;
    
    initial begin
        clk_out = 1'b0;
        count = 18'b0;
    end
    
    always @(posedge clk_in)
    begin
        count <= count+1;
            if (count == 100000)
            begin
                count <= 18'b0;
                clk_out = ~clk_out;  
            end
    end
endmodule

`timescale 1ns / 1ps

module ssdDriver(clk, Num, H, L);
    input clk;
    input [15:0] Num;
    output [3:0] H;
    output [6:0] L;
    
    reg [3:0] H, Q;
    wire clk500;
    wire [1:0] counter;
    
    initial begin
        Q = 4'b0000;
        H = 4'b1111;
    end
    
    always @(Num)
    begin
        case (counter)
            2'b00: begin
                Q <= Num[15:12];
                H <= 4'b0111;
            end
            2'b01: begin
                Q <= Num[11:8];
                H <= 4'b1011;
            end
            2'b10: begin
                Q <= Num[7:4];
                H <= 4'b1101;
            end
            2'b11: begin
                Q <= Num[3:0];
                H <= 4'b1110;
            end
        endcase
    end
    
    ClockDivider clockDivider(.clk_in(clk), .clk_out(clk500));
    RingCounter ringCounter(.clk(clk500), .counter(counter));
    ssd SSD(.Q(Q), .L(L));
endmodule

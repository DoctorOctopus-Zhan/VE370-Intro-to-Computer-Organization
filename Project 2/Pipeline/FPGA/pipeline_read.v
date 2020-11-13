`timescale 1ns / 1ps

module PipelineRead(clk, button, switch, H, L);
    input clk, button;
    input [6:0] switch;
    output [3:0] H;
    output [6:0] L;
    
    wire [3:0] H;
    wire [6:0] L;
    reg [15:0] Num;
    wire [31:0] PCOut, RegDataOut;
    
    initial begin
        Num = 16'b0000000000000000;
    end
    
    pipeline Pipeline(.clk(button), .ReadReg(switch[4:0]), .ReadRegData(RegDataOut), .ReadPC(PCOut));
    ssdDriver ssd_driver(.clk(clk), .Num(Num), .H(H), .L(L));
    
    always @(switch) begin
        case (switch[5])
            1: Num <= (switch[6] == 0) ? RegDataOut[15:0] : RegDataOut[31:16];
            0: Num <= (switch[6] == 0) ? PCOut[15:0] : PCOut[31:16];
        endcase
    end
    
endmodule

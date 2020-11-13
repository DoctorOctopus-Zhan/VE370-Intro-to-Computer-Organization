`timescale 1ns / 1ps

module ssd(Q, L);
    input [3:0] Q;
    output [6:0] L;
    
    reg [6:0] L;
    
    initial begin
        L = 7'b1111111;
    end
    
    always @(Q) begin
        case (Q)
            4'h0: L = 7'b1000000;
            4'h1: L = 7'b1111001;
            4'h2: L = 7'b0100100;
            4'h3: L = 7'b0110000;
            4'h4: L = 7'b0011001;
            4'h5: L = 7'b0010010;
            4'h6: L = 7'b0000010;
            4'h7: L = 7'b1111000;
            4'h8: L = 7'b0000000;
            4'h9: L = 7'b0010000;
            4'ha: L = 7'b0001000;
            4'hb: L = 7'b0000011;
            4'hc: L = 7'b1000110;
            4'hd: L = 7'b0100001;
            4'he: L = 7'b0000110;
            4'hf: L = 7'b0001110;
            default: L = 7'b1111111; 
        endcase   
    end
endmodule

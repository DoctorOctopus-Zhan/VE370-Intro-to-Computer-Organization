
module ALU_add(data_out, data_1, data_2);
    input [31:0] data_1, data_2;
    output [31:0] data_out;
    reg [31:0] data_out;

    always @(data_1 or data_2) begin
        data_out=data_1+data_2;
        //$display("Addr_add: %h, %h: %h", data_1, data_2, data_out);
    end
    
endmodule
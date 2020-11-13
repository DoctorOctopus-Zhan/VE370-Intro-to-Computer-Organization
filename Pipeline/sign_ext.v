module sign_ext(data_out, data_in);
    input [15:0] data_in;
    output [31:0] data_out;

    reg [31:0] data_out;

    always @(data_in) begin
        data_out[15:0]=data_in[15:0];
        data_out[31:15]={16{data_in[15]}};
        //$display("Sign_ext: %h", data_out);
    end

endmodule
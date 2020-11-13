
module shift_l (data_out, data_in);
    parameter val=2;
    parameter in_size=30;
    parameter out_size=32;
    input [in_size-1:0] data_in;
    output [out_size-1:0] data_out;

    reg [in_size+val-1:0] data;
    reg [out_size-1:0] data_out;

    always @(data_in) begin
        data=0;
        data[in_size+val-1:val]=data_in;
        data_out=data[out_size-1:0];
        //$display("shift_left: %b", data_out);
    end

endmodule
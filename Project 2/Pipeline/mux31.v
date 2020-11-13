
module mux31 (data_out, data_in_1, data_in_2, data_in_3, signal);

    parameter size=32;

    input [size-1:0] data_in_1, data_in_2, data_in_3;
    input [1:0] signal;
    output [size-1:0] data_out;

    reg [size-1:0] data_out;

    always @(data_in_1 or data_in_2 or data_in_3 or signal) begin
        if (signal==2'b0) data_out=data_in_1;
        else if (signal==2'b01) data_out=data_in_2;
        else if (signal==2'b10) data_out=data_in_3;
        else data_out=0;
        //$display("mux31 choose: %h from %b, %b, %b with signal %b", data_out, data_in_1, data_in_2, data_in_3, signal);
    end

endmodule
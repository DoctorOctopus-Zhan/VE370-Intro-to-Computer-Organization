
module mux21 (data_out, data_in_1, data_in_2, signal);

    parameter size=32;

    input [size-1:0] data_in_1, data_in_2;
    input signal;
    output [size-1:0] data_out;

    reg [size-1:0] data_out;

    always @(data_in_1 or data_in_2 or signal) begin
        if (signal==0) data_out=data_in_1;
        else data_out=data_in_2;
        //$display("mux choose: %h from %h, %h with signal %b", data_out, data_in_1, data_in_2, signal);
    end

endmodule
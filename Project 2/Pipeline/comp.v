module comp(equal, data_in_1, data_in_2);

    parameter size=32;

    input [size-1:0] data_in_1, data_in_2;
    output equal;

    reg equal;

    always @(data_in_1 or data_in_2) begin
        if (data_in_1==data_in_2) equal=1;
        else equal=0;
    end

endmodule
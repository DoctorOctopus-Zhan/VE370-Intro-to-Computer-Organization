module ALU(result, data_in_1, data_in_2, op);
    input [31:0] data_in_1, data_in_2;
    input [3:0] op;
    output [31:0] result;

    reg [31:0] result;

    always @(data_in_1 or data_in_2 or op) begin
        //$display("ALU: %d: %h, %h",op, data_in_1, data_in_2);
        if (op==0) result=(data_in_1 & data_in_2); 
        else if (op==1) result=(data_in_1 | data_in_2);
        else if (op==2) result=(data_in_1+data_in_2);
        else if (op==6) result=(data_in_1-data_in_2);
        else if (op==7) begin
            if (data_in_1<data_in_2) result=1;
            else result=0;
        end
        else result=0;
        //$display("ALU: %h",result);
    end

endmodule

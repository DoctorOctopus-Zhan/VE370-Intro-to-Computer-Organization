module ALU_ctrl(op, funct, ALU_op, inst);
    input [5:0] funct, inst;
    input [1:0] ALU_op;
    output [3:0] op;

    reg [3:0] op;

    always @(inst or funct or ALU_op) begin
        case(ALU_op)
            2'b00: op=4'b0010;
            2'b01: begin
                case(inst)
                    6'b0000100: op=4'b0110;//beq
                    6'b0000101: op=4'b0101;//bne
                endcase
            end
            2'b10: begin
                case(funct)
                    6'b100000: op=4'b0010;
                    6'b100010: op=4'b0110;
                    6'b100100: op=4'b0000;
                    6'b100101: op=4'b0001;
                    6'b101010: op=4'b0111;
                endcase
            end
            2'b11: begin
                case(inst)
                    6'b001000: op=4'b0010; //addi
                    6'b001100: op=4'b0000; //andi
                endcase
            end
        endcase
    end

endmodule
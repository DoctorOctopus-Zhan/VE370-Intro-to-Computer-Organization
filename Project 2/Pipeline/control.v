
module control(ctrl_sig, inst);
    input [31:0] inst;
    output ctrl_sig;

    reg [9:0] ctrl_sig;

    always @(inst) begin
        ctrl_sig=10'b0;
        case (inst[31:26])
            6'b000000: begin
                if (inst==0) ctrl_sig=10'b0;
                else ctrl_sig=9'b0001100010;
                //reg_dst=1;
                //reg_write=1;
                //ALUop=2'b10;
            end
            6'b001000: begin //addi
                ctrl_sig=10'b0010110010;
                //ALUsrc=1;
                //reg_write=1;
                //ALUop=2'b11;
            end
            6'b001100: begin //andi
                ctrl_sig=10'b0010110010;
                //reg_write=1;
                //ALUsrc=1;
                //ALUop=2'b11;
            end
            6'b100011: begin //lw
                ctrl_sig=10'b0010001011;
                //mem_read=1;
                //mem2reg=1;
                //ALUsrc=1;
                //reg_write=1;
                //ALUop=2'b00;
            end
            6'b101011: begin //sw
                ctrl_sig=10'b0010000100;
                //mem_write=1;
                //ALUsrc=1;
                //ALUop=2'b00;
            end
            6'b000100: begin //beq
                ctrl_sig=10'b0100010000;
                //branch=1;
                //ALUop=2'b01;
            end
            6'b000101: begin //bne
                ctrl_sig=10'b0100010000;
                //branch=1;
                //zero_inv=1;
                //ALUop=2'b01;
            end
            6'b000010: begin //j
                ctrl_sig=10'b1000000000;
                //jump=1;
                //ALUop=2'b00;
            end
        endcase
        //$display("Control: reg_dst=%b; jump=%b; branch=%b;\n mem_read=%b; mem2reg=%b; mem_write=%b;\n ALUsrc=%b; reg_write=%b; zero_inv=%b; ALUop=%b;", reg_dst, jump, branch, mem_read, mem2reg, mem_write, ALUsrc, reg_write, zero_inv, ALUop);
        //$display("Control:\n jump=%b; branch=%b; ALUsrc=%b;\n reg_dst=%b; ALU_op=%b; mem_read=%b;\n mem_write=%b; reg_write=%b; mem2reg=%b;\n", ctrl_sig[9], ctrl_sig[8], ctrl_sig[7], ctrl_sig[6], ctrl_sig[5:4], ctrl_sig[3], ctrl_sig[2], ctrl_sig[1], ctrl_sig[0]);

    end

endmodule
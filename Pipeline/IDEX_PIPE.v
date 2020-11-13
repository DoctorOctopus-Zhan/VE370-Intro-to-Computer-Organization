module IDEX_PIPE(ctrl_EX, reg_read_1_EX, reg_read_2_EX, inst_EX, sign_ext_EX, reg_read_1_ID, reg_read_2_ID, inst_ID, sign_ext_ID, ctrl_ID, clk);

    input[31:0] reg_read_1_ID, reg_read_2_ID, inst_ID, sign_ext_ID;
    input [7:0] ctrl_ID;
    input clk;
    output[31:0] reg_read_1_EX, reg_read_2_EX, inst_EX, sign_ext_EX;
    output [7:0] ctrl_EX;

    reg [31:0] reg_read_1_EX, reg_read_2_EX, inst_EX, sign_ext_EX;
    reg[7:0] ctrl_EX;
    
    initial begin
        reg_read_1_EX=0;
        reg_read_2_EX=0;
        inst_EX=0;
        sign_ext_EX=0;
        ctrl_EX=0;
    end
    
    always @(posedge clk) begin
        reg_read_1_EX=reg_read_1_ID;
        reg_read_2_EX=reg_read_2_ID;
        inst_EX=inst_ID;
        sign_ext_EX=sign_ext_ID;
        ctrl_EX=ctrl_ID;
    end

endmodule


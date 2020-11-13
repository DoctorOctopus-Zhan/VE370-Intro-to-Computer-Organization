module MEMWB_PIPE(ctrl_WB, read_data_WB, ALU_out_WB, reg_dst_WB, read_data_MEM, ALU_out_MEM, reg_dst_MEM, ctrl_MEM, clk);

    input[31:0] read_data_MEM, ALU_out_MEM;
    input[4:0] reg_dst_MEM;
    input [3:0] ctrl_MEM;
    input clk;
    output[31:0] read_data_WB, ALU_out_WB;
    output[4:0] reg_dst_WB;
    output [3:0] ctrl_WB;

    reg [31:0] read_data_WB, ALU_out_WB;
    reg [3:0] ctrl_WB;
    reg [4:0] reg_dst_WB;
    
    initial begin
        read_data_WB=0;
        ALU_out_WB=0;
        reg_dst_WB=0;
        ctrl_WB=0;
    end
    
    always @(posedge clk) begin
        read_data_WB=read_data_MEM;
        ALU_out_WB=ALU_out_MEM;
        reg_dst_WB=reg_dst_MEM;
        ctrl_WB=ctrl_MEM;
       //$display("MEMWB: read_data_WB:%h, ALU_out_WB:%h, ctrl_WB:%b, reg_dst_WB:%d", read_data_WB, ALU_out_WB, ctrl_WB, reg_dst_WB);
    end
    
endmodule


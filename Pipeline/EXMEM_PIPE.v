module EXMEM_PIPE(ctrl_MEM, ALU_out_MEM, write_data_MEM, reg_dst_MEM, ALU_out_EX, write_data_EX, reg_dst_EX,  ctrl_EX, clk);

    input[31:0] ALU_out_EX, write_data_EX;
    input[4:0] reg_dst_EX;
    input [3:0] ctrl_EX;
    input clk;
    output[31:0] ALU_out_MEM, write_data_MEM;
    output[4:0] reg_dst_MEM;
    output [3:0] ctrl_MEM;

    reg [31:0] ALU_out_MEM, write_data_MEM;
    reg [3:0] ctrl_MEM;
    reg [4:0] reg_dst_MEM;
    
    initial begin
        ALU_out_MEM=0;
        write_data_MEM=0;
        reg_dst_MEM=0;
        ctrl_MEM=0;
    end
    
    always @(posedge clk) begin
        ALU_out_MEM=ALU_out_EX;
        write_data_MEM=write_data_EX;
        reg_dst_MEM=reg_dst_EX;
        ctrl_MEM=ctrl_EX;
        //$display("EXMEM: ALU_out_MEM:%h, write_data_MEM:%h, ctrl_MEM:%b, reg_dst_MEM:%d", ALU_out_MEM, write_data_MEM, ctrl_MEM, reg_dst_MEM);
    end
    
endmodule


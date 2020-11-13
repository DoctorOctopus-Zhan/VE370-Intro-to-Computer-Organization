`timescale 1ns / 1ps

module pipeline(clk, ReadReg, ReadRegData, ReadPC);

    input clk;
    input [4:0] ReadReg;
    output [31:0] ReadRegData, ReadPC;

//hazard
    wire hazard;//not provided

//IF
    wire PC_write;
    reg[31:0] PC;
    wire[31:0] PC_p4;
    wire[31:0] inst_IF;
    wire flush_IF, IFID_write; 
    wire[31:0] next_PC;
    wire[31:0] next_PC_pre;
    wire branch_sig;

//ID 
    wire[31:0] PC_p4_ID;
    wire[31:0] inst_ID;
    wire[9:0] ctrl_sig_ID;
    wire[7:0] ctrl_sig_ID_f;
    wire[31:0] read_data_1_ID, read_data_2_ID;
    wire[31:0] read_data_1_f_ID, read_data_2_f_ID;
    wire[31:0] imm_ext_ID, imm_ext_sl_ID;
    wire[31:0] branch_addr;//not used
    //wire[31:0] branch_addr_f;
    wire comp_result;
    wire[31:0] jump_addr_ID;
    wire[31:0] jump_addr_ID_f;//as the first instruction is 0x0, this allow user to jump to correct instruction.

//EX
    wire[7:0] ctrl_sig_EX;
    wire[31:0] inst_EX;
    wire[31:0] read_data_1_EX, read_data_2_EX;
    wire[31:0] imm_ext_EX;
    wire[31:0] ALU_data_in_A_EX, ALU_data_in_B_EX, ALU_data_in_B_presrc_EX;
    wire[31:0] ALU_result_EX;
    wire[3:0] ALU_op_EX;
    wire[4:0] write_dst_EX;

//MEM
    wire[4:0] write_dst_MEM;
    wire[31:0] write_data_MEM;
    wire[3:0] ctrl_sig_MEM;
    wire[31:0] ALU_result_MEM;
    wire[31:0] mem_read_data_MEM;
    wire[31:0] write_data_f_MEM;

//WB
    wire[4:0] write_dst_WB;
    wire[31:0] write_data_WB;
    wire[3:0] ctrl_sig_WB;
    wire[31:0] mem_read_data_WB;
    wire[31:0] ALU_result_WB;

//forward
    wire forward_A_comp_sig_ID, forward_B_comp_sig_ID;
    wire[1:0] forward_A_sig_EX, forward_B_sig_EX;
    wire mem_src;


    assign ReadPC = PC; // FPGA output
    
//IF stage
    assign PC_p4=PC+4;
    inst_mem inst_mem_block (inst_IF, PC);
    IFID_PIPE IFID_PIPE_block (PC_p4_ID, inst_ID, PC_p4, inst_IF, flush_IF, IFID_write, clk);

//ID stage
    control control_block (ctrl_sig_ID, inst_ID);
    reg_file reg_file_block (read_data_1_ID, read_data_2_ID, inst_ID[25:21], inst_ID[20:16], write_dst_WB, write_data_WB, ctrl_sig_WB[1], clk, ReadReg, ReadRegData);
    sign_ext imm_ext (imm_ext_ID, inst_ID[15:0]);
    shift_l sign_sl_block (imm_ext_sl_ID, imm_ext_ID[29:0]);
    ALU_add branch_ALU_block (branch_addr, PC_p4_ID, imm_ext_sl_ID);
    mux21 #(8) ID_flush_mux (ctrl_sig_ID_f, ctrl_sig_ID[7:0], 8'b0, hazard);
    mux21 comp_forward_A_block (read_data_1_f_ID, read_data_1_ID, ALU_result_MEM, forward_A_comp_sig_ID);
    mux21 comp_forward_B_block (read_data_2_f_ID, read_data_2_ID, ALU_result_MEM, forward_B_comp_sig_ID);
    comp comp_block (comp_result, read_data_1_f_ID, read_data_2_f_ID);
    IDEX_PIPE IDEX_PIPE_block (ctrl_sig_EX, read_data_1_EX, read_data_2_EX, inst_EX, imm_ext_EX, read_data_1_ID, read_data_2_ID, inst_ID, imm_ext_ID, ctrl_sig_ID_f, clk);

//EX stage
    mux31 ALU_forward_A_block (ALU_data_in_A_EX, read_data_1_EX, write_data_WB, ALU_result_MEM, forward_A_sig_EX);
    mux31 ALU_forward_B_block (ALU_data_in_B_presrc_EX, read_data_2_EX, write_data_WB, ALU_result_MEM, forward_B_sig_EX);
    mux21 ALU_src_block (ALU_data_in_B_EX, ALU_data_in_B_presrc_EX, imm_ext_EX, ctrl_sig_EX[7]);
    ALU_ctrl ALU_ctrl_block (ALU_op_EX, inst_EX[5:0], ctrl_sig_EX[5:4], inst_EX[31:26]);
    ALU ALU_block (ALU_result_EX, ALU_data_in_A_EX, ALU_data_in_B_EX, ALU_op_EX);
    mux21 #(5) reg_dst_block (write_dst_EX, inst_EX[20:16], inst_EX[15:11], ctrl_sig_EX[6]);
    EXMEM_PIPE EXMEM_PIPE_block (ctrl_sig_MEM, ALU_result_MEM, write_data_MEM, write_dst_MEM, ALU_result_EX, ALU_data_in_B_presrc_EX, write_dst_EX, ctrl_sig_EX[3:0], clk);

//MEM stage
    mux21 mem_src_mux (write_data_f_MEM, write_data_MEM, mem_read_data_WB, mem_src);
    data_mem data_mem_block (mem_read_data_MEM, write_data_f_MEM, ALU_result_MEM, ctrl_sig_MEM[2], ctrl_sig_MEM[3], clk);
    MEMWB_PIPE MEMWB_PIPE_block (ctrl_sig_WB, mem_read_data_WB, ALU_result_WB, write_dst_WB, mem_read_data_MEM, ALU_result_MEM, write_dst_MEM, ctrl_sig_MEM, clk);

//WB stage
    mux21 wb_mux (write_data_WB, ALU_result_WB, mem_read_data_WB, ctrl_sig_WB[0]);

//always
    forward forward_block (forward_A_sig_EX, forward_B_sig_EX, forward_A_comp_sig_ID, forward_B_comp_sig_ID, mem_src, inst_EX[25:21], inst_EX[20:16], ctrl_sig_WB[1], ctrl_sig_WB[3] ,write_dst_WB, ctrl_sig_MEM[1], ctrl_sig_MEM[2], write_dst_MEM, inst_ID);
    hazard hazard_block (PC_write, IFID_write, hazard, ctrl_sig_EX[3], ctrl_sig_EX[1], ctrl_sig_MEM[3], inst_ID, write_dst_EX, write_dst_MEM);
    assign jump_addr_ID={PC_p4_ID[31:28], inst_ID[25:0], 2'b0};
    //[27:2]=inst_ID[25:0];
    //assign jump_addr_ID[31:28]=PC_p4_ID[31:28];
    assign jump_addr_ID_f=jump_addr_ID;
    branch_judge branch_judge_block (branch_sig, inst_ID[31:26], comp_result);
    assign flush_IF=branch_sig;
    mux21 branch_PCp4_mux (next_PC_pre, PC_p4, branch_addr, branch_sig);
    mux21 jump_mux (next_PC, next_PC_pre, jump_addr_ID_f, ctrl_sig_ID[9]);

initial begin
    PC=0;
end

always @(posedge clk) begin
    /*if(PC_write == 0) begin
        PC = PC;
    end*/
    PC = (PC_write) ? next_PC : PC;
end

endmodule
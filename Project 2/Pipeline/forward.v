module forward(forward_A, forward_B, forward_A_comp, forward_B_comp, mem_src, rs_EX, rt_EX, write_WB, read_mem_WB, write_dst_WB, write_MEM, write_mem_MEM, write_dst_MEM, inst_ID);

    input [4:0] rs_EX, rt_EX, write_dst_WB, write_dst_MEM;
    input[31:0] inst_ID;
    input write_WB, write_MEM, read_mem_WB, write_mem_MEM;
    output [1:0] forward_A, forward_B;
    output forward_A_comp, forward_B_comp;
    output mem_src;

    reg [1:0] forward_A, forward_B;
    reg forward_A_comp, forward_B_comp;
    reg mem_src;

    always @(rs_EX or rt_EX or write_WB or write_dst_WB or write_MEM or write_dst_MEM or read_mem_WB or write_mem_MEM) begin
        forward_A=2'b00;
        forward_B=2'b00;
        forward_A_comp=0;
        forward_B_comp=0;
        mem_src=0;
        
        if (write_WB==1 && write_dst_WB==rs_EX) forward_A=2'b01;
        if (write_WB==1 && write_dst_WB==rt_EX) forward_B=2'b01;
        if (write_MEM==1 && write_dst_MEM==rs_EX) forward_A=2'b10;
        if (write_MEM==1 && write_dst_MEM==rt_EX) forward_B=2'b10;

        if ((write_dst_MEM==inst_ID[25:21]) && (inst_ID[31:26]==4 || inst_ID[31:26]==5)) forward_A_comp=1;
        if ((write_dst_MEM==inst_ID[20:16]) && (inst_ID[31:26]==4 || inst_ID[31:26]==5)) forward_B_comp=1;
        
        if (write_dst_MEM==write_dst_WB && read_mem_WB==1 && write_mem_MEM==1) mem_src=1;
        //$display("mem_src: %b", mem_src);
        //$display("forward: rs_EX:%d, rt_EX:%d, write_WB:%b, write_dst_WB:%d,  write_MEM:%b, write_dst_MEM:%d.", rs_EX, rt_EX, write_WB, write_dst_WB,  write_MEM, write_dst_MEM);
        //$display("forward: forward A: %b, forward B: %b\n forward comp A: %b, forward comp B: %b\n", forward_A, forward_B, forward_A_comp, forward_B_comp);
    end

endmodule
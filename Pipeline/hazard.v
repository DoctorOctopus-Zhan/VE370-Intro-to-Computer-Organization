module hazard(PC_write, IFID_write, hazard, IDEX_mem_read, IDEX_reg_write, EXMEM_mem_read, inst, write_dst_EX, write_dst_MEM);

    input IDEX_mem_read, IDEX_reg_write, EXMEM_mem_read;
    input [31:0] inst;
    input [4:0] write_dst_EX, write_dst_MEM;
    output PC_write, IFID_write, hazard;

    reg PC_write, IFID_write, hazard;
    
    initial begin
        PC_write=1;
        IFID_write=1;
        hazard=0;
    end
    
    always @(*) begin
        if (IDEX_mem_read && write_dst_EX && (write_dst_EX==inst[25:21] || write_dst_EX==inst[20:16])) begin
            PC_write=0;
            IFID_write=0;
            hazard=1;
        end
        else if (inst[31:26]==4 || inst[31:26]==5) begin
            if (IDEX_reg_write && write_dst_EX && (write_dst_EX==inst[25:21] || write_dst_EX==inst[20:16])) begin
                PC_write=0;
                IFID_write=0;
                hazard=1;
            end
            else if (EXMEM_mem_read && write_dst_MEM && (write_dst_MEM==inst[25:21] || write_dst_MEM==inst[20:16])) begin
                PC_write=0;
                IFID_write=0;
                hazard=1;
            end
            else begin
                PC_write=1;
                IFID_write=1;
                hazard=0;
            end
        end
        else begin
            PC_write=1;
            IFID_write=1;
            hazard=0;
        end
        
        //if ((inst[31:26]==4 || inst[31:26]==5) && (write_dst_EX==inst[25:21] || write_dst_EX==inst[20:16])) flag=1;
        //$display("hazard: IDEX_mem_read: %b, inst: %b, write_dst_EX: %d", IDEX_mem_read, inst, write_dst_EX);
        //if ((((inst[31:26] == 4) && comp_result) || ((inst[31:26] == 5) && (!comp_result)))) IF_flush = 1;
        //$display("hazard: PC_write:%b IFID_write:%b hazard:%b", PC_write, IFID_write, hazard);
    end

endmodule
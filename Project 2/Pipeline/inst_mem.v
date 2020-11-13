
module inst_mem(inst, read_addr);

    parameter inst_mem_size=64;

    input [31:0] read_addr;
    output [31:0] inst;

    reg [31:0] inst_mem[0:inst_mem_size-1];
    reg [31:0] inst;
    
    integer i;

    initial begin
        i=0;
        for (i=0; i<inst_mem_size; i=i+1) inst_mem[i]=0;
        $readmemb("E:/zhan/VE370/Project/Project2/Pipeline_bonus.txt", inst_mem);
        //for (i=0; i<60; i=i+1) $display("%b\n", inst_mem[i]);
    end
    
    always @(read_addr) begin
        //inst={inst_mem[read_addr], inst_mem[read_addr+1], inst_mem[read_addr+2], inst_mem[read_addr+3]};
        inst  = inst_mem[read_addr / 4];
        //$display("inst: %b", inst);
    end

endmodule
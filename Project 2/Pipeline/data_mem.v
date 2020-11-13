module data_mem(read_data, write_data, address, mem_write, mem_read, clk);
    parameter size = 32;
    parameter addr_size = 32;
    parameter mem_size = 32;
    input clk;
    output [size-1:0] read_data;
    input [size-1:0] write_data;
    input [addr_size-1:0] address;
    input mem_read, mem_write;
    
    reg [size-1:0] mem[0:mem_size-1];
    
    integer i;

    initial begin
        i=0;
        for (i=0; i<mem_size; i=i+1) begin
            mem[i]=0;
        end
    end
    always @(negedge clk) begin
    //always @(posedge clk) begin
    //always @(address or mem_read or mem_write or write_data) begin
        if (mem_write) begin
            mem[address>>2]=write_data;
        end
        //$display("mem: write: %h read: %h", write_data, read_data);
        //$display("mem: %h: %h", address/4, mem[address/4]);
    end
    
    assign read_data = (mem_read == 1'b1) ? mem[address>>2] : 32'bx;
endmodule
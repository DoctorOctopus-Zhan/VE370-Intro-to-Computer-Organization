
module reg_file(read_data_1, read_data_2, read_reg_1, read_reg_2, write_reg, write_data, reg_write, clk, ReadReg, ReadRegData);
// FPGA    
    input [4:0] ReadReg;
    output [31:0] ReadRegData;
    
    
    input reg_write, clk;
    input [4:0] read_reg_1, read_reg_2, write_reg;
    input [31:0] write_data;
    output [31:0] read_data_1, read_data_2;

    reg [31:0] reg_file[0:31];
    
    assign ReadRegData = reg_file[ReadReg]; //FPGA
    
    integer i;

    initial begin
        i=0;
        for (i=0; i<32; i=i+1) begin
            reg_file[i]=0;
        end
    end
    
    assign read_data_1=reg_file[read_reg_1];
    assign read_data_2=reg_file[read_reg_2];
        
    //always @(write_reg or write_data or reg_write) begin
    always @(negedge clk) begin
        if (reg_write) begin
            reg_file[write_reg]=write_data;
        end
        //$display("Reg: %d:%h", write_reg, write_data);
    end
    
endmodule
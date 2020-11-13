module IFID_PIPE(PCp4_ID, inst_ID, PCp4_IF, inst_IF, flush_IF, IFID_write, clk);

    input[31:0] PCp4_IF, inst_IF;
    input flush_IF, IFID_write;
    input clk;
    output[31:0] PCp4_ID, inst_ID;

    reg [31:0] PCp4_ID, inst_ID;
    
    initial begin
        PCp4_ID=0;
        inst_ID=0;
    end

    always @(posedge clk) begin
        if (IFID_write) begin
            PCp4_ID=PCp4_IF;
            inst_ID=inst_IF;
        end
        if (flush_IF==1) begin
            PCp4_ID=0;
            inst_ID=0;
        end
        //$display("IFID: PC_p4:%h inst:%b", PCp4_ID, inst_ID);
    end
endmodule


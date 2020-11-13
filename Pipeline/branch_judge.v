module branch_judge (branch_sig, inst_op_ID, comp_result_ID);

    input[5:0] inst_op_ID;
    input comp_result_ID;
    output branch_sig;

    reg branch_sig;

    always @(inst_op_ID or comp_result_ID) begin
        branch_sig=0;
        if (inst_op_ID==4 && comp_result_ID==1) branch_sig=1;
        else if (inst_op_ID==5 && comp_result_ID==0) branch_sig=1;
        else if (inst_op_ID==2) branch_sig=1;
        //$display("branch_sig: %b", branch_sig);
    end

endmodule
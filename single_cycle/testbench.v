`timescale 1ns / 1ps

module testbench;

    integer i = 0;
    integer j = 0;
	reg clk;

	single_cycle uut (clk);

	initial begin
		clk = 0;
        $display("Time:%d, Clock = %d, PC = %H", i, j, uut.pc.PC_out);
        //$display("Zero = %d, bne = %d, result = %d", uut.alu.zero, uut.control.bne, uut.alu.result);
        //$display("a = %H, b = %H, ALUcontrol = %b", uut.alu.a, uut.alu.b, uut.alu.control);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.Reg_file.memory[16], uut.Reg_file.memory[17], uut.Reg_file.memory[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.Reg_file.memory[19], uut.Reg_file.memory[20], uut.Reg_file.memory[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.Reg_file.memory[22], uut.Reg_file.memory[23], uut.Reg_file.memory[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.Reg_file.memory[9], uut.Reg_file.memory[10], uut.Reg_file.memory[11]);
        $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H", uut.Reg_file.memory[12], uut.Reg_file.memory[13], uut.Reg_file.memory[14]);
        $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H", uut.Reg_file.memory[15], uut.Reg_file.memory[24], uut.Reg_file.memory[25]);       
        $display("----------------------------------------------------------");
        i = i + 10;
        j = j + 1;        		
	end
    always #5 begin
        clk = ~clk;
    end
    always #10 begin
        $display("Time:%d, Clock = %d, PC = %H", i, j, uut.pc.PC_out);
        //$display("Zero = %d, bne = %d, result = %H", uut.alu.zero, uut.control.bne, uut.alu.result);
        //$display("a = %H, b = %H, ALUcontrol = %b", uut.alu.a, uut.alu.b, uut.alu.control);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.Reg_file.memory[16], uut.Reg_file.memory[17], uut.Reg_file.memory[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.Reg_file.memory[19], uut.Reg_file.memory[20], uut.Reg_file.memory[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.Reg_file.memory[22], uut.Reg_file.memory[23], uut.Reg_file.memory[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.Reg_file.memory[9], uut.Reg_file.memory[10], uut.Reg_file.memory[11]);
        $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H", uut.Reg_file.memory[12], uut.Reg_file.memory[13], uut.Reg_file.memory[14]);
        $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H", uut.Reg_file.memory[15], uut.Reg_file.memory[24], uut.Reg_file.memory[25]);
        $display("----------------------------------------------------------");        
        i = i + 10;
        j = j + 1;
    end

endmodule

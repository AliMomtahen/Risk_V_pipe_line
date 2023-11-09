module riscvTB_pipe_line();
	reg clk = 0;
	reg rst = 0;
	always #7 clk =~clk ;
	pipe_line_RISK_V riscv(clk ,rst);
	initial begin
		#17 rst=~rst;
		#25 rst=~rst;
		#10003
		$stop;

	end

endmodule

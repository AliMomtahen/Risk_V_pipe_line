module pc_reg(input clk,rst,input [31:0] in_pc,output reg [31:0] out_pc);
	reg [31:0] pc;
	assign out_pc = pc;
	always@(posedge clk)begin
		if(rst)begin
			pc = 32'b0;
			out_pc = 32'b0;
		end
		else begin
			out_pc = pc;
			pc = in_pc;
		end
	end
endmodule

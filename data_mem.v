module data_mem(adr,write_en,data_in ,data_out, clk);
	parameter N = 32,inst_num=50;
	input [N-1:0] data_in;
	input clk,write_en;
	input [7:0] adr;
	output reg [N-1:0] data_out;

	reg [N-1:0] mem [0:N-1] ;
	assign mem[0] = 32'd10;
	assign mem[1] = 32'd11;
	assign mem[10] = 32'd5;
	assign mem[11] = 32'd8;
	assign mem[12] = 32'd23;
	assign mem[13] = 32'd67;
	assign mem[14] = 32'd129;
	assign mem[15] = 32'b1111111_01011_00110_100_01101_1100011;
	assign mem[16] = 32'd45;
	assign mem[17] = 32'd45678;
	assign mem[18] = 32'd5;
	assign mem[19] = 32'd7;

	assign data_out = mem[adr];
	always @(posedge clk) begin
		if (write_en == 1) begin
			mem[adr] = data_in;
		end
	end
endmodule

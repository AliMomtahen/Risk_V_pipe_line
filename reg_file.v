
module reg_file(A1,A2,A3,RD1,RD2,WE3,WD3,clk,rst);
	parameter reg_size = 32,regs_num = 32;
	input clk,WE3,rst;
	input [4:0] A1,A2,A3;
	input [31:0] WD3;
	output reg [reg_size-1:0]  RD1,RD2;

	reg [reg_size-1:0] mem [0:regs_num-1] ;	
	assign RD1 = mem[A1];	
	assign RD2 = mem[A2];		
	always@(posedge clk)begin
		if (rst) begin: ClrMem
            integer i;
            for (i = 0; i < regs_num; i = i + 1) begin
                mem[i] <= 32'b0;
            end
        end
		else begin
			if(WE3)
				if(A3 != 5'b0)
					mem[A3] = WD3;
		end
	end
endmodule
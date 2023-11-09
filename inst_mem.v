module inst_mem(adr, dataOut
, clk);
	parameter N = 32,inst_num=50;
	input clk;
	input [N-1:0] adr;
	output reg [N-1:0] dataOut;
	reg [7:0] inst_adr = 8'b0;


	assign inst_adr =  adr >> 2;
	reg [N-1:0] mem [0:49] ;	
	
	initial begin
		$readmemh ("instr.txt" , mem);
	end
	
	// assign mem[0] = 32'b000000000000_00000_010_00001_0000011; // lw
	// assign mem[1] = 32'b000000000001_00000_010_00010_0000011; // lw
	// assign mem[2] = 32'b0000000_00001_00010_000_00011_0110011; 
	// assign mem[3] = 32'b000000000001_00011_000_00101_0010011; // addi x5 x3 1 (I_TYPE)
	// assign mem[4] = 32'b001000111001_00011_110_01111_0010011; // ori x15 x3 1 
	// assign mem[5] = 32'b000000000001_00011_100_00101_0010011; // xori x5 x3 1 
	// assign mem[6] = 32'b0000000_00101_00000_010_01011_0100011; // sw x5 11(x0)
	// assign mem[7] = 32'b0000000000000000001_00111_0110111; // lui x7 1 
	// assign mem[8] = 32'b000101010101_00001_010_01111_0010011; // slti x5 x3 1 
	// assign mem[9] = 32'b1111111_00100_01000_000_11001_1100011;// beq x4 x8  XXX  
	// assign mem[10] = 32'b1111111_00001_00010_001_11001_1100011;// bnq x1 x2  XXX  
	
	// assign mem[11] = 32'b0000000_00010_00001_010_00100_0110011; // slt  x4 x1 x2
	




// code to find max arr    head of arr is in adrr 10
	// assign mem[0] = 32'b0000000000000000000_01001_0110111; // lui x9 0
	// assign mem[1] = 32'b000000001010_01001_000_01001_0010011; // addi x9 x9 10 
	// assign mem[2] = 32'b000000001010_00000_000_01011_0010011; // addi x11 x0 10 
	// assign mem[3] = 32'b000000000000_01001_010_01010_0000011; // lw x10 0(x9)
	// assign mem[4] = 32'b0000000_00000_00000_000_00110_0110011; // add x6 x0 x0
	// assign mem[5] = 32'b0000000_00110_01001_000_00111_0110011; // add x7 x6 x9
	// assign mem[6] = 32'b000000000000_00111_010_00101_0000011; // lw x5  0(x7)
	// assign mem[7] = 32'b0000000_01010_00101_100_01000_1100011; // blt x5 x10 mem[9]
	// assign mem[8] = 32'b0000000_00101_00000_000_01010_0110011; // x10 = x5   max is in x10
	// assign mem[9] = 32'b000000000001_00110_000_00110_0010011; // addi x6 x6 1
	// assign mem[10] = 32'b1111111_01011_00110_100_01101_1100011; // blt x6 x11 mem[5]

	assign dataOut = mem[inst_adr];
endmodule
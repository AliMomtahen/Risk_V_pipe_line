module mux32_2to1(input [31:0] in1,in2,input sel,output reg [31:0] out);
	assign out = sel ? in2 : in1;
endmodule

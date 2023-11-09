module controller_pipe(input [31:0] instr,input zero,clk,rst,output reg  reg_write,alu_src,mem_write ,
				output reg [1:0] res_src,output reg [2:0] imm_src,output reg[3:0] alu_control 
				, output reg jump , branch , pc_src2);
	always@(*)begin
		//opcode
		pc_src2 = 0;
		{reg_write,alu_src,mem_write,res_src,imm_src,alu_control , jump , branch} = 12'b0;
		if(rst)begin
			pc_src2=0;
			{reg_write,alu_src,mem_write,res_src,imm_src,alu_control , jump ,branch} = 12'b0;
		end
		else begin
		case(instr[6:0])
			7'b011_0011 :begin //R-Type
				case(instr[14:12])
					//func3
					3'b000:begin
						
						{res_src ,alu_src ,mem_write} = 6'b0;
						reg_write=1;
						
						//func7
						case(instr[31:25])
							7'b0: //add
								alu_control = 4'd3;

							7'b0100_000: //sub
								alu_control = 4'd6;
						endcase
					end
					3'b110: //or
						alu_control = 4'd1;

					3'b111:begin //and
						alu_control = 4'd0;
					end


					3'b010: begin //slt
						alu_control = 4'd2;
						reg_write = 1;
					end



				endcase
			end
			7'b000_0011 :begin //lw
				{reg_write,alu_src} = 2'b1;
				reg_write=1;
				{mem_write} = 1'b0;
				{alu_control,res_src, imm_src} = 9'b0011_01_000;
				
			end
			7'b001_0011 :begin //I-type immediate
				case(instr[14:12])
					//func3
					3'b000:begin // addi
						alu_control = 4'd3;
						imm_src = 3'd0;
						alu_src = 1'd1;
						res_src = 2'd0;
						reg_write = 1;

					end
					3'b100:begin // xori
						alu_control = 4'd5;
						imm_src = 3'd0;
						alu_src = 1;
						res_src = 2'd0;
						reg_write = 1;
					end
					3'b110:begin // ori
						alu_control = 4'd1;
						imm_src = 3'd0;
						alu_src = 1;
						res_src = 2'd0;
						reg_write = 1;
					end


					3'b010: begin //slti
						alu_control = 4'd2;
						reg_write = 1;
						alu_src =1;
						res_src = 2'd0;
						imm_src = 3'd0;

					end



				endcase
			end
			7'b110_0111 :begin //jalr 
				jump=1;
				alu_src = 1;
				alu_control = 4'd3;
				imm_src = 3'd0;
				res_src = 2'b10;
				pc_src2 = 1;
				reg_write =1;
			end
			7'b010_0011 :begin //sw
				alu_control = 4'd3;
				imm_src = 3'd1;
				res_src = 2'b10;
				mem_write=1;
				alu_src=1;

			end
			7'b110_1111 :begin //jal
				//pc_src0 = 1;
				jump=1;
				res_src = 2'b10;
				reg_write = 1;
				imm_src = 3'd2;

			end
			7'b110_0011 :begin //B-Type
				branch =1;
				case(instr[14:12])
					
					//func3
					3'b000: begin // beq
						alu_control = 4'd7;
						imm_src = 3'd4;
						//if(zero) pc_src0 = 1;
						
						
					end
					3'b001:begin // bne
						alu_control = 4'd10;
						imm_src = 3'd4;
						//if(zero == 0) pc_src0 = 1;
					end
					3'b100:begin // blt
						alu_control = 4'd8;
						imm_src = 3'd4;
						//if(zero == 1) pc_src0 = 1;
					end

					3'b101:begin // bgt
						alu_control = 4'd9;
						imm_src = 3'd4;
						//if(zero == 0) pc_src0 = 1;
					end


					//slti



				endcase
			end
			7'b011_0111 :begin //lui
			imm_src = 3'd3;
			reg_write = 1;
			res_src = 2'b11;

			end
			default:;

		endcase
		end
	end

endmodule


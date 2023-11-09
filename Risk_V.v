module pipe_line_RISK_V(input clk,rst);


wire [31:0] pc_plus_4_f, pc_target_e, pc_f2, pc_f1, rd, instr_d, pc_d, pc_plus_4_d, rd1, rd2, result_w
        , ext_imm_d, rd1_e, rd2_e, pc_e, ext_imm_e, pc_plus_4_e, src_a_e
        , write_data_e, src_b_e, alu_result_m, alu_result, write_data_m, pc_plus_4_m, rd_m2
        , alu_result_w, read_data_w, pc_plus_4_w;
wire [4:0] rd_w, rs1_e, rs2_e, rd_e , rd_m;
wire [2:0] imm_src_d;
wire [1:0] forward_a_e, forward_b_e, result_src_w;

wire reg_write_d, mem_write_d, jump_d, branch_d, alu_src_d, reg_write_e, mem_write_e, jump_e
        , branch_e, y;
wire [1:0] result_src_d, result_src_m , result_src_e;
wire [3:0] alu_control_d , alu_control_e ;
wire  pc_src_e, stal_f, stal_d, flush_d, reg_write_w, flush_e, alu_src_e, mem_write_m, pc_src2_d
        , pc_src_e2, zero_e, sign_e;





reg_file reg_file (instr_d[19:15], instr_d[24:20], rd_w, rd1, rd2 , reg_write_w, result_w, ~clk , rst);
imm_extend ext (instr_d[31:7], imm_src_d, ext_imm_d);

inst_mem inst_memory (pc_f1, rd , clk);                              
mux32_4to1 pc_mux (pc_plus_4_f, pc_target_e , alu_result, alu_result,{pc_src_e2, pc_src_e}, pc_f2);
Register pc_reg (clk, rst, ~stal_f, pc_f2, pc_f1);
adder pc_adder (pc_f1, 32'd4, pc_plus_4_f);
adder jumpPc_adder(pc_e , ext_imm_e , pc_target_e);
Register f_reg1 (clk, flush_d, ~stal_d, rd, instr_d);
Register f_reg2 (clk, flush_d, ~stal_d, pc_f1, pc_d);
Register f_reg3 (clk, flush_d, ~stal_d, pc_plus_4_f, pc_plus_4_d);


Register e_reg1 (clk, flush_e, 1'b1, rd1, rd1_e);
Register e_reg15 (clk, flush_e, 1'b1, rd2, rd2_e);
Register e_reg2 (clk, flush_e, 1'b1, pc_d, pc_e);
Register_5bit e_reg3 (clk, flush_e, 1'b1, instr_d[19:15], rs1_e);
Register_5bit e_reg4 (clk, flush_e, 1'b1, instr_d[24:20], rs2_e);
Register_5bit e_reg5 (clk, flush_e, 1'b1, instr_d[11:7], rd_e);
Register e_reg6 (clk, flush_e, 1'b1, ext_imm_d, ext_imm_e);
Register e_reg7 (clk, flush_e, 1'b1, pc_plus_4_d, pc_plus_4_e);
Register e_reg8 (clk, flush_e, 1'b1, pc_src2_d, pc_src_e2);

assign imm_src_d2 = imm_src_d2;
assign y = branch_e & zero_e;
assign pc_src_e = jump_e | y;


mux32_4to1 a_mux ( rd1_e, result_w, alu_result_m, 32'b0, forward_a_e, src_a_e);
mux32_4to1 b_mux ( rd2_e, result_w, alu_result_m, 32'b0,forward_b_e, write_data_e);
mux32_2to1 b2_mux ( write_data_e, ext_imm_e,alu_src_e, src_b_e);
ALU alu (src_a_e, src_b_e, alu_control_e,  alu_result , zero_e);
Register m_reg1 (clk, rst, 1'b1, alu_result, alu_result_m);
Register m_reg2 (clk, rst, 1'b1, write_data_e, write_data_m);
Register_5bit m_reg3 (clk, rst, 1'b1, rd_e, rd_m);
Register m_reg4 (clk, rst, 1'b1, pc_plus_4_e, pc_plus_4_m);

hazard_unit haz_unit(instr_d[19:15], instr_d[24:20] ,rs1_e ,  rs2_e , rd_e , rd_m ,rd_w , reg_write_m , reg_write_w,
         pc_src_e , result_src_e,flush_d , stal_d , stal_f , flush_e, forward_a_e , forward_b_e , clk , pc_src_e2);

data_mem data_memory (alu_result_m, mem_write_m,  write_data_m, rd_m2 , clk);
Register w_reg1 (clk, rst, 1'b1, alu_result_m, alu_result_w);
Register w_reg2 (clk, rst, 1'b1, rd_m2, read_data_w);
Register_5bit w_reg3 (clk, rst, 1'b1, rd_m, rd_w);
Register w_reg4 (clk, rst, 1'b1, pc_plus_4_m, pc_plus_4_w);

mux32_4to1 result_mux ( alu_result_w, read_data_w, pc_plus_4_w, 32'b0,result_src_w, result_w);

controller_pipe contr(instr_d , zero_e , clk , rst, reg_write_d, alu_src_d, mem_write_d, result_src_d
        , imm_src_d, alu_control_d, jump_d , branch_d , pc_src2_d);

Register_1bit cnt_e_reg1 (clk, flush_e, 1'b1, reg_write_d, reg_write_e);
Register_2bit cnt_e_reg2 (clk, flush_e, 1'b1, result_src_d, result_src_e);
Register_1bit cnt_e_reg3 (clk, flush_e, 1'b1, mem_write_d, mem_write_e);
Register_1bit cnt_e_reg4 (clk, flush_e, 1'b1, jump_d, jump_e);
Register_1bit cnt_e_reg5 (clk, flush_e, 1'b1, branch_d, branch_e);
Register_4bit cnt_e_reg6 (clk, flush_e, 1'b1, alu_control_d, alu_control_e);
Register_1bit cnt_e_reg7 (clk, flush_e, 1'b1, alu_src_d, alu_src_e);
Register_1bit cnt_m_reg1 (clk, rst, 1'b1, reg_write_e, reg_write_m);
Register_2bit cnt_m_reg2 (clk, rst, 1'b1, result_src_e, result_src_m);
Register_1bit cnt_m_reg3 (clk, rst, 1'b1, mem_write_e, mem_write_m);
Register_1bit cnt_w_reg1 (clk, rst, 1'b1, reg_write_m, reg_write_w);
Register_2bit cnt_w_reg2 (clk, rst, 1'b1, result_src_m, result_src_w);

endmodule
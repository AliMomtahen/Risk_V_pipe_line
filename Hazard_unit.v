module hazard_unit(input [4:0] rs1_d , rs2_d ,rs1_e ,  rs2_e , rd_e , rd_m ,rd_w , 
    input reg_write_m , reg_write_w, pc_src_e , input [1:0] result_src_e
    , output reg flush_d , stal_d , stal_f , flush_e ,
    output reg [1:0] forward_a_e , forward_b_e , input clk , pc_src_e2
);

    reg lw_stall;
     always @(*) begin
        if (((rs1_e == rd_m) && reg_write_m) && (rs1_e != 0)) begin
            forward_a_e = 2'b10;
        end
        else if (((rs1_e == rd_w) && reg_write_w) && (rs1_e != 0)) begin
            forward_a_e = 2'b01;
        end
        else begin
            forward_a_e = 2'b00;
        end
    end

    always @(*) begin
        if (((rs2_e == rd_m) && reg_write_m) && (rs2_e != 0)) begin
            forward_b_e = 2'b10;
        end
        else if (((rs2_e == rd_w) && reg_write_w) && (rs2_e!= 0)) begin
            forward_b_e = 2'b01;
        end
        else begin
            forward_b_e = 2'b00;
        end
    end
    always @(* ) begin
    
    lw_stall = (((rs1_d == rd_e) || (rs2_d == rd_e)) && result_src_e[0]) ? 1 : 0;
    stal_f = lw_stall;
    stal_d = lw_stall;
    
    end
    always @(pc_src_e , lw_stall) begin
        flush_d = pc_src_e | pc_src_e2 ;
        flush_e = (lw_stall | pc_src_e | pc_src_e2 ) ? 1 : 0; 
    end
endmodule
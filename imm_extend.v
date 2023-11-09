
module  imm_extend(input [24:0] inp, input [2:0] sel  , output reg[31:0] out_imm);
    parameter [2:0] 
     I_TYPE = 0 , S_TYPE = 1, J_TYPE = 2 , U_TYPE= 3 , B_TYPE=3'd4;
     always @(sel , inp) begin
        case (sel)
            I_TYPE: out_imm = {{20{inp[24]}} , inp[24 : 13]};
            S_TYPE: out_imm = {{20{inp[24]}} , inp[24:18] , inp[4:0]};
            J_TYPE: out_imm = {{12{inp[24]}} ,inp[12:5] , inp[13] , inp[23:14] , 1'b0};
            U_TYPE: out_imm = {inp[24:5] , 12'b0};
            B_TYPE: out_imm = {{20{inp[24]}} , inp[0] , inp[23:18] , inp[4:1] , 1'b0};
            default: 
                out_imm = 32'b0;
        endcase
     end
endmodule
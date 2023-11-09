module  ALU(input [31:0] inp1 , inp2 , input [3:0] sel , output reg [31:0] out , output reg signbit);
    parameter [3:0]  
    A = 4'd3 , B = 4'd6 , C = 4'd0 , D = 4'd1 , E = 4'd4 , F = 4'd5 , G = 4'd2 , H =4'd7 , J = 4'd8
        ,K = 4'd9 , L = 4'd10;
    assign signbit = out[31];
    always@(inp1 , inp2,sel)begin
        signbit = 0;
         case (sel)
            A:  out = inp1 + inp2;
            B: out = inp1-inp2;
            C: out = inp1 & inp2;
            D: out = inp1 | inp2;
            E: out = inp1 << inp2;
            F: out = inp1 ^ inp2;
            G: begin
                if( inp1[31] == inp2[31]) out = (inp2 > inp1) ? 32'd1 : 32'd0;
                else if(inp1[31] == 1) out = 32'd1;
                else out = 32'd0;
            end
            H: signbit = (inp1 == inp2) ? 1 : 0;
            J: begin
                if( inp1[31] == inp2[31]) signbit = (inp2 > inp1) ? 1 : 0;
                else if(inp1[31] == 1) signbit = 1;
                else signbit = 0;
            end
            K:
            begin
                if( inp1[31] == inp2[31]) signbit = (inp2 > inp1) ? 0 : 1;
                else if(inp1[31] == 1) signbit = 0;
                else signbit = 1;
            end
            L:signbit = (inp1 == inp2) ? 0 : 1;
            default: 
                out = 32'b0;
         endcase   
    end

endmodule

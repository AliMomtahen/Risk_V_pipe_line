module Register_3bit (input clk, rst, write_en ,input [2:0] data_in, output [2:0] data_out);
    reg [2:0] data;

    always @(posedge clk) begin
        if (rst)
            data <= 3'b0;
        else if (write_en)
            data <= data_in;
    end

    assign data_out = data;

endmodule

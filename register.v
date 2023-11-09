module Register (input clk, rst, write_en ,input [31:0] data_in, output [31:0] data_out);
    reg [31:0] data;

    always @(posedge clk) begin
        if (rst)
            data <= 32'b0;
        else if (write_en)
            data <= data_in;
    end

    assign data_out = data;

endmodule
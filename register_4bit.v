module Register_4bit (input clk, rst, write_en ,input [3:0] data_in, output [3:0] data_out);
    reg [3:0] data;

    always @(posedge clk) begin
        if (rst)
            data <= 4'b0;
        else if (write_en)
            data <= data_in;
    end

    assign data_out = data;

endmodule
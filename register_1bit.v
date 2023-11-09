module Register_1bit (input clk, rst, write_en ,input data_in, output data_out);
    reg data;

    always @(posedge clk) begin
        if (rst)
            data <= 1'b0;
        else if (write_en)
            data <= data_in;
    end

    assign data_out = data;

endmodule

`ifndef ASYNDFF_V
`define ASYNDFF_V

module asyn (
    data_in, clk, reset, data_out
);
    input data_in;
    input clk, reset;
    output reg data_out;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            data_out <= 1'b0;
        end
        else begin
            data_out <= data_in;
        end
    end
endmodule

`endif 
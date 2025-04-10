`ifndef SYNDFF_V
`define SYNDFF_V

module synFF (
    clk, inp, outp, reset
);
    input clk, inp, reset;
    output reg outp;

    always @(posedge clk) begin
        if (reset) begin
            outp <= 1'b0;
        end
        else outp <= inp;
    end
endmodule

`endif 
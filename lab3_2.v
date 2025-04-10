`ifndef LAB3_2_V
`define LAB3_2_V
    
module MUX21 (
    inp1, inp2, sel, out_mux
);
    input [31 : 0] inp1, inp2;
    input sel;
    output reg [31 : 0] out_mux;

    always @(*) begin
        if (sel == 1'b1) begin
            out_mux = inp1;
        end
        else if (sel == 1'b0) begin
            out_mux = inp2;
        end
    end
endmodule
`endif 
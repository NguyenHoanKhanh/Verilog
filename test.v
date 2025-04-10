`ifndef TEST_V
`define TEST_V

module mux2_1 (a, b, sel, out);
    input [2 : 0] a, b;
    input sel;
    output reg [2 : 0] out;

    always @(*) begin
        if (sel == 1'b0) begin
            out <= a;
        end
        else if (sel == 1'b1) begin
            out <= b;
        end
    end
endmodule

module mux81 (a, b, c, d, e, f, g, h, sel, out);
    input [2 : 0] a, b, c, d, e, f, g, h;
    input [2 : 0] sel;
    wire [2 : 0] temp [7 : 0];
    output [2 : 0] out;

    mux2_1 a1 (a, b, sel[0], temp[0]);
    mux2_1 a2 (c, d, sel[0], temp[1]);
    mux2_1 a3 (e, f, sel[0], temp[2]);
    mux2_1 a4 (g, h, sel[0], temp[3]);
    mux2_1 a5 (temp[0], temp[1], sel[1], temp[4]);
    mux2_1 a6 (temp[2], temp[3], sel[1], temp[5]);
    mux2_1 a7 (temp[4], temp[5], sel[2], out);

endmodule

`endif 
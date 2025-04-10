module adder (
    a, b, out, cout
);
    input [7 : 0] a, b;
    output [7 : 0] out;
    output cout;

    assign {out, cout} = a + b;
endmodule
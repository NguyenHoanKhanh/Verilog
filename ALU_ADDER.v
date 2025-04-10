module adder (S, Cout, A, B, Cin);
    input [3 : 0] A, B;
    input Cin;
    output [3 : 0] S;
    output Cout;

    assign {Cout, S} = A + B + Cin;
endmodule

module alu_adder (S, Cout, A, B, Cin, Sign, Zero, Parity, Overflow);
    input [15 : 0] A, B;
    input Cin;
    output Cout;
    output [15 : 0] S;
    output Sign, Zero, Parity, Overflow;
    wire [2 : 0] C;

    adder AD (S[3 : 0], C[0], A[3 : 0], B[3 : 0], Cin);
    adder AD1 (S[7 : 4], C[1], A[7 : 4], B[7 : 4], C[0]);
    adder AD2 (S[11 : 8], C[2], A[11 : 8], B[11 : 8], C[1]);
    adder AD3 (S[15 : 12], Cout, A[15 : 12], B[15 : 12], C[2]);

    assign {Cout, S} = A + B + Cin;
    assign Sign = S[15];
    assign Zero = ~|S;
    assign Parity = ~^S;
    assign Overflow = (A[15] & B[15] & ~S[15]) | (~A[15] & ~B[15] & S[15]);

endmodule
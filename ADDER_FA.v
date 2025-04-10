module fulladder (A, B, Cin, Sum, Cout);
    input A, B;
    input Cin;
    output Sum, Cout;

    assign Sum = (A ^ B) ^ Cin;
    assign Cout = (A & B) | ((A ^ B) & Cin);
endmodule

module adder_4 (A, B, Cin, Sum, Cout);
    input [3 : 0] A, B;
    input Cin;
    output [3 : 0] Sum;
    output Cout;
    wire [2 : 0] t;
    
    fulladder FA (A[0], B[0], Cin, Sum[0], t[0]);
    fulladder FA1 (A[1], B[1], t[0], Sum[1], t[1]);
    fulladder FA2 (A[2], B[2], t[1], Sum[2], t[2]);
    fulladder FA3 (A[3], B[3], t[2], Sum[3], Cout);
endmodule
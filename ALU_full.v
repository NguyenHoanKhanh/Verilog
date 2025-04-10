module MUX21_16 (A, B, SEL, OUT);
    input [15 : 0] A, B;
    input  SEL;
    output reg [15 : 0] OUT;

    always @(*) begin
        if (SEL == 0) 
        begin
            OUT = A;
        end
        else if (SEL == 1)
        begin 
            OUT = B;
        end
    end
endmodule

module MUX41_16 (A, B, C, D, SEL, OUT);
    input [15 : 0] A, B, C, D;
    input [1 : 0] SEL;
    output [15 : 0] OUT;
    wire [15 : 0] T1, T2;

    MUX21_16 G (A, B, SEL[0], T1);
    MUX21_16 G1 (C, D, SEL[0], T2);
    MUX21_16 g2 (T1, T2, SEL[1], OUT);
endmodule

module FA (A, B, Cin, Sum, Cout);
    input A, B, Cin;
    output Sum, Cout;

    assign Sum = (A ^ B) ^ Cin;
    assign Cout = (A & B) | ((A ^ B) & Cin);
endmodule

module ADD_16 (A, B, Cin, Sum, Cout);
    input [15 : 0] A, B;
    input Cin;
    output [15 : 0] Sum;
    output Cout;
    wire [15 : 0] t;

    FA F (A[0], B[0], Cin, Sum[0], t[0]);
    FA F1 (A[1], B[1], t[0], Sum[1], t[1]);
    FA F2 (A[2], B[2], t[1], Sum[2], t[2]);
    FA F3 (A[3], B[3], t[2], Sum[3], t[3]);
    FA F4 (A[4], B[4], t[3], Sum[4], t[4]);
    FA F5 (A[5], B[5], t[4], Sum[5], t[5]);
    FA F6 (A[6], B[6], t[5], Sum[6], t[6]);
    FA F7 (A[7], B[7], t[6], Sum[7], t[7]);
    FA F8 (A[8], B[8], t[7], Sum[8], t[8]);
    FA F9 (A[9], B[9], t[8], Sum[9], t[9]);
    FA F10 (A[10], B[10], t[9], Sum[10], t[10]);
    FA F11 (A[11], B[11], t[10], Sum[11], t[11]);
    FA F12 (A[12], B[12], t[11], Sum[12], t[12]);
    FA F13 (A[13], B[13], t[12], Sum[13], t[13]);
    FA F14 (A[14], B[14], t[13], Sum[14], t[14]);
    FA F15 (A[15], B[15], t[14], Sum[15], Cout);
endmodule

module ADD_1 (A, Cin, Sum, Cout);
    input [15 : 0] A;
    input Cin;
    output [15 : 0] Sum;
    output Cout;
    wire [15 : 0] t;
    supply0 GND;
    supply1 VCC;

    FA E (A[0], VCC, Cin, Sum[0], t[0]);
    FA E1 (A[1], GND, t[0], Sum[1], t[1]);
    FA E2 (A[2], GND, t[1], Sum[2], t[2]);
    FA E3 (A[3], GND, t[2], Sum[3], t[3]);
    FA E4 (A[4], GND, t[3], Sum[4], t[4]);
    FA E5 (A[5], GND, t[4], Sum[5], t[5]);
    FA E6 (A[6], GND, t[5], Sum[6], t[6]);
    FA E7 (A[7], GND, t[6], Sum[7], t[7]);
    FA E8 (A[8], GND, t[7], Sum[8], t[8]);
    FA E9 (A[9], GND, t[8], Sum[9], t[9]);
    FA E10 (A[10], GND, t[9], Sum[10], t[10]);
    FA E11 (A[11], GND, t[10], Sum[11], t[11]);
    FA E12 (A[12], GND, t[11], Sum[12], t[12]);
    FA E13 (A[13], GND, t[12], Sum[13], t[13]);
    FA E14 (A[14], GND, t[13], Sum[14], t[14]);
    FA E15 (A[15], GND, t[14], Sum[15], Cout);
endmodule

module SUB_16 (A, B, Cin, Sum, Cout);
    input [15 : 0] A, B;
    input Cin;
    output [15 : 0] Sum;
    output Cout;
    wire [15 : 0] t;
    wire [15 : 0] BN;

    assign BN = ~B + 1;
    
    FA L (A[0], BN[0], Cin, Sum[0], t[0]);
    FA L1 (A[1], BN[1], t[0], Sum[1], t[1]);
    FA L2 (A[2], BN[2], t[1], Sum[2], t[2]);
    FA L3 (A[3], BN[3], t[2], Sum[3], t[3]);
    FA L4 (A[4], BN[4], t[3], Sum[4], t[4]);
    FA L5 (A[5], BN[5], t[4], Sum[5], t[5]);
    FA L6 (A[6], BN[6], t[5], Sum[6], t[6]);
    FA L7 (A[7], BN[7], t[6], Sum[7], t[7]);
    FA L8 (A[8], BN[8], t[7], Sum[8], t[8]);
    FA L9 (A[9], BN[9], t[8], Sum[9], t[9]);
    FA L10 (A[10], BN[10], t[9], Sum[10], t[10]);
    FA L11 (A[11], BN[11], t[10], Sum[11], t[11]);
    FA L12 (A[12], BN[12], t[11], Sum[12], t[12]);
    FA L13 (A[13], BN[13], t[12], Sum[13], t[13]);
    FA L14 (A[14], BN[14], t[13], Sum[14], t[14]);
    FA L15 (A[15], BN[15], t[14], Sum[15], Cout);
endmodule

module SUB_1 (A, Cin, Sum, Cout);
    input [15 : 0] A;
    input Cin;
    output [15 : 0] Sum;
    output Cout;
    wire [15 : 0] t;
    supply0 GND;
    supply1 VCC;

    FA J (A[0], VCC, Cin, Sum[0], t[0]);
    FA J1 (A[1], VCC, t[0], Sum[1], t[1]);
    FA J2 (A[2], VCC, t[1], Sum[2], t[2]);
    FA J3 (A[3], VCC, t[2], Sum[3], t[3]);
    FA J4 (A[4], VCC, t[3], Sum[4], t[4]);
    FA J5 (A[5], VCC, t[4], Sum[5], t[5]);
    FA J6 (A[6], VCC, t[5], Sum[6], t[6]);
    FA J7 (A[7], VCC, t[6], Sum[7], t[7]);
    FA J8 (A[8], VCC, t[7], Sum[8], t[8]);
    FA J9 (A[9], VCC, t[8], Sum[9], t[9]);
    FA J10 (A[10], VCC, t[9], Sum[10], t[10]);
    FA J11 (A[11], VCC, t[10], Sum[11], t[11]);
    FA J12 (A[12], VCC, t[11], Sum[12], t[12]);
    FA J13 (A[13], VCC, t[12], Sum[13], t[13]);
    FA J14 (A[14], VCC, t[13], Sum[14], t[14]);
    FA J15 (A[15], VCC, t[14], Sum[15], Cout);
endmodule

module AND_16 (A, B, OUT);
    input [15 : 0] A, B;
    output [15 : 0] OUT;

    assign OUT = A & B;
endmodule

module OR_16 (A, B, OUT);
    input [15 : 0] A, B;
    output [15 : 0] OUT;

    assign OUT = A | B;
endmodule

module XOR_16 (A, B, OUT);
    input [15 : 0] A, B;
    output [15 : 0] OUT;

    assign OUT = A ^ B;
endmodule

module NAND_16 (A, B, OUT);
    input [15 : 0] A, B;
    output [15 : 0] OUT;

    assign OUT = ~(A & B);
endmodule

module AU (A, B, Cin, SEL, Sum, Cout);
    input [15 : 0] A, B;
    input Cin;
    input [1 : 0] SEL;
    output reg [15 : 0] Sum;
    output reg Cout;
    wire [15 : 0] Sum1, Sum2, Sum3, Sum4;
    wire Cout1, Cout2, Cout3, Cout4;
    
    ADD_16 P (A, B, Cin, Sum1, Cout1);
    ADD_1 P1 (A, Cin, Sum2, Cout2);
    SUB_16 P2 (A, B, Cin, Sum3, Cout3);
    SUB_1 P3 (A, Cin, Sum4, Cout4);

    always @(*) begin
        if (SEL[1] == 0 && SEL[0] == 0) 
        begin
            Sum = Sum1;
            Cout = Cout1;
        end
        else if (SEL[1] == 0 && SEL[0] == 1) 
        begin
           Sum = Sum2;
           Cout = Cout2;
        end
        else if (SEL[1] == 1 && SEL[0] == 0) 
        begin
            Sum = Sum3;
            Cout = Cout3;
        end
        else if (SEL[1] == 1 && SEL[0] == 1) 
        begin
            Sum = Sum4;
            Cout = Cout4;
        end
    end
endmodule

module LU (A, B, SEL, OUT);
    input [15 : 0] A, B;
    input [1 : 0] SEL;
    output reg [15 : 0] OUT;
    wire [15 : 0] OUT1, OUT2, OUT3, OUT4;

    AND_16 Y (A, B, OUT1);
    OR_16 R (A, B, OUT2);
    XOR_16 X (A, B, OUT3);
    NAND_16 I (A, B, OUT4);

    always @(*) begin
        if (SEL[1] == 0 && SEL[0] == 0) 
        begin
            OUT = OUT1;
        end
        else if (SEL[1] == 0 && SEL[0] == 1) 
        begin
            OUT = OUT2;
        end
        else if (SEL[1] == 1 && SEL[0] == 0) 
        begin
            OUT = OUT3;
        end
        else if (SEL[1] == 1 && SEL[0] == 1) 
        begin
            OUT = OUT4;
        end
    end
endmodule

module ALU (A, B, Cin, SEL, Sum, Cout);
    input [15 : 0] A, B;
    input Cin;
    input [2 : 0] SEL;
    output reg [15 : 0] Sum;
    output reg Cout;
    wire [15 : 0] AU_out, LU_out;
    wire Cout1;
    
    AU N (A, B, Cin, SEL[1 : 0], AU_out, Cout1);
    LU N1 (A, B, SEL[1 : 0], LU_out);

    always @(*) begin
        if (SEL[2] == 0) 
        begin
            Sum = AU_out;
            Cout = Cout1;
        end
        else if (SEL[2] == 1)
        begin
            Sum = LU_out;
        end
    end
endmodule
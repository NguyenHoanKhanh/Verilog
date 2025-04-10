module fulladder (
    a, b, cin, sum, cout
);
    input a, b, cin;
    output sum, cout;
    wire t1, t2, t3, t4;

    xor C1 (t1, a, b);
    xor C2 (sum, cin, t1);
    and A1 (t3, a, b);
    and A2 (t4, t1, cin);
    or O1 (cout, t3, t4);
endmodule 

module neg (
    a, outreg
);
    input a;
    wire b;
    wire cout;
    output outreg;
    supply1 vcc;
    supply0 gnd;
    
    not n1 (b, a);
    fulladder f1 (vcc, b, gnd, outreg, cout);

endmodule

module substract (
    a, b, cin, sub, cout
);
    input [3 : 0] a, b;
    input cin;
    output cout;
    output [3 : 0] sub;
    wire [3 : 0] t1, t2;
    supply0 gnd;
    supply1 vcc;
    neg ne1 (b[0], t1[0]);
    fulladder f1 (sub[0], t1[0], a[0], gnd, t2[0]);
    neg ne2 (b[1], t1[1]);
    fulladder f2 (sub[1], t1[1], a[1], t2[1], t2[2]);
    neg ne3 (b[2], t1[2]);
    fulladder f3 (sub[2], t1[2], a[2], t2[2], t2[3]);
    neg ne4 (b[3], t1[3]);
    fulladder f4 (sub[3], t1[3], a[3], t2[3], cout);
endmodule
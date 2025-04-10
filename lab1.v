
module d_ff_asyn (pre, clr, clk, D, Q, Qn
);
    input pre, clr, clk, D;
    output Q, Qn;

    wire [19:0] temp;

    buf b0(Q, temp[18]);
    buf b1(Qn, temp[19]);

    not n13 (Pre, pre);
    not n14 (Clr, clr);
    not n1 (temp[0], clk);
    not n2 (temp[1], D);
    nand a1 (temp[2], D, Clr, temp[0]);
    nand a2 (temp[3], temp[1], temp[0], Pre);
    not n3 (temp[4], Pre);
    not n4 (temp[5], temp[2]);
    not n5 (temp[6], temp[3]);
    or o1 (temp[7], temp[4], temp[5], temp[10]);
    not n6 (temp[8], temp[7]);
    not n7 (temp[11], Clr);
    or o2 (temp[9], temp[8], temp[6], temp[11]);
    not n8 (temp[10], temp[9]);
    nand a3 (temp[12], clk, temp[7]);
    not n9 (temp[14], temp[12]);
    nand a4 (temp[13], clk, temp[9]);
    not n10 (temp[15], temp[13]);
    or o3 (temp[18], temp[14], temp[4], temp[17]);
    not n11 (temp[16], temp[18]);
    or o4 (temp[19], temp[16], temp[15], temp[11]);
    not n12 (temp[17], temp[19]);
endmodule

module statemachine (
    q2, q1, q0, q2_n, q1_n, q0_n
);
    input q2, q1, q0;
    output q2_n, q1_n, q0_n;
    wire t1, t2, t3, t4, t5, t6, t7, t8, t9;
    
    not n1 (t1, q0);
    not n2 (t2, q1);
    not n3 (t3, q2);
    
    and a1 (t4, t3, t2);
    or o1 (q2_n, t1, t4);
    and a2 (t5, t3, t1);
    and a3 (t6, q2, q0);
    or o2 (q1_n, t2, t5, t6);
    and a4 (t7, t3, q1, t1);
    and a5 (t8, q2, q1, q0);
    and a6 (t9, q2, t2, t1);
    or o3 (q0_n, t7, t8, t9);
endmodule 

module load (
    load_en, d2, d1, d0, pr2, clr2, pr1, clr1, pr0, clr0
);
    input load_en;
    input d2, d1, d0;
    output pr2, clr2, pr1, clr1, pr0, clr0;
    wire t1, t2, t3;
    not n1 (t1, d2);
    not n2 (t2, d1);
    not n3 (t3, d0);
    and a1 (pr2, load_en, d2);
    and a2 (clr2, load_en, t1);
    and a3 (pr1, load_en, d1);
    and a4 (clr1, load_en, t2);
    and a5 (pr0, load_en, d0);
    and a6 (clr0, load_en, t3);
endmodule

module asyn_counter (
    clk, load_en, data_in, data_out
);
    input clk, load_en;
    input [2 : 0] data_in;
    output [2 : 0] data_out;

    wire [2 : 0] qn, pr, clr, d, q;

        //load
        load l (.load_en(load_en), .d2(data_in[2]), .d1(data_in[1]), .d0(data_in[0]), .pr2(pr[2]), .clr2(clr[2]), .pr1(pr[1]), .clr1(clr[1]), .pr0(pr[0]), .clr0(clr[0]));
        //flip - flop
        d_ff_asyn d2 (.pre(pr[2]), .clr(clr[2]), .clk(clk), .D(d[2]), .Q(q[2]), .Qn(qn[2]));
        d_ff_asyn d1 (.pre(pr[1]), .clr(clr[1]), .clk(clk), .D(d[1]), .Q(q[1]), .Qn(qn[1]));
        d_ff_asyn d0 (.pre(pr[0]), .clr(clr[0]), .clk(clk), .D(d[0]), .Q(q[0]), .Qn(qn[0]));
        //statemachine
        statemachine s (.q2(q[2]), .q1(q[1]), .q0(q[0]), .q2_n(d[2]), .q1_n(d[1]), .q0_n(d[0]));
        //output
        buf (data_out[2], d[2]);
        buf (data_out[1], d[1]);
        buf (data_out[0], d[0]);

endmodule

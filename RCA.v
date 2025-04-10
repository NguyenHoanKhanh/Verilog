module rca(
    a, b, carry_in, carry_out, sum
);
    parameter N = 8;
    input [N - 1 : 0] a, b;
    input carry_in;
    output carry_out;
    output [N - 1 : 0] sum;
    wire [N : 0] carry;

    assign carry[0] = carry_in;
    assign carry_out = carry[N];

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: ripple
            wire t1, t2, t3;
            xor G(t1, a[i], b[i]), G1(sum[i], t1, carry[i]);
            and U(t2, t1, carry[i]), U1(t3, a[i], b[i]);
            or O1 (carry[i + 1], t2, t3);
        end
    endgenerate
endmodule
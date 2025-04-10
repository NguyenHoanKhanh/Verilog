primitive udp_sum (sum, a, b, c);
    input a, b, c;
    output sum;

    table
        //  a   b   c   :   sum    
            0   0   0   :   0;
            0   0   1   :   1;
            0   1   0   :   1;
            0   1   1   :   0;
            1   0   0   :   1;
            1   0   1   :   0;
            1   1   0   :   0;
            1   1   1   :   1;
    endtable

endprimitive

primitive udp_carry (carry, a, b, c);
    input a, b, c;
    output carry;

    table
        //  a   b   c   :   sum
            0   0   0   :   0;
            0   0   1   :   0;
            0   1   0   :   0;
            0   1   1   :   1;
            1   0   0   :   0;
            1   0   1   :   1;
            1   1   0   :   1;
            1   1   1   :   1;
    endtable
endprimitive

module fulladder (a, b, c, sum, carry);
    input a, b, c;
    output sum;
    output carry;

    udp_sum A1(sum, a, b, c);
    udp_carry A2(carry, a, b, c);
endmodule

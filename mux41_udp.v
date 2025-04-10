primitive udp_mux41 (f, s1, s0, i3, i2, i1, i0); 
    input i3, i2, i1, i0, s1, s0;
    output f;
    table
        //  s1  s0  i3  i2  i1  i0  :   f
            0   0   ?   ?   ?   0   :   0; 
            0   0   ?   ?   ?   1   :   1;
            0   1   ?   ?   0   ?   :   0;
            0   1   ?   ?   1   ?   :   1;
            1   0   ?   0   ?   ?   :   0;
            1   0   ?   1   ?   ?   :   1;
            1   1   0   ?   ?   ?   :   0;
            1   1   1   ?   ?   ?   :   1;
    endtable
endprimitive

module mux41_udp (
    i3, i2, i1, i0, s1, s0, f
);
    input i3, i2, i1, i0, s1, s0;
    output f;

    udp_mux41 U1(f, s1, s0, i3, i2, i1, i0);
endmodule
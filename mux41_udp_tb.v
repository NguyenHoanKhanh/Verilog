module mux41_udp_tb;
    reg i3, i2, i1, i0, s1, s0;
    wire f;

    mux41_udp UDP ( .f(f), .s1(s1), .s0(s0), .i3(i3), .i2(i2), .i1(i1), .i0(i0));
    
    initial begin
        $dumpfile ("muxudp.vcd");
        $dumpvars (0, mux41_udp_tb);
        $monitor ("i3 = %b, i2 = %b, i1 = %b, i0 = %b, s1 = %b, s0 = %b, f = %b", i3, i2, i1, i0, s1, s0, f);

        s1 = 1; s0 = 1;
        i3 = 1; i2 = 1; i1 = 0; i0 = 1;
    end

endmodule
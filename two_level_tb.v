module two_level_tb;
    reg a, b, c, d;
    wire t1, t2, f;

    two_level LUT (.a(a), .b(b), .c(c), .d(d), .t1(t1), .t2(t2), .f(f));

    initial begin
        //Simulation
        $dumpfile("two_level.vcd");
        $dumpvars(0, two_level_tb);
        //Display                   
        $monitor("a = %b, b = %b, c = %b, d = %b, t1 = %b, t2 = %b, f = %b", a, b, c, d, t1, t2, f);

        //Test 1
        a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0;
        #10;
        //Test 2
        a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1;
        #10;
        //Test 3
        a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0;
        #10;
        //Test 4
         a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b1;
        #10;

    end
endmodule
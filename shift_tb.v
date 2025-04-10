module shift_test;
    reg clk, clr, in;
    wire out, out1, out2, out3;
    shiftreg_4bit DUT (.clock(clk), .clear(clr), .A(in), .E(out), .B(out1), .C(out2), .D(out3));

    initial begin
        clk = 0;
        #2 clr = 0;
        #5 clr = 1;
    end
    always #5 clk = ~clk;
    initial begin #2;
        repeat(2)
        begin
            #10 in = 0; 
            #10 in = 0;
            #10 in = 1;
            #10 in = 1;
        end
    end

    initial begin
        $dumpfile("shift.vcd");
        $dumpvars(0, shift_test);
        #200 $finish;
    end
endmodule
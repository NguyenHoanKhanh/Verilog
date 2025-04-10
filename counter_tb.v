module testcounter;
    reg clk, clr;
    wire [7 : 0] out;

    counter_7bit DUT (.clock(clk), .clear(clr), .count(out));
    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;

    initial begin
        clr = 1;
        #15 clr = 0;
        #200 clr = 1;
        #10 $finish;
    end

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, testcounter);
        $monitor($time, " ", "count = %d", out);
    end
endmodule
module even_odd_tb;
    reg clk, x;
    wire result;

    oddeven DUT (.clk(clk), .x(x), .result(result));

    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;
    initial begin
        $dumpfile("odd_even.vcd");
        $dumpvars(0, even_odd_tb);
        $monitor($time, " ", "x = %b, result = %b", x, result);

        #2 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 $finish;
    end
endmodule
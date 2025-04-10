module multi_edge_clk_tb;
    reg [7 : 0] a, b, d;
    reg clk;
    wire [7 : 0] c, f;

    multi_edge_clk DUT (.a(a), .b(b), .c(c), .d(d), .clk(clk), .f(f));

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        $dumpfile("multi_edge.vcd");
        $dumpvars(0, multi_edge_clk_tb);
        $monitor($time, " ", "a = %d, b = %d, c = %d, d = %d, f = %d", a, b, c, d, f);

        a = 8'd30;
        b = 8'd20;
        d = 8'd30;
        #10;
        #15;
        a = 8'd10;
        b = 8'd40;
        d = 8'd50;

        #30
        $finish;
    end
endmodule

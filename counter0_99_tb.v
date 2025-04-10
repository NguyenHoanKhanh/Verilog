module clock0_99_tb;
    reg clk, rst;
    wire [6 : 0] clock1, clock2;

    clock0_99 c (.decode_clock1(clock1), .decode_clock2(clock2), .rst(rst), .clk(clk));

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #10 rst = 1'b1;
    end
    always #10 clk = ~clk;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, clock0_99_tb);
    end

    initial begin
        #10000; $finish;
    end

    initial begin
        $monitor($time, " ", "clock1 = %h, clock2 = %h", clock1, clock2);
    end
endmodule
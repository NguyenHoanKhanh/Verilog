module traffic_tb;
    reg clk;
    wire [2 : 0] light;

    traffic DUT (.clk(clk), .light(light));

    initial begin
        #0 clk = 0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, traffic_tb);
        $monitor($time, " ", "light = %3b", light);
        #200;
        #10 $finish;
    end
endmodule
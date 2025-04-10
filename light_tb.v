module light_tb;
    reg clk;
    wire [2 : 0] light;

    light DUT (.clk(clk), .light(light));

    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("light.vcd");
        $dumpvars(0, light_tb);
        $monitor($time, " ", "light = %3b", light);
        #200;
        #10 $finish;
    end
endmodule
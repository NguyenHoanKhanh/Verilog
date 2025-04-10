`include "lab2_1.v"
module tb;
    reg inp;
    wire out;
    reg clk, rst, start;

    detect DT (.inp(inp), .out(out), .clk(clk), .start(start), .rst(rst));

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;
        #5; rst = 1'b0;
        #5; start = 1'b1;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("detect.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #10; inp = 1'b0; 
        #10; inp = 1'b1; 
        #10; inp = 1'b0;
        #100; $finish;
    end
    
    initial begin
        #0;
        $monitor($time, " ", "out = %b", out);
    end
endmodule
`include "lab01.v"

module tb;
    reg clk, reset, preset, clear, start;
    reg [2 : 0] inp;
    wire [2 : 0] outp;

    count_syn CS (.clk(clk), .clear(clear), .reset(reset), .preset(preset), .start(start), .inp(inp), .outp(outp));

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        preset = 1'b0;
        clear = 1'b0;
        start = 1'b0;
        #5; reset = 1'b0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("lab01.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        @(posedge clk);
        start = 1'b1;
        // preset = 1'b0;
        // clear = 1'b1;
        preset = 1'b1;
        clear = 1'b0;
        inp = 3'b101;
        @(negedge clk);
        #100; $finish;
    end

    initial begin
        $monitor($time, " ", "output = %d", outp);
    end
endmodule
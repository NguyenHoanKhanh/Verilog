`include "synDFF.v"

module tb;
    reg clk, reset, inp;
    wire outp;

    synFF S (.clk(clk), .reset(reset), .inp(inp), .outp(outp));

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        #5; reset = 1'b0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("syn.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #5; inp = 1'b0;
        #5; inp = 1'b1;
    end

    initial begin
        $monitor($time, " ", "inp = %b, outp = %b", inp, outp);
    end

    initial begin
        #100 $finish;
    end
endmodule
`include "tesm.v"
module testbench;
    reg clk, reset;
    wire [7 : 0] out_data;

    counter c (.clk(clk), .reset(reset), .out_data(out_data));

    initial begin
        clk = 1'b0;
        reset = 1'b0;
        #5; reset = 1'b1;
    end
    always #10 clk = ~clk;

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, c);
    end

    initial begin
        #1000; $finish;
    end

    initial begin
        $monitor($time, " ", "out_data = %d", out_data);
    end
endmodule
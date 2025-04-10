module mealy_tb;
    reg a, clk, reset;
    wire b;

    mealy DUT (.a(a), .clk(clk), .reset(reset), .b(b));

    initial begin
        clk = 0; reset = 1; #10 reset = 0;
    end
    always #5 clk = ~clk;
    initial begin
        $dumpfile("detector.vcd");
        $dumpvars(0, mealy_tb);
        $monitor($time, " ", "a = %b, reset = %b, b = %b", a, reset, b);
        #10 a = 0;
        #10 a = 1;
        #10 a = 1;
        #10 a = 0; // This should trigger z = 1 (detecting "0110")

        #20 a = 1; 
        #10 a = 1; 
        #10 a = 0; // Another "0110" detection
        
        #10 $finish;
    end
endmodule


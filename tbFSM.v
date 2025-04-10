`timescale 1ns / 1ps
`include "FSM.v"
module MSSV_tb;
    reg clk, rst;
    reg [2:0] inp;
    wire [2:0] outp;
    wire [1 : 0] detect;
    wire [3 : 0] sum;
    wire done;
    
    MSSV uut (
        .clk(clk), 
        .rst(rst), 
        .inp(inp), 
        .detect(detect),
        .outp(outp), 
        .done(done),
        .sum(sum)
    );

    always #5 clk = ~clk; // Clock period = 10ns
    
    initial begin
        $dumpfile("MSSV_tb.vcd");
        $dumpvars(0, MSSV_tb);
        
        clk = 0;
        rst = 1;
        inp = 3'd0;
        
        #10 rst = 0;
        
        // Test all possible cases
        #10 inp = 3'd0; // Valid case: Transition to S1
        #10 inp = 3'd6; // Valid case: Transition to S2
        #10 inp = 3'd4; // Valid case: Transition to S3
        #10 inp = 3'd2; // Valid case: Back to S0
        
        // Invalid test cases (4 groups)
        #10 inp = 3'd0; #10 inp = 3'd6; // Invalid sequence 1
        #10 inp = 3'd4; #10 inp = 3'd3; // Invalid sequence 2
        #10 inp = 3'd0; #10 inp = 3'd6; // Invalid sequence 3 (looping S1)
        #10 inp = 3'd4; #10 inp = 3'd1; // Invalid sequence 4 (wrong transition)
        
        #10 inp = 3'd0; // Restarting valid sequence
        #10 inp = 3'd6;
        #10 inp = 3'd4;
        #10 inp = 3'd2;
        
        #1000;
        $finish;
    end

    initial begin
        $monitor($time, " ", "outp = %d, done = %b, detect = %d, sum = %d", outp, done, detect, sum);
    end
endmodule

`timescale 1ns / 1ps
`include "mealy.v"
module tb;
    reg clk, rst;
    reg [2:0] inp;
    wire [2:0] outp2;
    wire [1 : 0] detect;
    wire done;
    
    
    mealy m (
        .clk(clk),
        .rst(rst),
        .inp(inp),
        .detect(detect),
        .outp(outp2),
        .done(done)
    );

    always #5 clk = ~clk; // Clock period = 10ns
    
    initial begin
        $dumpfile("mealy.vcd");
        $dumpvars(0, tb);
        
        clk = 0;
        rst = 1;
        inp = 3'd0;
        
        #10 rst = 0;
        
        repeat (3) begin
            #10 inp = 3'd0; // Transition to S1
            #10 inp = 3'd6; // Transition to S2
            #10 inp = 3'd4; // Transition to S3
            #10 inp = 3'd2; // Back to S0
        end
        
        // Test all possible cases
        #10 inp = 3'd0; // Valid case: Transition to S1
        #10 inp = 3'd6; // Valid case: Transition to S2
        #10 inp = 3'd4; // Valid case: Transition to S3
        #10 inp = 3'd2; // Valid case: Back to S0
        
        // Invalid test cases (4 groups)
        #10 inp = 3'd0; #10 inp = 3'd6; // Invalid sequence 1
        #10 inp = 3'd4; #10 inp = 3'd7; // Invalid sequence 2
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
        $monitor($time, " ", "outp = %d, done = %b, detect = %d", outp2, done, detect);
    end
endmodule

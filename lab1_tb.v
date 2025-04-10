`timescale 1ns/1ps
module asyn_counter_tb;
    reg clk, load_en;
    reg [2:0] data_in;
    wire [2:0] data_out;

    // Instantiate the asynchronous counter
    asyn_counter uut (
        .clk(clk),
        .load_en(load_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        load_en = 1'b0;
        clk = 1'b0;
    end
    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5ns (100MHz clock)
    
    initial begin
        $dumpfile ("lab1.vcd");
        $dumpvars(0, asyn_counter_tb);
    end
    // Monitor output
    initial begin
        clk = 0;    
        load_en = 1;
        data_in = 3'b000;
        #10;
        load_en = 0;
        
        repeat (7) begin
            #80; // Wait for 8 clock cycles
            load_en = 1;
            data_in = data_in + 3'b001; // Change input value
            #10;
            load_en = 0;
        end
        #100; $finish;
    end

    initial begin
        $monitor($time, " ", "dataout = %d", data_out);
        
    end
endmodule

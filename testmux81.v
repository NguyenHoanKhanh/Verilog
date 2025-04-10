`include "test.v"
`timescale 1ns / 1ps

module mux81_tb;

    // Inputs
    reg [2:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;

    // Output
    wire [2:0] out;

    // Instantiate the mux81 module
    mux81 uut (
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h),
        .sel(sel), .out(out)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        a = 3'b001; b = 3'b010; c = 3'b011; d = 3'b100;
        e = 3'b101; f = 3'b110; g = 3'b111; h = 3'b000;

        // Apply test cases
        #10; sel = 3'b000; // Expect out = a = 001
        $display ("out = %b", out);
        #10; sel = 3'b001; // Expect out = b = 010
        $display ("out = %b", out);
        #10; sel = 3'b010; // Expect out = c = 011
        $display ("out = %b", out);
        #10; sel = 3'b011; // Expect out = d = 100
        $display ("out = %b", out);
        #10; sel = 3'b100; // Expect out = e = 101
        $display ("out = %b", out);
        #10; sel = 3'b101; // Expect out = f = 110
        $display ("out = %b", out);
        #10; sel = 3'b110; // Expect out = g = 111
        $display ("out = %b", out);
        #10; sel = 3'b111; // Expect out = h = 000
        $display ("out = %b", out);
        // Finish simulation
        $finish;
    end

endmodule

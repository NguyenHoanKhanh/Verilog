`include "lab3_1.v"

module tb;
    reg [2 : 0] sel_alu;
    reg [31 : 0] inp1, inp2;
    wire signed [31 : 0] outp;
    wire carryout, overflow;

    ALU A (
        .inp1(inp1), 
        .inp2(inp2), 
        .outp(outp), 
        .carryout(carryout), 
        .sel_alu(sel_alu), 
        .overflow(overflow)
    );

    initial begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #10;
        inp1 = 32'h1010abcd;
        inp2 = 32'hfedcba98;
        #10;
    end

    initial begin
        #10;
        sel_alu = 3'b000;
        #10;
        sel_alu = 3'b001;
        #10;
        sel_alu = 3'b010;
        #10;
        sel_alu = 3'b011;
        #10;
        sel_alu = 3'b100;
        #10;
        sel_alu = 3'b101;
        #10;
        sel_alu = 3'b110;
        #10;
        sel_alu = 3'b111;
        #10;
    end

    initial begin
        $monitor($time, " ", "sel_alu = %d, outp = %h, overflow = %b, carryout = %b", sel_alu, outp, carryout, overflow);
    end
endmodule
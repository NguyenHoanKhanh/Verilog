`include "lab6_1.v"

module tb;
    reg inp1, inp2, carryin;
    wire sum, carryout;

    adder a (.inp1(inp1), .inp2(inp2), .carryin(carryin), .carryout(carryout), .sum(sum));

    initial begin
        $dumpfile("add1.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #10;
        inp1 = 1'b0; 
        inp2 = 1'b1;
        carryin = 1'b0;
        #10; 
        inp1 = 1'b1; 
        inp2 = 1'b1;
        carryin = 1'b0;
        $monitor($time, " ", "sum = %b, carryoput = %b ", sum, carryout);
    end
endmodule
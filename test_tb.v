`include "test.v"
module tb;
    reg [31 : 0] inp1, inp2;
    wire signed [31 : 0] outp;
    wire carryout;

    SUB32 D (
        .inp1(inp1),
        .inp2(inp2),
        .carryout(carryout),
        .Subout(outp)
    );

    initial begin
        inp1 = 32'b0;
        inp2 = 32'd2;
        #10;
        inp1 = 32'b10;
        inp2 = 32'd2;
        #10;
        inp1 = 32'b11;
        inp2 = 32'd2;
    end

    initial $monitor($time, " ", "inp1 = %d, inp2 = %d, outp = %d", inp1, inp2, outp);

endmodule
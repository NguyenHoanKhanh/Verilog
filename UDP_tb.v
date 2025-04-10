module fulladder_tb;
    reg a, b, c;
    wire sum;
    wire carry;

    fulladder UDP (.a(a), .b(b), .c(c), .sum(sum), .carry(carry));

    initial begin
        $dumpfile("UDP.vcd");
        $dumpvars(0, fulladder_tb);
        $monitor($time, " ", "a = %b, b = %b, c = %b, sum = %b, carry = %b", a, b, c, sum, carry);

        a = 0; b = 0; c = 0;
        #10;

        a = 1; b = 1; c = 1;
        #10;
    end
endmodule
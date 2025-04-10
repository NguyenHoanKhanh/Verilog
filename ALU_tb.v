module alu_tb;
    reg [15 : 0] x, y;
    wire [15 : 0] sum;
    wire sign, zero, carry, parity, overflow;

    alu dut (.x(x), .y(y), .sum(sum), .sign(sign), .zero(zero), .carry(carry), .parity(parity), .overflow(overflow));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
        $monitor($time, " ", "x = %h, y = %h, sum = %h, sign = %b, zero = %b, carry = %b,  parity = %b, overflow = %b"
        , x, y, sum, sign, zero, carry, parity, overflow);

        //Test 1 
        x = 16'h8fff; y = 16'h8000;
        #10;
        //Test 2 
        x = 16'h8000; y = 16'h8000;
        #10;
        //Test 3
        x = 16'h8000; y = 16'h0000;
        #10;
        $finish;
    end
endmodule
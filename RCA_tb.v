module rca_tb;
    reg [7 : 0] a, b;
    reg carry_in;
    wire carry_out;
    wire [7 : 0] sum;

    rca DUT (.a(a), .b(b), .carry_in(carry_in), .carry_out(carry_out), .sum(sum));

    initial begin
        $dumpfile("rca.vcd");
        $dumpvars(0, rca_tb);
        $monitor("a = %h, b = %h, carry_in = %b, carry_out = %b, sum = %h", a, b, carry_in, carry_out, sum);
        carry_in = 0;
        a = 8'hAB; b = 8'hFF; #10; // Expected: sum = 0xAA, carry_out = 1
        a = 8'h12; b = 8'h34; #10; // Expected: sum = 0x46, carry_out = 0
        a = 8'hF0; b = 8'h0F; #10; // Expected: sum = 0xFF, carry_out = 0
        a = 8'hFF; b = 8'h01; #10; // Expected: sum = 0x00, carry_out = 1
        $finish;
    end
endmodule
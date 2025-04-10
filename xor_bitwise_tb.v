module xor_bitwise_tb;
    reg [15 : 0] a, b;
    wire [15 : 0] result;

    xor_bitwise DUT (.a(a), .b(b), .f(result));

    initial begin
        $dumpfile("xor_bitwise.vcd");
        $dumpvars(0, xor_bitwise_tb);
        $monitor($time, " ", "a = %h, b = %h, result = %h", a, b, result);
        #0 a = 16'habab; b = 16'hffff;
        #10 a = 16'h0101; b = 16'h5555;
        #20 $finish; 
    end
endmodule
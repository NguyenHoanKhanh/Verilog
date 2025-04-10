module adder_4_tb;
    reg [3 : 0] A, B;
    reg Cin;
    wire [3 : 0] Sum;
    wire Cout;

    adder_4 DUT (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));

    initial begin
        $dumpfile ("ADDER_FA.vcd");
        $dumpvars (0, adder_4_tb);
        $monitor($time, " ", "A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
        Cin = 0;

        //Test 1 
        A = 4'hA; B = 4'h5;
        #10;
        //Test 2
        A = 4'hB; B = 4'hC;
        #10;
        $finish;
    end
endmodule
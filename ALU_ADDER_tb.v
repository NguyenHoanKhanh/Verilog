module alu_adder_tb;
    reg [15 : 0] A, B;
    reg Cin;
    wire [15 : 0] S;
    wire Cout;
    wire Sign, Zero, Parity, Overflow;

    alu_adder DUT (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout), .Sign(Sign), .Zero(Zero), .Parity(Parity), .Overflow(Overflow));

    initial begin
        $dumpfile("alu_adder.vcd");
        $dumpvars(0, alu_adder_tb);
        $monitor($time, " ", "A = %h, B = %h, Cin = %b, S = %h, Cout = %b, Sign = %b, Zero = %b, Parity = %b, Overflow = %b", A, B, Cin, S, Cout, Sign, Zero, Parity, Overflow);
        Cin = 1'b0; 

        //Test 1
        A = 16'h8fff; B = 16'h8000; 
        #10;
        //Test 2
        A = 16'hfffe; B = 16'h0002;
        #10;
        //Test 3
        A = 16'haaaa; B = 16'h5555;
        #10;
        $finish;
    end
endmodule
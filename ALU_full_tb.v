module ALU_tb;
    reg [15 : 0] A, B;
    reg Cin;
    reg [2 : 0] SEL;
    wire [15 : 0] Sum;
    wire Cout;

    ALU DUT (.A(A), .B(B), .Cin(Cin), .SEL(SEL), .Sum(Sum), .Cout(Cout));

    initial begin
        $dumpfile ("ALU.vcd");
        $dumpvars (0, ALU_tb);
        Cin = 0 ;
        A = 16'hAAAA;
        B = 16'H5555;
        #10;
        //Test 1 
        SEL[2] = 0;
        SEL[1] = 0;
        SEL[0] = 0;
        $monitor("ADD 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h, Cout = %b", A, B,SEL[2], SEL[1], SEL[0], Sum, Cout);
        #10;
        //Test 2
        SEL[2] = 0;
        SEL[1] = 0;
        SEL[0] = 1;
        $monitor("Increment", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h, Cout = %b", A, B,SEL[2], SEL[1], SEL[0], Sum, Cout);
        #10;
        //Test 3
        SEL[2] = 0;
        SEL[1] = 1;
        SEL[0] = 0;
        $monitor("SUB 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h, Cout = %b", A, B,SEL[2], SEL[1], SEL[0], Sum, Cout);
        #10;
        //Test 4
        SEL[2] = 0;
        SEL[1] = 1;
        SEL[0] = 1;
        $monitor("Decrement", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h, Cout = %b", A, B,SEL[2], SEL[1], SEL[0], Sum, Cout);
        #10;
        //Test 5
        SEL[2] = 1;
        SEL[1] = 0;
        SEL[0] = 0;
        $monitor("AND 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h", A, B,SEL[2], SEL[1], SEL[0], Sum);
        #10;
        //Test 6
        SEL[2] = 1;
        SEL[1] = 0;
        SEL[0] = 1;
        $monitor("OR 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h", A, B,SEL[2], SEL[1], SEL[0], Sum);
        #10;
        //Test 7
        SEL[2] = 1;
        SEL[1] = 1;
        SEL[0] = 0;
        $monitor("NAND 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h", A, B,SEL[2], SEL[1], SEL[0], Sum);
        #10;
        //Test 8
        SEL[2] = 1;
        SEL[1] = 1;
        SEL[0] = 1;
        $monitor("XOR 16 bit", $time, " ", "A = %h, B = %h, SEL[2] = %b, SEL[1] = %b, SEL[0] = %b, Sum = %h", A, B,SEL[2], SEL[1], SEL[0], Sum);
        #10;
    end
endmodule
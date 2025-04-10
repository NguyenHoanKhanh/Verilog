module compare_nbit_tb;
    reg [15 : 0] A, B;
    wire lt, gt, eq;

    compare_nbit UUT (.A(A), .B(B), .lt(lt), .gt(gt), .eq(eq));

    initial begin
        $dumpfile ("compare.vcd");
        $dumpvars(0, compare_nbit_tb);
        $monitor($time, " ", "A = %h, B = %h, lt = %b, gt = %b, eq = %b", A, B, lt, gt, eq);

        //Test 1
        A = 4'h5; B = 4'h4;
        #10;
        //Test 2 
        A = 4'h6; B = 4'h6;
        #10;
        //Test 3 
        A = 4'h3; B = 4'h5;
    end
endmodule
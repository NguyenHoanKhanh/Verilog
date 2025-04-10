module andgate_tb;
    reg x, y;
    wire z_and, f_nand, h_nand, k_and, b_and, m_in;

    andgate LUT (.x(x), .y(y), .z_and(z_and), .f_nand(f_nand), .h_nand(h_nand), .k_and(k_and), .b_and(b_and));

    initial begin
        $dumpfile ("andgate.vcd");
        $dumpvars(0, andgate_tb);
        $monitor("x = %b, y = %b, z_and = %b, k_and = %b, f_nand = %b, h_nand = %b, b_and = %b", x, y, z_and,k_and, f_nand, h_nand, b_and);
        //Test cases
        //Test 1
        x = 0; y = 0;
        #10;
        //Test 2
        x = 0; y = 1;
        #10;
        //Test 3
        x = 1; y = 0;
        #10;
        //Test 4
        x = 1; y = 1;
        #10;
    end
endmodule   
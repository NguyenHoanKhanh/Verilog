module andgate (
    x, y, z_and, f_nand, k_and, h_nand, b_and
);
    input x, y;
    output z_and, k_and, f_nand, h_nand, b_and;

    assign z_and = x & y;
    assign f_nand = ~(x & y);
    and G (k_and, x, y);
    nand K (h_nand, x, y);
    assign b_and = &x;

endmodule
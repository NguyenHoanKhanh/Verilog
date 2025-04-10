module two_level (
    a, b, c, d, , t1, t2, f
);
    input a, b, c, d;
    output f, t1, t2;

    assign t1 = a & b;
    assign t2 = ~(c | d);
    assign f = ~(t1 & t2); 
    
endmodule
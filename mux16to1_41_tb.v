module mux16to1_41_tb;
    reg [15:0] in;
    reg [3:0] sel;
    wire out;

    mux16to1_41 uut (.in(in), .sel(sel), .out(out));

    initial begin
        $dumpfile("mux16to1_41.vcd");
        $dumpvars(0, mux16to1_41_tb);
        $monitor($time, " ", "in = %h, sel = %h, out = %b", in, sel, out);
        in = 16'b0101110010011010;
        //Test 1
        sel = 4'h0;
        #5;
        //Test 2
        sel = 4'h1;
        #5;
        //Test 3
        sel = 4'h2;
        #5;
        //Test 4
        sel = 4'h3;
        #5;
        //Test 5
        sel = 4'h4;
        #5;
        //Test 6
        sel = 4'h5;
        #5;
        //Test 7
        sel = 4'h6;
        #5;
        //Test 8
        sel = 4'h7;
        #5;
        //Test 9
        sel = 4'h8;
        #5;
        //Test 10
        sel = 4'h9;
        #5;
        //Test 11
        sel = 4'ha;
        #5;
        //Test 12
        sel = 4'hb;
        #5;
        //Test 13
        sel = 4'hc;
        #5;
        //Test 14
        sel = 4'hd;
        #5;
        //Test 15
        sel = 4'he;
        #5;
        //Test 16
        sel = 4'hf;
        #5;
        $finish;
    end
endmodule
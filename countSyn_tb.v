module countSyn_tb;
    reg clk, rst;
    wire [31:0] count;
    wire [31:0] m_in;
    counter LUT (.clk(clk), .rst(rst), .count(count), .m_in(m_in));

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        clk = 0;
        rst = 0;
        $dumpfile ("countSyn.vcd");
        $dumpvars(0, countSyn_tb);
        $monitor("clk = %b, rst = %b, count = %d, m_in = %d", clk, rst, count, m_in);

        rst = 1;
        #10;
        rst = 0;

        #100;

        $finish;   
    end
endmodule
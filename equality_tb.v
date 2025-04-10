module equality_tb;
    reg [1 : 0] x, y;
    wire z;

    comparator DUT (.x(x), .y(y), .z(z));

    initial begin
        $dumpfile("comparator.vcd");
        $dumpvars(0, equality_tb);  
        $monitor($time," ", "x = %2b, y = %2b, z = %b", x, y, z);
        x = 2'b01; y = 2'b00;
        #10 x = 2'b10; y = 2'b10;
        #10 x = 2'b01; y = 2'b11;
    end
endmodule
module tb;
    reg [15 : 0] data_1, data_2;
    wire Cout;
    wire [15 : 0] Sum;
    
    Adder_16bit ad (.d_1(data_1), .d_2(data_2), .Cout(Cout), .Sum(Sum));

    initial begin
        $dumpfile("FA16bit.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        data_1 = 16'd0;
        data_2 = 16'd0;
    end

    initial begin
        #10;
        #10; data_1 = 16'd1; data_2 = 16'd2;
        #10; data_1 = 16'd7; data_2 = 16'd10;
        #10; data_1 = 20; data_2 = 30;
        #1000; $finish;
    end

    initial begin
        $monitor("data_1 = %0d, data_2 = %0d, Cout = %b, Sum = %d", data_1, data_2, Cout, Sum);
    end
endmodule
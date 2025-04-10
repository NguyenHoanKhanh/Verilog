`include "lab01_2.v"
module tb;
    reg [4 : 0] ReadAddress1, ReadAddress2, WriteAddress;
    reg [31 : 0] WriteData;
    reg ReadWriteEn, clk;
    wire [31 : 0] ReadData1, ReadData2;

    register_file RF (
        .ReadAddress1(ReadAddress1),
        .ReadAddress2(ReadAddress2),
        .WriteAddress(WriteAddress),
        .WriteData(WriteData),
        .ReadWriteEn(ReadWriteEn),
        .clk(clk),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    initial begin
        clk = 1'b0;
    end
    always #5 clk = ~clk;

    initial begin
        #10; 
        ReadWriteEn = 1'b0;
        WriteAddress = 5'b00000;
        WriteData = 32'd10;
        #10;
        ReadWriteEn = 1'b0;
        WriteAddress = 5'b00001;
        WriteData = 32'd20;
        #10;
        ReadWriteEn = 1'b1;
        ReadAddress1 = 5'b00000;
        #10;
        ReadWriteEn = 1'b1;
        ReadAddress2 = 5'b00001;
        #10;
    end

    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        $monitor($time, " ", "ReadData1 = %d, ReadData2 = %d", ReadData1, ReadData2);
        #100; $finish;
    end
endmodule

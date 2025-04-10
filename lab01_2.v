`ifndef LAB01_2_V
`define LAB01_2_V
module register_file (
    ReadAddress1, ReadAddress2, WriteAddress, WriteData, ReadWriteEn, clk, ReadData1, ReadData2
);
    input [4 : 0] ReadAddress1, ReadAddress2;
    input [4 : 0] WriteAddress;
    input [31 : 0] WriteData;
    input ReadWriteEn, clk;
    output reg [31 : 0] ReadData1, ReadData2;

    reg [31 : 0] register [31 : 0];

    always @(posedge clk) begin
        if (ReadWriteEn == 1'b0) begin
            register[WriteAddress] <= WriteData;
        end
        else if (ReadWriteEn == 1'b1) begin 
            ReadData1 <= register[ReadAddress1];
            ReadData2 <= register[ReadAddress2];
        end
    end
endmodule

`endif 
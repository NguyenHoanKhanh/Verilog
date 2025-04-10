module SRAM (
    Address, WriteData, ReadData, WriteEn, ReadEn, clk
);
    input clk;
    input [31 : 0] WriteData;
    input WriteEn, ReadEn;
    input [31 : 0] Address;
    output reg [31 : 0] ReadData;

    reg [3 : 0] register [31 : 0];

    always @(posedge clk) begin
        if (WriteEn == 1'b1 && ReadEn == 1'b0) begin
            register[Address] <= WriteData;
        end
        else if (WriteEn == 1'b0 && ReadEn == 1'b1) begin
            ReadData <= register[Address];
        end
    end
    
endmodule
`include "lab4_1.v"

module tb;
    reg [31 : 0] tb_inp1, tb_inp2;
    reg [2 : 0] tb_sel_alu;
    // wire carryout, overflow;
    reg [4 : 0] tb_ReadAddress, tb_WriteAddress;
    reg tb_load1, tb_load2;
    reg tb_ReadWriteEn;
    reg tb_clk, tb_reset;
    wire [31 : 0] tb_read_datapath;
    reg tb_done;

    datapath DP (
        .dp_inp1(tb_inp1), 
        .dp_inp2(tb_inp2), 
        .dp_sel_alu(tb_sel_alu), 
        .dp_ReadAddress(tb_ReadAddress), 
        .dp_WriteAddress(tb_WriteAddress), 
        .dp_ReadWriteEn(tb_ReadWriteEn), 
        .dp_clk(tb_clk), 
        .dp_load1(tb_load1), 
        .dp_load2(tb_load2), 
        .dp_reset(tb_reset), 
        .dp_done(tb_done), 
        .dp_read_datapath(tb_read_datapath)
    );

    initial begin
        tb_clk = 1'b0;
    end
    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        @(posedge tb_clk);
            tb_load1 = 1'b1;
            tb_inp1 = 32'd0; 
        @(posedge tb_clk);
            tb_load2 = 1'b1;
            tb_inp2 = 32'd5;
        @(posedge tb_clk);
            tb_sel_alu = 3'b101;
            tb_ReadWriteEn = 1'b0;
            tb_WriteAddress = 5'b00001;
        @(posedge tb_clk);
            tb_ReadWriteEn = 1'b1;
            tb_ReadAddress = 5'b00001;
        @(posedge tb_clk);
            tb_done = 1'b1;
            $monitor($time, " ", "ReadAddress = %d, ReadData = %d", tb_ReadAddress, tb_read_datapath);
        #100; $finish;
    end

endmodule
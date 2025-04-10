`include "lab5_1.v"
`include "lab4_1.v"

module tb;
    reg [31 : 0] tb_inp1, tb_inp2;
    wire [31 : 0] tb_read;
    wire tb_load1, tb_load2, tb_ReadWriteEn;
    wire [2 : 0] tb_sel_alu;
    reg tb_clk, tb_reset , tb_start;
    reg [4 : 0] tb_ReadAddress, tb_WriteAddress;
    reg [31 : 0] tb_WriteData;
    wire tb_carryout, tb_overflow;
    wire tb_done;
    integer i;

    datapath DP (
        .dp_inp1(tb_inp1),
        .dp_inp2(tb_inp2),
        .dp_read_datapath(tb_read),
        .dp_sel_alu(tb_sel_alu),
        .dp_carryout(tb_carryout),
        .dp_overflow(tb_overflow),
        .dp_load1(tb_load1),
        .dp_load2(tb_load2),
        .dp_clk(tb_clk),
        .dp_reset(tb_reset),
        .dp_ReadWriteEn(tb_ReadWriteEn),
        .dp_done(tb_done),
        .dp_ReadAddress(tb_ReadAddress),
        .dp_WriteAddress(tb_WriteAddress)
    );

    controller CT (
        .ct_clk(tb_clk),
        .ct_reset(tb_reset),
        .ct_load1(tb_load1),
        .ct_load2(tb_load2),
        .ct_sel_alu(tb_sel_alu),
        .ct_ReadWriteEn(tb_ReadWriteEn),
        .ct_start(tb_start),
        .ct_done(tb_done)
    );

    initial begin
        tb_clk = 1'b0;
        tb_reset = 1'b1;
        tb_start = 1'b0;
        i = 0;
        #5; tb_reset = 1'b0;
    end
    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("lab5.vcd");
        $dumpvars(0, tb);
    end

     initial begin
        repeat(10) begin
            @(posedge tb_clk);
            tb_start = 1;
            @(posedge tb_clk);
            tb_inp1 = $urandom_range(1, 256);
            tb_inp2 = $urandom_range(1, 256);
            $display($time, " Input1 = %d, Input2 = %d", tb_inp1, tb_inp2);
            
            @(posedge tb_clk);
            @(posedge tb_clk);
            tb_WriteAddress = 5'b00001;
            @(posedge tb_clk);
            tb_ReadAddress = 5'b00001;
            @(posedge tb_done);
            i <= i + 1;
        end
        $finish;
    end

    initial begin
        forever @(posedge tb_done)begin
           #0;
            $display($time, " ", "Result = %d", tb_read); 
        end
    end
endmodule
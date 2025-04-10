`include "data3.v"
`include "control3.v"

module tb;
    reg tb_clk, tb_rst, tb_start;
    reg [15 : 0] tb_inp1, tb_inp2;
    wire tb_load_M, tb_load_Q, tb_load_Qm, tb_load_A;
    wire tb_sel_add, tb_sel_sub, tb_sel_other, tb_sel_alu;
    wire tb_shift_Q, tb_shift_A;
    wire tb_clr_M, tb_clr_Q, tb_clr_A, tb_clr_Qm;
    wire tb_decre;
    wire tb_done;
    wire tb_eqz;
    wire [4 : 0] tb_count;
    wire signed [31 : 0] tb_out;

    datapath DP (
        .d_inp1(tb_inp1), 
        .d_inp2(tb_inp2), 
        .d_clk(tb_clk), 
        .d_rst(tb_rst), 
        .d_clr_M(tb_clr_M), 
        .d_clr_Q(tb_clr_Q),
        .d_clr_A(tb_clr_A), 
        .d_clr_Qm(tb_clr_Qm), 
        .d_load_M(tb_load_M), 
        .d_load_Q(tb_load_Q), 
        .d_load_A(tb_load_A), 
        .d_load_Qm(tb_load_Qm), 
        .d_shift_Q(tb_shift_Q), 
        .d_shift_A(tb_shift_A), 
        .d_sel_add(tb_sel_add), 
        .d_sel_sub(tb_sel_sub), 
        .d_sel_other(tb_sel_other), 
        .d_sel_alu(tb_sel_alu), 
        .d_done(tb_done), 
        .d_count(tb_count), 
        .d_decre(tb_decre), 
        .d_out(tb_out), 
        .d_eqz(tb_eqz)
    );

    controller CT (
        .c_clk(tb_clk), 
        .c_reset(tb_rst), 
        .c_start(tb_start), 
        .c_load_A(tb_load_A), 
        .c_load_Q(tb_load_Q), 
        .c_load_M(tb_load_M), 
        .c_load_Qm(tb_load_Qm), 
        .c_clr_M(tb_clr_M), 
        .c_clr_Q(tb_clr_Q), 
        .c_clr_A(tb_clr_A), 
        .c_clr_Qm(tb_clr_Qm), 
        .c_sel_alu(tb_sel_alu), 
        .c_sel_add(tb_sel_add), 
        .c_sel_sub(tb_sel_sub), 
        .c_sel_other(tb_sel_other), 
        .c_shift_A(tb_shift_A), 
        .c_shift_Q(tb_shift_Q), 
        .c_done(tb_done), 
        .c_eqz(tb_eqz), 
        .c_decre(tb_decre)
    );


    initial begin
        tb_clk = 1'b0;
        tb_start = 1'b0;
        tb_rst = 1'b1;
        tb_inp1 = 16'b0;
        tb_inp2 = 16'b0;
        #5; tb_rst = 1'b0;
    end
    
    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("data3.vcd");
        $dumpvars(0, tb);
    end
    
    initial begin
        @(negedge tb_clk);
        tb_inp1 = 16'd10;
        tb_inp2 = 16'd20;
        $display ($time, " ", "Number 1 = %d", tb_inp1);
        $display ($time, " ", "Number 2 = %d", tb_inp2);
        
        @(posedge tb_clk);
        tb_start = 1'b1;  // Bật start sau khi đã đặt giá trị đầu vào
        @(posedge tb_clk);
        tb_start = 1'b0;  // Tắt start để tránh giữ tín hiệu quá lâu

        @(posedge tb_done);
        #100; $finish;
    end

    
    initial begin
        @(posedge tb_done);
        $display($time, " ", "Result = %d", tb_out);
    end
endmodule
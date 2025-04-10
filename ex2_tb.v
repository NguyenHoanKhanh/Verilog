`include "controller_moore.v"
`include "datapath2.v"

module tb;
    reg clk, rst, start;
    reg [15 : 0] data_in;
    wire [15 : 0] data_out;
    wire temp_sel1, temp_sel2, temp_sel3, temp_sel4;    
    wire lt, gt, eq;
    wire load_A, load_B;
    wire done;
    integer i;

    datapath DP (
        .clk(clk),
        .rst(rst), 
        .done(done),
        .inp(data_in), 
        .outp(data_out), 
        .sel1(temp_sel1), 
        .sel2(temp_sel2),
        .sel3(temp_sel3), 
        .sel4(temp_sel4), 
        .temp_lt(lt), 
        .temp_gt(gt), 
        .temp_eq(eq), 
        .load_A(load_A), 
        .load_B(load_B)
    );

    controller CT (
        .clk(clk),
        .rst(rst), 
        .done(done), 
        .clt(lt), 
        .cgt(gt), 
        .ceq(eq), 
        .sel1(temp_sel1), 
        .sel2(temp_sel2), 
        .sel3(temp_sel3), 
        .sel4(temp_sel4),
        .ldA(load_A), 
        .ldB(load_B), 
        .start(start)
    );

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;
        i = 0;
        #5; rst = 1'b0;
    end
    always #5 clk = ~clk;
    initial begin
        $dumpfile("ex2.vcd");
        $dumpvars(0, tb);
    end
    initial begin
        #10;
        @(posedge clk);
        repeat(10) begin
            @(negedge clk);
            start = 1'b1;
            @(negedge clk);
            data_in = $urandom_range(1, 256);
            $display($time, " ", "Number 1 = %d", data_in);
            @(negedge clk);
            data_in = $urandom_range(1, 256);
            $display($time, " ", "Number 2 = %d", data_in);
            @(posedge done);
            @(negedge clk);
            @(negedge clk);
            start = 1'b0;
            i = i + 1;
        end
        #10; $finish;
    end
    initial begin
        forever @(posedge done) begin
            #0;
            $display($time, " ", "Result = %d", data_out);
        end
    end
endmodule
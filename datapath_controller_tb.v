`include "data.v"
`include "control.v"

module tb;
    reg clk, reset, start;
    reg [15 : 0] data_in;
    wire [15 : 0] data_out;
    wire temp_clrP, temp_decB, temp_loadA, temp_loadB, temp_loadP, temp_done, temp_eqz;
    integer i;

    datapath DP (
        .clk(clk),
        .reset(reset),
        .clrP(temp_clrP),
        .decB(temp_decB),
        .load_A(temp_loadA),
        .load_B(temp_loadB),
        .load_P(temp_loadP),
        .eqz(temp_eqz),
        .in(data_in),
        .out(data_out),
        .done(temp_done)
    );

    controller CT (
        .clk(clk),
        .reset(reset),
        .start(start),
        .clrP(temp_clrP),
        .decB(temp_decB),
        .load_A(temp_loadA),
        .load_B(temp_loadB),
        .load_P(temp_loadP),
        .eqz(temp_eqz),
        .done(temp_done)
    );

    initial begin
        clk = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        i = 0;
        #5; reset = 1'b0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dc.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #10;
        @(posedge clk);
        repeat(10) begin
            $display("======== Test no.%d ========", i + 1);
            @(negedge clk);
            start = 1'b1;
            data_in = $urandom_range(1, 256);
            $display ($time, " ", "Multiplier = %d", data_in);
            @(negedge clk);
            data_in = $urandom_range(1, 256);
            $display ($time, " ", "Multiplicand = %d", data_in);
            @(posedge temp_done);
            @(negedge clk);
            start = 1'b0;
            i = i + 1;
        end
        $finish;
    end

    initial begin
        forever @(posedge temp_done) begin
            #0;
            $display ($time, " ", "Product = %d", data_out);
        end
    end
endmodule
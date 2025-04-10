`include "encoder_CASE.v"

module encoder_tb;
    reg [7 : 0] a;
    wire [2 : 0] sel;
    integer i;
    encoder EN (.inp(a), .outp(sel));

    initial begin
        $dumpfile("encoder.vcd");
        $dumpvars(0, encoder_tb);
    end

    initial begin
        #10; a = 8'b10000000;
        #10; a = 8'b00000010;
    end

    initial begin
        $monitor($time, " ","sel = %3b", sel);
    end

endmodule
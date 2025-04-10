module prio_encoder_tb;
    reg [7 : 0] in;
    wire [2 : 0] code;
    
    prio_encoder DUT (.in(in), .code(code));

    initial begin
        $dumpfile("prior_encoder.vcd");
        $dumpvars(0, prio_encoder_tb);
        $monitor($time, " ", "in = %d, code = %b", in, code);
        in = 8'ha;
        #10;

    end
endmodule
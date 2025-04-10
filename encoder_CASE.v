`ifndef ENCODER_CASE_V
`define ENCODER_CASE_V
module encoder (
    inp, outp
);
    input [7 : 0] inp;
    output reg [2 : 0] outp;

    always @(*) begin
        case (inp)
            8'd1 : outp = 3'b000; 
            8'd2 : outp = 3'b001;
            8'd4 : outp = 3'b010; 
            8'd8 : outp = 3'b011;
            8'd16 : outp = 3'b100; 
            8'd32 : outp = 3'b101;
            8'd64 : outp = 3'b110; 
            8'd128 : outp = 3'b111;
        endcase
    end
endmodule

`endif 
module clock0_99 (decode_clock1, decode_clock2, rst, clk);
    input clk, rst;
    reg [3 : 0] clock1, clock2;
    output [6 : 0] decode_clock1, decode_clock2;

    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            clock1 <= 4'd0;
            clock2 <= 4'd0;
        end
        else begin
            clock1 <= clock1 + 1;
            if (clock1 == 4'd9) begin
                clock1 <= 4'd0;
                clock2 <= clock2 + 1;
                if (clock2 == 4'd9) begin
                    clock1 <= 0;
                    clock2 <= 0;
                end
            end
        end
    end

    function [6 : 0] decode_clock;
        input [3 : 0] decode;
        begin
            case (decode)
                4'd0 : decode_clock = 7'b0111111;
                4'd1 : decode_clock = 7'b0000110;
                4'd2 : decode_clock = 7'b1011011;
                4'd3 : decode_clock = 7'b1001111;
                4'd4 : decode_clock = 7'b1100110;
                4'd5 : decode_clock = 7'b1101101;
                4'd6 : decode_clock = 7'b1111101;
                4'd7 : decode_clock = 7'b0000111;
                4'd8 : decode_clock = 7'b1111111;
                4'd9 : decode_clock = 7'b1101111;
            endcase
        end
    endfunction
    
    assign decode_clock1 = decode_clock(clock1);
    assign decode_clock2 = decode_clock(clock2);
endmodule

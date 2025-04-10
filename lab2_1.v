`ifndef LAB2_1_V
`define LAB2_1_V

module detect (
    clk, start, rst, inp, out, done
);
    input clk, start, rst;
    input inp;
    output reg done;
    output reg out;
    reg [1 : 0] PState, NState;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            PState <= S0;
        end
        else if (start == 1'b1) begin
            PState <= NState;
        end
        else begin
            PState <= S0;
        end
    end

    always @(*) begin
        case (PState)
            S0 : begin
                out = 1'b0;
                done = 1'b0;
                if (inp == 1'b1) begin
                    NState = S0;
                end  
                else if (inp == 1'b0) begin
                    NState = S1;
                end
            end
            S1 : begin 
                out = 1'b0;
                done = 1'b0;
                if (inp == 1'b1) begin
                    NState = S2;
                end
                else if (inp == 1'b0) begin
                    NState = S1;
                end
            end
            S2 : begin
                out = 1'b1;
                done = 1'b0;
                if (inp == 1'b1) begin
                    NState = S0;
                end
                else if (inp == 1'b0) begin
                    NState = S3;
                end
            end
            S3 : begin
                out = 1'b0;
                done = 1'b1;
                NState = S0;
            end
        endcase
    end
endmodule

`endif 
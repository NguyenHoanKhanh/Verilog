`ifndef CONTROL_V
`define CONTROL_V

module controller (
    clk, reset, clrP, decB, load_A, load_B, load_P, done, eqz, start
);
    input clk, reset, start;
    output reg clrP, decB, load_A, load_B, load_P, done;    
    input eqz;
    reg [1 : 0] PState, NState;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            PState <= S0;
        end
        else if (start) begin
            PState <= NState;
        end
        else begin
            PState <= S0;
        end
    end

    always @(*) begin
        case (PState)
            S0: begin
                load_A = 1'b1;
                load_B = 1'b0;
                load_P = 1'b0;
                clrP = 1'b1;
                decB = 1'b0;
                done = 1'b0;

                NState = S1;
            end
            S1 : begin
                load_A = 1'b0;
                load_B = 1'b1; 
                load_P = 1'b0;
                clrP = 1'bx;
                decB = 1'b0;
                done = 1'b0;

                NState = S2;
            end 
            S2 : begin
                load_A = 1'b0;
                load_B = 1'b0;
                clrP = 1'b0;
                done = 1'b0;

                if (eqz) begin
                    decB = 1'b0;
                    load_P = 1'b0;
                    NState = S3;
                end
                else begin
                    decB = 1'b1;
                    load_P = 1'b1;
                    NState = S2;
                end
            end
            S3 : begin
                load_A = 1'b0;
                load_B = 1'b0;
                load_P = 1'b0;
                decB = 1'b0;
                clrP = 1'b0;
                done = 1'b1;

                NState = S0;
            end
        endcase
    end
endmodule

`endif 
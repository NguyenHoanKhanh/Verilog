`ifndef CONTROLLER2_V
`define CONTROLLER2_V

module controller (
    clk, rst, done, lt, gt, eq, csel1, csel2, csel3, csel4, load_A, load_B, start
);
    input rst, clk, start;
    output reg done, load_A, load_B;
    output reg csel1, csel2, csel3, csel4;
    input lt, gt, eq;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1 : 0] PState, NState;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            PState <= S0;
        end
        else  if (start == 1'b1) begin
            PState <= NState;
        end
        else PState <= S0;
    end

    always @(*) begin
        case (PState)
            S0 : begin
                csel1 = 1'bx;
                csel2 = 1'bx;
                load_A = 1'b0;  
                load_B = 1'b0;
                csel3 = 1'bx;
                csel4 = 1'bx;
                done = 1'b0;

                NState = S1;
            end

            S1 : begin
                csel1 = 1'b1;
                csel2 = 1'bx;
                load_A = 1'b1;
                load_B = 1'b0;
                csel3 = 1'bx;
                csel4 = 1'bx;
                done = 1'b0;

                NState = S2;
            end
            S2 : begin 
                csel1 = 1'bx;
                csel2 = 1'b1;
                load_A = 1'b0;
                load_B = 1'b1;
                csel3 = 1'bx;
                csel4 = 1'bx;
                done = 1'b0;

                NState = S3;
            end
            S3 : begin
                if (lt == 1'b1 && gt == 1'b0 && eq == 1'b0) begin
                    csel1 = 1'bx;
                    csel2 = 1'b0;
                    load_A = 1'b0;
                    load_B = 1'b1;
                    csel3 = 1'b0;
                    csel4 = 1'b1;
                    done = 1'b0;

                    NState = S3;
                end
                else if (lt == 1'b0 && gt == 1'b1 && eq == 1'b0) begin
                    csel1 = 1'b0;
                    csel2 = 1'bx;
                    load_A = 1'b1;
                    load_B = 1'b0;
                    csel3 = 1'b1;
                    csel4 = 1'b0;
                    done = 1'b0;

                    NState = S3;
                end
                else if (lt == 1'b0 && gt == 1'b0 && eq == 1'b1) begin
                    csel1 = 1'b0;
                    csel2 = 1'bx;
                    load_A = 1'b1;
                    load_B = 1'b0;
                    csel3 = 1'bx;
                    csel4 = 1'bx;
                    done = 1'b1;

                    NState = S0;
                end
            end
        endcase
    end
endmodule

`endif 

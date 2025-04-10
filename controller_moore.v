`ifndef CONTR0LLER_MOORE_V
`define CONTR0LLER_MOORE_V

module controller(
    clk, rst, start, clt, cgt, ceq, done, ldA, ldB, sel1, sel2, sel3, sel4
);
    input clk, rst, start;
    input clt, ceq, cgt;
    output reg done, ldA, ldB;
    output reg sel1, sel2, sel3, sel4;
    reg [2 : 0] PState, NState;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011,
                S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            PState <= S0;
        end
        else PState <= NState;
    end

    always @(*) begin
        case (PState)
            S0 : begin 
                ldA = 1'b0;
                ldB = 1'b0;
                done = 1'b0;
                sel1 = 1'bx;
                sel2 = 1'bx;
                sel3 = 1'bx;
                sel4 = 1'bx;

                if (start) begin
                    NState = S1;
                end
                else NState = S0;
            end
            S1 : begin
                ldA = 1'b1;
                sel1 = 1'b1;
                ldB = 1'b0;
                sel2 = 1'b0;
                sel3 = 1'bx;
                sel4 = 1'bx;
                done = 1'b0;

                NState = S2;
            end
            S2 : begin
                ldA = 1'b0;
                ldB = 1'b1;
                sel1 = 1'bx;
                sel2 = 1'b1;
                sel3 = 1'bx;
                sel4 = 1'bx;
                done = 1'b0;

                NState = S3;
            end
            S3 : begin
                ldA = 1'b0;
                ldB = 1'b0;
                sel1 = 1'bx;
                sel2 = 1'bx;
                sel3 = 1'bx;
                sel4 = 1'bx;
                done = 1'b0;

                if (clt == 1'b1 && cgt == 1'b0 && ceq == 1'b0) begin
                    NState = S4;
                end
                else if (clt == 1'b0 && cgt == 1'b1 && ceq == 1'b0) begin
                    NState = S5;
                end
                else if (clt == 1'b0 && cgt == 1'b0 && ceq == 1'b1) begin
                    NState = S6;
                end
            end
            S4 : begin
                ldA = 1'b0;
                ldB = 1'b1;
                sel1 = 1'bx;
                sel2 = 1'b0;
                sel3 = 1'b0;
                sel4 = 1'b1;
                done = 1'b0;

                NState = S3;
            end
            S5 : begin
                ldA = 1'b1;
                ldB = 1'b0;
                sel1 = 1'b0;
                sel2 = 1'bx;
                sel3 = 1'b1;
                sel4 = 1'b0;
                done = 1'b0;

                NState = S3;
            end
            S6 : begin
                ldA = 1'b0;
                ldB = 1'b0;
                sel1 = 1'bx;
                sel2 = 1'bx;
                sel3 = 1'bx;
                sel4 = 1'bx;
                done = 1'b1;
                
                NState = S0;
            end
        endcase
    end
endmodule
`endif 
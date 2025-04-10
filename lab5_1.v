`ifndef LAB5_1_V
`define LAB5_1_V

module controller (
    ct_clk, ct_reset, ct_load1, ct_load2, ct_sel_alu, ct_ReadWriteEn, ct_start, ct_done
);
    input ct_clk, ct_reset, ct_start;
    output reg ct_load1, ct_load2;
    output reg [2 : 0] ct_sel_alu;
    output reg ct_ReadWriteEn;
    output reg ct_done;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
    reg [2 : 0] PState, NState;

    always @(posedge ct_clk, posedge ct_reset) begin
        if (ct_reset == 1'b1) begin
            PState <= S0;           
        end
       else if (ct_start == 1'b1) begin
            PState <= NState;
       end
    end

    always @(*) begin
        case (PState)
            S0 : begin
                if (ct_start == 1'b1) begin
                    ct_load1 = 1'b0;
                    ct_load2 = 1'b0;
                    ct_sel_alu = 3'bxxx;
                    ct_ReadWriteEn = 1'bx;
                    ct_done = 1'b0;

                    NState = S1;
                end
                else if (ct_start == 1'b0) begin
                    ct_load1 = 1'b0;
                    ct_load2 = 1'b0;
                    ct_sel_alu = 3'bxxx;
                    ct_ReadWriteEn = 1'bx;
                    ct_done = 1'b0;

                    NState = S0;
                end
            end

            S1 : begin
                ct_load1 = 1'b1;
                ct_load2 = 1'b0;
                ct_sel_alu = 3'bxxx;
                ct_ReadWriteEn = 1'bx;
                ct_done = 1'b0;

                NState = S2;
            end
            S2 : begin 
                ct_load1 = 1'b0;
                ct_load2 = 1'b1;
                ct_sel_alu = 3'bxxx;
                ct_ReadWriteEn = 1'bx;
                ct_done = 1'b0;

                NState = S3;
            end
            S3 : begin 
                ct_load1 = 1'b0;
                ct_load2 = 1'b0;
                ct_sel_alu = 3'b101;
                ct_ReadWriteEn = 1'b0;
                ct_done = 1'b0;

                NState = S4;
            end 

            S4 : begin
                ct_load1 = 1'b0;
                ct_load2 = 1'b0;
                ct_sel_alu = 3'bxxx;
                ct_ReadWriteEn = 1'bx;
                ct_done = 1'b0;

                NState = S5;
            end
            S5: begin
                ct_load1 = 1'b0;
                ct_load2 = 1'b0;
                ct_sel_alu = 3'bxxx;
                ct_ReadWriteEn = 1'b1;
                ct_done = 1'b0;

                NState = S6;
            end
            S6 : begin
                ct_load1 = 1'b0;
                ct_load2 = 1'b0;
                ct_sel_alu = 3'bxxx;
                ct_ReadWriteEn = 1'bx;
                ct_done = 1'b1;

                NState = S0;
            end
        endcase
    end
endmodule

`endif 
`ifndef CONTROL3_V
`define CONTROL3_V

module controller (
    c_clk, c_reset, c_start, c_load_A, c_load_Q, c_load_M, c_load_Qm, c_clr_M, c_clr_Q, c_clr_A, c_clr_Qm, c_sel_alu, c_sel_add, c_sel_sub, c_sel_other, c_shift_A, c_shift_Q, c_done, c_eqz, c_decre
);
    input c_clk, c_reset, c_start;
    input c_sel_add, c_sel_sub, c_sel_other;
    output reg c_load_M, c_load_A, c_load_Q, c_load_Qm;
    output reg c_clr_M, c_clr_Q, c_clr_A, c_clr_Qm;
    output reg c_sel_alu;
    output reg c_shift_A, c_shift_Q;
    output reg c_decre;
    input c_eqz;
    output reg c_done;
    reg [2 : 0] PState, NState;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

    always @(posedge c_clk, negedge c_reset) begin
        if (~c_reset) begin
            PState <= S0;
        end
        else PState <= NState;
    end 

    always @(*) begin
        case (PState)
            S0 : begin
                if (c_start == 1'b1) begin
                    c_load_A = 1'b0;
                    c_load_Q = 1'b0;
                    c_load_M = 1'b0;
                    c_load_Qm = 1'b0;
                    c_clr_A = 1'b0;
                    c_clr_Q = 1'b0;
                    c_clr_M = 1'b0;
                    c_clr_Qm = 1'b0;
                    c_sel_alu = 1'b0;
                    c_shift_A = 1'b0;
                    c_shift_Q = 1'b0;
                    c_decre = 1'b0;
                    c_done = 1'b0;

                    NState = S1;
                end
                else begin
                    c_load_A = 1'b0;
                    c_load_Q = 1'b0;
                    c_load_M = 1'b0;
                    c_load_Qm = 1'b0;
                    c_clr_A = 1'b0;
                    c_clr_Q = 1'b0;
                    c_clr_M = 1'b0;
                    c_clr_Qm = 1'b0;
                    c_sel_alu = 1'b0;
                    c_shift_A = 1'b0;
                    c_shift_Q = 1'b0;
                    c_decre = 1'b0;
                    c_done = 1'b0;

                    NState = S0;
                end
            end
            S1 : begin
                c_load_A = 1'b0;
                c_load_Q = 1'b0;
                c_load_M = 1'b0;
                c_load_Qm = 1'b0;
                c_clr_A = 1'b1;
                c_clr_Q = 1'b1;
                c_clr_M = 1'b1;
                c_clr_Qm = 1'b1;
                c_sel_alu = 1'b0;
                c_shift_A = 1'b0;
                c_shift_Q = 1'b0;
                c_decre = 1'b0;
                c_done = 1'b0;

                NState = S2;
            end
            S2 : begin
                c_load_A = 1'b0;
                c_load_Q = 1'b0;
                c_load_M = 1'b1;
                c_load_Qm = 1'b0;
                c_clr_A = 1'b0;
                c_clr_Q = 1'b0;
                c_clr_M = 1'b0;
                c_clr_Qm = 1'b0;
                c_sel_alu = 1'b0;
                c_shift_A = 1'b0;
                c_shift_Q = 1'b0;
                c_decre = 1'b0;
                c_done = 1'b0;

                NState = S3;
            end
            S3 : begin
                c_load_A = 1'b0;
                c_load_Q = 1'b1;
                c_load_M = 1'b0;
                c_load_Qm = 1'b0;
                c_clr_A = 1'b0;
                c_clr_Q = 1'b0;
                c_clr_M = 1'b0;
                c_clr_Qm = 1'b0;
                c_sel_alu = 1'b0;
                c_shift_A = 1'b0;
                c_shift_Q = 1'b0;
                c_decre = 1'b0;
                c_done = 1'b0;

                NState = S4;
            end
            S4 : begin
                c_load_Q = 1'b0;
                c_load_M = 1'b0;
                c_load_Qm = 1'b0;
                c_clr_A = 1'b0;
                c_clr_Q = 1'b0;
                c_clr_M = 1'b0;
                c_clr_Qm = 1'b0;
                c_shift_A = 1'b0;
                c_shift_Q = 1'b0;
                c_decre = 1'b0;
                c_done = 1'b0;

                if (c_sel_add == 1'b1 && c_sel_sub == 1'b0 && c_sel_other == 1'b0) begin
                    c_sel_alu = 1'b0;
                    c_load_A = 1'b1;

                    NState = S5;
                end
                else if (c_sel_add == 1'b0 && c_sel_sub == 1'b1 && c_sel_other == 1'b0) begin
                    c_sel_alu = 1'b1;
                    c_load_A = 1'b1;

                    NState = S5;
                end
                else if (c_sel_add == 1'b0 && c_sel_sub == 1'b0 && c_sel_other == 1'b1) begin
                    c_sel_alu = 1'b0;
                    c_load_A = 1'b0;

                    NState = S5;
                end
            end
            S5 : begin
                c_load_A = 1'b0;
                c_load_Q = 1'b0;
                c_load_M = 1'b0;
                c_load_Qm = 1'b1;
                c_clr_A = 1'b0;
                c_clr_Q = 1'b0;
                c_clr_M = 1'b0;
                c_clr_Qm = 1'b0;
                c_sel_alu = 1'b0;
                c_shift_A = 1'b1;
                c_shift_Q = 1'b1;
                c_decre = 1'b1;
                c_done = 1'b0;
                
                NState = S6;
            end
            S6 : begin
                c_load_A = 1'b0;
                c_load_Q = 1'b0;
                c_load_M = 1'b0;
                c_load_Qm = 1'b0;
                c_clr_A = 1'b0;
                c_clr_Q = 1'b0;                                     
                c_clr_M = 1'b0;
                c_clr_Qm = 1'b0;
                c_shift_A = 1'b0;
                c_shift_Q = 1'b0;
                c_decre = 1'b0;
                c_sel_alu = 1'b0;

                if (c_eqz == 1'b1) begin
                    c_done = 1'b1;
                    
                    NState = S0;
                end
                else if (c_eqz == 1'b0) begin
                    c_done = 1'b0;
                    
                    NState = S4;
                end 
            end
        endcase
    end
endmodule

`endif 
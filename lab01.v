`ifndef LAB01_V
`define LAB01_V

module count_syn (
    preset, clear, inp, outp, reset, clk, start
);
    input preset, clear, reset, clk;
    input start;
    input [2 : 0] inp;
    output reg [2 : 0] outp;
    reg [2 : 0] temp;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;
    reg [2 : 0] PState, NState;
    always @(posedge clk, posedge reset) begin
        if (reset == 1'b1) begin
            PState <= S0; 
        end
        else if (start == 1'b1) begin
            PState <= NState;
        end
        else PState <= S0;
    end

    always @(*) begin
        if (preset == 1'b1 && clear == 1'b0) begin
            case (PState)
            S0 : begin
                    if (inp == 3'b001) begin
                        outp <= 3'b001;
                        NState = S2;
                    end
                    else if (inp == 3'b010) begin
                        outp <= 3'b010;
                        NState = S4;    
                    end
                    else if (inp == 3'b101) begin
                        outp <= 3'b101;

                        NState = S6;
                    end
                    else NState = S1; 
            end
            S1 : begin
                outp <= 3'b000;

                NState = S2;
            end
            S2 : begin
                outp <= 3'b110;

                NState = S3;
            end
            S3 : begin
                outp <= 3'b100;

                NState = S4;
            end
            S4 : begin
                outp <= 3'b111;

                NState = S5;
            end
            S5 : begin
                outp <= 3'b011;

                NState = S1;
            end
            S6 : begin 
                outp <= 3'b010;
                NState = S4;
            end
        endcase
        end
        else if (preset == 1'b0 && clear == 1'b1) begin
            case (PState)
            S0 : begin
                outp <= 3'b000;
                NState = S1;
            end
            S1 : begin
                outp <= 3'b110;
                NState = S2;
            end
            S2 : begin
                outp <= 3'b100;
                NState = S3;
            end
            S3 : begin
                outp <= 3'b111;
                NState = S4;
            end
            S4 : begin
                outp <= 3'b011;
                NState = S0;
            end
            endcase 
        end
    end
endmodule

`endif 
`ifndef TEST1_V
`define TEST1_V 

module reg_control (
    clk, reset, ldA, ldB, ldP, clr_p, decre, done, start, eqz
);
    input clk, reset, start, eqz;
    output reg ldA, ldB, ldP, clr_p, decre, done;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            S0 : begin
                ldA = 1'b1;
                ldB = 1'b0;
                ldP = 1'b0;
                clr_p = 1'b1;
                decre = 1'b0;
                done = 0;
                next_state = S1;
            end
            S1 : begin
                ldA = 1'b0;
                ldB = 1'b1;
                ldP = 1'b0;
                clr_p = 1'b0;
                decre = 1'b0;
                done = 0;
                next_state = S2;
            end
            S2 : begin  
                ldA = 1'b0;
                ldB = 1'b0;
                clr_p = 1'b0;
                done = 0;
                if (eqz) begin
                    decre = 1'b0;
                    ldP = 1'b0;
                    next_state = S3;
                end
                else begin
                    ldP = 1'b1;
                    decre = 1'b1;
                    next_state = S2;
                end
            end
            S3 : begin
                ldA = 1'b0;
                ldB = 1'b0;
                ldP = 1'b0;
                decre = 1'b0;
                clr_p = 1'b0;
                done = 1'b1;
                next_state = S0;
            end
            default: begin
                ldA = 1'b1;
                ldB = 1'b0;
                ldP = 1'b0;
                clr_p = 1'b1;
                decre = 1'b0;
                done = 0;
                next_state = S1;
            end
        endcase
    end
endmodule

`endif 
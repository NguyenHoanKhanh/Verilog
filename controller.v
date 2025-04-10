`ifndef CONTROLLER_V
`define CONTROLLER_V

module controller (clock, reset, start, eqz, ldA, ldP, ldB, decB, clrP, done);
    input clock, reset, start;
    input eqz;
    output reg ldA, ldP, ldB, decB, clrP, done;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] pr_state, nx_state;

    always @(posedge clock, posedge reset) begin
        if (reset) begin
            pr_state <= S0;
        end
        else if (start) begin
            pr_state <= nx_state;
        end
        else begin
            pr_state <= S0;
        end
    end

    always @(*) begin
        case (pr_state)
            S0: begin
                ldA = 1'b1;
                ldP = 1'b0;
                ldB = 1'b0;
                decB = 1'b0;
                clrP = 1'b1;
                done = 1'b0;

                nx_state = S1;
            end

            S1: begin
                ldA = 1'b0;
                ldP = 1'b0;
                ldB = 1'b1;
                decB = 1'b0;
                clrP = 1'bx;
                done = 1'b0;

                nx_state = S2;
            end

            S2: begin
                ldA = 1'b0;
                ldB = 1'b0;
                clrP = 1'b0;
                done = 1'b0;

                if (eqz == 1'b1) begin
                    ldP = 1'b0;
                    decB = 1'b0;
                    nx_state = S3;
                end
                else begin
                    ldP = 1'b1;
                    decB = 1'b1;
                    nx_state = S2;
                end
            end

            S3: begin
                ldA = 1'b0;
                ldP = 1'b0;
                ldB = 1'b0;
                decB = 1'b0;
                clrP = 1'b0;
                done = 1'b1;

                nx_state = S1;
            end  
        endcase
    end
endmodule

`endif 
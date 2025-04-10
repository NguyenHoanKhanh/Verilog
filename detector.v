module mealy (
    clk, a, b, reset
);
    input clk, a, reset;
    output reg b;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1 : 0] PS, NS;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PS <= S0;
        end
        else PS <= NS;
    end

    always @(PS, a) begin
        b = 0;
        case (PS)
            S0 : begin
                if (a == 0) begin
                    NS = S1;
                end
                else if (a == 1) begin
                        NS = S0;
                end
                end 
            S1 : begin
                if (a == 1) begin
                    NS = S2;
                end
                else if (a == 0) begin
                    NS = S1;
                end
            end
            S2 : begin
                if (a == 1) begin
                    NS = S3;
                end
                else if (a == 0) begin
                    NS = S1;
                end
            end
            S3 : begin
                if (a == 0) begin
                    NS = S1;
                    b = 1;
                end
                else if (a == 0) begin
                    NS = S0;
                end
            end
        endcase
    end
endmodule
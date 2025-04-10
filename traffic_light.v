module traffic (
    clk, light
);
    input clk;
    output reg [2 : 0] light;
    parameter red = 3'b000, green = 3'b001, yellow = 3'b010;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1 : 0] state;

    always @(posedge clk) begin
        case (state)
            S0 : 
                begin
                    light <= red; state <= S1;
                end
            S1 : 
                begin
                    light <= green; state <= S2;
                end
            S2 : 
                begin
                    light <= yellow; state <= S0; 
                end
            default:    
                begin
                    light <= red; state <= S0;
                end
        endcase
    end
endmodule
module light (clk, light);
    input clk;
    output reg [2 : 0] light;
    parameter RED = 3'b100, YELLOW = 3'b001, GREEN = 3'b010;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1 : 0] state;

    always @(posedge clk) begin
        case (state)
            S0 : state <= S1;
            S1 : state <= S2;
            S2 : state <= S0;
            default: state <= S0;
        endcase
    end

    always @(state) begin
        case (state) 
            S0 : light = RED;
            S1 : light = GREEN;
            S2 : light = YELLOW;
            default: light = RED;
        endcase
    end
endmodule
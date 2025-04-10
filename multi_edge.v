module multi_edge_clk (a, b, c, d ,f, clk);
    input [7 : 0] a, b, d;
    input clk;
    output reg [7 : 0] c, f;

    always @(posedge clk) begin
        c <= a + b;
    end

    always @(negedge clk) begin
        f <= c - d;
    end
endmodule
module test (
    clk1, clk2, d, q
);
    input clk1, clk2;
	input [3 : 0] d;
    output reg [3 : 0] q;
	wire clk;
	
    assign clk = clk1 & clk2;
    
    always @(posedge clk) begin
			q <= d;
    end
endmodule
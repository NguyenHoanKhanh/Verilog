module counter_7bit (
    clock, clear, count
);
    parameter N = 7;
    input clock, clear;
    output reg [N : 0] count;

    always @(negedge clock) begin
        if (clear) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end
endmodule
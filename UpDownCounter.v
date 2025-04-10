module updown (mode, clr, load, din, clk, count);
    input mode, clr, load, clk;
    input [0 : 7] din;
    output reg [0 : 7] count;

    always @(posedge clk) begin
        if (load) begin
            count <= din;
        end
        else if (clr) begin
            count <= 0;
        end
        else if (mode) begin
            count <= count + 1;
        end
        else begin
            count <= count - 1;
        end
    end
endmodule
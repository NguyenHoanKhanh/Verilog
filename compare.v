module compare_nbit (A, B, lt, gt, eq);
    parameter C = 16;
    input [C - 1 : 0] A, B;
    output reg lt, gt, eq;

    always @(*) begin
        gt = 0; lt = 0; eq = 0;
        if (A > B) begin
            gt = 1;
        end
        else if (A < B) begin
            lt = 1;
        end
        else if (A == B) begin
            eq = 1;
        end
    end
endmodule
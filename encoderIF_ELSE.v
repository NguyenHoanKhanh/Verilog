module encoder (
   sel, a 
);
    input [7 : 0] a;
    output reg [2 : 0] sel;

    always @(*) begin
        if (a[0] == 1 && a[7 : 1] == 0) begin
            sel = 3'b000;
        end
        else if (a[1] == 1 && a[0] == 0 && a[7 : 2] == 0) begin
            sel = 3'b001;
        end
        else if (a[2] == 1 && a[1 : 0] == 0 && a[7 : 3] == 0) begin
            sel = 3'b010;
        end
        else if (a[3] == 1 && a[2 : 0] == 0 && a[7 : 4] == 0) begin
            sel = 3'b011;
        end
        else if (a[4] == 1 && a[3 : 0] == 0 && a[7 : 5] == 0) begin
            sel = 3'b100;
        end
        else if (a[5] == 1 && a[4 : 0] == 0 && a[7 : 6] == 0) begin
            sel = 3'b101;
        end
        else if (a[6] == 1 && a[5 : 0] == 0 && a[7] == 0) begin
            sel = 3'b110;
        end
        else if (a[7] == 1 && a[6 : 0] ==0) begin
            sel = 3'b111;
        end
    end
endmodule
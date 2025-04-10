`ifndef DATAPATH2_V
`define DATAPATH2_V

module Load_reg (
    inp, outp, load, reset, clk
);
    input [15 : 0] inp;
    input clk, reset, load;
    output reg [15 : 0] outp;
    reg [15 : 0] temp;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            temp <= 16'b0;
        end
        else if (load) begin
            temp <= inp;
        end
    end

    always @(*) begin
        outp = temp;
    end
endmodule

module compare (
    a, b, lt, gt, eq
);
    input [15 : 0] a, b;
    output reg lt, gt, eq;
    
    always @(*) begin
        if (a > b) begin
            lt = 1'b0;
            eq = 1'b0;
            gt = 1'b1;
        end
        else if (a < b) begin
            lt = 1'b1;
            gt = 1'b0;
            eq = 1'b0;
        end
        else if (a == b) begin
            lt = 1'b0;
            gt = 1'b0;
            eq = 1'b1;
        end
    end
endmodule

module subtract (
    a, b, sub
);
    input [15 : 0] a, b;
    output [15 : 0] sub;

    assign sub = a - b;
endmodule

module mux21 (
    a, b, sel, out
);
    input [15 : 0] a, b;
    input sel;
    output reg [15 : 0] out;

    always @(*) begin
        if (sel == 1'b1) begin
            out = a;
        end
        else if (sel == 1'b0) begin
            out = b;
        end
    end
endmodule 

module datapath (
    clk, rst, done, inp, outp, sel1, sel2, sel3, sel4, temp_lt, temp_gt, temp_eq, load_A, load_B
);
    input clk, rst;
    input [15 : 0] inp;
    input sel1, sel2, sel3, sel4;
    input load_A, load_B;
    output reg [15 : 0] outp;
    input done;
    output temp_lt, temp_gt, temp_eq;
    wire [15 : 0] temp_M1, output_SUB, temp_M2, out_A, out_B, temp_M3, temp_M4;
    mux21 M (
        .a(inp),
        .b(output_SUB),
        .sel(sel1),
        .out(temp_M1)
    );

    mux21 M1 (
        .a(inp),
        .b(output_SUB),
        .sel(sel2),
        .out(temp_M2)
    );

    Load_reg A (
        .clk(clk),
        .reset(rst),
        .inp(temp_M1),
        .load(load_A),
        .outp(out_A)
    );

    Load_reg B (
        .clk(clk),
        .reset(rst),
        .inp(temp_M2),
        .load(load_B),
        .outp(out_B)
    );

    compare C (
        .a(out_A),
        .b(out_B),
        .lt(temp_lt), 
        .gt(temp_gt),
        .eq(temp_eq)
    );

    mux21 M2 (
        .a(out_A),
        .b(out_B),
        .sel(sel3),
        .out(temp_M3)
    );

    mux21 M3 (
        .a(out_A),
        .b(out_B),
        .sel(sel4),
        .out(temp_M4)
    );

    subtract S (
        .a(temp_M3),
        .b(temp_M4),
        .sub(output_SUB)
    );

    always @(*) begin
        outp = (done == 1'b1) ? out_A : 16'bz;
    end

endmodule

`endif 
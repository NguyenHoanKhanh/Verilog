`ifndef LAB3_1_v
`define LAB3_1_v
module AND32 (
    inp1, inp2, outp
);
    input [31 : 0] inp1, inp2;
    output [31 : 0] outp;

    assign outp = inp1 & inp2;
endmodule

module OR32 (
    inp1, inp2, outp
);
    input [31 : 0] inp1, inp2;
    output [31 : 0] outp;

    assign outp = inp1 | inp2;
endmodule

module XOR32 (
    inp1, inp2, outp
);
    input [31 : 0] inp1, inp2;
    output [31 : 0] outp;

    assign outp = inp1 ^ inp2;
endmodule

module FullAdder (
    inp1, inp2, Cin, Cout, Sum
);
    input inp1, inp2;
    input Cin;
    output Cout, Sum;
    wire t1, t2, t3, t4;

    xor x1 (t1, inp1, inp2);
    xor x2 (Sum, t1, Cin);
    and a1 (t3, inp1, inp2);
    and a2 (t4, t1, Cin);
    or o1 (Cout, t3, t4);
endmodule

module INCREMENT (
    inp1, outp, overflow, carryout
);
    input [31 : 0] inp1;
    output [31 : 0] outp;
    output overflow, carryout;
    wire [31 : 0] inp2;
    wire [31 : 0] t;
    genvar i;
    assign inp2 = 32'h00000001;
    assign t[0] = 1'b0;
    generate
        for (i = 0; i < 31; i = i + 1)
            begin
                FullAdder fa (.inp1(inp1[i]), .inp2(inp2[i]), .Cin(t[i]), .Sum(outp[i]), .Cout(t[i + 1]));
            end
            FullAdder fa31 (.inp1(inp1[31]), .inp2(inp2[31]), .Cin(t[31]), .Sum(outp[31]), .Cout(carryout));
    endgenerate

    assign overflow = t[31] ^ t[30];
endmodule

module ADD32 (
    inp1, inp2, outp, overflow, carryout
);
    input [31 : 0] inp1, inp2;
    output [31 : 0] outp;
    output overflow;
    output carryout;
    wire [31 : 0] t;
    genvar i;

    assign t[0] = 1'b0;
    
    generate 
        for (i = 0; i < 31; i = i + 1)
            begin 
                FullAdder F (.inp1(inp1[i]), .inp2(inp2[i]), .Cin(t[i]), .Sum(outp[i]), .Cout(t[i + 1]));
            end
                FullAdder lastF (.inp1(inp1[31]), .inp2(inp2[31]), .Cin(t[31]), .Sum(outp[31]), .Cout(carryout));
    endgenerate

    assign overflow = t[30] ^ t[31];
endmodule 

module DECREMENT (
    inp1, outp, carryout
);
    input [31 : 0] inp1;
    output signed [31 : 0] outp;
    output carryout;

    wire [31 : 0] inp2;
    wire [31 : 0] t;
    genvar i;
    assign inp2 = 32'hFFFFFFFF;
    assign t[0] = 1'b0;

    generate
        for (i = 0; i < 31; i = i + 1)
            begin
                FullAdder fa (.inp1(inp1[i]), .inp2(inp2[i]), .Cin(t[i]), .Sum(outp[i]), .Cout(t[i + 1]));
            end
                FullAdder fa31 (.inp1(inp1[31]), .inp2(inp2[31]), .Cin(t[31]), .Sum(outp[31]), .Cout(carryout));
    endgenerate
endmodule 

module SUB32 (
    inp1, inp2, Subout, carryout
);
    input [31 : 0] inp1, inp2;
    output signed [31 : 0] Subout;
    output carryout;
    wire [31 : 0] t, temp_inp2;
    assign t[0] = 1'b1;
    genvar i;

    generate 
        for (i = 0; i <= 31; i = i + 1)
            begin
                not n (temp_inp2[i], inp2[i]);
            end
    endgenerate

    generate 
        for (i = 0; i < 31; i = i + 1)
            begin
                FullAdder fa (.inp1(inp1[i]), .inp2(temp_inp2[i]), .Cin(t[i]), .Sum(Subout[i]), .Cout(t[i + 1]));
            end
                FullAdder fa31 (.inp1(inp1[31]), .inp2(temp_inp2[31]), .Cin(t[31]), .Sum(Subout[31]), .Cout(carryout));
    endgenerate
endmodule 

module complement (
    inp, outp
);
    input [31 : 0] inp;
    output [31 : 0] outp;

    assign outp = ~inp;
endmodule

module ALU (
    inp1, inp2, outp, carryout, sel_alu, overflow
);
    input [31 : 0] inp1, inp2;
    input [2 : 0] sel_alu;
    output reg signed [31 : 0] outp;
    output reg carryout;
    output reg overflow;
    wire signed [31 : 0] out_comp, out_and, out_xor, out_or, out_de, out_add, out_sub, out_inc;
    wire overflow_add, overflow_in;
    wire carryout_de, carryout_in, carryout_add, carryout_sub;
    reg [31 : 0] temp_out;
    reg temp_carry, temp_over;

    complement C (.inp(inp1), .outp(out_comp));
    AND32 A32 (.inp1(inp1), .inp2(inp2), .outp(out_and));
    XOR32 X32 (.inp1(inp1), .inp2(inp2), .outp(out_xor));
    OR32 O32 (.inp1(inp1), .inp2(inp2), .outp(out_or));
    DECREMENT DE32 (.inp1(inp1), .outp(out_de), .carryout(carryout_de));
    ADD32 AD32 (.inp1(inp1), .inp2(inp2), .outp(out_add), .overflow(overflow_add), .carryout(carryout_add));
    SUB32 SU32 (.inp1(inp1), .inp2(inp2), .Subout(out_sub), .carryout(carryout_sub));
    INCREMENT IN32 (.inp1(inp1), .outp(out_inc), .overflow(overflow_in), .carryout(carryout_in));

    always @(*) begin
        if (sel_alu == 3'b000) begin
            temp_out <= out_comp;
        end
        else if (sel_alu == 3'b001) begin
            temp_out <= out_and;
        end
        else if (sel_alu == 3'b010) begin
            temp_out <= out_xor;
        end
        else if (sel_alu == 3'b011) begin
            temp_out <= out_or;
        end
        else if (sel_alu == 3'b100) begin
            temp_out <= out_de;
            temp_carry <= carryout_de;
        end
        else if (sel_alu == 3'b101) begin
            temp_out <= out_add;
            temp_carry <= carryout_add;
            temp_over <= overflow_add;
        end
        else if (sel_alu == 3'b110) begin
            temp_out <= out_sub;
            temp_carry <= carryout_sub;
        end
        else if (sel_alu == 3'b111) begin
            temp_out <= out_inc;
            temp_carry <= carryout_in;
        end
    end

    always @(*) begin
        outp = temp_out;
        carryout = temp_carry;
        overflow = temp_over;
    end
endmodule

`endif 
`ifndef DATA_V
`define DATA_V

module load_reg (
    clk, clr, reset, inp, outp, dec, load
);
    input clk, clr, reset, dec, load;
    input [15 : 0] inp;
    output reg [15 : 0] outp;
    reg [15 : 0] temp;

    always @(posedge clk , posedge reset) begin
        if (reset) begin
            temp <= 16'bz;
        end
        else if (clr) begin
            temp <= 16'b0;
        end
        else if (load) begin
            temp <= inp;
        end
        else if (dec) begin
            temp <= temp - 1;
        end
    end

    always @(*) begin
        outp = temp;
    end
endmodule

module addition (
    a, b, result
);
    input [15 : 0] a, b;
    output [15 : 0] result;
    
    assign result = a + b;
endmodule

module compare (
    eqz, inp
);
    input [15 : 0] inp;
    output reg eqz;

    always @(*) begin
        if (inp == 16'b0) begin 
            eqz = 1'b1;
        end
        else eqz = 1'b0;
    end
endmodule

module datapath (
    clk, reset, clrP, decB, load_A, load_B, load_P, eqz, in, out, done
);
    input clk, reset, clrP, decB, load_A, load_B, load_P, done;
    input [15 : 0] in;
    output reg [15 : 0] out;
    output eqz;
    wire [15 : 0] temp_A, temp_B, temp_P, temp_ADD;

    load_reg A (
        .clk(clk),
        .reset(reset),
        .clr(1'b0),
        .dec(1'b0),
        .load(load_A),
        .inp(in),
        .outp(temp_A)
    );

    load_reg B (
        .clk(clk),
        .reset(reset),
        .clr(1'b0),
        .dec(decB),
        .load(load_B),
        .inp(in),
        .outp(temp_B)
    );

    load_reg P (
        .clk(clk),
        .reset(reset),
        .clr(clrP),
        .dec(1'b0),
        .load(load_P),
        .inp(temp_ADD),
        .outp(temp_P)
    );

    addition ADD (
        .a(temp_A),
        .b(temp_P),
        .result(temp_ADD)
    );

    compare CP (
        .inp(temp_B),
        .eqz(eqz)
    );

    always @(*) begin
        out = (done == 1'b1) ? (temp_P) : (16'bz);
    end
endmodule

`endif 
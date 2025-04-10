`ifndef DATAPATH_V
`define DATAPATH_V

module dec_reg (clock, reset, load, clear, decrease, data_in, data_out);
    input clock, reset, load, clear, decrease;
    input [15:0] data_in;
    output reg [15:0] data_out;

    reg [15:0] temp;

    always @(posedge clock, posedge reset) begin
        if (reset) begin
            temp <= 16'bz;
        end
        else if (load) begin
            temp <= data_in;
        end
        else if (clear) begin
            temp <= 16'd0;
        end
        else if (decrease) begin
            temp <= temp - 1;
        end
    end

    always @(*) begin
        data_out = temp;
    end
endmodule

module adder (data_A, data_B, sum);
    input [15:0] data_A, data_B;
    output [15:0] sum;

    assign sum = data_A + data_B;
endmodule

module comp (data_in, eqz);
    input [15:0] data_in;
    output eqz;

    assign eqz = (data_in == 16'd0) ? 1'b1 : 1'b0;
endmodule

module datapath (clock, reset, ldA, ldB, ldP, decB, clrP, done, data_in, eqz, result);
    input clock, reset;
    input ldA, ldP, ldB;
    input decB, clrP;
    input done;
    input [15:0] data_in;
    output eqz;
    output reg [15:0] result;

    wire [15:0] temp_regA, temp_regP, temp_regB, temp_adder;

    dec_reg reg_A (
        .clock(clock),
        .reset(reset),
        .load(ldA),
        .clear(1'b0),
        .decrease(1'b0),
        .data_in(data_in),
        .data_out(temp_regA)
    );

    dec_reg reg_P (
        .clock(clock),
        .reset(reset),
        .load(ldP),
        .clear(clrP),
        .decrease(1'b0),
        .data_in(temp_adder),
        .data_out(temp_regP)
    );

    dec_reg reg_B (
        .clock(clock),
        .reset(reset),
        .load(ldB),
        .clear(1'b0),
        .decrease(decB),
        .data_in(data_in),
        .data_out(temp_regB)
    );

    adder ALU (
        .data_A(temp_regA),
        .data_B(temp_regP),
        .sum(temp_adder)
    );

    comp comparator (
        .data_in(temp_regB),
        .eqz(eqz)
    );

    always @(*) begin
        result = (done == 1'b1) ? temp_regP : 16'bz;
    end
endmodule

`endif 
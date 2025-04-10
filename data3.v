`ifndef DATA3_V
`define DATA3_V

module load_reg (
    inp, out, load, clr, shift, reset, clk, s_in
);
    input clk, reset;
    input s_in;
    input [15 : 0] inp;
    output [15 : 0] out;
    input load, shift, clr;
    reg [15 : 0] reg_data;

    always @(posedge clk, negedge reset) begin
        if (~reset) begin
            reg_data <= 16'bz;
        end
        else if (load == 1'b1) begin
            reg_data <= inp;
        end
        else if (clr == 1'b1) begin
            reg_data <= 16'b0;
        end
        else if (shift == 1'b1) begin
            reg_data <= {s_in, reg_data[15 : 1]};
        end
    end
	 
    assign out = reg_data;
endmodule

module load (
    inp, clk, rst, out, clr, load
);
    input clk, rst, clr, load;
    input inp;
    output out;
    reg temp;

    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            temp <= 1'bz;
        end
        else if (clr == 1'b1) begin
            temp <= 1'b0;
        end
        else if (load == 1'b1) begin
            temp <= inp;
        end
    end

    assign out = temp;
endmodule

module addition (
    inp1, inp2, out_add
);
    input [15 : 0] inp1, inp2;
    output [15 : 0] out_add;

    assign out_add = inp1 + inp2;
endmodule

module subtraction (
    inp1, inp2, out_sub
);
    input [15 : 0] inp1, inp2;
    output [15 : 0] out_sub;

    assign out_sub = inp1 - inp2;
endmodule   

module ALU (
    inp1, inp2, out_ALU, sel_alu
);
    input [15 : 0] inp1, inp2;
    input sel_alu;
    output [15 : 0] out_ALU;
    wire [15 : 0] out_add, out_sub;

    addition AD (.inp1(inp1), .inp2(inp2), .out_add(out_add));
    subtraction ST (.inp1(inp1), .inp2(inp2), .out_sub(out_sub));

    assign out_ALU = (sel_alu) ? out_sub : out_add;
endmodule

module compare (
    inp1, inp2, sel_add, sel_sub, sel_other
);
    input inp1, inp2;
    output reg sel_add, sel_sub, sel_other;

    always @(*) begin
        sel_add = 1'b0;
        sel_sub = 1'b0;
        sel_other = 1'b0;

        if (inp1 === 1'bx || inp2 === 1'bx) begin
            sel_other = 1'b1;
        end
        else if (inp1 == 0 && inp2 == 1) begin
            sel_add = 1'b1;
        end
        else if (inp1 == 1 && inp2 == 0) begin
            sel_sub = 1'b1;
        end
        else if ((inp1 == 1'b0 && inp2 == 1'b0) || (inp1 == 1'b1 && inp2 == 1'b1)) begin
            sel_other = 1'b1; 
        end
    end
endmodule

module Decrement (
	decre, count, eqz, clk, rst
);
	input clk, rst, decre;
	output reg [4 : 0] count = 5'b10000;
	output reg eqz;
	
	always @(posedge clk, negedge rst) begin
		if (~rst) begin	
			count <= 5'b10000;
			eqz <= 1'b0;
		end
		else if (decre == 1'b1) begin	
			if (count > 1) begin
				count <= count - 1;
                eqz <= 1'b0;
			end
			else begin
                count <= 1'b0;
				eqz <= 1'b1;
			end
		end
	end
endmodule

module datapath (
    d_inp1, d_inp2, d_clk, d_rst, d_clr_M, d_clr_Q, d_clr_A, d_clr_Qm, d_load_M, d_load_Q, d_load_A, d_load_Qm, d_shift_Q, d_shift_A, d_sel_add, d_sel_sub, d_sel_other, d_sel_alu, d_done, d_decre, d_out, d_eqz
);
    input d_clk, d_rst;
    input d_clr_A, d_clr_M, d_clr_Q, d_clr_Qm;
    input d_load_A, d_load_M, d_load_Q, d_load_Qm;
    input d_shift_Q, d_shift_A;
    output d_sel_add, d_sel_sub, d_sel_other;
    input d_sel_alu;
    input [15 : 0] d_inp1, d_inp2;
    input d_decre;
    output d_eqz;
    input d_done;
    wire [4 : 0] d_count;
    output reg [31 : 0] d_out;
    wire [15 : 0] temp_M, temp_Q, temp_A, result_ALU;
    wire temp_Qm;
    reg prev_Q0;
    reg [15 : 0] prev_A;

    load_reg M (
        .inp(d_inp1), 
        .out(temp_M), 
        .load(d_load_M), 
        .clr(d_clr_M), 
        .shift(1'b0), 
        .reset(d_rst), 
        .clk(d_clk), 
        .s_in(1'b0)       
    );

    load_reg Q (
        .inp(d_inp2), 
        .out(temp_Q), 
        .load(d_load_Q), 
        .clr(d_clr_Q), 
        .shift(d_shift_Q), 
        .reset(d_rst), 
        .clk(d_clk), 
        .s_in(temp_A[0])
    );

    load_reg A (
        .inp((d_sel_other == 1'b1) ? temp_A : result_ALU), 
        .out(temp_A), 
        .load(d_load_A), 
        .clr(d_clr_A), 
        .shift(d_shift_A), 
        .reset(d_rst), 
        .clk(d_clk), 
        .s_in(temp_A[15])
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (~d_rst) begin
            prev_Q0 <= 1'b0;
        end
        else begin
            prev_Q0 <= temp_Q[0];
        end
    end

    always @(posedge d_clk, negedge d_rst) begin
        if (~d_rst) begin
            prev_A <= 16'd0;
        end
        else begin
            prev_A <= temp_A;
        end
    end


    load Qm (
        .inp(temp_Q[0]), 
        .clk(d_clk), 
        .rst(d_rst), 
        .out(temp_Qm), 
        .clr(d_clr_Qm), 
        .load(d_load_Qm)
    );

    compare cp (
        .inp1(prev_Q0),
        .inp2(temp_Qm),
        .sel_add(d_sel_add),
        .sel_sub(d_sel_sub),
        .sel_other(d_sel_other)
    );

    ALU cal (
        .inp1(prev_A), 
        .inp2(temp_M), 
        .out_ALU(result_ALU), 
        .sel_alu(d_sel_alu)
    );

    Decrement dec (
        .decre(d_decre), 
        .count(d_count), 
        .eqz(d_eqz), 
        .clk(d_clk), 
        .rst(d_rst)
    );

    always @(posedge d_clk, negedge d_rst) begin
        if (~d_rst) begin
            d_out <= 32'b0;
        end
        else if (d_done == 1'b1) begin
            d_out <= {temp_A, temp_Q};
        end
    end
endmodule

`endif 
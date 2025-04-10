`include "lab01_2.v"
`include "lab3_1.v"
`ifndef LAB4_1_v
`define LAB4_1_v

module load_reg (
    inp, outp, clk, reset, load
);
    input clk, reset, load;
    input [31 : 0] inp;
    output reg [31 : 0] outp;   
    reg [31 : 0] temp;

    always @(posedge clk, posedge reset) begin
        if (reset == 1'b1) begin
            temp <= 32'b0;
        end    
        else if (load == 1'b1) begin
            temp <= inp;
        end
    end    

    always @(*) begin
        outp = temp;
    end
endmodule

module datapath (
    dp_inp1, dp_inp2, dp_sel_alu, dp_ReadAddress, dp_WriteAddress, dp_ReadWriteEn, dp_clk, dp_load1, dp_load2, dp_reset, dp_done, dp_read_datapath, dp_carryout, dp_overflow
);  
    input dp_clk, dp_reset;
    input [31 : 0] dp_inp1, dp_inp2;
    input dp_load1, dp_load2;
    input [2 : 0] dp_sel_alu; 
    input dp_done;
    input [4 : 0] dp_ReadAddress, dp_WriteAddress;
    input dp_ReadWriteEn;
    output reg [31 : 0] dp_read_datapath;
    output dp_carryout, dp_overflow;
    wire [31 : 0] temp_A, temp_B;
    wire [31 : 0] outp_ADD;
    wire [31 : 0] dp_ReadData;

    load_reg A (
        .clk(dp_clk),
        .load(dp_load1),
        .inp(dp_inp1),
        .outp(temp_A),
        .reset(dp_reset)
    );

    load_reg B (
        .clk(dp_clk),
        .load(dp_load2),
        .inp(dp_inp2),
        .outp(temp_B),
        .reset(dp_reset)
    );

    ALU AL (
        .inp1(temp_A),
        .inp2(temp_B),
        .outp(outp_ADD), 
        .carryout(dp_carryout),
        .sel_alu(dp_sel_alu),
        .overflow(dp_overflow)
    );

    register_file LW_SW (
        .ReadAddress1(dp_ReadAddress),
        .ReadAddress2(5'b0),
        .WriteAddress(dp_WriteAddress),
        .WriteData(outp_ADD),
        .ReadWriteEn(dp_ReadWriteEn),
        .clk(dp_clk),
        .ReadData1(dp_ReadData),
        .ReadData2()
    );

    always @(*) begin
        dp_read_datapath = (dp_done == 1'b1) ? dp_ReadData : 32'bz;
    end

endmodule

`endif 
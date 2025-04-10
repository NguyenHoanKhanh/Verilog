`ifndef FA_ANOTHER_V
`define FA_ANOTHER_V

module FA (
    data_1, data_2, Cin, Cout, Sum
);
    input data_1, data_2;
    input Cin;
    output Cout, Sum;

    assign Sum = data_1 ^ data_2 ^ Cin;
    assign Cout = (data_1 & data_2) | ((data_1 ^ data_2) & Cin);
endmodule

module Adder_16bit (
    d_1, d_2, Cout, Sum
);
    input [15 : 0] d_1, d_2;
    wire Cin;
    output Cout;
    output [15 : 0] Sum;
    wire [15 : 0] t;
    assign Cin = 1'b0;

    // // Normal
    // FA f0 (.data_1(d_1[0]), .data_2(d_2[0]), .Cin(Cin), .Cout(t[0]), .Sum(Sum[0]));
    // FA f1 (.data_1(d_1[1]), .data_2(d_2[1]), .Cin(t[0]), .Cout(t[1]), .Sum(Sum[1]));
    // FA f2 (.data_1(d_1[2]), .data_2(d_2[2]), .Cin(t[1]), .Cout(t[2]), .Sum(Sum[2]));
    // FA f3 (.data_1(d_1[3]), .data_2(d_2[3]), .Cin(t[2]), .Cout(t[3]), .Sum(Sum[3]));
    // FA f4 (.data_1(d_1[4]), .data_2(d_2[4]), .Cin(t[3]), .Cout(t[4]), .Sum(Sum[4]));
    // FA f5 (.data_1(d_1[5]), .data_2(d_2[5]), .Cin(t[4]), .Cout(t[5]), .Sum(Sum[5]));
    // FA f6 (.data_1(d_1[6]), .data_2(d_2[6]), .Cin(t[5]), .Cout(t[6]), .Sum(Sum[6]));
    // FA f7 (.data_1(d_1[7]), .data_2(d_2[7]), .Cin(t[6]), .Cout(t[7]), .Sum(Sum[7]));
    // FA f8 (.data_1(d_1[8]), .data_2(d_2[8]), .Cin(t[7]), .Cout(t[8]), .Sum(Sum[8]));
    // FA f9 (.data_1(d_1[9]), .data_2(d_2[9]), .Cin(t[8]), .Cout(t[9]), .Sum(Sum[9]));
    // FA f10 (.data_1(d_1[10]), .data_2(d_2[10]), .Cin(t[9]), .Cout(t[10]), .Sum(Sum[10]));
    // FA f11 (.data_1(d_1[11]), .data_2(d_2[11]), .Cin(t[10]), .Cout(t[11]), .Sum(Sum[11]));
    // FA f12 (.data_1(d_1[12]), .data_2(d_2[12]), .Cin(t[11]), .Cout(t[12]), .Sum(Sum[12]));
    // FA f13 (.data_1(d_1[13]), .data_2(d_2[13]), .Cin(t[12]), .Cout(t[13]), .Sum(Sum[13]));
    // FA f14 (.data_1(d_1[14]), .data_2(d_2[14]), .Cin(t[13]), .Cout(t[14]), .Sum(Sum[14]));
    // FA f15 (.data_1(d_1[15]), .data_2(d_2[15]), .Cin(t[14]), .Cout(Cout), .Sum(Sum[15]));
    
    //Use FOR loop
    // genvar i;
    // generate
    //         FA f0 (.data_1(d_1[0]), .data_2(d_2[0]), .Cin(Cin), .Cout(t[0]), .Sum(Sum[0]));
    //     for (i = 1 ;i < 15; i = i + 1 ) begin
    //         FA f (.data_1(d_1[i]), .data_2(d_2[i]), .Cin(t[i - 1]), .Cout(t[i]), .Sum(Sum[i]));
    //     end
    //         FA f1 (.data_1(d_1[15]), .data_2(d_2[15]), .Cin(t[14]), .Cout(Cout), .Sum(Sum[15]));
    // endgenerate

endmodule
`endif 
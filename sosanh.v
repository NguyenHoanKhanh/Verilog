//=> Blocking 
// module compare (
//     inp1, inp2, lt, gt, eq
// );
//     input [3 : 0] inp1, inp2;   
//     output reg lt, gt, eq;

//     always @(*) begin
//         if (inp1 < inp2) begin
//             lt = 1'b1;
//             gt = 1'b0;
//             eq = 1'b0;
//         end
//         else if (inp1 > inp2) begin
//             gt = 1'b1;
//             lt = 1'b0;
//             eq = 1'b0;
//         end
//         else if (inp1 == inp2) begin
//             eq = 1'b1;
//             lt = 1'b0;
//             gt = 1'b0;
//         end
//     end
// endmodule

//=> Non - Blocking 
// module compare (
//     inp1, inp2, lt, gt, eq
// );
//     input [3 : 0] inp1, inp2;   
//     output reg lt, gt, eq;

//     always @(*) begin
//         if (inp1 < inp2) begin
//             lt <= 1'b1;
//             gt <= 1'b0;
//             eq <= 1'b0;
//         end
//         else if (inp1 > inp2) begin
//             gt <= 1'b1;
//             lt <= 1'b0;
//             eq <= 1'b0;
//         end
//         else if (inp1 == inp2) begin
//             eq <= 1'b1;
//             lt <= 1'b0;
//             gt <= 1'b0;
//         end
//     end
// endmodule


// => Behavioral
// module compare (
//     inp1, inp2, l, g, e
// );
//     input [3 : 0] inp1, inp2;
//     output l, g, e;

//     assign l = (inp1 < inp2) ? 1'b1 : 1'b0;
//     assign g = (inp1 > inp2) ? 1'b1 : 1'b0;
//     assign e = (inp1 == inp2) ? 1'b1 : 1'b0;
// endmodule

// => Structure
// module sosanh (
//     lt, gt, eq, a, b
// );
//     parameter N = 26;
//     input [3 : 0] a, b;
//     output lt, gt, eq;
//     wire [N - 1 : 0] t;

//     not n0 (t[0], a[3]);
//     not n1 (t[1], b[3]);
//     not n2 (t[2], a[2]);
//     not n3 (t[3], b[2]);
//     not n4 (t[4], a[1]);
//     not n5 (t[5], b[1]);
//     not n6 (t[6], a[0]);
//     not n7 (t[7], b[0]);

//     and a0 (t[8], b[3], t[0]);
//     and a1 (t[9], a[3], t[1]);
//     and a2 (t[10], b[2], t[2]);
//     and a3 (t[11], a[2], t[3]);
//     and a4 (t[12], b[1], t[4]);
//     and a5 (t[13], a[1], t[5]);
//     and a6 (t[14], b[0], t[6]);
//     and a7 (t[15], a[0], t[7]);

//     nor nr0 (t[16], t[8], t[9]);
//     nor nr1 (t[17], t[10], t[11]);
//     nor nr2 (t[18], t[12], t[13]);
//     nor nr3 (t[19], t[14], t[15]);

//     and a8 (t[20], t[16], t[10]);
//     and a9 (t[21], t[16], t[11]);
//     and a10 (t[22], t[16], t[17], t[12]);
//     and a11 (t[23], t[16], t[17], t[13]);
//     and a12 (t[24], t[16], t[17], t[18], t[14]);
//     and a13 (t[25], t[16], t[17], t[18], t[15]);
//     and a14 (eq, t[16], t[17], t[18], t[19]);

//     or o1 (lt, t[8], t[20], t[22], t[24]);
//     or o2 (gt, t[9], t[21], t[23], t[25]);

// endmodule
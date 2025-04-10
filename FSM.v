`ifndef FSM_V
`define FSM_V
module MSSV (
    inp, outp, done, clk, rst, detect, sum
);
    input clk, rst;
    input [2 : 0] inp;
    output reg [2 : 0] outp;
    output reg done;
    output reg [1 : 0] detect;
    output reg [3 : 0] sum;
    reg [2 : 0] temp [3 : 0];
    // wire [2 : 0] temp;
    reg [2 : 0] PState, NState;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

    // assign temp = inp;   
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PState <= S0;
        end
        else PState <= NState;
    end

    // always @(*) begin
    //     if ((PState == S4) && (temp % 2 == 0)) begin
    //         detect = 2'd1;
    //     end
    //     else if ((PState != S4) && (temp % 2 != 0)) begin
    //         detect = 2'd2;
    //     end
    // end

    always @(*) begin
        case (PState)
            S0 : begin
                outp = 3'd0;
                sum = 4'd0;
                detect = 2'b0;
                done = 0;
                if (inp == 3'd0) begin
                    NState = S1;
                end 
                else begin
                    NState = S0;
                end
            end
            S1 : begin
                outp = 3'd0;
                temp[0] = outp;
                detect = 2'b0;
                done = 0;
                if (inp == 3'd6) begin
                    NState = S2;
                end
                else if (inp == 3'd0) begin
                    NState = S1;    
                end
            end
            S2 : begin
                outp = 3'd6;
                temp[1] = outp;
                detect = 2'b0;
                sum = 4'd0;
                temp[1] = outp;
                done = 0;
                if (inp == 3'd4) begin
                    NState = S3;
                end
                else if (inp == 3'd0) begin
                    NState = S1;
                end
                else NState = S0;
            end
            S3 : begin 
                outp = 3'd4;
                temp[2] = outp;
                detect = 2'd0;
                sum = 4'd0;
                done = 0;
                if (inp == 3'd2) begin
                    NState = S4;
                end
                else if (inp == 3'd0) begin
                    NState = S1;
                end
                else if (inp != 3'd2) begin
                    NState = S0;
                end
            end 
            S4 : begin
                outp = 3'd2;
                temp[3] = outp;
                if ((PState == S4) && (outp % 2 == 0)) begin
                    detect = 2'd1;
                end
                else detect = 2'd2;
                done = 1;
                sum = temp[0] + temp[1] + temp[2] + temp[3];
                NState = S0;
            end
            default: 
                outp = 3'd0;
        endcase
    end
endmodule

`endif 
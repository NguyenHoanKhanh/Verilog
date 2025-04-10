`ifndef MEALY_V
`define MEALY_V

module mealy (
    inp, outp, done, clk, rst, detect
);
    input clk, rst;
    input [2 : 0] inp;
    output reg [2 : 0] outp;
    output reg done;
    // wire [2 : 0] temp; 
    output reg [1 : 0] detect;
    reg [1 : 0] PState, NState;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    // assign temp = inp;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PState <= S0;
        end
        else PState <= NState;
    end

    // always @(*) begin
    //     if ((PState == S3) && (temp % 2 == 0)) begin
    //         detect = 2'd1;
    //     end
    //     else detect = 2'd2;
    // end

    always @(*) begin
        case (PState)
            S0 : begin
                if (inp == 3'd0) begin
                    outp = 3'd0;
                    detect = 2'd0;
                    done = 0;
                    NState = S1;
                end 
                else if (inp != 3'd0) begin
                    NState = S0;
                end
            end
            S1 : begin
                if (inp == 3'd6) begin
                    outp = 3'd6;
                    detect = 2'd0;
                    done = 0;
                    NState = S2;
                end
                else if (inp == 3'd0 | inp != 3'd6) begin
                    NState = S0;    
                end
            end
            S2 : begin
                if (inp == 3'd4) begin
                    outp = 3'd4;
                    detect = 2'd0;
                    done = 0;
                    NState = S3;
                end
                else if (inp == 3'd0) begin
                    NState = S1;
                end
                else NState = S0;
            end
            S3 : begin 
                if (inp == 3'd2) begin
                    outp = 3'd2;
                    if ((PState == S3) && (outp % 2 == 0)) begin
                        detect = 2'd1;
                    end
                    else begin
                        detect = 2'd2;
                    end
                    done = 1;
                    NState = S0;
                end
                else if (inp != 3'd2) begin
                    NState = S0;
                end
            end 

            default: 
                outp <= 3'd0;
        endcase
    end
endmodule

`endif 
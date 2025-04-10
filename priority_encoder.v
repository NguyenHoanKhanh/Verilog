module prio_encoder (in, code);
    input [7 : 0] in;
    output reg [2 : 0] code;

    always @(in) begin
        case (in)
            0 : code = 3'b000;
            1 : code = 3'b001;
            2 : code = 3'b010;
            3 : code = 3'b011;
            4 : code = 3'b100;
            5 : code = 3'b101; 
            6 : code = 3'b110;
            7 : code = 3'b111;
            default : code = 3'bxxx; 
        endcase
    end
endmodule
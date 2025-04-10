module oddeven (
    clk, result, x
);
    input clk, x;
    output reg result;
    reg even_odd;
    parameter EVEN = 0, ODD = 1;
    // always @(posedge clk) begin
    //     case (even_odd)
    //         EVEN : 
    //             begin 
    //                 result <= x ? 1 : 0; 
    //                 even_odd <= x ? ODD : EVEN;
    //             end
    //         ODD : 
    //             begin 
    //                 result <= x ? 0 : 1; 
    //                 even_odd <= x ? EVEN : ODD;
    //             end
    //         default: even_odd <= EVEN;
    //     endcase
    // end
    always @(posedge clk) 
        begin
            case (even_odd)
            EVEN : even_odd <= x ? ODD : EVEN;
            ODD : even_odd <= x ? EVEN : ODD;
            default: even_odd <= EVEN;
            endcase
        end
    always @(even_odd)
        begin
            case (even_odd)
                EVEN : result = 0;
                ODD : result = 1;
                default : result = 0; 
            endcase
        end
endmodule
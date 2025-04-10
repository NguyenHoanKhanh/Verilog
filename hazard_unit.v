module hazard_unit (
    ex_1sel, ex_2sel, rs_addr1E , rs_addr2E, rd_addrM, rd_addrW, rd_wrenM, rd_wrenW, rd_wrenE, rd_addrE, wb_M, rs_addr1D, rs_addr2D
);
    input [4 : 0] rs_addr1E, rs_addr2E, rd_addrE, rd_addrM, rd_addrW, rs_addr1D, rs_addr2D;
    input rd_wrenM, rd_wrenW, rd_wrenE, wb_M, br_selE;
    output reg [1 : 0] ex_1sel, ex_2sel, rs1d_sel, rs2d_sel;
    wire stallF, flushE;
    wire load_hazard;

    always @(*) begin
        if(rs_addr1E != 5'b0) begin 
            if(rs_addr1E == rd_addrM && rd_wrenM == 1'b1) begin
                ex_1sel = 2'b01;
            end
            else if (rs_addr1E == rd_addrW && rd_addrW == 1'b1) begin
                ex_1sel = 2'b10;
            end
            else ex_1sel = 2'b00;
        end
        else ex_1sel = 2'b00;

        if (rs_addr2E != 5'b0) begin
            if (rs_addr2E == rd_addrM && rd_wrenM == 1'b1) begin
                ex_2sel = 2'b01;                
            end
            else if (rs_addr2E == rd_addrW && rd_wrenW == 1'b1) begin
                ex_2sel = 2'b10;
            end
            else ex_2sel = 2'b00;
        end
        else ex_2sel = 2'b00;
    end

    assign load_hazard = wb_M & (rs_addr1D == rd_addrE) | (rs_addr2D == rd_addrE); 
    assign stallF = load_hazard;
    assign flushE = br_selE | load_hazard;
endmodule
module hazard_unit(
    input       /*br_selE,*/ wb_selE, /*wb_selM, rd_wrenE,*/ rd_wrenM, rd_wrenW,
    input [4:0] rs1_addrD, rs2_addrD, rs1_addrE, rs2_addrE, rd_addrE, rd_addrM, rd_addrW,
    output stallF, stallD, /*flushD,*/ flushE,
    output logic [1:0] forward1sel, forward2sel/*, rs1d_sel, rs2d_sel*/
);

    logic load_hazard;

    always_comb begin
        // Forwarding
        if (rs1_addrE != 5'b0)
            if ((rs1_addrE == rd_addrM) && rd_wrenM) 
                forward1sel = 2'b01;    // EX to EX
            else if ((rs1_addrE == rd_addrW) && rd_wrenW) 
                forward1sel = 2'b10;    // MEM to EX
            else                                          
                forward1sel = 2'b00;
        else                                              
            forward1sel = 2'b00; 

        if (rs2_addrE != 5'b0)
            if ((rs2_addrE == rd_addrM) && rd_wrenM) 
                forward2sel = 2'b01;
            else if ((rs2_addrE == rd_addrW) && rd_wrenW) 
                forward2sel = 2'b10;
            else                                          
                forward2sel = 2'b00;
        else                                              
            forward2sel = 2'b00;

        // Branch instruction -> don't use
        // if (rs1_addrD != 5'b0)
        //     if ((rs1_addrD == rd_addrE) && rd_wrenE) 
        //         rs1d_sel = 2'b01;
        //     else if ((rs1_addrD == rd_addrM) && rd_wrenM)
        //         if (wb_selM)                            
        //             rs1d_sel = 2'b11;
        //         else                                      
        //             rs1d_sel = 2'b10;
        //     else                                          
        //         rs1d_sel = 2'b00;
        // else                                              
        //     rs1d_sel = 2'b00;

        // if (rs2_addrD != 5'b0)
        //     if ((rs2_addrD == rd_addrE) && rd_wrenE) 
        //         rs2d_sel = 2'b01;
        //     else if ((rs2_addrD == rd_addrM) && rd_wrenM)
        //         if (wb_selM)                            
        //             rs2d_sel = 2'b11;
        //         else                                      
        //             rs2d_sel = 2'b10;
        //     else                                          
        //         rs2d_sel = 2'b00;
        // else                                              
        //     rs2d_sel = 2'b00;
    end

    assign load_hazard = wb_selE & ((rs1_addrD == rd_addrE) | (rs2_addrD == rd_addrE));
    assign stallF = load_hazard;
    assign stallD = load_hazard;
    // assign flushD = br_selE;
    assign flushE = load_hazard /*| br_selE*/;

endmodule
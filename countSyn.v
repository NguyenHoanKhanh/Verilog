module counter (
    clk, rst, count, m_in
);
    integer m;
    input clk, rst;
    output reg [31:0] count;
    output reg [31:0] m_in;
    
    always @(posedge clk or posedge rst) begin
        if (rst) 
            begin
                count = 32'b0;
                m <= 0;
                m_in <= 0;
            end
        else 
            begin
                m <= +m;
                m_in <= m;
                count = count + 1;
            end
    end
endmodule
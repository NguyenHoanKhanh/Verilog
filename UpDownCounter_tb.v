module updown_tb;
    reg mode, clr, clk, load;
    reg [7:0] din;
    wire [7:0] count;

    updown DUT (.mode(mode), .clr(clr), .clk(clk), .load(load), .din(din), .count(count));

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        $dumpfile("updowm.vcd");
        $dumpvars(0, updown_tb);

        $monitor($time, " ", "mode = %b, clr = %b, load = %b, din = %d, count = %d", mode, clr, load, din, count);
        clr = 1 ;
        mode = 0 ;
        load = 0 ;
        din = 0 ;
        #10;
        clr = 0;
        mode = 1;
        #10;
        #100;
        mode = 0;
        #10;
        #50;
        load = 1;
        din = 5;
        #10;
        $finish;

       
    end
endmodule

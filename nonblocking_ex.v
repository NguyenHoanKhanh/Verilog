module nonblock ;
    integer a, b, c, d;
    reg clock;

    always @(posedge clock) begin
        a <= b + c;
        d <= a - 3;
        b <= d + 10;
        c <= c + 1;
    end

    initial 
    begin
        $monitor($time, " ", "a = %4d, b = %4d, c = %4d, d = %4d", a, b, c, d);
        a = 30; b = 20; c = 15; d = 5;
        clock = 0;

        forever 
        begin
            #5 clock = ~clock;
        end
        
    end
    initial 
    begin
            #100 $finish;
    end    
endmodule
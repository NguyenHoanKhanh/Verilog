module test_adder;
    reg [7 : 0] a, b;
    wire [7 : 0] sum;
    wire cout;
    integer myseed;

    adder DUT (.a(a), .b(b), .out(sum), .cout(cout));

    initial begin
        myseed = 15;
    end
    initial begin
        repeat(5)
            begin
                a = $random(myseed);
                b = $random(myseed);
                #10;
                $display("T = %3d, a = %h, b = %h, sum = %h", $time, a, b, sum);
            end
    end
endmodule
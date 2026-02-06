`timescale 1ns / 1ps

module tb_risc;

    reg clk = 0;
    reg rst = 1;

    Datapath DUT (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        #10 rst = 0;
        #200 $finish;
    end

endmodule

`timescale 1ns / 1ps

module RegisterFile (
    input  wire       clk,
    input  wire       we,
    input  wire [2:0] raddr1,
    input  wire [2:0] raddr2,
    input  wire [2:0] waddr,
    input  wire [7:0] wdata,
    output wire [7:0] rdata1,
    output wire [7:0] rdata2
);

    reg [7:0] regs [0:7];

    assign rdata1 = regs[raddr1];
    assign rdata2 = regs[raddr2];

    always @(posedge clk) begin
        if (we) begin
            regs[waddr] <= wdata;
            $display("REG WRITE: R%0d = %0d", waddr, wdata);
        end
    end

endmodule

`timescale 1ns / 1ps
`default_nettype none

module DataMemory (
    input  wire        clk,
    input  wire [7:0]  addr,
    input  wire [7:0]  wdata,
    input  wire        we,
    output wire [7:0]  rdata
);

    reg [7:0] DMEM [0:255];

    assign rdata = DMEM[addr];

    always @(posedge clk) begin
        if (we) begin
            DMEM[addr] <= wdata;
            $display("MEM WRITE: MEM[%0d] = %0d", addr, wdata);
        end
    end

endmodule

`default_nettype wire

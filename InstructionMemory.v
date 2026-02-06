`timescale 1ns / 1ps
`default_nettype none

module InstructionMemory (
    input  wire [7:0]  addr,
    output wire [15:0] instr
);

    reg [15:0] IMEM [0:255];

    initial begin
        IMEM[0] = 16'b0100_001_000000101; // LOAD R1, #5
        IMEM[1] = 16'b0100_010_000001010; // LOAD R2, #10
        IMEM[2] = 16'b0000_011_001_010_000; // ADD R3 = R1 + R2
        IMEM[3] = 16'b0001_111_010_001_000; // SUB R7 = R2 - R1
        IMEM[4] = 16'b0101_011_000010100; // STORE R3 -> MEM[20]
        IMEM[5] = 16'b1111_000_000000000; // HALT
    end

    assign instr = IMEM[addr];

endmodule

`default_nettype wire

`timescale 1ns / 1ps
`default_nettype none

module ALU (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] ALU_Sel,
    output reg  [7:0] ALU_Out
);

    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Out = A + B;   // ADD
            3'b001: ALU_Out = A - B;   // SUB
            default: ALU_Out = 8'b0;
        endcase
    end

endmodule

`default_nettype wire

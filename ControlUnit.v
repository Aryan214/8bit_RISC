`timescale 1ns / 1ps

module ControlUnit (
    input  wire [3:0] opcode,
    output reg rf_we,
    output reg mem_we,
    output reg alu_src,
    output reg [2:0] alu_op
);

    always @(*) begin
        rf_we   = 0;
        mem_we = 0;
        alu_src = 0;
        alu_op  = 3'b000;

        case (opcode)
            4'b0100: begin // LOAD
                rf_we   = 1;
                alu_src = 1;
            end
            4'b0000: begin // ADD
                rf_we  = 1;
                alu_op = 3'b000;
            end
            4'b0001: begin // SUB
                rf_we  = 1;
                alu_op = 3'b001;
            end
            4'b0101: begin // STORE
                mem_we = 1;
            end
            4'b1111: begin // HALT
                rf_we  = 0;
            end
        endcase
    end

endmodule

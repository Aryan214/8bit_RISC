`timescale 1ns / 1ps
`default_nettype none

module Datapath (
    input wire clk,
    input wire rst
);

    reg  [7:0] PC;

    wire [15:0] instr;
    wire [3:0]  opcode;
    wire [2:0]  rd, rs, rt;
    wire [7:0]  imm;

    wire rf_we, mem_we, alu_src;
    wire [2:0] alu_op;

    wire [7:0] reg_rs;
    wire [7:0] reg_rt;
    wire [7:0] alu_B;
    wire [7:0] alu_out;

    // FETCH
    InstructionMemory IM (
        .addr(PC),
        .instr(instr)
    );

    // DECODE
    assign opcode = instr[15:12];
    assign rd     = instr[11:9];
    assign rs     = instr[8:6];
    assign rt     = instr[5:3];
    assign imm    = instr[7:0];

    // CONTROL
    ControlUnit CU (
        .opcode(opcode),
        .rf_we(rf_we),
        .mem_we(mem_we),
        .alu_src(alu_src),
        .alu_op(alu_op)
    );

    // REGISTER FILE
    RegisterFile RF (
        .clk(clk),
        .we(rf_we),
        .raddr1(rs),
        .raddr2((opcode == 4'b0101) ? rd : rt), // ✅ READ R3 FOR STORE
        .waddr(rd),
        .wdata((opcode == 4'b0100) ? imm : alu_out),
        .rdata1(reg_rs),
        .rdata2(reg_rt)
    );

    // ALU
    assign alu_B = alu_src ? imm : reg_rt;

    ALU ALU_U (
        .A(reg_rs),
        .B(alu_B),
        .ALU_Sel(alu_op),
        .ALU_Out(alu_out)
    );

    // DATA MEMORY
    DataMemory DM (
        .clk(clk),
        .addr(imm),
        .wdata(reg_rt),   // ✅ STORE R3 VALUE
        .we(mem_we),
        .rdata()
    );

    // PC
    always @(posedge clk or posedge rst) begin
        if (rst)
            PC <= 0;
        else if (opcode != 4'b1111)
            PC <= PC + 1;
    end

    // DEBUG
    always @(posedge clk) begin
        $display(
            "DEBUG | PC=%0d opcode=%b rs=%0d rt=%0d rd=%0d reg_rs=%0d reg_rt=%0d alu_out=%0d",
            PC, opcode, rs, rt, rd, reg_rs, reg_rt, alu_out
        );
    end

endmodule

`default_nettype wire

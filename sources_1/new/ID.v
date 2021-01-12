`timescale 1ns / 1ps

module ID(
    input clk,
    input [31:0] PC_ID, INSTRUCTION_ID,
    input RegWrite_WB,
    input [31:0] ALU_DATA_WB,
    input [4:0] RD_WB,
    input MemRead_EX,
    output [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
    output [2:0] FUNCT3_ID,
    output [6:0] FUNCT7_ID, OPCODE_ID,
    output [4:0] RD_ID, RS1_ID, RS2_ID,
    output PCwrite, IF_IDwrite, control_sel,
    output reg MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc,
    output reg [1:0] ALUop
);
    assign FUNCT3_ID = INSTRUCTION_ID[14:12];
    assign FUNCT7_ID = INSTRUCTION_ID[31:25];
    assign OPCODE_ID = INSTRUCTION_ID[6:0];
    assign RD_ID = INSTRUCTION_ID[11:7];
    assign RS1_ID = INSTRUCTION_ID[19:15];
    assign RS2_ID = INSTRUCTION_ID[24:20];

    hazard_detection(RD_ID, RS1_ID, RS2_ID, MemRead_EX, PCwrite, IF_IDwrite, control_sel);
    
    control_path control(OPCODE_ID, control_sel, MemRead, MemtoReg, MemWrite,
                         RegWrite, Branch, ALUSrc, ALUop);

    registers register(clk, RegWrite_WB, RS1_ID, RS2_ID, RD_WB, ALU_DATA_WB,
                       REG_DATA1_ID, REG_DATA2_ID);
                       
    imm_gen imm(INSTRUCTION_ID, IMM_ID);
endmodule

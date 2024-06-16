`timescale 1ns / 1ps

module RISC_V(
    input clk, reset,
    
    output [31:0] PC_EX, ALU_OUT_EX, PC_MEM,
    output PCSrc,
    output [31:0] DATA_MEMORY_MEM, ALU_DATA_WB,
    output [1:0] forwardA, forwardB,
    output pipeline_stall
);
    wire [31:0] PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID, IMM_ID;
    wire PCwrite;
    wire IF_IDwrite, control_sel;
    wire MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc;
    wire [1:0] ALUop;
    
    wire [31:0] REG_DATA1_ID, REG_DATA2_ID;
    wire [31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_ID_EX, PC_Branch;
    wire [2:0] FUNCT3_EX, FUNCT3_ID;
    wire [6:0] FUNCT7_EX, FUNCT7_ID, OPCODE_ID;
    wire [4:0] RD_EX, RS1_EX, RS2_EX, RD_ID, RS1_ID, RS2_ID;
    wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX;
    wire [1:0] ALUop_EX;
    wire ALUSrc_EX, Branch_EX;
    
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_EX;
    wire [31:0] PC_Branch_EX, REG_DATA2_EX_FINAL;
    
    wire MemRead_MEM, MemWrite_MEM, ZERO_MEM, Branch_MEM, RegWrite_MEM, MemtoReg_MEM;
    wire [31:0] REG_DATA2_MEM_FINAL, read_data_MEM, PC_Branch_MEM;
    
    wire [4:0] RD_MEM;
    
    wire [31:0] read_data_WB, ALU_OUT_WB;
    wire RegWrite_WB, MemtoReg_WB;
    wire [4:0] RD_WB;


    IF fetch(clk, reset, PCSrc, PCwrite, PC_Branch_MEM, PC_IF, INSTRUCTION_IF);
    
    pipeline_if_id p1(clk, reset, IF_IDwrite, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
    
    ID decode(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, MemRead_EX,
        IMM_ID, REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID,
        PCwrite, IF_IDwrite, control_sel, MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc, ALUop,
        PC_Branch);
        
    pipeline_id_ex p2(clk, reset, 1'b1, IMM_ID, REG_DATA1_ID, REG_DATA2_ID, PC_ID, FUNCT3_ID, FUNCT7_ID,
        RD_ID, RS1_ID, RS2_ID, RegWrite, MemtoReg, MemRead, MemWrite, ALUop, ALUSrc, Branch,
        IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_ID_EX, FUNCT3_EX, FUNCT7_EX, RD_EX, RS1_EX, RS2_EX,
        RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc_EX, Branch_EX);
        
    forwarding fwd(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_MEM, RegWrite_WB, forwardA, forwardB);
        
    EX execute(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_ID_EX, FUNCT3_EX, FUNCT7_EX, RD_EX, RS1_EX, RS2_EX,
        RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc_EX, Branch_EX,
        forwardA, forwardB, ALU_DATA_WB, ALU_OUT_MEM, ZERO_EX, ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL);
        
    pipeline_ex_mem p3(clk, reset, 1'b1, MemRead_EX, MemWrite_EX, RegWrite_EX, MemtoReg_EX, REG_DATA2_EX_FINAL,
        ALU_OUT_EX, PC_Branch_EX, ZERO_EX, Branch_EX, RD_EX, MemRead_MEM, MemWrite_MEM, RegWrite_MEM, MemtoReg_MEM,
        REG_DATA2_MEM_FINAL, ALU_OUT_MEM, PC_Branch_MEM, ZERO_MEM, Branch_MEM, RD_MEM);
        
    data_memory memory(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM >> 2, REG_DATA2_MEM_FINAL, read_data_MEM);
    
    pipeline_mem_wb p4(clk, reset, 1'b1, read_data_MEM, ALU_OUT_MEM, RegWrite_MEM, MemtoReg_MEM, RD_MEM,
        read_data_WB, ALU_OUT_WB, RegWrite_WB, MemtoReg_WB, RD_WB);
        
    mux2_1 mux_WB(read_data_WB, ALU_OUT_WB, MemtoReg_WB, ALU_DATA_WB);

    assign PCSrc = (Branch_MEM & ZERO_MEM);
    assign PC_EX = PC_ID_EX;
    assign PC_MEM = PC_Branch_MEM;
    assign DATA_MEMORY_MEM = read_data_MEM;
    assign pipeline_stall = control_sel;
endmodule 

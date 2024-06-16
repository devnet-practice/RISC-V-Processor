`timescale 1ns / 1ps

module EX(
    input [31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX,
    input [2:0] FUNCT3_EX,
    input [6:0] FUNCT7_EX,
    input [4:0] RD_EX, RS1_EX, RS2_EX,
    input RegWrite_EX,
    input MemtoReg_EX,
    input MemRead_EX,
    input MemWrite_EX,
    input [1:0] ALUop_EX,
    input ALUSrc_EX,
    input Branch_EX,
    input [1:0] forwardA, forwardB,
    
    input [31:0] ALU_DATA_WB, ALU_OUT_MEM,
    
    output ZERO_EX,
    output [31:0] ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL
);
    wire [31:0] mux_reg1_out, mux_reg2_out, mux_alu_out;
    wire [3:0] ALU_input_ex;
   
    adder adder_ex(PC_EX, IMM_EX, PC_Branch_EX);
  
    mux4_1 mux_reg1_ex(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardA, mux_reg1_out);
    mux4_1 mux_reg2_ex(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardB, mux_reg2_out);
    
    mux2_1 mux_alu_ex(mux_reg2_out, IMM_EX, ALUSrc_EX, mux_alu_out);
        
    ALUcontrol alu_control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALU_input_ex);
    
    ALU alu(ALU_input_ex, mux_reg1_out, mux_alu_out, ZERO_EX, ALU_OUT_EX);
    
    assign REG_DATA2_EX_FINAL = mux_reg2_out;
endmodule

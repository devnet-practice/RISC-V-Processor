`timescale 1ns / 1ps

module RISC_V(
    input clk, reset,
    
    output [31:0] PC_EX, ALU_OUT_EX, PC_MEM,
    output PCSrc,
    output [31:0] DATA_MEMORY_MEM, ALU_DATA_WB,
    output [1:0] forwardA, forwardB,
    output pipeline_stall
);
    
endmodule

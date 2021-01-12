`timescale 1ns / 1ps

module IF(
    input clk, reset, PCSrc, PC_write,
    input [31:0] PC_Branch,
    output [31:0] PC_IF, INSTRUCTION_IF
);
    wire [31:0] mux_out, PC_out, adder_out, im_out;
    
    mux2_1 mux(adder_out, PC_Branch, PCSrc, mux_out);
    PC pc(clk, reset, PC_write, mux_out, PC_out);
    adder add(PC_out, 4, adder_out);
    instruction_memory IM(PC_out >> 2, im_out);
    
    assign PC_IF = PC_out;
    assign INSTRUCTION_IF = im_out;
endmodule

`timescale 1ns / 1ps

module instruction_memory(
    input [9:0] address,
    output [31:0] instruction
);
    reg [31:0] code_memory [0:1023];
    initial $readmemh("code.mem", code_memory);
    
    assign instruction = code_memory[address];
endmodule

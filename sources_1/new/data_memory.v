`timescale 1ns / 1ps

module data_memory(
    input clk, mem_read, mem_write,
    input [31:0] address, write_data,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:1023];
    
    always@(*) begin
        if (mem_read) begin
            read_data = memory[address];
        end
    end
    
    always@(posedge clk) begin
        if (mem_write) begin
            memory[address] = write_data;
        end
    end
endmodule

`timescale 1ns / 1ps

module adder(
    input [31:0] ina, inb,
    output [31:0] out
);
    assign out = ina + inb;
endmodule

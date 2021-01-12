`timescale 1ns / 1ps

module mux2_1(
    input [31:0] ina, inb,
    input sel,
    output reg [31:0] out
);
    always @(ina or inb or sel) begin
        if (sel)
            out = inb;
        else
            out = ina;
    end
    
    // assign out = sel ? inb : ina;
endmodule

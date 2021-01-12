`timescale 1ns / 1ps

module pipeline_if_id(
    input clk, reset,
    input [31:0] in,
    output reg [31:0] out
);
    always @(posedge clk) begin
        if (reset)
            out <= 32'b0;
        else
            out <= in;
    end
endmodule

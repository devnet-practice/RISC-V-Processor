`timescale 1ns / 1ps

module forwarding(
    input [4:0] rs1, rs2, ex_mem_rd, mem_wb_rd,
    input ex_mem_regwrite, mem_wb_regwrite,
    output reg [1:0] forwardA, forwardB
);
    always@(*) begin
        if (ex_mem_regwrite && ex_mem_rd != 5'b0 && ex_mem_rd == rs1) begin
            forwardA = 2'b10;
        end
        
        if (ex_mem_regwrite && ex_mem_rd != 5'b0 && ex_mem_rd == rs2) begin
            forwardB = 2'b10;
        end
        
        if (mem_wb_regwrite && mem_wb_rd != 5'b0 && 
            ~(ex_mem_regwrite && ex_mem_rd != 5'b0 && ex_mem_rd == rs1) &&
            mem_wb_rd == rs1) begin
            forwardA = 2'b01;
        end
        
        if (mem_wb_regwrite && mem_wb_rd != 5'b0 && 
            ~(ex_mem_regwrite && ex_mem_rd != 5'b0 && ex_mem_rd == rs2) &&
            mem_wb_rd == rs2) begin
            forwardB = 2'b01;
        end
    end
endmodule

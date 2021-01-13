`timescale 1ns / 1ps

module pipeline_mem_wb(
    input clk, reset, write,
    input [31:0] red_data_MEM,
    input [31:0] ALU_OUT_MEM,
    input RegWrite_MEM, MemtoReg_MEM,
    input [4:0] RD_MEM,
    output reg [31:0] red_data_WB,
    output reg [31:0] ALU_OUT_WB,
    output reg RegWrite_WB, MemtoReg_WB,
    output reg [4:0] RD_WB
);
    always@(posedge clk) begin
        if (reset) begin
            red_data_WB <= 32'b0;
            ALU_OUT_WB <= 32'b0;
            RegWrite_WB <= 1'b0;
            MemtoReg_WB <= 1'b0;
            RD_WB <= 5'b0;
        end
        else begin
            if (write) begin
                red_data_WB <= red_data_MEM;
                ALU_OUT_WB <= ALU_OUT_MEM;
                RegWrite_WB <= RegWrite_MEM;
                MemtoReg_WB <= MemtoReg_MEM;
                RD_WB <= RD_MEM;
            end
        end
      end
endmodule

`timescale 1ns / 1ps

module pipeline_ex_mem(
    input clk, reset, write,
    input mem_read_EX, mem_write_EX,
    input RegWrite_EX, MemtoReg_EX,
    input [31:0] address_EX, write_data_EX,
    input [31:0] PC_Branch_EX,
    input ZERO_EX, Branch_EX,
    input [4:0] RD_EX,
    output reg mem_read_MEM, mem_write_MEM,
    output reg RegWrite_MEM, MemtoReg_MEM,
    output reg [31:0] address_MEM, write_data_MEM,
    output reg [31:0] PC_Branch_MEM,
    output reg ZERO_MEM, Branch_MEM,
    output reg [4:0] RD_MEM
);
    always@(posedge clk) begin
        if (reset) begin
            address_MEM <= 32'b0;
            write_data_MEM <= 32'b0;
            PC_Branch_MEM <= 32'b0;
            mem_read_MEM <= 1'b0;
            mem_write_MEM <= 1'b0;
            RegWrite_MEM <= 1'b0;
            MemtoReg_MEM <= 1'b0;
            ZERO_MEM <= 1'b0;
            Branch_MEM <= 1'b0;
            RD_MEM <= 5'b0;
        end
        else begin
            if (write) begin
                address_MEM <= address_EX;
                write_data_MEM <= write_data_EX;
                mem_read_MEM <= mem_read_EX;
                mem_write_MEM <= mem_write_EX;
                PC_Branch_MEM <= PC_Branch_EX;
                ZERO_MEM <= ZERO_EX;
                Branch_MEM <= Branch_EX;
                RD_MEM <= RD_EX;
                RegWrite_MEM <= RegWrite_EX;
                MemtoReg_MEM <= MemtoReg_EX;
            end
        end
      end
endmodule

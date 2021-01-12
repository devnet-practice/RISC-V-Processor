`timescale 1ns / 1ps

module registers(
    input clk, reg_write,
    input [4:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    output reg [31:0] read_data1, read_data2
);
    reg [31:0] register_bank [31:0];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            register_bank[i] = i;
        end
    end
    
    always @(posedge clk) begin
        if (reg_write) begin
            register_bank[write_reg] = write_data;
        end
    end
 
    always @(read_reg1 or read_reg2) begin
        read_data1 = register_bank[read_reg1];
        read_data2 = register_bank[read_reg2];
    end
endmodule

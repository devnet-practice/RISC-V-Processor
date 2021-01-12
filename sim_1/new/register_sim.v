`timescale 1ns / 1ps

module register_sim();
    reg clk, reg_write;
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;
    
    registers uut(clk, reg_write, read_reg1, read_reg2, write_reg, write_data,
                read_data1, read_data2);
                
    always #10 clk = !clk;
    
    initial begin
        clk = 1;
        reg_write = 1; read_reg1 = 13; read_reg2 = 3; write_reg = 20; write_data = 1024; #20;
        reg_write = 0; read_reg1 = 20; read_reg2 = 15; write_reg = 15; write_data = 1024; #20;
        reg_write = 1; read_reg1 = 31; read_reg2 = 13; write_reg = 2; write_data = 2048; #20;
        reg_write = 0; read_reg1 = 5; read_reg2 = 2; write_reg = 2; write_data = 4096; #20;
        reg_write = 1; read_reg1 = 2; read_reg2 = 15; write_reg = 30; write_data = 4096; #20;
        reg_write = 0; read_reg1 = 30; read_reg2 = 2; write_reg = 30; write_data = 4096; #20;
    end
endmodule

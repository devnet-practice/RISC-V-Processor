`timescale 1ns / 1ps

module control_path(
    input [6:0] opcode,
    input control_sel,
    output reg MemRead, MemtoReg, MemWrite, RegWrite, Branch, ALUSrc,
    output reg [1:0] ALUop
);
    always@(*) begin
        if (control_sel) begin
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            Branch = 1'b0;
            ALUSrc = 1'b0;
            ALUop = 2'b0;
        end
        
        else begin
            case (opcode)
                7'b0110011: begin       // R-format
                    ALUSrc = 1'b0;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch = 1'b0;
                    ALUop = 2'b10;
                end
                
                7'b0010011: begin       // I-format
                    ALUSrc = 1'b1;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch = 1'b0;
                    ALUop = 2'b10;
                end
                
                7'b0000011: begin       // ld
                    ALUSrc = 1'b1;
                    MemtoReg = 1'b1;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemWrite = 1'b0;
                    Branch = 1'b0;
                    ALUop = 2'b00;
                end
                
                7'b0100011: begin       // S-type, sd
                    ALUSrc = 1'b1;
                    MemtoReg = 1'bx;
                    RegWrite = 1'b0;
                    MemRead = 1'b0;
                    MemWrite = 1'b1;
                    Branch = 1'b0;
                    ALUop = 2'b00;
                end
                
                7'b1100011: begin       // B-type, beq
                    ALUSrc = 1'b0;
                    MemtoReg = 1'bx;
                    RegWrite = 1'b0;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch = 1'b1;
                    ALUop = 2'b01;
                end
                
                default: begin
                    MemRead = 1'b0;
                    MemtoReg = 1'b0;
                    MemWrite = 1'b0;
                    RegWrite = 1'b0;
                    Branch = 1'b0;
                    ALUSrc = 1'b0;
                    ALUop = 2'b0;
                end
            endcase
        end
    end
endmodule

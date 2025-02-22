`timescale 1ns / 1ps

module imm_gen(
    input [31:0] in,
    output reg [31:0] out
);
    always@(*) begin
        casex({in[14:12],in[6:0]})
          10'bxxx0000011: out <= {{20{in[31]}},in[31:20]};                    //load instructions
          10'b0000010011: out <= {{20{in[31]}},in[31:20]};                   //addi
          10'b1110010011: out <= {{20{in[31]}},in[31:20]};                    //andi
          10'b1100010011: out <= {{20{in[31]}},in[31:20]};                     //ori
          10'b1000010011: out <= {{20{in[31]}},in[31:20]};                     //xori
          10'b0100010011: out <= {{20{in[31]}},in[31:20]};                    //slti
          10'b0110010011: out <= {{20{in[31]}},in[31:20]};                      //sltiu
          10'b1010010011: out <= {27'b0,in[24:20]};                             //srli,srai
          10'b0010010011: out <= {27'b0,in[24:20]};                              //slli
          10'bxxx0100011: out <= {{20{in[31]}},in[31:25],in[11:7]};               //store instructions
          10'bxxx1100011: out <= {{20{in[31]}},in[7],in[30:25],in[11:8], 1'b0}; //beq,bne,blt,bge,bltu,bgeu;
          default: out <= 32'b0;
        endcase
    end
endmodule

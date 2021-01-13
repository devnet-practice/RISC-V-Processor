///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
    reg clk, reset;
    wire [31:0] PC_EX, ALU_OUT_EX, PC_MEM;
    wire PCSrc;
    wire [31:0] DATA_MEMORY_MEM, ALU_DATA_WB;
    wire [1:0] forwardA, forwardB;
    wire pipeline_stall;
      
    RISC_V procesor(clk, reset,
        PC_EX, ALU_OUT_EX, PC_MEM,
        PCSrc,
        DATA_MEMORY_MEM, ALU_DATA_WB,
        forwardA, forwardB,
        pipeline_stall
    );  
  
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
//       IF_ID_write = 1'b1;      
//       PCSrc = 1'b0;
//       PC_write = 1'b1;    
//       PC_Branch = 32'b0;  
//       RegWrite_WB = 1'b0;       
//       ALU_DATA_WB = 32'b0;
//       RD_WB = 5'b0;           
       
    #10 reset=1'b0;
    #200 $finish;
  end
endmodule

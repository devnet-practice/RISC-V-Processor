module mux4_1(
    input [31:0] ina, inb, inc, ind,
    input [1:0] sel,
    output reg [31:0] out
);
    
    wire mux1_result, mux2_result;
    
    always@(*) begin
        case (sel)
            2'b00: out <= ina;
            2'b01: out <= inb;
            2'b10: out <= inc;
            2'b11: out <= ind;
        endcase
    end
    
//    mux2_1 mux1(ina, inb, sel[0], mux1_result);
//    mux2_1 mux2(inc, ind, sel[0], mux2_result);
//    mux2_1 mux3(mux1_result, mux2_result, sel[1], out);
endmodule
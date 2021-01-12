module mux4_1(
    input [31:0] ina, inb,
    input [1:0] sel,
    output out
);
    
    wire mux1_result, mux2_result;
    
    mux2_1 mux1(ina, inb, sel[0], mux1_result);
    mux2_1 mux2(inc, ind, sel[0], mux2_result);
    mux2_1 mux3(mux1_result, mux2_result, sel[1], out);
endmodule
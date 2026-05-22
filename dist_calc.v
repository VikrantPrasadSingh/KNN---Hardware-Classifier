// DISTANCE CALCULATOR  (Manhattan)
module dist_calc (
    input  [7:0] A1, A2, A3, A4,
    input  [7:0] B1, B2, B3, B4,
    output [9:0] D
);
    wire [7:0] d1 = (A1 >= B1) ? (A1 - B1) : (B1 - A1);
    wire [7:0] d2 = (A2 >= B2) ? (A2 - B2) : (B2 - A2);
    wire [7:0] d3 = (A3 >= B3) ? (A3 - B3) : (B3 - A3);
    wire [7:0] d4 = (A4 >= B4) ? (A4 - B4) : (B4 - A4);
    assign D = d1 + d2 + d3 + d4;
endmodule
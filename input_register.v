// INPUT REGISTER / FEATURE BUFFER

module input_register (
    input        clk,
    input        reset,
    input  [7:0] feature0,   // sepal length
    input  [7:0] feature1,   // sepal width
    input  [7:0] feature2,   // petal length
    input  [7:0] feature3,   // petal width
    output reg [7:0] f0_out,
    output reg [7:0] f1_out,
    output reg [7:0] f2_out,
    output reg [7:0] f3_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            f0_out <= 0; f1_out <= 0;
            f2_out <= 0; f3_out <= 0;
        end else begin
            f0_out <= feature0; f1_out <= feature1;
            f2_out <= feature2; f3_out <= feature3;
        end
    end
endmodule
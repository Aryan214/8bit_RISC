module ProgramCounter (
    input  wire clk,
    input  wire rst,
    input  wire [7:0] pc_next,
    output reg  [7:0] pc
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 8'd0;
        else
            pc <= pc_next;
    end
endmodule

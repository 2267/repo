module counter(clk, rst, inc, out);

input clk;
input rst;
input inc;
output reg [3:0] out;

reg rst_reg;
always@(posedge clk)
begin
    rst_reg <= rst;
end

always@(posedge clk or negedge rst_reg)
begin
    if(!rst_reg)
        out <= 4'b0;
    else if(inc)
        out <= out + 1'b0;

    if(out == 4'd10)
        out <= 4'b0;
end

endmodule


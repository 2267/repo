module fenpin3(input clk, input rst, output clko);

reg clk1,clk2;
reg[1:0] cnt1,cnt2;
assign clko = clk1 | clk2;
always@(negedge rst) begin
clk1 = 0;
clk2 =0;
cnt1 = 0;
cnt2 = 0;
end
always@(posedge clk)begin
    cnt1 <= cnt1 + 2'b1;
    if(cnt1 == 2'b01)
        clk1 <= 1'b0;
    else if(cnt1 == 2'b00)
        clk1 <= 1'b1;
    else if(cnt1 == 2'b10)
        cnt1 <= 2'b00;
end

always@(negedge clk)begin
    cnt2 <= cnt2 + 2'b1;
    if(cnt2 == 2'b01)
        clk2 <= 1'b0;
   else     if(cnt2 == 2'b00)
        clk2 <= 1'b1;
 
    else if(cnt2 == 2'b10)
        cnt2 <= 2'b00;
end
endmodule
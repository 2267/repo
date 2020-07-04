module 2reg(input in,output out,input clk);

reg reg1,reg2;
always@(posedge clk)begin
    reg1 <= in;
    reg2 <= reg1;
end

endmodule
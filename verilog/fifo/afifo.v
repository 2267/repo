module afifo(
    input r_clk,
    input w_clk,
    input rst,
    input r_sig,
    input w_sig,
    output reg [7:0] r_data,
    input [7:0] w_data,
    output full,
    output empty
);



reg [7:0] mem [0:7];
reg [3:0] r_ptr;
reg [3:0] w_ptr;


always@(posedge r_clk or posedge w_clk)
begin
    if(!rst)begin
        r_ptr = 4'b0000;
        w_ptr = 4'b0000;
    end
end

always@(posedge r_clk)
begin
    if(r_sig && !empty)
    begin
    r_data <= mem[r_ptr];
    r_ptr<= r_ptr+1'b1;
    end
end
always@(posedge w_clk )
begin
    if(w_sig && !full)
    begin
    mem[w_ptr] <= w_data;
    w_ptr<= w_ptr+1'b1;
    end
end

wire [3:0] r_gptr, w_gptr;
reg [3:0] wr_gptr1, wr_gptr2;
reg [3:0] rw_gptr1, rw_gptr2; 

assign r_gptr = {1'b0, r_ptr[3:1]} ^ r_ptr[3:0];
assign w_gptr = {1'b0, w_ptr[3:1]} ^ w_ptr[3:0];

always @(posedge w_clk)
begin
    wr_gptr2 <= wr_gptr1;
    wr_gptr1 <= r_gptr;
end

always @(posedge r_clk)
begin
    rw_gptr2 <= rw_gptr1;
    rw_gptr1 <= w_gptr;
end


assign empty = (rw_gptr2 == r_gptr)?1:0;
assign full = (wr_gptr2[1:0] == w_gptr[1:0])&&(~wr_gptr2[3:2] == w_gptr[3:2])?1:0;


endmodule
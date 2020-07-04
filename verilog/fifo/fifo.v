module sfifo(
    input clk,
    input rst,
    input rsig, 
    input wsig, 
    input [7:0] wdata,
    output [7:0] rdata,
    output full,
    output empty
);

reg [3:0] rptr;
reg [3:0] wptr;
reg [7:0] data_reg;

reg [7:0] mem [0:7];

assign empty = (rptr == wptr) ? 1 : 0;
assign full = ((rptr[2:0]==wptr[2:0]) && (rptr[3]!=wptr[3])) ? 1 : 0;
assign rdata = data_reg;

always @ (posedge clk)
begin
    if(!rst)begin
        rptr = 4'b0000;
        wptr = 4'b0000;
    end
end

always @ (posedge clk)
begin
    if(rsig && !empty)
    begin
        data_reg  <= mem[rptr];
        rptr <= rptr + 1'b1;
    end

    if(wsig && !full)
    begin
        mem[wptr] <= wdata;
        wptr <= wptr + 1'b1; 
    end
end
endmodule
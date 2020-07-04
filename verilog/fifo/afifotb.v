module afifotb;

reg clk;
reg wclk;
reg rst;
reg [7:0] wdata;
wire [7:0] rdata;
reg read;
reg write;

wire full;
wire empty;

reg [7:0] data;
initial forever #10 clk = ~clk;
initial forever #7 wclk = ~wclk;
initial
begin
    $monitor($time, " : ", "read %b:%b, write %b:%b , full %b, empty %b", read, rdata, write, wdata, full, empty);
    clk = 0;
    wclk = 0;
    write = 0;
    read = 0;
    rst = 0;
    data = 0;
    #20 rst = 1;
    #5

    repeat(20)begin
    #20
      data += 1'b1;
      wdata = data;
      write = ~write;
    end
    #10 write = 0;
    
    repeat(32)begin
    #20
      read = ~read;
    end
    #10 read = 0;
    repeat(20)begin
    #20
      data += 1'b1;
      wdata = data;
      write = ~write;
    end
    #10 write = 0;
    #400 $finish;
end


    


afifo fifo(clk,wclk, rst,read,write,rdata,wdata,full,empty);

endmodule
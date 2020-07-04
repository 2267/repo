`timescale 1ns/10ps

module gtb;

reg [7:0] in;
wire [7:0] out;

wire [7:0] ori;


togrey tg(in,out);
tobin tb(out, ori);
always #10 in = in + 1'b1;
initial fork
        //监控输出
    $monitor($time,": ","%b -> %b -> %b",in, out, ori);
    in = 8'b0;
    #200 $finish;
join



endmodule
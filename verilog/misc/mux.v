module mux2(sel,a,b,out);
input sel,a,b;
output out;
assign out = sel?b:a;
endmodule

module not_mux(x,out);
input x;
output out;
    mux2 m(x,1'b1,1'b0,out);
endmodule



module and_mux(x,y,out);
input x,y;
output out;
    mux2 m(x,1'b0,y,out);
endmodule

module or_mux(x,y,out);
input x,y;
output out;
    mux2 m(x,y,1'b1,out);
endmodule

module dlatch_mux(x,y,out);
input x,y;
output out;
    mux2 d(x,out,y,out);
endmodule

module dff(d,en,q);
input d,en;
output q;
wire mid;
dlatch_mux dm1(en, d, mid);

dlatch_mux dm2(!en, mid, q);
endmodule

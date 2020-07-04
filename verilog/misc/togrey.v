module togrey(input [7:0] bin, output [7:0] grey);


assign grey[7:0] = {1'b0,bin[7:1]} ^ bin[7:0];


endmodule
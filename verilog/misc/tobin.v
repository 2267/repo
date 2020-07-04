module tobin(input [7:0] grey, output [7:0] bin);
   assign bin[7] = grey[7];
   genvar i;
   generate
       for(i = 0 ; i <= 6 ; i=i+1)  // or from 6 -> 1
   begin: name
       assign  bin[i] = grey[i] ^ bin[i+1];
   end
   endgenerate
endmodule
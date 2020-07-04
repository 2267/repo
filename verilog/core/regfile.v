module regfile(
    input clk,
    input rst,
    input enable,
    input sig_write,
    input sig_read1,
    input sig_read2,
    input [4:0] index_write,
    input [4:0] index_read1,
    input [4:0] index_read2,
    input [31:0] data_write,
    output reg [31:0] data_read1,
    output reg [31:0] data_read2
);

reg [31:0] registers [0:31];

always @(posedge clk or negedge rst)
begin
    registers[0] <= 0;
    if(!rst) begin
        // reset: nothing done
    end
    else if(enable) begin
        if(sig_read1)
            data_read1 <= registers[index_read1];
        if(sig_read2)
            data_read2 <= registers[index_read2];
        if(sig_write)
            registers[index_write] <= data_write;
    end
end

endmodule
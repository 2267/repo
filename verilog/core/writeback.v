module writeback(
    input clk,
    input rst,
    input enable,
    input valid,
    input sel,
    input [4:0] index,
    input [31:0] data_ex,
    input [31:0] data_mem,
    output reg [4:0] out_index,
    output reg [31:0] data,
    output reg sig_write
);

always @(posedge clk or negedge rst)
begin
    out_index <= index;
    sig_write <= valid;

    if(!rst) begin
        // reset: nothing done
    end
    else if(enable && valid) begin
        data <= sel ? data_ex : data_mem;
    end
end

endmodule
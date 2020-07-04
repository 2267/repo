module ifetch(
    input clk,
    input rst,
    input enable,
    input jump_bool,
    input [31:0] jump_addr,
    input [31:0] inst_in,
    output reg [31:0] inst_addr,
    output reg [31:0] inst_out
);

reg [31:0] pc;

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        pc <= 32'b0;
        inst_addr <= 32'b0;
        inst_out <= 32'b0;
    end
    else if(enable) begin
        inst_addr <= pc;

        inst_out <= inst_in; // last clk pc-inst

        if(jump_bool)
            pc <= jump_addr;
        else 
            pc <= pc + 32'd4; // 4-bit inst
    end
end

endmodule
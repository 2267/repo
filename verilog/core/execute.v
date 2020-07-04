`include "define_inst.v"
module execute(
    input clk,
    input rst,
    input enable,
    input [6:0] cmd,
    input [4:0] index_rd,
    input [31:0] data_rs1,
    input [31:0] data_rs2,
    input [20:0] imm,
    output reg memacc_valid,
    output reg memacc_type,
    output reg [31:0] memacc_addr,
    output reg [31:0] memacc_data_store,
    output reg writeback_valid,
    output reg writeback_type,
    output reg [31:0] data_rd,
    output reg [4:0] index_rd_out
);

always @(posedge clk or negedge rst)
begin
    index_rd_out <= index_rd;
    if(!rst) begin
        memacc_valid <= 1'b0;
        writeback_valid <= 1'b0;
    end
    else if(enable) begin
        case(cmd)
            `cmd_add : data_rd <= data_rs1 + data_rs2;
            `cmd_sub : data_rd <= data_rs1 - data_rs2; // need fix
            `cmd_sll : data_rd <= data_rs1 << data_rs2;
            `cmd_slt : data_rd <= (data_rs1 < data_rs2)? 1'b1: 1'b0; // need fix
            `cmd_sltu: data_rd <= (data_rs1 < data_rs2)? 1'b1: 1'b0;
            `cmd_xor : data_rd <= data_rs1 ^ data_rs2;
            `cmd_srl : data_rd <= data_rs1 >> data_rs2;
            `cmd_sra : data_rd <= data_rs1 >>> data_rs2;
            `cmd_or  : data_rd <= data_rs1 | data_rs2;
            `cmd_and : data_rd <= data_rs1 & data_rs2;
        endcase
    end
end
endmodule
module memacc(
    input clk,
    input rst,
    input enable,

    input memacc_valid,
    input memacc_type,
    output memacc_type_out,
    output memacc_type_valid,
    input [31:0] memacc_addr,

    output reg [31:0] memacc_addr_out,
    input [31:0] memacc_data_load_in,

    input [31:0] memacc_data_store,
    output reg [31:0] memacc_data_store_out,

    output reg [31:0] data_memacc,

    input [31:0] data_rd,
    input [4:0] index_rd,
    output reg [31:0] data_rd_out,
    output reg [4:0] index_rd_out,

    input writeback_valid,
    input writeback_type,
    output reg writeback_valid_out,
    output reg writeback_type_out
);


always @(posedge clk or negedge rst)
begin
    if(!rst | !enable) begin
        writeback_valid_out <= 0;
    end
    else if(enable) begin
        writeback_valid_out <= writeback_valid;
        writeback_type_out <= writeback_type;
        data_rd_out <= data_rd;
        index_rd_out <= index_rd;
        if(memacc_valid)begin
            memacc_addr_out <= memacc_addr;
            memacc_type_out <= memacc_type;
            case(memacc_type): //need to fix
                1'b0: data_memacc <= memacc_data_load_in; //load
                1'b1: memacc_data_store_out <=  memacc_data_store;//store
            endcase
        end
    end
end

endmodule
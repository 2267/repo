
`include "regfile.v"

`include "ifetch.v"
`include "decode.v"
`include "execute.v"
`include "memacc.v"
`include "writeback.v"





module core(
    input clk,
    input rst,
    input enable,
    input [31:0] port_data_in,
    input [31:0] port_inst_in,
    output [31:0] port_data_out,
    output [31:0] port_data_addr,
    output [31:0] port_inst_addr,
    output port_memacc_type,
    output port_memacc_valid
);


wire [31:0] wire_instruction;


wire [6:0] wire_cmd;
wire [20:0] wire_imm;

wire wire_sig_read1, wire_sig_read2;

wire [4:0] wire_index_rs1, wire_index_rs2;
wire [31:0] wire_data_rs1, wire_data_rs2;

wire [4:0] wire_index_rd, wire_index_rd1, wire_index_rd2;
wire [31:0]  wire_data_rd1, wire_data_rd2;

wire [3:0] wire_field_valid;
assign wire_sig_read1 = wire_field_valid[2];
assign wire_sig_read2 = wire_field_valid[1];


wire wire_memacc_valid, wire_memacc_type;
wire wire_writeback_valid, wire_writeback_type;
wire wire_writeback_valid1, wire_writeback_type1;
wire [31:0] wire_memacc_addr, wire_data_memacc, wire_memacc_data_store;


wire wire_sig_write;
wire [4:0] wire_index_write;
wire [31:0] wire_data_write;


ifetch    stage1(.clk(clk), .rst(rst), .enable(enable), 
        .jump_bool(), .jump_addr(), 
        .inst_in(port_inst_in), .inst_addr(port_inst_addr),.inst_out(wire_instruction));

decode    stage2(.clk(clk), .rst(rst), .enable(enable), 
        .inst(wire_instruction), .cmd(wire_cmd), 
        .rd(wire_index_rd), .rs1(wire_index_rs1), .rs2(wire_index_rs2), .imm(wire_imm), 
        .valid_field(wire_field_valid));

execute   stage3(.clk(clk), .rst(rst), .enable(enable), 
        .cmd(wire_cmd), .data_rs1(wire_data_rs1), .data_rs2(wire_data_rs2), .imm(wire_imm), 
        .data_rd(wire_data_rd1), .index_rd(wire_index_rd), .index_rd_out(wire_index_rd1),
        .memacc_valid(wire_memacc_valid), .memacc_type(wire_memacc_type), .memacc_addr(wire_memacc_addr), .memacc_data_store(wire_memacc_data_store),
        .writeback_valid(wire_writeback_valid), .writeback_type(wire_writeback_type));


memacc    stage4(.clk(clk), .rst(rst), .enable(enable), 
        .data_rd(wire_data_rd1), .data_rd_out(wire_data_rd2),
        .index_rd(wire_index_rd1), .index_rd_out(wire_index_rd2),
        .memacc_valid(wire_memacc_valid), .memacc_type(wire_memacc_type), 
        .memacc_addr(wire_memacc_addr),  .memacc_addr_out(port_data_addr), 
        .memacc_data_load_in(port_data_in), .memacc_data_store_out(port_data_out), .memacc_data_store(wire_memacc_data_store),
        .data_memacc(wire_data_memacc), .memacc_type_out(port_memacc_type), .memacc_type_valid(port_memacc_valid),
        .writeback_valid(wire_writeback_valid), .writeback_valid_out(wire_writeback_valid1),
        .writeback_type(wire_writeback_type), .writeback_type_out(wire_writeback_type1)
        );

writeback stage5(.clk(clk), .rst(rst), .enable(enable), 
        .valid(wire_writeback_valid1), .sel(wire_writeback_type1), 
        .index(wire_index_rd2), .data_ex(wire_data_rd2), .data_mem(wire_data_memacc), 
        .sig_write(wire_sig_write), .out_index(wire_index_write), .data(wire_data_write));



regfile regs(.clk(clk), .rst(rst), .enable(enable), 
        .sig_write(wire_sig_write),     .sig_read1(wire_sig_read1),    .sig_read2(wire_sig_read2), 
        .index_write(wire_index_write), .index_read1(wire_index_rs1),  .index_read2(wire_index_rs2),
        .data_write(wire_data_write),   .data_read1(wire_data_rs1),    .data_read2(wire_data_rs2));

endmodule


 
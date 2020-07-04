`include "define_inst.v"


module decode(
    input clk,
    input rst,
    input enable,
    input [31:0] inst,
    output reg [6:0] cmd,
    output reg [4:0] rd,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [20:0] imm,
    output reg [3:0] valid_field
);
wire [6:0] opcode;
wire [2:0] func3;
assign func3 = inst[14:12];
assign opcode = inst[6:0];



always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        valid_field <= 4'b0000;
    end
    else if(enable) begin
        case(opcode)
            `_type_r: begin
                case({inst[31:25],func3})  
                    `_add : cmd<= `cmd_add ;
                    `_sub : cmd<= `cmd_sub ;
                    `_sll : cmd<= `cmd_sll ;  
                    `_slt : cmd<= `cmd_slt ;  
                    `_sltu: cmd<= `cmd_sltu; 
                    `_xor : cmd<= `cmd_xor ;  
                    `_srl : cmd<= `cmd_srl ;  
                    `_sra : cmd<= `cmd_sra ;  
                    `_or  : cmd<= `cmd_or  ;  
                    `_and : cmd<= `cmd_and ;  
                endcase
                rd <= inst[11:7];
                rs1 <= inst[19:15];
                rs2 <= inst[24:20];
                valid_field <= 4'b1110;
            end
            `_type_i1: begin
                case(func3)
                    `_lb : cmd<= `cmd_lb ;
                    `_lh : cmd<= `cmd_lh ;
                    `_lw : cmd<= `cmd_lw ;
                    `_lbu: cmd<= `cmd_lbu;
                    `_lhu: cmd<= `cmd_lhu;
                endcase
                rd <= inst[11:7];
                rs1 <= inst[19:15];
                imm[11:0] <= inst[31:20];
                valid_field <= 4'b1101;
            end
            `_type_i2: begin
                case(func3)
                    `_addi : cmd<= `cmd_addi;
                    `_slti : cmd<= `cmd_slti ;
                    `_sltiu: cmd<= `cmd_sltiu;
                    `_xori : cmd<= `cmd_xori ;
                    `_ori  : cmd<= `cmd_ori  ;
                    `_andi : cmd<= `cmd_andi ;
                    `_slli : cmd<= `cmd_slli ;
                    `_srli : begin
                        if(inst[31:25] == 7'b0000000)
                            cmd<= `cmd_srli ;
                        else
                            cmd<= `cmd_srai ;
                    end
                endcase
                rd <= inst[11:7];
                rs1 <= inst[19:15];
                imm[11:0] <= inst[31:20];
                valid_field <= 4'b1101;
            end
            `_type_s: begin
                case(func3)
                    `_sb : cmd<= `cmd_sb;
                    `_sh : cmd<= `cmd_sh;
                    `_sw : cmd<= `cmd_sw;
                endcase
                rs1 <= inst[19:15];
                rs2 <= inst[24:20];
                imm[11:0] <= {inst[31:25],inst[11:6]};
                valid_field <= 4'b0111;
            end
            `_type_b:begin
                case(func3)                    
                    `_beq  : cmd<= `cmd_beq;
                    `_bne  : cmd<= `cmd_bne;
                    `_blt  : cmd<= `cmd_blt;    
                    `_bge  : cmd<= `cmd_bge;
                    `_bltu : cmd<= `cmd_bltu;
                    `_bgeu : cmd<= `cmd_bgeu;
                endcase
            end
            `_type_j_jal:begin
                rd  <= inst[11:7];
                imm <= {inst[31], inst[19:12], inst[20], inst[30:21], 1'bx};
                valid_field <= 4'b1001;
            end
            default: valid_field <= 4'b0000;
        endcase
    end
end


endmodule
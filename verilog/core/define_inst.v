`define cmd_add   6'd1
`define cmd_sub   6'd2
`define cmd_sll   6'd3
`define cmd_slt   6'd4
`define cmd_sltu  6'd5
`define cmd_xor   6'd6
`define cmd_srl   6'd7
`define cmd_sra   6'd8
`define cmd_or    6'd9
`define cmd_and   6'd10
`define cmd_lb    6'd11
`define cmd_lh    6'd12
`define cmd_lw    6'd13
`define cmd_lbu   6'd14
`define cmd_lhu   6'd15
`define cmd_sb    6'd16
`define cmd_sh    6'd17
`define cmd_sw    6'd18
`define cmd_beq   6'd19
`define cmd_bne   6'd20
`define cmd_blt   6'd21
`define cmd_bge   6'd22
`define cmd_bltu  6'd23
`define cmd_bgeu  6'd24
`define cmd_addi  6'd25
`define cmd_slti  6'd26
`define cmd_sltiu 6'd27
`define cmd_xori  6'd28
`define cmd_ori   6'd29
`define cmd_andi  6'd30
`define cmd_slli  6'd31
`define cmd_srli  6'd32
`define cmd_srai  6'd33

// R-type: opcode 0110011
// {func7, func3}
`define _type_r 7'b0110011
`define _add  {7'b0000000,3'b000} 
`define _sub  {7'b0100000,3'b000} 
`define _sll  {7'b0000000,3'b001}  
`define _slt  {7'b0000000,3'b010}  
`define _sltu {7'b0000000,3'b011} 
`define _xor  {7'b0000000,3'b100} 
`define _srl  {7'b0000000,3'b101} 
`define _sra  {7'b0100000,3'b101} 
`define _or   {7'b0000000,3'b110} 
`define _and  {7'b0000000,3'b111}


// I-type:
`define _type_i1 7'b0000011
`define _lb  3'b000
`define _lh  3'b001
`define _lw  3'b010
`define _lbu 3'b100
`define _lhu 3'b101

`define _type_i2 7'b0010011
`define _addi  3'b000
`define _slti  3'b010
`define _sltiu 3'b011
`define _xori  3'b100
`define _ori   3'b110
`define _andi  3'b111 
`define _slli  3'b001 // 7'b000000
`define _srli  3'b101 // 7'b000000
`define _srai  3'b101 // 7'b010000

`define _type_i3 7'b0001111 // -
`define _fence   3'b000
`define _fencei  3'b001

`define _type_i4 7'b1110011 // - ecall ebreak

`define _type_i5_jalr 7'b1100111


// S-type
`define _type_s 7'b0100011
`define _sb 3'b000
`define _sh 3'b001
`define _sw 3'b010


// B-type
`define _type_b 7'b1100011
`define _beq  3'b000
`define _bne  3'b001
`define _blt  3'b100
`define _bge  3'b101
`define _bltu 3'b110
`define _bgeu 3'b111

// U-type
`define _type_u_lui 7'b0110111  // -
`define _type_u_auipc 7'b0010111  // -

// J-type
`define _type_j_jal 7'b1101111

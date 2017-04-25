// 32-bits incremented PC
// 32-bits read register 1 value
// 32-bits read register 2 value
// 32-bits sign extended offset
// 5-bits Rt field
// 5-bits Rd field
// 2-bits WB control signals => mem_to_reg, reg_write
// 3-bits MEM control signals => branch, mem_read, mem_write
// 5-bits EX control signals => reg_dest, alu_op, alu_src
// alu_op = 3 bits
module IDEX(clk, inc_pc, read_data_1, read_data_2,
	sign_extended, rt, rd, mem_read, mem_write, mem_to_reg,
	reg_write, reg_dest, branch, alu_op, alu_src,

	inc_pc_reg, read_data_1_reg, read_data_2_reg, sign_extended_reg,
	rt_reg, rd_reg, mem_read_reg, mem_write_reg,
	mem_to_reg_reg, reg_write_reg, reg_dest_reg, branch_reg,
	alu_op_reg, alu_src_reg);

input [31:0] inc_pc, read_data_1, read_data_2, sign_extended;
input [4:0] rt, rd;
input clk, mem_to_reg, reg_write, branch, mem_read, mem_write, reg_dest, alu_src;
input [2:0] alu_op;

output reg [31:0] inc_pc_reg, read_data_1_reg, read_data_2_reg, sign_extended_reg;
output reg [4:0] rt_reg, rd_reg;
output reg mem_to_reg_reg, reg_write_reg, branch_reg, mem_read_reg, mem_write_reg, reg_dest_reg, alu_src_reg;
output reg [2:0] alu_op_reg;

always @ (posedge clk)
begin
	// what about stalling?
	inc_pc_reg <= inc_pc;
	read_data_1_reg <= read_data_1;
	read_data_2_reg <= read_data_2;
	sign_extended_reg <= sign_extended;
	rt_reg <= rt;
	rd_reg <= rd;
	mem_to_reg_reg <= mem_to_reg;
	reg_write_reg <= reg_write;
	branch_reg <= branch;
	mem_read_reg <= mem_read;
	mem_write_reg <= mem_write;
	reg_dest_reg <= reg_dest;
	alu_src_reg <= alu_src;
	alu_op_reg <= alu_op;
end

endmodule
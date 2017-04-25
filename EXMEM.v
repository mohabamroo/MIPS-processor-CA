// 32-bits branch address
// 1-bit zero flag
// 32-bits ALU result/address
// 32-bits register value to write to memory
// 5-bits Rd field (writeReg)
// 2-bits WB control signals => mem_to_reg, reg_write
// 3-bits MEM control signals => branch, mem_read, mem_write
module EXMEM(clk, branch_addr, zero_flag, alu_res, write_data,
	mem_to_reg, reg_write, rd, mem_read, mem_write, branch,

	branch_addr_reg, zero_flag_reg, alu_res_reg,
	write_data_reg, mem_to_reg_reg, reg_write_reg,
	rd_reg, mem_read_reg, mem_write_reg, branch_reg);

input [31:0] branch_addr, alu_res, write_data;
input [4:0] rd;
input clk, zero_flag, mem_to_reg, reg_write, mem_read, mem_write, branch;

output reg [31:0] branch_addr_reg, alu_res_reg, write_data_reg;
output reg [4:0] rd_reg;
output reg zero_flag_reg, mem_to_reg_reg, reg_write_reg, mem_read_reg, mem_write_reg, branch_reg;

always @ (posedge clk)
begin
	// what about stalling?
	branch_addr_reg <= branch_addr;
	alu_res_reg <= alu_res;
	write_data_reg <= write_data;
	rd_reg <= rd;
	zero_flag_reg <= zero_flag;
	mem_to_reg_reg <= mem_to_reg;
	reg_write_reg <= reg_write;
	mem_read_reg <= mem_read;
	mem_write_reg <= mem_write;
	branch_reg <= branch;
end

endmodule
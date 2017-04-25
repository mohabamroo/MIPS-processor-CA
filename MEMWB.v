// 32-bits ALU result
// 32-bits memory word read
// 5-bits Rd field (writeReg)
// 2-bits WB control signals
// 2-bits WB control signals => mem_to_reg, reg_write

module EXMEM(clk, alu_res, read_data,
	rd, mem_to_reg, reg_write,

	alu_res_reg, read_data_reg, rd_reg,
	mem_to_reg_reg, reg_write_reg);

input [31:0] alu_res, read_data;
input [4:0] rd;
input clk, mem_to_reg, reg_write;

output reg [31:0] alu_res_reg, read_data_reg;
output reg [4:0] rd_reg;
output reg mem_to_reg_reg, reg_write_reg;

always @ (posedge clk)
begin
	// what about stalling?
	alu_res_reg <= alu_res;
	read_data_reg <= read_data;
	rd_reg <= rd;
	mem_to_reg_reg <= mem_to_reg;
	reg_write_reg <= reg_write;
end

endmodule
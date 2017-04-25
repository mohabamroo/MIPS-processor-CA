module IFID(clk, instruction, incremented_pc, instruction_reg, incremented_pc_reg);
input [31:0] instruction, incremented_pc;
input clk;
output reg [31:0] instruction_reg, incremented_pc_reg;

always @ (posedge clk)
begin
	// what about stalling?
	instruction_reg <= instruction;
	incremented_pc_reg <= incremented_pc;
end

endmodule

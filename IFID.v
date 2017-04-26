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

module test();
	reg [31:0] x, y;
	reg [2:0] sel;
	wire [31:0] res;
	wire zeroflag;


	// #x means @ time x, do kza
	initial begin
		x = 5; y = 5; sel = 0;
		#10 $display("The resut is %d", res);
		$display("flag: %d", zeroflag);
	end

	always @ (x, y, sel);
		ALU test(x, y, sel, res, zeroflag);
endmodule

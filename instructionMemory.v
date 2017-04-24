// that simple??
module instructionMemory(pc, instruction);
	input[15:0] pc;
	output[31:0] instruction;
	// memory of 512 word, each of 32 bits
	reg [31:0] instruction_memory [511:0];
	// continous assignment
	assign instruction = instruction_memory[pc];
endmodule
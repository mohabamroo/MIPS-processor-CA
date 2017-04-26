// that simple??
module instructionMemory(pc, instruction);
	input[31:0] pc;
	output[31:0] instruction;
	// memory of 512 word, each of 32 bits
	reg [31:0] instruction_memory [511:0];
	// continous assignment
	assign instruction = instruction_memory[pc];
	initial
	begin
	instruction_memory[0] = 32'd10;
	end
endmodule


module instr_tst();

wire [31:0] IF_instr, IF_pc;
assign IF_pc = 32'd0;

instructionMemory test(IF_pc, IF_instr);
always@(*)
	begin
	$display("instruction: %d", IF_instr);
	end
endmodule
module control(opcode, RegDest, Branch, MemRead,
	MemtoReg, MemWrite, ALUOp, ALUSrc, RegWrite);
	input [5:0] opcode;
	output reg RegDest, Branch, MemRead,
	MemtoReg, MemWrite, ALUSrc, RegWrite;
	output reg [2:0] ALUOp;

	// needed set of instructions
	// Arithmetic: add, sub, addi
	// Load/Store: lw, sw
	// Logic: and, or, sll, srl, andi, ori
	// Control flow: beq, bne
	// Comparison: slt

	// ALUOp problem?
	always @ (opcode)
	begin
	case(opcode)
		// R-format: add, sub, and, or, sll, srl, slt
		6'b000000: begin
			RegDest <= 1'b1;
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b0;
			RegWrite <= 1'b1;
			ALUOp <= 3'b010; // what for?
		end
		// addi
		6'b001000: begin
			RegDest <= 1'b0;
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b1;
			ALUOp <= 3'b100; // add in alu?
		end
		// andi
		6'b001100: begin
			RegDest <= 1'b0;
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b1;
			ALUOp <= 3'b101;
		end
		// ori
		6'b001000: begin
			RegDest <= 1'b0;
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b1;
			ALUOp <= 3'b111;
		end
		// lw
		6'b001000: begin
			RegDest <= 1'b0;
			Branch <= 1'b0;
			MemRead <= 1'b1;
			MemtoReg <= 1'b1;
			MemWrite <= 1'b0;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b1;
			ALUOp <= 3'b000; // from table in lec
		end
		// sw
		6'b101011: begin
			RegDest <= 1'b0; // don't care
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0; // don't care
			MemWrite <= 1'b1;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b0;
			ALUOp <= 3'b000; // from table in lec
		end
		// beq
		6'b000100: begin
			RegDest <= 1'b0; // don't care
			Branch <= 1'b1;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0; // don't care
			MemWrite <= 1'b0; 
			ALUSrc <= 1'b0;
			RegWrite <= 1'b0;
			ALUOp <= 3'b001; // from table in lec
		end
		// bne
		6'b000101: begin
			RegDest <= 1'b0; // don't care
			Branch <= 1'b0;
			MemRead <= 1'b0;
			MemtoReg <= 1'b0; // don't care
			MemWrite <= 1'b1;
			ALUSrc <= 1'b1;
			RegWrite <= 1'b0;
			ALUOp <= 3'b001; // from table in lec
		end
	end
endmodule
module aluControl(function_code, alu_operation, alu_control);
input [5:0] function_code;
input [2:0] alu_operation;
output reg [2:0] alu_control;

always @(*)
begin
	// R-format, from control signals, aluOp = 010
	case(alu_operation)
	3'b010:
		begin
			case(function_code[5:0])
				6'b100000:	alu_control = 3'd0;	// add
				6'b100010:	alu_control = 3'd1;	// sub
				6'b100100:  alu_control = 3'd2;	// and
				6'b100101:  alu_control = 3'd3; // or
				6'b101010:  alu_control = 3'd4; // slt
				6'b000000:	alu_control = 3'd6; // sll
				6'b000001:	alu_control = 3'd7; // srl
				default:	alu_control = 3'd0; // add
			endcase
		end
	// load, store => add
	3'b000: begin alu_control = 3'd0; end
	// beq, bnq ?? => subtract
	3'b001: begin alu_control = 3'd1; end
	// addi
	3'b100: begin alu_control = 3'd0; end
	// andi
	3'b101: begin alu_control = 3'd2; end
	// ori
	3'b111: begin alu_control = 3'd3; end
	endcase
end

endmodule
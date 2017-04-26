// compiled and tested
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
				6'h20:	alu_control = 3'd0;	// add
				6'h22:	alu_control = 3'd1;	// sub
				6'h24:  alu_control = 3'd2;	// and
				6'h25:  alu_control = 3'd3; // or
				6'h2A:  alu_control = 3'd4; // slt
				6'h0:	alu_control = 3'd6; // sll
				6'h2:	alu_control = 3'd7; // srl
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

module alu_c_test();
reg [5:0] function_code;
reg [2:0] alu_operation;
wire [2:0] alu_control;

initial
	begin
	// or, expecting 3
	alu_operation = 3'b010; function_code = 6'b100101;
	#10 $display("alu control = %b", alu_control);
	end

	always @(*);
		aluControl test(function_code, alu_operation, alu_control);

endmodule
// compiled and tested
module ALU(in1, in2, aluop, outRes, zeroflag);
	input [31:0] in1;
	input [31:0] in2;
	input [2:0] aluop;

	// variables (manipulated) should be reg,
	// but wires are just outputs (not manipulated)
	output reg [31:0] outRes;
	output reg zeroflag;

	always @ (in1, in2, aluop)
	begin
		if(in1 == in2)
		begin zeroflag = 1; end
		else
		begin zeroflag = 0; end
		// these controls are customizable
		// I didnt find a strict set
		// 000 means add or sth like that
		case(aluop)
			0: outRes = in1 + in2;	// add,ld, st
			1: outRes = in1 - in2;	// sub
			2: outRes = in1 && in2;	// and
			3: outRes = in1 || in2;	// or
			4: outRes = in1 < in2;	// slt
			5: outRes = ~(in1 | in2); // nor
			// where to get the shift amount??
			6: outRes =  in1 << in2; //sll
			7: outRes = in1 >> in2; //slr
		endcase
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
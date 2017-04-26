// compiled and tested!
module registers(data1, data2, rs, rt, rd, regWrite, writeData);
input regWrite;
output reg [31:0] data1, data2;
input [4:0] rs, rd, rt;
input [31:0] writeData;

// array 32 registers, each of 32 bit
reg [31:0] regs [0:31];

initial
begin
    regs[0] = 32'd0;
    regs[1] = 32'd5;
    regs[2] = 32'd10;
    regs[3] = 32'd16;
end

always @ (rs, rt, rd, regWrite, writeData)
begin
    if(regWrite)
		if(rd != 5'd0)
    regs[rd] = writeData;

	if(rs == 5'd0)
		data1 = 32'd0;
	else
		data1 = regs[rs][31:0];

	if(rt == 5'd0)
		data2 = 32'd0;
	else
		data2 = regs[rt][31:0];
end
endmodule

module test();
    reg [31:0] writeData;
    reg regWrite;
    reg [4:0] rs, rd, rt;
	wire [31:0] data1, data2;

	initial begin
		rs = 5'd3; rt = 5'd3; rd = 5'd3;
		regWrite = 1; 
		#0 writeData = 32'd40;
		#40 $display("The resut is %d %d", data1, data2);
	end

	always @ (rs, rt, rd, regWrite, writeData);
		registers test(data1, data2, rs, rt, rd, regWrite, writeData);
endmodule
// compiled!
module registers(clk, data1, data2, rs, rt, rd, regWrite, writeData);
input clk, regWrite;
output reg [31:0] data1, data2;
input [4:0] rs, rd, rt;
input [31:0] writeData;

// array 32 registers, each of 32 bit
reg [31:0] regs [0:31];

always @ (clk, rs, rt, rd, regWrite, writeData)
begin
	if(rs == 5'd0)
		data1 = 32'd0;
	else
		data1 = regs[rs][31:0];

	if(rt == 5'd0)
		data2 = 32'd0;
	else
		data2 = regs[rt][31:0];
end

always @(posedge clk)
begin
	if(regWrite)
		if(rd!= 5'd0)
		begin regs[rd] <= writeData; end
end

endmodule
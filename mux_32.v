// compiled and tested
module mux_32(select, in1, in2, out);

input select;
input [31:0] in1, in2;
output reg [31:0] out;
always@(*)
begin
if(select==0)
	out <= in1;
else
	out <= in2;
end
endmodule

module mux_32_tb();
	reg select;
	reg [31:0] in1, in2;
	wire [31:0] out;

initial
begin
	select = 0;
	in1 = 32'd10;
	in2 = 32'd55;
	#10 $display("The resut is %d", out);
end
	always @ (select);
		mux_32 test(select, in1, in2, out);

endmodule
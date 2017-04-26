// compiled
module mux_5(select, in1, in2, out);

input select;
input [4:0] in1, in2;
output reg [4:0] out;
always@(*)
	begin
	if(select==0)
		out <= in1;
	else
		out <= in2;
	end
endmodule


module mux_5_tb();
	reg select;
	reg [4:0] in1, in2;
	wire [4:0] out;

initial
begin
	select = 0;
	in1 = 5'd10;
	in2 = 5'd5;
	#10 $display("The resut is %d", out);
end
	always @ (select);
		mux_5 test(select, in1, in2, out);

endmodule
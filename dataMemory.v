// compiled and tested
// do we need clk?
module dataMemory(clk, read_address, write_data, mem_read, mem_write,
	read_data);
	input [31:0] write_data, read_address;
	input mem_read, mem_write, clk;
	output reg [31:0] read_data;
	// memory of 32 cells??? each cell is 32 bits
	// SIZE OF MEMORY
	reg[7:0] memory[511:0];

initial
	begin
		memory[0] = 8'b10101010;
		memory[1] = 8'b11111111;
		memory[2] = 8'b00000000;
		memory[3] = 8'b11001100;

		memory[4] = 8'b11111111;
		memory[5] = 8'b00000000;
		memory[6] = 8'b00000000;
		memory[7] = 8'b11111111;
	end
always@(posedge clk)
begin
if(mem_read)
	begin
	// concatinating 4 words
	read_data <= {memory[read_address+3], memory[read_address+2], memory[read_address+1], memory[read_address]};
	end
if(mem_write)
	begin
	memory[read_address] <= write_data[7:0];
	memory[read_address+1] <= write_data[15:8];
	memory[read_address+2] <= write_data[23:16];
	memory[read_address+3] <= write_data[31:24];
	end
end

endmodule


module mem_test();

reg [31:0] write_data, read_address;
reg mem_read, mem_write, clk;
wire [31:0] read_data;

initial
    begin
    forever
		begin #10 clk = ~clk; end
	end

initial
	begin
	clk = 1'b0; mem_read = 1;
	mem_write = 0; write_data = 32'd5;
	read_address = 0;
	#15 begin $display("The resut is %b", read_data); end
	#20 begin read_address = 4; end
	#35 begin $display("The resut is %b", read_data); end
	#30 write_data = 32'd5; mem_write = 1; mem_read = 0;
	#50 $display("The resut is %b", read_data);
	end
always @ (clk);
	dataMemory test(clk, read_address, write_data, mem_read, mem_write, read_data);

endmodule

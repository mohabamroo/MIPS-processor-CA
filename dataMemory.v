// compiled!
// do we need clk?
module control(clk, read_address, write_data, mem_read, mem_write,
	read_data);
	input [15:0] write_data, read_address;
	input mem_read, mem_write, clk;
	output reg [15:0] read_data;
	// memory of 32 cells??? each cell is 32 bits
	// SIZE OF MEMORY
	reg[15:0] memory[7:0];

always@(posedge clk)
begin
if(mem_read)
	begin
	// concatinating 4 words
	read_data <= {memory[read_address+3], memory[read_address+2], memory[read_address+1], memory[read_address]};
	end
else if(mem_write)
	begin
	memory[read_address] <= write_data[7:0];
	memory[read_address+1] <= write_data[15:8];
	memory[read_address+2] <= write_data[23:16];
	memory[read_address+3] <= write_data[31:24];
	end
end

endmodule
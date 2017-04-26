module cpu(clk);

// IF Signal Declarations

wire [31:0] IF_instr, IF_pc, IF_pc_jump, IF_pc_next, IF_pc4;

assign IF_pc = 32'd0;
instructionMemory test(IF_pc, IF_instr);
always@(*)
begin
$display("instruction: %d", IF_instr);
end
endmodule
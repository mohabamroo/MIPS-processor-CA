module cpu(clk);

// IF Signal Declarations

wire [31:0] IF_instr, IF_pc, IF_pc_jump, IF_pc_next, IF_pc4;

instructionMemory(IF_pc, IF_instr);
module cpu(clk);
input clk;
// IF vars declaration
wire [31:0] instruction, pc, incremented_pc, incremented_pc_reg, instruction_reg;
reg [31:0] pc_reg;
// ID vars declaration
reg [31:0] sign_extend;
wire [4:0] rs, rd, rt;
wire [5:0] opcode, funct;
wire [15:0] immediate;
wire [4:0]  shamt;

// control signals declaration
wire RegDest, RegDest_reg;
wire Branch, Branch_reg;
wire MemRead, MemRead_reg;
wire MemtoReg, MemtoReg_reg;
wire MemWrite, MemWrite_reg;
wire [2:0] ALUOp, ALUOp_reg;
wire RegWrite, RegWrite_reg;
wire ALUSrc, ALUSrc_reg;

// registers declaration
wire [31:0] read_data1, read_data2, sign_extend_reg;
wire writeData;

//alu declaration
wire [31:0] alu_in2, alu_res;
wire zeroflag;
wire [4:0] rd_after_mux;
wire [2:0] alu_control;
// IF stage

// incremented pc
assign incremented_pc = pc + 32'd4;
// pc register
always @(posedge clk)
    begin pc_reg <= pc; end
    
instructionMemory mem(pc, instruction);

// IFID
IFID pipe1(clk, instruction, incremented_pc, instruction_reg, incremented_pc_reg);

// pc mux between pc and alu res from EXMEM
mux_32 pcMux(PCSrc, incremented_pc, alu_res_reg);
// ----------------------------------------

// ID stage
// concatinating


always @(immediate)
begin
  if (immediate[15]==0)
  	sign_extend = {16'd0, immediate};
  else
  	sign_extend = {16'd1, immediate};
end

assign funct = instruction[5:0];
assign shamt = instruction[10:6];
assign immediate = instruction[15:0];
assign rd = instruction[15:11];
assign rt = instruction[20:16];
assign rs = instruction[25:21];
assign opcode = instruction[31:26];

control control_signals(opcode, RegDest, Branch, MemRead,
	MemtoReg, MemWrite, ALUOp, ALUSrc, RegWrite);

registers regs_unit(read_data1, read_data2, rs, rt, rd, regWrite, writeData);

IDEX pipe2(clk, incremented_pc_reg, read_data_1, read_data_2,
	sign_extend, rt, rd, MemRead, MemWrite, MemtoReg,
	RegWrite, RegDest, Branch, ALUOp, ALUSrc,

	incremented_pc_reg2, read_data_1_reg, read_data_2_reg, sign_extend_reg,
	rt_reg, rd_reg, MemRead_reg, MemWrite_reg,
	MemtoReg_reg, RegWrite_reg, RegDest_reg, Branch_reg,
	ALUOp_reg, ALUSrc_reg);


// shift sign extened left by 2
assign shifted_sign_extend = sign_extend << 2;
assign branch_addr = incremented_pc_reg2 + shifted_sign_extend;
assign funct = sign_extend_reg[5:0];
mux_32 alu_mux(ALUSrc_reg, read_data_2_reg, sign_extend_reg, alu_in2);
mux_5 rd_mux(RegDest_reg, rt_reg, rd_reg, rd_after_mux);
aluControl alu_control_unit(funct, ALUOp, alu_control);
ALU alu_unit(read_data_1_reg, alu_in2, alu_control, alu_res, zeroflag, shamt);
// ----------------------------------------------

EXMEM pipe3(clk, branch_addr, zeroflag, alu_res, read_data_2_reg,
	MemtoReg_reg, RegWrite_reg, rd_after_mux, MemRead_reg, MemWrite_reg, Branch_reg,

	branch_addr_reg, zeroflag_reg, alu_res_reg,
	write_data, MemtoReg_reg2, RegWrite_reg2,
	rd_after_mux_reg, MemRead_reg2, MemWrite_reg2, Branch_reg2);
// -------------------------------------------------

assign PCSrc = zeroflag_reg && Branch_reg2;

dataMemory memo(clk, alu_res_reg, write_data, MemRead_reg2, MemWrite_reg2,
	read_data);
// ---------------------------------------------------

MEMWB pipe4(clk, alu_res_reg, read_data, rd_after_mux_reg, MemtoReg_reg2, RegWrite_reg2,

	alu_res_reg2, read_data_reg, rd_after_mux_reg2,
	MemtoReg_reg3, RegWrite_reg3);

mux_32 mem_mux(MemtoReg_reg3, read_data_reg, alu_res_reg2, writeData);

endmodule

module main_test();
reg clk;

initial
    begin
    clk = 0;
    forever
		begin #10 clk = ~clk; end
	end

always@(*);
	cpu main(clk);
endmodule
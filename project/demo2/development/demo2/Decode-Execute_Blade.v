/********************************************************************************************************
/		MODULE: Decode-Execute_Blade
/		PURPOSE: Pipeline blade between Decode and Execute stages
/
/		INPUTS: Sorted by stage consumed
/			clk - Clock
/			rst - Reset
/			Flush - Clear all the values
/			Stall - Keep all values, don't load new ones
/
/			Execute:
/				ALU_B_Src_Dec -
/					0 = Register Source (Forwarding will determine from where)
/					1 = Immediate Source (Already determined in Decode Stage)
/				ALU_OP_Code_Dec[3:0] - See ALU for operations
/				Comp_Code_Dec[1:0] - Which comparison requires a branch
/					00 - Equal
/					01 - Not Equal
/					10 - Less Than
/					11 - Greater Than or Equal
/				Immediate_Dec[15:0] - Immediate to be used in an immediate instruction
/				Pass_Thr_Sel_Dec - Which Src to pass through when pass through is selected
/					0 = Pass through A
/					1 = Pass through B
/				Nxt_PC_Dec[15:0] - PC calculated a branch instruction
/				Reg_1_Read_Dec[15:0] - Value 1 read from register file
/				*Reg_2_Read_Dec[15:0] - Value 2 read from register file
/				Reg_1_Src_Dec[2:0] - Register that was read from, used in forwarding
/				Reg_2_Src_Dec[2:0] - Register that was read from, used in forwarding
/					
/			Memory:	
/				Mem_Data_Dec[1:0] - Mem_Data[1] = Write, Mem_Data[0] = Read
/				*Reg_2_Read_Dec[15:0] - Value 2 read from register file - Write to memory
/				
/			WriteBack:
/				Reg_Write_Dec - To write or not
/				WB_Sel_Dec - Which thing to write back in WB stage
/					0 = ALU
/					1 = Memory
/				Write_Reg_Sel_Dec[2:0] - Which register to write to, pre-calculated				
/
/		OUTPUTS: Sorted by stage consumed
/			Execute:
/				ALU_B_Src_Exe -
/					0 = Register Source (Forwarding will determine from where)
/					1 = Immediate Source (Already determined in Decode Stage)
/				ALU_OP_Code_Exe[3:0] - See ALU for operations
/				Comp_Code_Exe[1:0] - Which comparison requires a branch
/					00 - Equal
/					01 - Not Equal
/					10 - Less Than
/					11 - Greater Than or Equal
/				Immediate_Exe[15:0] - Immediate to be used in an immediate instruction
/				Pass_Thr_Sel_Exe - Which Src to pass through when pass through is selected
/					0 = Pass through A
/					1 = Pass through B
/				Nxt_PC_Exe[15:0] - PC calculated a branch instruction
/				Reg_1_Read_Exe[15:0] - Value 1 read from register file
/				Reg_2_Read_Exe[15:0] - Value 2 read from register file
/				Reg_1_Src_Exe[2:0] - Register that was read from
/				Reg_2_Src_Exe[2:0] - Register that was read from
/					
/			Memory:	
/				Mem_Data_Exe[1:0] - Mem_Data[1] = Write, Mem_Data[0] = Read
/				
/			WriteBack:
/				Reg_Write_Exe - To write or not
/				WB_Sel_Exe - Which thing to write back in WB stage
/					0 = ALU
/					1 = Memory
/				Write_Reg_Sel_Exe[2:0] - Which register to write to, pre-calculated				
/
/		Yea this complex
********************************************************************************************************/
module Decode-Execute_Blade(clk, rst, Flush, Stall, ALU_B_Src_Dec, ALU_OP_Code_Dec, Comp_Code_Dec, Immediate_Dec, Pass_Thr_Sel_Dec, Nxt_PC_Dec, Reg_1_Read_Dec, Reg_2_Read_Dec, Reg_1_Src_Dec, Reg_2_Src_Dec, Mem_Data_Dec, Reg_Write_Dec, WB_Sel_Dec, Write_Reg_Sel_Dec, ALU_B_Src_Exe, ALU_OP_Code_Exe, Comp_Code_Exe, Immediate_Exe, Pass_Thr_Sel_Exe, Nxt_PC_Exe, Reg_1_Read_Exe, Reg_2_Read_Exe, Reg_1_Src_Exe, Reg_2_Src_Exe, Mem_Data_Exe, Reg_Write_Exe, WB_Sel_Exe, Write_Reg_Sel_Exe);

	input clk;
	input rst;
	input Flush;
	input Stall;

//Execute
	input ALU_B_Src_Dec;
	input [3:0] ALU_OP_Code_Dec;
	input [1:0] Comp_Code_Dec;
	input [15:0] Immediate_Dec;
	input Pass_Thr_Sel_Dec;
	input [15:0] Nxt_PC_Dec;
	input [15:0] Reg_1_Read_Dec;
	input [15:0] Reg_2_Read_Dec;
	input [2:0] Reg_1_Src_Dec;
	input [2:0] Reg_2_Src_Dec;

//Memory
	input [1:0] Mem_Data_Dec;
	
//WriteBack
	input Reg_Write_Dec;
	input WB_Sel_Dec;
	input [2:0] Write_Reg_Sel_Dec;

//Execute
	output ALU_B_Src_Exe;
	output [3:0] ALU_OP_Code_Exe;
	output [1:0] Comp_Code_Exe;
	output [15:0] Immediate_Exe;
	output Pass_Thr_Sel_Exe;
	output [15:0] Nxt_PC_Exe;
	output [15:0] Reg_1_Read_Exe;
	output [15:0] Reg_2_Read_Exe;
	output [2:0] Reg_1_Src_Exe;
	output [2:0] Reg_2_Src_Exe;
	
//Memory
	output [1:0] Mem_Data_Exe;
	
//WriteBack
	output Reg_Write_Exe;
	output WB_Sel_Exe;
	output [2:0] Write_Reg_Sel_Exe;	

//Execute
	dff_pipe alu_b_src 			(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(ALU_B_Src_Dec), 	.q(ALU_B_Src_Exe));
	dff_pipe alu_op_code [3:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(ALU_OP_Code_Dec),	.q(ALU_OP_Code_Exe));
	dff_pipe comp_code [1:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Comp_Code_Dec),		.q(Comp_Code_Exe));
	dff_pipe immediate [15:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Immediate_Dec),		.q(Immediate_Exe));
	dff_pipe pass_thr_sel 		(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Pass_Thr_Sel_Dec), 	.q(Pass_Thr_Sel_Exe));
	dff_pipe nxt_pc [15:0] 		(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Nxt_PC_Dec), 		.q(Nxt_PC_Exe));
	dff_pipe reg_1_read [15:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Reg_1_Read_Dec),	.q(Reg_1_Read_Exe));
	dff_pipe reg_2_read [15:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Reg_2_Read_Dec),	.q(Reg_2_Read_Exe));
	dff_pipe reg_1_src [2:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Reg_1_Src_Dec),		.q(Reg_1_Src_Exe));
	dff_pipe reg_2_src [2:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Reg_2_Src_Dec),		.q(Reg_2_Src_Exe));
	
//Memory
	dff_pipe mem_data [1:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Mem_Data_Dec), .q(Mem_Data_Exe));
	
//WriteBack
	dff_pipe reg_write 				(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Reg_Write_Dec), 	.q(Reg_Write_Exe));
	dff_pipe wb_sel 				(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(WB_Sel_Dec), 		.q(WB_Sel_Exe));
	dff_pipe write_reg_sel [2:0] 	(.clk(clk), .rst(rst), .Flush(Flush), .Stall(Stall), .d(Write_Reg_Sel_Dec), .q(Write_Reg_Sel_Exe));
	
endmodule
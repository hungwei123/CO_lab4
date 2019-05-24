module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, Jump_o, MemRead_o , MemWrite_o , MemtoReg_o, BranchType_o);
     
//I/O ports
input	[6-1:0] instr_op_i;
output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
output			Branch_o;
output			Jump_o;
output			MemRead_o;
output			MemWrite_o;
output			MemtoReg_o;
output			BranchType_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;
wire			Branch_o;
wire			Jump_o;
wire			MemRead_o;
wire			MemWrite_o;
wire			MemtoReg_o;
wire			BranchType_o;
 
//Main function
/*your code here*/
reg	[3-1:0] aluOp_o;
reg	aluSrc_o;
reg	regWrite_o;
reg	regDst_o;
reg			branch_o;
reg			jump_o;
reg			memRead_o;
reg			memWrite_o;
reg			memtoReg_o;
reg 			branchType_o;

always @(*) begin
	case (instr_op_i)
		6'b000000: begin // add,sub,and,or,nor,slt,sll,srl
			aluOp_o = 3'b010;
			aluSrc_o = 0;
			regWrite_o = 1;
			regDst_o = 1;
			branch_o = 0;
			jump_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branchType_o = 0;
		end
		6'b001000: begin // addi
			aluOp_o = 3'b100;
			aluSrc_o = 1;
			regWrite_o = 1;
			regDst_o = 0;
			memtoReg_o = 0;
			branch_o = 0;
			jump_o = 0;
			memWrite_o = 0;
			memRead_o = 0;
			branchType_o = 0;
		end
		6'b011110: begin // lw
			aluOp_o = 3'b000;
			aluSrc_o = 1;
			regWrite_o = 1;
			regDst_o = 0;
			memWrite_o = 0;
			memRead_o = 1;
			memtoReg_o = 1;
			branch_o = 0;
			jump_o = 0;
			branchType_o = 0;
		end
		6'b011100: begin // sw
			aluOp_o = 3'b000;
			aluSrc_o = 1;
			regWrite_o = 0;
			memWrite_o = 1;
			memRead_o = 0;
			branch_o = 0;
			jump_o = 0;
			branchType_o = 0;
			regDst_o = 0;
			memtoReg_o = 0;
		end
		6'b000100: begin // beq
			aluOp_o = 3'b001;
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 1;
			branchType_o = 0;
			jump_o = 0;
			regDst_o = 0;
		end
		6'b011010: begin // bne
			aluOp_o = 3'b001; // 110
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 1;
			branchType_o = 1;
			jump_o = 0;
			regDst_o = 0;
		end
		6'b011101: begin // jump
			jump_o = 1;
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 0;
			branchType_o = 0;
			regDst_o = 0;
		end
		6'b011001: begin // blt
			aluOp_o = 3'b011;
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 1;
			branchType_o = 1;
			jump_o = 0;
			regDst_o = 0;
		end
		6'b010010: begin // bnez
			aluOp_o = 3'b111;
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 1;
			branchType_o = 1;
			jump_o = 0;
			regDst_o = 0;
		end
		6'b001110: begin // bgez
			aluOp_o = 3'b110;
			aluSrc_o = 0;
			regWrite_o = 0;
			memRead_o = 0;
			memWrite_o = 0;
			memtoReg_o = 0;
			branch_o = 1;
			branchType_o = 1;
			jump_o = 0;
			regDst_o = 0;
		end
	endcase
end

assign ALUOp_o = aluOp_o;
assign ALUSrc_o = aluSrc_o;
assign RegWrite_o = regWrite_o;
assign RegDst_o = regDst_o;
assign Branch_o = branch_o;
assign Jump_o = jump_o;
assign MemRead_o = memRead_o;
assign MemWrite_o = memWrite_o;
assign MemtoReg_o = memtoReg_o;
assign BranchType_o = branchType_o;
endmodule

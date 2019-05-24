module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input		clk_i;
input         	rst_n;

//Internal Signles
wire [32-1:0] instruction, pc_i, pc_o, rsData, rtData, rdData;
wire [32-1:0] extended, zeroFilled, rtData_before, aluResult, shifterResult;
wire [32-1:0] data_read, result_mux3to1, shiftExtended, pcAdd4, jumpAddr, branchAddr, ifBranch;
wire [32-1:0] shiftJump;
wire [5-1:0] writeAddr;
wire [4-1:0] aluOperation;
wire [3-1:0] aluOP;
wire [2-1:0] furSlt;
wire regDst, regWrite, aluSrc, aluZero, aluZero_not, aluOverflow, shiftLR;
wire branch, jump, memRead, memWrite, memToRe, branchType;
wire ifZero, pcSrc;
//modules

Program_Counter PC(      
.clk_i(clk_i),
.rst_n(rst_n),
.pc_in_i(pc_i),   
.pc_out_o(pc_o) 
);
	


Adder Adder1(
.src1_i(pc_o),     
.src2_i(32'd4),
.sum_o(pcAdd4)    
);
	


Instr_Memory IM(
.pc_addr_i(pc_o),  
 .instr_o(instruction)    
 );



Mux2to1 #(.size(5)) Mux_Write_Reg(
.data0_i(instruction[20:16]),
.data1_i(instruction[15:11]),
.select_i(regDst),
.data_o(writeAddr)
);	
		


Reg_File RF(
.clk_i(clk_i),      
.rst_n(rst_n) ,     
.RSaddr_i(instruction[25:21]),  
.RTaddr_i(instruction[20:16]),  
.RDaddr_i(writeAddr),  // ?
.RDdata_i(rdData), 
.RegWrite_i(regWrite),
.RSdata_o(rsData) ,  
.RTdata_o(rtData_before)          
 );
	


Decoder Decoder(
.instr_op_i(instruction[31:26]), 
.RegWrite_o(regWrite),    
.ALUOp_o(aluOP),   
.ALUSrc_o(aluSrc),   
.RegDst_o(regDst),
.Branch_o(branch),
.BranchType_o(branchType),
.Jump_o(jump),
.MemRead_o(memRead),
.MemWrite_o(memWrite),
.MemtoReg_o(memToReg)
);


ALU_Ctrl AC(
.funct_i(instruction[5:0]),   
.ALUOp_i(aluOP),   
.ALU_operation_o(aluOperation),
.leftRight_o(shiftLR),
.FURslt_o(furSlt) 
);
	
Sign_Extend SE(
.data_i(instruction[15:0]),
.data_o(extended)
);

Zero_Filled ZF(
.data_i(instruction[15:0]),
.data_o(zeroFilled)     
);
		
Mux2to1 #(.size(32)) ALU_src2Src(
.data0_i(rtData_before),
.data1_i(extended),
.select_i(aluSrc),
.data_o(rtData)
);	
		
ALU ALU(	
.aluSrc1(rsData),
.aluSrc2(rtData),
.ALU_operation_i(aluOperation),	
.result(aluResult),	
.zero(aluZero),	
.overflow(aluOverflow)
);
		
Shifter shifter( 	
.result(shifterResult), 	
.leftRight(shiftLR),	
.shamt(instruction[10:6]),
.sftSrc(rtData) 	
);

Mux3to1 #(.size(32)) 
RDdata_Source(
.data0_i(aluResult),
.data1_i(shifterResult),	
.data2_i(zeroFilled),
.select_i(furSlt),
.data_o(result_mux3to1)  
);			

Data_Memory DM(
.clk_i(clk_i),
.addr_i(result_mux3to1),
.data_i(rtData_before),
.MemRead_i(memRead),
.MemWrite_i(memWrite),
.data_o(data_read)
);

Mux2to1 #(.size(32)) mem_to_reg(
.data0_i(result_mux3to1),
.data1_i(data_read),
.select_i(memToReg),
.data_o(rdData)
);

Mux2to1 #(.size(1)) if_zero(
.data0_i(aluZero),
.data1_i(aluZero_not),
.select_i(branchType),
.data_o(ifZero)
);

Mux2to1 #(.size(32)) if_branch(
.data0_i(pcAdd4),
.data1_i(branchAddr),
.select_i(pcSrc),
.data_o(ifBranch)
);

Adder Adder2(
.src1_i(pcAdd4),     
.src2_i(shiftExtended),
.sum_o(branchAddr) 
);

Shifter shift_jump( 	
.result(shiftJump), 	
.leftRight(1'b1), // left
.shamt(5'b00010),
.sftSrc(instruction)
);

Shifter shift_extended( 	
.result(shiftExtended), 	
.leftRight(1'b1), // left
.shamt(5'b00010),
.sftSrc(extended)
);

Mux2to1 #(.size(32)) to_PC(
.data0_i(ifBranch),
.data1_i(jumpAddr),
.select_i(jump),
.data_o(pc_i)
);

assign aluZero_not = ~aluZero;
assign pcSrc = branch & ifZero;
assign jumpAddr = {pcAdd4[31:28], shiftJump[27:0]};
//assign jumpAddr[31:28] = pcAdd4[31:28];
//assign jumpAddr[27:0] = shiftJump;

endmodule




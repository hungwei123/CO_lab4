module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, leftRight_o, FURslt_o);

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;
output	   leftRight_o;
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		leftRight_o;
wire		[2-1:0] FURslt_o;

//Main function
/*your code here*/
reg 		[4-1:0] alu_operation;
reg		LR;
reg			[2-1:0] furslt;
always@(*) begin
if(ALUOp_i == 3'b010) begin // R-type
	if(funct_i == 6'b010010) begin
		alu_operation = 4'b0000; //ADD
		furslt = 2'b00;
	end
	if(funct_i == 6'b010000) begin
		alu_operation = 4'b0001; //SUB
		furslt = 2'b00;
	end 
	if(funct_i == 6'b010100) begin
		alu_operation = 4'b0010; //AND
		furslt = 2'b00;
	end 
	if(funct_i == 6'b010110) begin
		alu_operation = 4'b0011; //OR
		furslt = 2'b00;
	end
	if(funct_i == 6'b010101) begin
		alu_operation = 4'b0100; //NOR
		furslt = 2'b00;
	end 
	if(funct_i == 6'b100000) begin
		alu_operation = 4'b0101; //SLT
		furslt = 2'b00;
	end 
	if(funct_i == 6'b000000) begin
		alu_operation = 4'b0110; //SLL
		LR = 1;
		furslt = 2'b01;
	end 
	if(funct_i == 6'b000010) begin
		alu_operation = 4'b0111; //SRL
		LR = 0;
		furslt = 2'b01;
	end
	if(funct_i == 6'b000110) begin
		alu_operation = 4'b1001; //SRLV
		LR = 1;
		furslt = 2'b00;
	end
	if(funct_i == 6'b000100) begin
		alu_operation = 4'b1010; //SLLV
		LR = 0;
		furslt = 2'b00;
	end
	if(funct_i == 6'b001000) begin //jr
		furslt = 2'b10;
	end
end
else if(ALUOp_i == 3'b100) begin	
	alu_operation = 4'b1000; //ADDI
	furslt = 2'b00;
end
else if(ALUOp_i == 3'b101) begin //lui
	
end
else if(ALUOp_i == 3'b000) begin //lw, sw
	alu_operation = 4'b0000;
	furslt = 2'b00;
end
else if(ALUOp_i == 3'b001) begin //beq, bne
	alu_operation = 4'b1011;
end
else if (ALUOp_i == 3'b011) begin // blt
	alu_operation = 4'b0101;
end
else if (ALUOp_i == 3'b111) begin // bnez
	alu_operation = 4'b1011;
end
else if (ALUOp_i == 3'b110) begin // bgez
	alu_operation = 4'b1100;
end

end

assign ALU_operation_o = alu_operation;
assign leftRight_o = LR;
assign FURslt_o = furslt;

endmodule     

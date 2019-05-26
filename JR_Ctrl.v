module JR_Ctrl(funct_i, ALUOp_i, JR_control_o);
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;
output     JR_control_o;

wire JR_control_o;

reg jr_control;
always@(*) begin
	if(ALUOp_i == 3'b010 && funct_i == 6'b001000)
		jr_control = 1;
	else
		jr_control = 0;
end

assign JR_control_o = jr_control;

endmodule
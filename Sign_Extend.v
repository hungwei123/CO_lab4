module Sign_Extend( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;

//Sign extended
/*your code here*/
reg [32-1:0] result;
always @(*) begin
	if(data_i[15] == 0) begin
		result[15:0] = data_i;
		result[31:16] = 16'b0000000000000000;
	end
	else begin
		result[15:0] = data_i;
		result[31:16] = 16'b1111111111111111;
	end
end

assign data_o = result;

endmodule      

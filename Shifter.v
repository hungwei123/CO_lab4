module Shifter( result, leftRight, shamt, sftSrc );

//I/O ports 
output	[32-1:0] result;

input	leftRight;
input	[5-1:0] shamt;
input	[32-1:0] sftSrc;

//Internal Signals
wire	[32-1:0] result;
  
//Main function
/*your code here*/
reg [32-1:0] res;
always @(*) begin
	if(leftRight == 1) res = (sftSrc << shamt); // shift left
	else res = (sftSrc >> shamt); // shift right
end

assign result = res;

endmodule
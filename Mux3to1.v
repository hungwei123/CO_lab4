module Mux3to1( data0_i, data1_i, data2_i, select_i, data_o );


parameter size = 0;			   
			

//I/O ports               

input wire	[size-1:0] data0_i;          

input wire	[size-1:0] data1_i;

input wire	[size-1:0] data2_i;

input wire	[2-1:0] select_i;

output wire	[size-1:0] data_o; 

//Main function
/*your code here*/
reg [size-1:0] dout;
always@(*)begin
	case (select_i)
		0: dout = data0_i;
		1: dout = data1_i;
		2: dout = data2_i;
	endcase
end

assign data_o = dout;


endmodule      

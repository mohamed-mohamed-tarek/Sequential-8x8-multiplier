module shifter(
	input [7:0] inp,
	input [1:0] shift_cntr,
	output reg [15:0] shift_out);
always@(*) begin
	
     case(shift_cntr)
        0,3 : shift_out = inp;
        1 : shift_out = inp << 4;
        2 : shift_out = inp << 8;
        default : shift_out = inp;
     endcase
end
endmodule

module r_TB();
reg [7:0] inp;
reg [1:0] shift_cntr;
wire [15:0] shift_out;

shifter s(inp,shift_cntr,shift_out);

	
initial 
begin

$monitor("shift_cntr=%d , in_data=  %b  =>>>  shift_out=%b",shift_cntr,inp,shift_out); 

inp = 7; 
shift_cntr = 0;
#10
shift_cntr = 1;
#10
shift_cntr = 2;
#10
shift_cntr = 3;
end
endmodule


		

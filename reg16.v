module reg16(
	input clk,sclr,clk_en,
	input [15:0] datain,
	output reg [15:0] reg_out);
always@(posedge clk) begin
	if(clk_en) begin
		if(!sclr)
			reg_out <= 0;
		else
			reg_out <= datain;
	end
end
endmodule
module TB();
reg clk ,sclr,clk_en;
reg [15:0] datain;
wire [15:0] reg_out;
reg16 r(clk,sclr,clk_en,datain,reg_out);
always
	#5 clk=~clk;
initial
	$monitor("sclr=%b clk_en=%b datain=%d reg_out=%d",sclr,clk_en,datain,reg_out);
initial begin
clk = 0; clk_en=0; sclr=1; datain=2;
#10
clk_en=1;
#10
sclr=0;


#80;
end
endmodule 
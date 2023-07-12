module adder(
	input [15:0] dataa, datab,
	output [15:0] sum);
assign sum = dataa + datab;
endmodule

module adder_TB();
reg [15:0] dataa ;
reg [15:0] datab;
wire [15:0] sum;
adder adder1(dataa , datab, sum);


initial 
begin
    $monitor("dataa = %0d  datab = %0d   Sum= %0d", dataa , datab , sum);

	dataa = 0; datab =0;
	#5
	dataa = 1;
    datab = 2;
	
	
	
	end
endmodule

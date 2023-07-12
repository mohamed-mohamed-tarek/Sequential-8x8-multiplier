
module mux4( input wire [3:0] mux_in_a , 
 input wire [3:0] mux_in_b , 
 input mux_sel ,
 output  reg[3:0]mux_out
 );
 always @(*) 
 begin 
    case (mux_sel ) 
   1'b0 : mux_out <= mux_in_a ;
   1'b1 : mux_out <= mux_in_b ; 

    endcase 
 end

endmodule

module mux_TB();
wire [3:0] out;
reg [3:0] in_a,in_b;
reg sel;

mux mux1 (in_a,in_b,sel,out);

	
initial 
begin
  $monitor("in_a=%d  in_b=%d  sel=%d  out=%d",in_a,in_b,sel,out); 
  
 in_a=1; in_b=2; sel=0;
 #20
 in_a=1; in_b=2; sel=1;

end
endmodule

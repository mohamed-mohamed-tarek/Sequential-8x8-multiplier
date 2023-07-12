module top (
input [7:0] dataa,datab , input start,  reseta , clk ,
  output  [15:0] product8x8 , output doneflag ,seg_a, seg_b, seg_c,
   seg_d, seg_e, seg_f,seg_g);

	wire [3:0] aout,bout;
	wire [7:0] product;
	wire [15:0] shift_out , sum;
	wire [2:0] state_out;
	wire [1:0] sel ,shift,count;
	wire clk_ena,sclr_n;

	mux4 m1(dataa[3:0],dataa[7:4],sel[1],aout);
	mux4 m2(datab[3:0],datab[7:4],sel[0],bout);
	mult4x4 mul1(aout,bout,product);
	shifter s1(product, shift,shift_out);
	adder d1(shift_out,product8x8,sum);
	reg16 r1(clk ,sclr_n,clk_ena,sum,product8x8);
	multcont mc1(clk,reseta,start,count,sel,shift,state_out,doneflag,clk_ena,sclr_n);
	counter c1(clk,(!start),count);
	seven_segment_encoder sse1 (state_out,seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g);
endmodule


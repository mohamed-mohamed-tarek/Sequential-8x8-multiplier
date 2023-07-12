`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2023 12:53:08 PM
// Design Name: 
// Module Name: mult_cont1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module multcont(
	input clk , reset_a, start,
	input [1:0] count,
	output reg [1:0] input_sel , shift_sel,
	output [2:0] state_out,
	output reg done , clk_ena, sclr_n);

	reg [2:0] current_state, next_state;
   

parameter IDLE  = 3'b000;
parameter LSB   = 3'b001;
parameter MID   = 3'b010;
parameter MSB   =3'b011;
parameter CALC_DONE=3'b100;
parameter ERR =3'b101;

 assign state_out = current_state;

always@(*) begin
if(reset_a==0)
	next_state=IDLE;
else 
begin
	case(current_state)
		IDLE: begin
			if(start==0) 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=IDLE;
			end
			else 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=0;
				next_state = LSB;
			end
		end
		LSB: begin
			if((start==0) && (count==0)) 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=1;
				next_state=MID;
			end
			else
			 begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=ERR;
			end
		end
		MID: begin
			if((start==0)&&(count==2'b01)) 
			begin
				input_sel=2'b01;
				shift_sel=2'b01;
				done=0;
				clk_ena=1;
				sclr_n=1;
				next_state= MID;
			end
			else if((start==0) && (count==2'b10)) 
			begin
				input_sel=2'b10;
				shift_sel=2'b01;
				done=0;
				clk_ena=1;
				sclr_n=1;
				next_state=MSB;
			end
			else
			 begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=ERR;
			end
		end
		MSB: begin
			if((start==0) && (count==2'b11)) 
			begin
				input_sel=2'b11;
				shift_sel=2'b10;
				done=0;
				clk_ena=1;
				sclr_n=1;
				next_state=CALC_DONE;
			end
			else 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=ERR;
			end
		end
		CALC_DONE: begin
			if(start==1) 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=ERR;
			end
			else
			 begin
				input_sel=0;
				shift_sel=0;
				done=1;
				clk_ena=0;
				sclr_n=1;
				next_state=IDLE;
			end
		end
		ERR: begin
			if(start==1) 
			begin
				input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=1;
				sclr_n=0;
				next_state=LSB;
				
			end
			else
			 begin
			input_sel=0;
				shift_sel=0;
				done=0;
				clk_ena=0;
				sclr_n=1;
				next_state=ERR;
			end
		end
	endcase
end
end

always@(posedge clk, negedge reset_a)
 begin
if(reset_a==0)
	current_state <= IDLE;
else 
	current_state <= next_state;
end


	endmodule

	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2023 12:53:41 PM
// Design Name: 
// Module Name: mult_cont_tb1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult_cont_tb1;

// Inputs
reg clk;
reg reset_a;
reg start;
reg [1:0] count;

// Outputs
wire [1:0] input_sel;
wire shift_sel;
wire [2:0] state_out;
wire done;
wire clk_ena;
wire sclr_n;

// Instantiate the Unit Under Test (UUT)
mult_cont1 uut (
    .clk(clk), 
    .reset_a(reset_a), 
    .start(start), 
    .count(count), 
    .input_sel(input_sel), 
    .shift_sel(shift_sel), 
    .state_out(state_out), 
    .done(done), 
    .clk_ena(clk_ena), 
    .sclr_n(sclr_n)
);

initial begin
    // Initialize inputs
    clk = 0;
    reset_a = 0;
    start = 0;
    count = 0;


    #50 reset_a = 1;


    #50 start = 0;
    #50 count = 0;


    #50 start = 1;
    #50 start = 0;
    #50 count = 0;


    #50 start = 1;
    #50 start = 0;
    #50 count = 1;


    #50 start = 1;
    #50 start = 0;
    #50 count = 2'b01;


    #50 start = 1;
    #50 start = 0;
    #50 count = 2'b10;


    #50 start = 1;
    #50 start = 0;
    #50 count = 2'b11;


    #50 start = 0;
    #50 count = 0;

    $finish;
end

// Clock generator
always begin
    #5 clk = ~clk;
end

endmodule
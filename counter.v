module counter(
    input clk,aclr_n,
    output reg [1:0] count_out
    );

    always@(posedge clk)
    begin
        count_out <=0;
        if(!aclr_n)
            count_out <=0;
        else count_out <= count_out+1 ;
    end
    
endmodule





module tb_counter;
reg clk;
reg res;
wire [1:0] out;
counter_2bit c0(
    .clk(clk),
    .aclr_n(res),
    .count_out(out)
);
//Makes the clk changes its state every 5ns
always #5 clk = ~clk;
    initial begin
        clk <=0;
        res <=0;
        
        #20 res <=1;
        #40 res <=0;
        #30 res <=1;
        #100 $finish;
    end
endmodule

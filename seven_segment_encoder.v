module seven_segment_encoder(
    input [2:0] bin,
    output reg seg_a,
    output reg seg_b,
    output reg seg_c,
    output reg seg_d,
    output reg seg_e,
    output reg seg_f,
    output reg seg_g
);

always @(bin)
begin
    case(bin)
        3'b000: begin seg_a = 1'b1; seg_b = 1'b1; seg_c = 1'b1; seg_d = 1'b1; seg_e = 1'b1; seg_f = 1'b1; seg_g = 1'b0; end // 0
        3'b001: begin seg_a = 1'b0; seg_b = 1'b1; seg_c = 1'b1; seg_d = 1'b0; seg_e = 1'b0; seg_f = 1'b0; seg_g = 1'b0; end // 1
        3'b010: begin seg_a = 1'b1; seg_b = 1'b1; seg_c = 1'b0; seg_d = 1'b1; seg_e = 1'b1; seg_f = 1'b0; seg_g = 1'b1; end // 2
        3'b011: begin seg_a = 1'b1; seg_b = 1'b1; seg_c = 1'b1; seg_d = 1'b1; seg_e = 1'b0; seg_f = 1'b0; seg_g = 1'b1; end // 3
        default: begin seg_a = 1'b1; seg_b = 1'b0; seg_c = 1'b0; seg_d = 1'b1; seg_e = 1'b1; seg_f = 1'b1; seg_g = 1'b1; end // E
    endcase
end

endmodule

module tb_encoder;  //make module to test the encoder
    reg [2:0] bin;  //reg as we assign values to it in the inital block
    wire seg_a; //wire as it it the output of the module
	wire seg_b;
	wire seg_c;
	wire seg_d;
	wire seg_e;
	wire seg_g;
	wire seg_f;
	
	
    seven_segment_encoder uut_encoder (  //make an instant of the module
        .bin(bin),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_g(seg_g),
        .seg_f(seg_f)
    );

    initial begin
        $monitor("bin = %b, seg_a = %b", bin, seg_a);  //display the output
        
        bin = 3'b000; // Test for 0
        #10;  //a delay of 10 time units

        
        bin = 3'b001; // Test for 1
        #10;

        bin = 3'b010; // Test for 2
        #10;

        bin = 3'b011; // Test for 3
        #10;

        // Test for other values
        bin = 3'b100;
        #10;

        bin = 3'b101;
        #10;

        bin = 3'b110;
        #10;

        bin = 3'b111;
        #10;

        $finish;
    end

        
endmodule
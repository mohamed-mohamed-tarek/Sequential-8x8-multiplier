module mult4x4(
  input [3:0] A,
  input [3:0] B,
  output reg [7:0] Product
);

  always @(A, B) begin
    Product = A * B;
  end

endmodule

module tb_mul_4x4; //make module to test the encoder

  reg [3:0] A;  //reg as we assign values to it in the inital block
  reg [3:0] B;
  wire [7:0] Product; //wire as it it the output of the module

  mul_4x4 uut_mul (
    .A(A),
    .B(B),
    .Product(Product)
  );

  initial begin
    $monitor("A = %b, B = %b, Product = %d", A, B, Product);

    
    A = 2; // Testcase 1
    B = 3;
    #10;

    A = 7;  // Testcase 2
    B = 5;
    #10;

    // Add more testcases here

    $finish;
  end

endmodule
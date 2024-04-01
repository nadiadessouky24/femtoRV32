
module RCA #(parameter n=32)
(
    input [n-1: 0] A,
    input [n-1: 0] B,
    input cin,
    output [n:0] sum
 );

 wire [n:0] c;

assign c[0] = cin; 
genvar i;
 
 generate
    for (i=0;i<n;i = i +1) begin
        full_adder u0 (A[i], B[i], c[i], sum [i], c[i+1]);
    end 
  endgenerate
 
 assign sum[n] = c[n];
 
 
endmodule
`timescale 1ns / 1ps



module nl_shift #(parameter n  = 32)
(
    input  [n-1:0] A,
    output [n-1:0] B
 );
 
 assign B = {A[n-2:0] , 1'b0 };
  
endmodule
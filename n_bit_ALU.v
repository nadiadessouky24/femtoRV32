`timescale 1ns / 1ps

module n_bit_ALU #(parameter n=32)
(
    input [n-1:0] A,
    input [n-1:0] B,
    input [3:0] S,
    output reg [n-1:0] ALUoutput,
    output reg Zflag
);

    wire [n-1:0] Bmux;
    wire [n-1:0] sum;
    wire [n-1:0] AND;
    wire [n-1:0] OR;
    
    assign Bmux = (S[2]==0)?  B:~B;
    RCA rca(A,Bmux,S[2],sum);
    
   assign AND = A & B;
   assign OR = A | B;
   
   always @(*) begin
   
       if(S == 4'b0000) begin
       ALUoutput  = AND;
       end
       else if( S == 4'b0001) begin
       ALUoutput = OR;
       end 
       else if (S == 4'b0010 | S == 4'b0110) begin
       ALUoutput = sum;
       end 
       else begin
       ALUoutput = 0; 
       end 
   end
   
   always @(*)
   begin 
      if (ALUoutput == 0) Zflag = 1;
        else Zflag = 0;  
   end 

endmodule
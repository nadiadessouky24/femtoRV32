`timescale 1ns / 1ps


module Nbit_reg #(parameter n = 32)
(
    input clk,
    input PC_Enable,
    input rst, 
    input BranchSel, 
    input [31:0] shift_left_out,
    input [31:0] PCin,
    output reg [31:0] PCout
 );

always @ (posedge clk) begin
    if(rst) begin
        PCout <= 0;
    end
    else begin
        PCout <= BranchSel? PCin  + shift_left_out : PCin +4;
    end
end

endmodule
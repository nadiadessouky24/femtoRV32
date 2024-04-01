`timescale 1ns / 1ps


module ControlUnit(
input  [4:0] inst,
output reg branch,
output reg memread,
output reg memtoreg,
output reg [1:0] ALUOp,
output reg MemWrite,
output reg ALUSrc,
output reg RegWrite
    );
    
    always @(*) begin
    
    if(inst == 5'b01100) begin //R-Inst
        branch =0;
        memread  = 0;
        memtoreg = 0;
        ALUOp = 2'b10;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 1;
    end
    else if(inst == 5'b00000) begin //LOAD INST
        branch =0;
        memread  = 1;
        memtoreg = 1;
        ALUOp = 2'b00;
        MemWrite = 0;
        ALUSrc = 1;
        RegWrite = 1;
    end 
    else if(inst == 5'b01000) begin //STORE INST
        branch =0;
        memread  = 0;
        memtoreg = 0;
        ALUOp = 2'b00;
        MemWrite = 1;
        ALUSrc = 1;
        RegWrite = 0;
    end 
    else if(inst == 5'b11000) begin //BRANCH INST
        branch = 1;
        memread  = 0;
        memtoreg = 0;
        ALUOp = 2'b01;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
    end
    else begin
        branch = 0;
        memread  = 0;
        memtoreg = 0;
        ALUOp = 2'b0;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
    end
    end
    
     
endmodule
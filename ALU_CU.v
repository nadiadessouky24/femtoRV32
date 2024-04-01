`timescale 1ns / 1ps

module ALU_CU(input [1:0] ALUOp, input [31:0] Inst, output reg [3:0] ALU_Selection);

always @(*)
begin
case(ALUOp)
2'b00:
    begin
    ALU_Selection = 4'b0010;
    end
2'b01:
    begin
    ALU_Selection = 4'b0110;
    end  
2'b10:
    begin
    case(Inst[14:12])
    3'b000:
    begin
    if(Inst[30] == 1)
    ALU_Selection = 4'b0110;
    else
    if(Inst[30] == 0)
    ALU_Selection = 4'b0010;
    end
    3'b111:
    begin
    if(Inst[30] == 0)
    ALU_Selection = 4'b0000;
    end
    3'b110:
    begin
    if(Inst[30] == 0)
    ALU_Selection = 4'b0001;

    end
    endcase    
    end
endcase          
end



endmodule
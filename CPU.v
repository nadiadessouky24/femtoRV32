`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Mostafa & Nadia Incorporated
// Engineer: Mostafa & Nadia
// 
// Create Date: 03/05/2024 01:32:17 PM
// Design Name: Single Cycle Processor
// Module Name: CPU
// Target Devices: Nexys A7 
//////////////////////////////////////////////////////////////////////////////////


module CPU(
input clk,
input rst
//input [3:0] SSDsel,
//input [1:0] LEDsel, 
//output reg [15:0] LEDout,
//output reg [12:0] BCDin
    );
    
    // Decleration of Wires
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp; //only supports 4 instructions. edit when adding more
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [31:0] Instruction;
    reg [31:0] PCin;
    wire [31:0] PCout;
    wire [3:0] ALU_Selection;
    wire Zflag;
    wire [31:0] WriteData;
    wire BranchSel;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] ImmGen;
    wire [31:0] ALUoutput;
    wire [31:0] ReadData_mem;
    wire [31:0] shift_left_out;
    wire PC_Enable;
    wire [31:0] ALU_in;
   
    wire [31:0] PCout4;
    
    assign PCout4 = PCout + 4;   

    assign PC_Enable = 1'b1; // To be changed
    

        assign BranchSel = Branch & Zflag;
        
        always @(*) begin
             PCin = rst ? 32'b0 : PCout; 
        end
    
    // instantiation of modules
    
    Nbit_reg PC(clk,PC_Enable,rst, BranchSel, shift_left_out,PCin , PCout); 
    InstMem instmem (PCout[7:2], Instruction);
    register registers(clk,rst,Instruction [19:15] , Instruction [24:20] , Instruction [11:7] , WriteData , RegWrite , ReadData1 , ReadData2 );
    ControlUnit CU (Instruction [6:2] , Branch , MemRead , MemtoReg , ALUOp , MemWrite , ALUSrc , RegWrite ); //to be edited when more intructions are added
    ImmGen immgen (Instruction , ImmGen );
    ALU_CU alucu ( ALUOp , Instruction , ALU_Selection );
    assign ALU_in = ALUSrc ? ImmGen : ReadData2 ;
    n_bit_ALU alu (ReadData1 , ALU_in , ALU_Selection ,ALUoutput , Zflag);
    DataMem datamem(clk, MemRead , MemWrite , ALUoutput [7:2] , ReadData2 , ReadData_mem );
    assign WriteData = MemtoReg ? ReadData_mem : ALUoutput;
    nl_shift shifter(ImmGen , shift_left_out);
    
    //LED
    
//    always@(*)
//        begin
//            case (LEDsel)
//                2'b00: 
//                begin 
//                     LEDout = Instruction [15:0];
//                end 
                
//                2'b01:
//                begin
//                     LEDout = Instruction [31:16];
//                end 
                
//                2'b10:
//                begin
     
//                    LEDout = {2'b00, ALUOp, ALU_Selection, Zflag, BranchSel}; 
//                end 
                
//                2'b11:
//                       begin
     
//                    LEDout = 16'b0; 
//                end 
//             endcase
//        end 
 
// always @(*)
//    begin
//        case (SSDsel)
//            4'b0000:
//            begin 
//                BCDin = PCout [12:0]; 
//            end  
            
//           4'b0001:
//            begin 
         
//                BCDin = PCout4 [12:0] ; 
//            end
              
//            4'b0010:
//            begin 
//                BCDin = {12'b0, BranchSel}; 
//            end           
            
//            4'b0011:
//            begin 
//                BCDin = PCin [12:0]; 
//            end 
            
//            4'b0100:
//            begin 
//                BCDin = ReadData1 [12:0]; 
//            end 
            
//            4'b0101:
//            begin 
//                BCDin = ReadData2 [12:0];  
//            end 
            
//            4'b0110:
//            begin 
//                BCDin = WriteData [12:0]; 
//            end 
            
//            4'b0111:
//            begin 
//                BCDin = ImmGen [12:0]; 
//            end 
            
//            4'b1000:
//            begin 
//                BCDin = shift_left_out [12:0]; 
//            end 
            
//            4'b1001:
//            begin 
//                BCDin = ALU_in [12:0]; 
//            end 
            
//            4'b1010:
//            begin 
//                BCDin = ALUoutput [12:0]; 
//            end 
            
//            4'b1011:
//            begin 
//                BCDin = ReadData_mem [12:0]; 
//            end 
            
//            default : BCDin = 13'b0; 
            
//            endcase
//    end    
 
 
 
 
endmodule

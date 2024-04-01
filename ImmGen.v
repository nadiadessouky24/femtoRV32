`timescale 1ns / 1ps


module ImmGen( input [31:0] inst, output reg [31:0] gen_out);


always @(*)
begin
    if (inst[6] == 0)
    begin
        if (inst[5] == 0)
        begin //lw 
            gen_out = {{20{inst[31]}} , inst[31:20]};                                                                                                                                                               
        
        end
        else if (inst[5] == 1) //sw
        begin
            gen_out = {{20{inst[31]}} , inst[31:25], inst[11:7]};
        end
    end    
    else if (inst[6] == 1) //BEQ
    begin
        gen_out = {{20{inst[31]}} , inst[31], inst[7],inst[30:25],inst[11:8]};
    end 
end

endmodule
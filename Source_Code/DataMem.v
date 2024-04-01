module DataMem
(input clk,
input MemRead,
input MemWrite,
input [5:0] addr,
input [31:0] data_in,
output reg [31:0] data_out); 
 
 reg [31:0] mem [0:63];
 
    
    initial begin
        mem[0]=32'd17;
        mem[1]=32'd9;
        mem[2]=32'd25;
    end

 
 
  always @(posedge clk)begin
 
    if (MemWrite == 1) begin 
        mem[addr] = data_in; 
    end

  end 
  
  always @(*) begin 
      if (MemRead == 1) begin //load word
        data_out = mem[addr]; 
    end 
  end

endmodule 
module rom_memory (input clk,
                   input wire [3:0] addr,
                   input wire rd,
                   output reg [3:0] data);

  //-- Memoria
  reg [3:0] rom [0:31];

  always @(negedge clk) begin
    data <= rom[addr];
  end
    
/*
//-- ROM1: contador
  initial begin
    rom[0] = 4'h0; 
    rom[1] = 4'h1;
    rom[2] = 4'h2;
    rom[3] = 4'h3;
    rom[4] = 4'h4; 
    rom[5] = 4'h5;
    rom[6] = 4'h6;
    rom[7] = 4'h7;
    rom[8] = 4'h8; 
    rom[9] = 4'h9;
    rom[10] = 4'hA;
    rom[11] = 4'hB;
    rom[12] = 4'hC; 
    rom[13] = 4'hD;
    rom[14] = 4'hE;
    rom[15] = 4'hF;
   end

*/

//-- ROM2: Secuencia
initial begin
    rom[0] = 4'h1; 
    rom[1] = 4'h2;
    rom[2] = 4'h4;
    rom[3] = 4'h8;
    rom[4] = 4'h1; 
    rom[5] = 4'h8;
    rom[6] = 4'h4;
    rom[7] = 4'h2;
    rom[8] = 4'h1; 
    rom[9] = 4'h0;
    rom[10] = 4'hF;
    rom[11] = 4'h0;
    rom[12] = 4'hF; 
    rom[13] = 4'h3;
    rom[14] = 4'hC;
    rom[15] = 4'h3;
   end

endmodule



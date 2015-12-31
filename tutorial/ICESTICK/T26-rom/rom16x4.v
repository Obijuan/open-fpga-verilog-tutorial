//----------------------------------------------------------------------------
//-- Memoria ROM de 16 x 4
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- La memoria está inicializada con los valores para sacar por los leds
//-- y generar una secuencia de luces
//----------------------------------------------------------------------------

module rom16x4 (input clk,
                input wire [3:0] addr,
                output reg [3:0] data);

  //-- Memoria
  reg [3:0] rom [0:31];

  always @(negedge clk) begin
    data <= rom[addr];
  end


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
    rom[9] = 4'hF;
    rom[10] = 4'h0;
    rom[11] = 4'hF;
    rom[12] = 4'hC; 
    rom[13] = 4'h3;
    rom[14] = 4'hC;
    rom[15] = 4'h3;
   end

endmodule



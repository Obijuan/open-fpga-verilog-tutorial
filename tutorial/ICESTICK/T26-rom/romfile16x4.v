//----------------------------------------------------------------------------
//-- Memoria ROM de 16 x 4
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- La memoria se inicializa a partir de un fichero, que se pasa como
//-- parámetro. Por defecto es rom1.list
//----------------------------------------------------------------------------
module romfile16x4 (input clk,
                    input wire [3:0] addr,
                    output reg [3:0] data);

//-- Parametro: Nombre del fichero con el contenido de la ROM
parameter ROMFILE = "rom1.list";

  //-- Memoria
  reg [3:0] rom [0:31];

  //-- Lectura de la memoria
  always @(negedge clk) begin
    data <= rom[addr];
  end

//-- Cargar en la memoria el fichero ROMFILE
//-- Los valores deben estan dados en hexadecimal
initial begin
  $readmemh(ROMFILE, rom);
end


endmodule

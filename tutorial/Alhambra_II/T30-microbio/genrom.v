//----------------------------------------------------------------------------
//-- Memoria ROM genérica
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Memoria con los siguientes parametros:
//--  * AW: Numero de bits de las direcciones
//--  * DW: Numero de bits de los datos
//--  * ROMFILE: Fichero a usar para cargar la memoria
//--
//-- Con este componente podemos hacer memorias rom de cualquier tamaño
//----------------------------------------------------------------------------

module genrom #(             //-- Parametros
         parameter AW = 5,   //-- Bits de las direcciones (Adress width)
         parameter DW = 8)   //-- Bits de los datos (Data witdh)

       (                              //-- Puertos
         input clk,                   //-- Señal de reloj global
         input wire [AW-1: 0] addr,   //-- Direcciones
         output reg [DW-1: 0] data);  //-- Dato de salida

//-- Parametro: Nombre del fichero con el contenido de la ROM
parameter ROMFILE = "prog.list";

//-- Calcular el numero de posiciones totales de memoria
localparam NPOS = 2 ** AW;

  //-- Memoria
  reg [DW-1: 0] rom [0: NPOS-1];

  //-- Lectura de la memoria
  always @(posedge clk) begin
    data <= rom[addr];
  end

//-- Cargar en la memoria el fichero ROMFILE
//-- Los valores deben estan dados en hexadecimal
initial begin
  $readmemh(ROMFILE, rom);
end


endmodule

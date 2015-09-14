//----------------------------------------------------------------------------
//-- Prueba de tranmision 3. Transmision periódica del caracter K, cada
//-- 250ms
//----------------------------------------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Although this transmitter has been written from the scratch, it has been
//-- inspired by the one developed in the swapforth proyect by James Bowman
//--
//-- https://github.com/jamesbowman/swapforth
//--
//----------------------------------------------------------------------------
`default_nettype none

`include "baudgen.vh"
`include "divider.vh"

//--- Modulo que envia un caracter cunado load esta a 1
module baudtx3(input wire clk,       //-- Reloj del sistema (12MHz en ICEstick)
               output wire tx        //-- Salida de datos serie (hacia el PC)
              );

//-- Parametro: velocidad de transmision
parameter BAUD =  `B115200;
parameter DELAY = `T_250ms;

//-- Registro de 10 bits para almacenar la trama a enviar:
//-- 1 bit start + 8 bits datos + 1 bit stop
reg [9:0] shifter;

//-- Reloj para la transmision
wire clk_baud;

//-- Señal de carga periodica
wire load;

//-- Señal de load sincronizada con clk_baud
reg load2;

//-- Registro de desplazamiento, con carga paralela
//-- Cuando DTR es 0, se carga la trama
//-- Cuando DTR es 1 se desplaza hacia la derecha, y se 
//-- introducen '1's por la izquierda
always @(posedge clk_baud)
  if (load2 == 0)
    shifter <= {"K",2'b01};
  else
    shifter <= {1'b1, shifter[9:1]};

//-- Sacar por tx el bit menos significativo del registros de desplazamiento
//-- Cuando estamos en modo carga (dtr == 0), se saca siempre un 1 para 
//-- que la linea este siempre a un estado de reposo. De esta forma en el 
//-- inicio tx esta en reposo, aunque el valor del registro de desplazamiento
//-- sea desconocido
assign tx = (load2) ? shifter[0] : 1;

//-- Sincronizar la señal load con clk_baud
//-- Si no se hace, 1 de cada X caracteres enviados tendrá algún bit
//-- corrupto (en las pruebas con la icEstick salian mal 1 de cada 13 aprox
always @(posedge clk_baud)
  load2 <= load;


//-- Divisor para obtener el reloj de transmision
divider #(BAUD)
  BAUD0 (
    .clk_in(clk),
    .clk_out(clk_baud)
  );


//-- Divisor para generar la señal de carga periodicamente
divider #(DELAY)
  DIV0 (
    .clk_in(clk),
    .clk_out(load)
  );

endmodule




  

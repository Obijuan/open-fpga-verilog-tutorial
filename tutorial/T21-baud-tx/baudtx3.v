//----------------------------------------------------------------------------
//-- Prueba del transmisor de la uart: Se invia un caracter fijo cada 250ms
//----------------------------------------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Although this UART has been written from the scratch, it has been
//-- inspired by the one developed in the swapforth proyect by James Bowman
//--
//-- https://github.com/jamesbowman/swapforth
//--
//-- 
//----------------------------------------------------------------------------
`default_nettype none

`include "baudgen.vh"
`include "divider.vh"

//--- Modulo que envia un caracter fijo repetidamente
module baudtx2(input wire clk,          //-- Reloj del sistema (12MHz en ICEstick)
               input wire dtr,
               output wire tx          //-- Salida de datos serie (hacia el PC)
             );

parameter BAUD =  `B115200; //`B115200; //`B9600; //`B19200;
parameter DELAY = `T_250ms;

//------ Cables
reg rstn = 0;
wire clk_car;
reg [9:0] shifter;
wire loadn;
wire clk_baud;


//-- Registro de desplazamiento
always @(posedge clk_baud)
  if (dtr == 0)
    shifter <= {"K",2'b01};
  else
    shifter <= {1'b1, shifter[9:1]};

//-- Sacar por tx el bit menos significativo del registros de desplazamiento
assign tx = (dtr) ? shifter[0] : 1;

//assign tx = shifter[0];

divider #(BAUD)
  BAUD0 (
    .clk_in(clk),
    .clk_out(clk_baud)
  );



/*
divider #(DELAY)
  DIV0 (
    .clk_in(clk),
    .clk_out(loadn)
  );
*/


//-- Inicializador
/*
always @(posedge clk_baud)
  loadn <=1;
*/
endmodule




  

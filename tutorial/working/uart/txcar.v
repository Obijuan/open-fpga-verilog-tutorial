//----------------------------------------------------------------------------
//-- Pruebas para la uart: Se hace eco de todo lo recibido por el puerto serie
//-- La unidad de Recepcion recibe el dato y se lo pasa a la unidad de 
//-- transmision para enviarlo de vuelta al pc
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
`include "baudgen.vh"
`include "divider.vh"

//--- Modulo que hace eco
module txcar(input wire clk,           //-- Reloj del sistema (12MHz en ICEstick)
             output wire tx,          //-- Salida de datos serie (hacia el PC)
             output wire act);        //-- Actividad (conectar a un led)

//-- BUG: a velocidades menores de 38400 no funciona bien
parameter BAUD = `B115200;
parameter DELAY = `T_1s;

//------ Cables
reg rstn = 0;       //-- Reset. Inicializacion de la UART
wire clk_rs;


//-- INSTANCIAR LA UNIDAD DE TRANSMISION

uart_tx #(.BAUD(BAUD))
  UART_TX (
    .clk(clk),
    .rstn(rstn),
    .data("B"),
    .ws(clk_rs),
    .tx(tx)
  );

//-- Sacar actividad por led verde
assign act = clk_rs;

divider #(DELAY)
  DIV0 (
    .clk_in(clk),
    .clk_out(clk_rs)
  );


//-- Inicializador
always @(posedge(clk))
  rstn <= 1;

endmodule




  

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
`include "baudgen.vh"
`include "divider.vh"

//--- Modulo que envia un caracter fijo repetidamente
module txcar(input wire clk,          //-- Reloj del sistema (12MHz en ICEstick)
             output wire tx,          //-- Salida de datos serie (hacia el PC)
             output wire act);        //-- Actividad (conectar a un led)

parameter BAUD = `B115200;
parameter DELAY = `T_250ms;

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




  

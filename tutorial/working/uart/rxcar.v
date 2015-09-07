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

//--- Modulo que hace eco
module rxcar(input wire clk,           //-- Reloj del sistema (12MHz en ICEstick)
             input wire  rx,          //-- Entrada de datos serie (desde el PC)
             output wire [3:0] leds,  //-- 4 bits de menos peso del dato recibido
             output wire act);        //-- Actividad (conectar a un led)

//-- BUG: a velocidades de 1200 baudios no funciona
parameter BAUD = `B1200; //`B115200;

//------ Cables
reg rstn = 0;       //-- Reset. Inicializacion de la UART
wire [7:0] data;    //-- Dato recibido y enviado de vuelta
wire rs;            //-- Read Strobe. Flanco para capturar datos recibidos
wire tx;

reg [7:0] regdata;

//--- INSTANCIAR LA UNIDAD DE RECEPCION

uart_rx #(.BAUD(BAUD)) 
  UART_RX (
    .clk(clk), 
    .rstn(rstn),
    .rx(rx),
    .data(data),  //-- Datos recibidos, cableados a la entrada de datos del transmisor
    .rs(rs)
  );

//-- Registrar los datos recibidos
always @(posedge clk)
  if (rs)
    regdata <= data;


//-- Sacar byte de menor peso del dato recibido por los leds
assign leds = regdata[3:0];

//-- Sacar actividad por led verde
assign act = rs;


//-- Inicializador
always @(posedge(clk))
  rstn <= 1;

endmodule




  

//----------------------------------------------------------------------------
//-- Ejemplo de uso del receptor serie
//-- Los caracteres recibidos se almacenan en un registro y los 4 bits menos
//-- significativos se sacan por los leds rojos de la ICEstick 
//----------------------------------------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Comprobado su funcionamiento a todas las velocidades estandares:
//-- 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200
//----------------------------------------------------------------------------

`default_nettype none

`include "baudgen.vh"

//-- Top design
module rxleds(input wire clk,         //-- Reloj del sistema
              input wire rx,          //-- Linea de recepcion serie
              output reg [3:0] leds,  //-- 4 leds rojos
              output wire act);       //-- Led de actividad (verde)

//-- Parametro: Velocidad de transmision
localparam BAUD = `B115200;

//-- Señal de dato recibido
wire rcv;

//-- Datos recibidos
wire [7:0] data;

//-- Señal de reset
reg rstn = 0;

//-- Inicializador
always @(posedge clk)
  rstn <= 1;

//-- Instanciar la unidad de recepcion
uart_rx #(BAUD)
  RX0 (.clk(clk),      //-- Reloj del sistema
       .rstn(rstn),    //-- Señal de reset
       .rx(rx),        //-- Linea de recepción de datos serie
       .rcv(rcv),      //-- Señal de dato recibido
       .data(data)     //-- Datos recibidos
      );

//-- Sacar los 4 bits menos significativos del dato recibido por los leds
//-- El dato se registra
always @(posedge clk)
    //-- Capturar el dato cuando se reciba
    if (rcv == 1'b1)
      leds <= data[3:0]; 

//-- Led de actividad
//-- La linea de recepcion negada se saca por el led verde
assign act = ~rx;

endmodule




//----------------------------------------------------------------------------
//-- Ejemplo de uso del receptor serie
//-- Se hace eco de todos los caracteres recibidos. Ademas los 4 bits menos
//-- significativos se sacan por los leds de la IceStick
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
module echo(input wire clk,         //-- Reloj del sistema
            input wire rx,          //-- Linea de recepcion serie
            output wire tx          //-- Linea de transmision serie
            );

//-- Parametro: Velocidad de transmision
localparam BAUD = `B115200;

//-- Señal de dato recibido
wire rcv;

//-- Datos recibidos
wire [7:0] data;

//-- Señal de reset
reg rstn = 0;

//-- Señal de transmisor listo
wire ready;

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

//-- Instanciar la unidad de transmision
uart_tx #(BAUD)
  TX0 ( .clk(clk),        //-- Reloj del sistema
         .rstn(rstn),     //-- Reset global (activo nivel bajo)
         .start(rcv),     //-- Comienzo de transmision
         .data(data),     //-- Dato a transmitir
         .tx(tx),         //-- Salida de datos serie (hacia el PC)
         .ready(ready)    //-- Transmisor listo / ocupado
       );


endmodule




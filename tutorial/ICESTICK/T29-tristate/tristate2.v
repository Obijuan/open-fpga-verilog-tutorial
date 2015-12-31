//----------------------------------------------------------------------------
//-- Ejemplo 2 de puertas tri-estado
//-- Hay 3 biestables con sus salidas conectas a un bus de 1 bit
//-- Este bus se saca por un led, para conocer su estado
//-- Con un registro de desplazamiento se selecciona que registro
//-- se conecta al bus a traves de su puerta triestado correspondiente
//-- Se hace de forma que cada vez se secciona una
//----------------------------------------------------------------------------
//--  (C) BQ. November 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

`include "divider.vh"


module tristate2  (
         input wire clk,      //-- Entrada de reloj
         output wire led0);   //-- Led a controlar

//-- Parametro: periodo de parpadeo
parameter DELAY = `T_1s;

//-- Cable con la señal de tiempo
wire clk_delay;

//-- Bus de 1 bit
wire bus;

//-- Señal de reset
reg rstn = 0;

//-- Registro de desplazamiento
reg [3:0] sreg;

//-- Definir los 3 bistables a conectar al bus, cada uno con un
//-- valor inicial cualquiera
reg reg0;
always @(posedge clk)
  reg0 <= 1'b1;

reg reg1;
always @(posedge clk)
  reg1 <= 1'b0;

reg reg2;
always @(posedge clk)
  reg2 <= 1'b1;

//-- Conectar los biestables al bus, a traves de puertas triestado
assign bus = (sreg[0]) ? reg0 : 1'bz;
assign bus = (sreg[1]) ? reg1 : 1'bz;
assign bus = (sreg[2]) ? reg2 : 1'bz;

//-- Conectar el bus al led
assign led0 = bus;

//-- Registros de desplazamiento
always @(posedge clk)
  if (!rstn)
    sreg <= 4'b0001;
  else if (clk_delay)
    sreg <= {sreg[2:0],sreg[3]};

//-- Inicializador
always @(posedge clk)
  rstn <= 1'b1;

//-- Divisor para temporizacion
dividerp1 #(DELAY)
  CH0 (
    .clk(clk),
    .clk_out(clk_delay)
  );

endmodule

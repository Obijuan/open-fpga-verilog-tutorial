//----------------------------------------------------------------------------
//-- Limitaciones en la sintesis de puertas triestado
//-- Error 2: Conexion de dos registro de 1 bit a un cable de 2 bits
//-- a traves de dos puertas triestado. Controlados con la misma
//-- señal de enable
//----------------------------------------------------------------------------
//--  (C) BQ. November 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------

/*
 El error obtenido al sintetizar es:

arachne-pnr -d 1k -p error2.pcf error2.blif -o error2.txt
seed: 1
device: 1k
read_chipdb +/share/arachne-pnr/chipdb-1k.bin...
  supported packages: tq144, vq100
read_blif error2.blif...
prune...
read_pcf error2.pcf...
instantiate_io...
fatal error: $_TBUF_ gate must drive top-level output or inout port
Makefile:208: recipe for target 'error2.bin' failed
make: *** [error2.bin] Error 1
*/


`default_nettype none


module error2  (
         input wire clk,            //-- Entrada de reloj
         output wire [1:0] leds);   //-- Leds a controlar

//-- Senal de habilitacion para las puertas
wire ena = 1'b1;

//-- Registro de 1 bit
reg reg0;
always @(posedge clk)
  reg0 <= 1'b1;

//-- Registro de 1 bit
reg reg1;
always @(posedge clk)
  reg1 <= 1'b1;

//-- Conectar los registros al cable de 2 bits
//-- Se controlan con la misma señal de habilitacion
assign leds[0] = (ena) ? reg0 : 1'bz;
assign leds[1] = (ena) ? reg1 : 1'bz;


endmodule

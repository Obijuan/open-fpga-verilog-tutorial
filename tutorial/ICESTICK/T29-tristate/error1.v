//----------------------------------------------------------------------------
//-- Limitaciones en la sintesis de puertas triestado
//-- Error 1: Conexion de un registro de 2 bits a traves de una
//--   puerta triestado
//----------------------------------------------------------------------------
//--  (C) BQ. November 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------

/*
 Al sintetizarlo con make sint3, se obtiene un error:
 ...
2.12.2. Executing Verilog-2005 frontend.
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/arith_map.v' to AST representation.
Generating RTLIL representation for module `\_80_ice40_alu'.
Successfully finished Verilog frontend.
Mapping error1.$ternary$error1.v:29$2 ($tribuf) with simplemap.
terminate called after throwing an instance of 'std::out_of_range'
  what():  vector::_M_range_check: __n (which is 1) >= this->size() (which is 1)
Aborted (core dumped)
Makefile:143: recipe for target 'error1.bin' failed
make: *** [error1.bin] Error 134
*/

`default_nettype none


module error1  (
         input wire clk,            //-- Entrada de reloj
         output wire [1:0] leds);   //-- Leds a controlar

wire ena = 1'b1;

//-- Registro de 2 bits
reg [1:0] reg1;

//-- Cargar el registro con valor inicial
always @(posedge clk)
  reg1 <= 2'b11;

//-- Conectar el registro a 2 leds
assign leds = (ena) ? reg1 : 2'bzz;


endmodule

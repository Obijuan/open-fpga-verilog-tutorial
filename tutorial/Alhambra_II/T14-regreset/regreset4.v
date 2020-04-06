//-----------------------------------------------------------------------------
//-- Secuenciador de 2 estados a partir de dos registros de 4 bits con
//-- inicialización de carga
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-- Modified by Iñigo Muguruza Goenaga
//-----------------------------------------------------------------------------
//-- License GPL
//-----------------------------------------------------------------------------

module regreset4(input wire clk, output wire [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 23;        //-- Bits del prescaler
parameter INI0 = 4'b1001; //-- Valor inicial para el registro 0
parameter INI1 = 4'b0110; //-- Valor inicial para el registro 1
parameter INI2 = 4'b0101; //-- Valor inicial para el registro 0
parameter INI3 = 4'b0000; //-- Valor inicial para el registro 1

//-- Reloj a la salida del presacaler
wire clk_pres;

//-- Salida de los regitros
wire [3:0] dout0;
wire [3:0] dout1;
wire [3:0] dout2;
wire [3:0] dout3;

//-- Señal de inicializacion del reset
reg rst = 0;

//-- Inicializador
always @(posedge(clk_pres))
  rst <= 1;

//-- Registro 0
register #(.INI(INI0))
  REG0 (
    .clk(clk_pres),
    .rst(rst),
    .din(dout3),
    .dout(dout0)
  );

//-- Registro 1
register #(.INI(INI1))
  REG1 (
    .clk(clk_pres),
    .rst(rst),
    .din(dout0),
    .dout(dout1)
  );

//-- Registro 1
register #(.INI(INI2))
  REG2 (
    .clk(clk_pres),
    .rst(rst),
    .din(dout1),
    .dout(dout2)
  );

  //-- Registro 1
register #(.INI(INI3))
  REG3 (
    .clk(clk_pres),
    .rst(rst),
    .din(dout2),
    .dout(dout3)
  );

//-- Sacar la salida del registro 0 por la del componente
assign data = dout3;

//-- Prescaler
prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(clk_pres)
  );

endmodule

//-----------------------------------------------------------------------------
//-- Secuenciador de 2 estados a partir de registro de 4 bits con
//-- inicialización de carga
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- License GPL
//-----------------------------------------------------------------------------

module regreset(input wire clk, output wire [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 23;        //-- Bits del prescaler
parameter INI = 4'b1100;  //-- Valor inicial a cargar en registro

//-- Reloj a la salida del presacaler
wire clk_pres;

//-- Salida del regitro
wire [3:0] dout;

//-- Señal de inicializacion del reset
reg rst = 0;

//-- Inicializador
always @(posedge(clk_pres))
  rst <= 1;

//-- Registro
register #(.INI(4'b1001))
  REG0 (
    .clk(clk_pres),
    .rst(rst),
    .din(~dout),
    .dout(dout)
  );

//-- Conectar el registro con la salida
assign data = dout;

//-- Prescaler
prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(clk_pres)
  );

endmodule



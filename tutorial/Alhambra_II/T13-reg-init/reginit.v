//-----------------------------------------------------------------------------
//-- Secuenciador de 2 estados a partir de registro de 4 bits con
//-- inicialización de carga
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- License GPL
//-----------------------------------------------------------------------------

module reginit(input wire clk, output wire [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 23;        //-- Bits del prescaler
parameter INI = 4'b1100;  //-- Valor inicial a cargar en registro

//-- Reloj a la salida del presacaler
wire clk_pres;

//-- Salida del regitro
reg [3:0] dout;

//-- Entrada del registro
wire [3:0] din;

//-- Señal de seleccion del multiplexor
reg sel = 0;

//-- Registro
always @(posedge(clk_pres))
  dout <= din;

//-- Conectar el registro con la salida
assign data = dout;

//-- Multiplexor de inicializacion
assign din = (sel == 0) ? INI : ~dout;
  
//-- Inicializador
always @(posedge(clk_pres))
  sel <= 1;

//-- Prescaler
prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(clk_pres)
  );

endmodule



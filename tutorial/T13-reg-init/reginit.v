//-----------------------------------------------------------------------------
//-- 
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- License GPL
//-----------------------------------------------------------------------------

module reginit(input wire clk, output wire [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 23;        //-- Bits del prescaler
parameter INI = 4'b1100;  //-- Valor inicial

//-- Reloj a la salida del presacaler
wire clk_pres;
reg [3:0] dout;
wire [3:0] din;
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



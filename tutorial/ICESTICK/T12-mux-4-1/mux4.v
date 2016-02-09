//-----------------------------------------------------------------------------
//-- Secuenciador de 4 estados usando un multiplexor de 4 a 1
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- License GPL
//-----------------------------------------------------------------------------

//-- Entrada: reloj
//-- Salida: datos a conectar en los leds
module mux4(input wire clk, output reg [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 23;         //-- Bits del prescaler
parameter VAL0 = 4'b0000;  //-- Valor secuencia 0
parameter VAL1 = 4'b1010;  //-- Valor secuencia 1
parameter VAL2 = 4'b1111;  //-- Valor secuencia 2
parameter VAL3 = 4'b0101;  //-- Valor secuencia 3

//-- Cables para las 5 entradas del multiplexor
wire [3:0] val0;
wire [3:0] val1;
wire [3:0] val2;
wire [3:0] val3;
wire [1:0] sel;  //-- Dos bits de selección

//-- Contador de 2 bits
reg [1:0] count = 0;
wire clk_pres; //-- Reloj una vez pasado por prescaler

//-- Por las entradas del mux cableamos los datos de entrada
assign val0 = VAL0;
assign val1 = VAL1;
assign val2 = VAL2;
assign val3 = VAL3;

//-- Implementación del multiplexor de 4 a 1
always@*
  case (sel)
     0 : data <= val0;
     1 : data <= val1;
     2 : data <= val2;
     3 : data <= val3;
     default : data <= 0;
  endcase

//-- Contador de 2 bits para realizar la seleccion de la fuente de datos
always @(posedge(clk_pres))
  count <= count + 1;

//-- El contador esta conectado a la entrada sel del mux
assign sel = count;

//-- Presaler que controla el incremento del contador para la selección
prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(clk_pres)
  );

endmodule



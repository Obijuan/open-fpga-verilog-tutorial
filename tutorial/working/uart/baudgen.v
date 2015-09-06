//-----------------------------------------------------------------------------
//-- Divisor de frecuencia para generar los baudios para transmisiones
//-- serie asincronas (UART)
//-- (c) BQ. September 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------
`include "baudgen.vh"

//-- ENTRADAS:
//--     -clk_in: Senal de reloj del sistema (12 MHZ en la iceStick)
//--     -restart: Si esta a 1, el reloj de salida no varia. En 0 oscila
//
//-- SALIDAS:
//--     - clk_out. Señal de salida para lograr la velocidad en baudios indicada
module baudgen(input wire clk_in,
               input wire restart, 
               output wire clk_out);

//-- Valor por defecto de la velocidad en baudios
parameter M = `B115200;

//-- Numero de bits para almacenar el divisor de baudios
localparam N = $clog2(M);

//-- Registro para implementar el contador modulo M
reg [N-1:0] divcounter = 0;

//-- Contador módulo M
always @(posedge clk_in)

  if (restart == 1)
    //-- Contador "congelado" a 0
    divcounter <= 0;
  else
    //-- Funcionamiento normal
    divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;

//-- Sacar un pulso de anchura 1 ciclo de reloj
assign clk_out = (divcounter == 0) ? 1 : 0;

endmodule


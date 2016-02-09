//-----------------------------------------------------------------------------
//-- Generacion de baudios
//-- Señal cuadrada, de periodo igual a la frecuencia de los baudios indicados
//-- El ancho del pulso positivo es de 1 ciclo de reloj
//--
//-- Una vez habilitado, el pulso se genera justo en la mitad del periodo
//-- Esto es necesario para implementar el receptor
//--
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------
`include "baudgen.vh"

//-- ENTRADAS:
//--     -clk: Senal de reloj del sistema (12 MHZ en la iceStick)
//--     -clk_ena: Habilitacion. 
//--            1. funcionamiento normal. Emitiendo pulsos
//--            0: Inicializado y parado. No se emiten pulsos
//
//-- SALIDAS:
//--     - clk_out. Señal de salida para lograr la velocidad en baudios indicada
//--                Anchura de 1 periodo de clk. SALIDA NO REGISTRADA
module baudgen_rx(input wire clk,
               input wire clk_ena, 
               output wire clk_out);

//-- Valor por defecto de la velocidad en baudios
parameter M = `B115200;

//-- Numero de bits para almacenar el divisor de baudios
localparam N = $clog2(M);

//-- Valor para generar pulso en la mitad del periodo
localparam M2 = (M >> 1);

//-- Registro para implementar el contador modulo M
reg [N-1:0] divcounter = 0;

//-- Contador módulo M
always @(posedge clk)

  if (clk_ena)
    //-- Funcionamiento normal
    divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;
  else
    //-- Contador "congelado" al valor maximo
    divcounter <= M - 1;

//-- Sacar un pulso de anchura 1 ciclo de reloj si el generador
//-- esta habilitado (clk_ena == 1)
//-- en caso contrario se saca 0
//-- Se pone a uno en la mitad del periodo
assign clk_out = (divcounter == M2) ? clk_ena : 0;


endmodule





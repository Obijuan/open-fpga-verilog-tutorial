//-------------------------------------------------------------------
//-- Ejemplo de uso de un registro de desplazamiento de 4 bits
//-- para generar una secuencia de rotacion de bits
//-------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-- GPL license
//-------------------------------------------------------------------
module shift4(input wire clk, output reg [3:0] data);

//-- Parametros del secuenciador
parameter NP = 21;  //-- Bits del prescaler
parameter INI = 1;  //-- Valor inicial a cargar en el registro

//-- Reloj de salida del prescaler
wire clk_pres;

//-- Shift / load. Señal que indica si el registro
//-- se carga o desplaza
//-- shift = 0: carga
//-- shift = 1: desplaza
reg load_shift = 0;

//-- Entrada serie del registro
wire serin;

//-- Instanciar el prescaler de N bits
prescaler #(.N(NP))
  pres1 (
    .clk_in(clk),
    .clk_out(clk_pres)
  );

//-- Inicializador
always @(posedge(clk_pres)) begin
    load_shift <= 1;
end

//-- Registro de desplazamiento
always @(posedge(clk_pres)) begin
  if (load_shift == 0)  //-- Load mode
    data <= INI;
  else
    data <= {data[2:0], serin};
end

//-- Salida de mayor peso se re-introduce por la entrada serie
assign serin = data[3];

endmodule


//----------------------------------------------------------------------------
//-- Unidad de transmision serie asincrona
//------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Comprobado su funcionamiento a todas las velocidades estandares:
//-- 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200
//----------------------------------------------------------------------------
//-- Although this transmitter has been written from the scratch, it has been
//-- inspired by the one developed in the swapforth proyect by James Bowman
//--
//-- https://github.com/jamesbowman/swapforth
//--
//----------------------------------------------------------------------------
`default_nettype none

`include "baudgen.vh"

//--- Modulo de transmision serie
//--- La salida tx ESTA REGISTRADA
module uart_tx (
         input wire clk,        //-- Reloj del sistema (12MHz en ICEstick)
         input wire rstn,       //-- Reset global (activo nivel bajo)
         input wire start,      //-- Activar a 1 para transmitir
         input wire [7:0] data, //-- Byte a transmitir
         output reg tx,         //-- Salida de datos serie (hacia el PC)
         output reg ready      //-- Transmisor listo / ocupado
       );

//-- Parametro: velocidad de transmision
parameter BAUD =  `B115200;

//-- Reloj para la transmision
wire clk_baud;

//-- Bitcounter
reg [3:0] bitc;

//-- Datos registrados
reg [7:0] data_r;

//--------- Microordenes
reg load;    //-- Carga del registro de desplazamiento. Puesta a 0 del
              //-- contador de bits
reg baud_en; //-- Habilitar el generador de baudios para la transmision

//-------------------------------------
//-- RUTA DE DATOS
//-------------------------------------

always @(posedge clk)
  if (start == 1 && state == IDLE)
    data_r <= data;

//-- Registro de 10 bits para almacenar la trama a enviar:
//-- 1 bit start + 8 bits datos + 1 bit stop
reg [9:0] shifter;

//-- Cuando la microorden load es 1 se carga la trama
//-- con load 0 se desplaza a la derecha y se envia un bit, al
//-- activarse la señal de clk_baud que marca el tiempo de bit
//-- Se introducen 1s por la izquierda
always @(posedge clk)
  //-- Reset
  if (rstn == 0)
    shifter <= 10'b11_1111_1111;

  //-- Modo carga
  else if (load == 1)
    shifter <= {data_r,2'b01};

  //-- Modo desplazamiento
  else if (load == 0 && clk_baud == 1)
    shifter <= {1'b1, shifter[9:1]};

//-- Contador de bits enviados
//-- Con la microorden load (=1) se hace un reset del contador
//-- con load = 0 se realiza la cuenta de los bits, al activarse
//-- clk_baud, que indica el tiempo de bit
always @(posedge clk)
  if (load == 1)
    bitc <= 0;
  else if (load == 0 && clk_baud == 1)
    bitc <= bitc + 1;

//-- Sacar por tx el bit menos significativo del registros de desplazamiento
//-- ES UNA SALIDA REGISTRADA, puesto que tx se conecta a un bus sincrono
//-- y hay que evitar que salgan pulsos espureos (glitches)
always @(posedge clk)
  tx <= shifter[0];

//-- Divisor para obtener el reloj de transmision
baudgen #(BAUD)
  BAUD0 (
    .clk(clk),
    .clk_ena(baud_en),
    .clk_out(clk_baud)
  );

//------------------------------
//-- CONTROLADOR
//------------------------------

//-- Estados del automata finito del controlador
localparam IDLE  = 0;  //-- Estado de reposo
localparam START = 1;  //-- Comienzo de transmision
localparam TRANS = 2;  //-- Estado: transmitiendo dato

//-- Estados del autómata del controlador
reg [1:0] state;
reg [1:0] next_state;

//-- Actualizacion del estado
always @(posedge clk) begin
	if(rstn == 0)
		state <= IDLE;
	else
		state <= next_state;
end

//-- Obtencion de los siguientes estados y
//-- Generacion de las microordenes
always @(*) begin

  //-- Por defecto permanecer en el mismo estado
  next_state = state;

  //-- Señales por defecto
  ready = 0;
  baud_en = 0;
  load = 0;

  case (state)

    //-- Estado de reposo. 
    IDLE: begin

      //-- Indicar que receptor listo
      ready = 1;

      //-- Se sale cuando la señal de start se pone a 1
      if (start == 1) 
        next_state <= START;
      else 
        next_state <= IDLE;
    end

    //-- Estado de comienzo. Prepararse para empezar
    //-- a transmitir. Duracion: 1 ciclo de reloj
    START: begin

      //-- Cargar dato a transmitir
      load = 1;

      //-- Activar generador de baudios
      baud_en = 1;

      //-- Pasar al siguiente estado
      next_state <= TRANS;
    end

    //-- Transmitiendo. Se esta en este estado hasta
    //-- que se hayan transmitido todos los bits pendientes
    TRANS: begin

      //-- Esperar a que todos los bits se envien
      if (bitc == 11)
        next_state <= IDLE;
      else
        next_state <= TRANS;
      
      //-- Generador de baudios activado
      baud_en = 1;
    end
  endcase

end

 
/*
    //-- Transiciones a los siguientes estados
    case (state)

      //-- Estado de reposo. Se sale cuando la señal
      //-- de start se pone a 1
      IDLE: 
        if (start == 1) 
          state <= START;
        else 
          state <= IDLE;

      //-- Estado de comienzo. Prepararse para empezar
      //-- a transmitir. Duracion: 1 ciclo de reloj
      START:
        state <= TRANS;

      //-- Transmitiendo. Se esta en este estado hasta
      //-- que se hayan transmitido todos los bits pendientes
      TRANS:
        if (bitc == 11)
          state <= IDLE;
        else
          state <= TRANS;

      //-- Por defecto. NO USADO. Puesto para
      //-- cubrir todos los casos y que no se generen latches
      default:
        state <= IDLE;

    endcase

//-- Generacion de las microordenes
assign load = (state == START) ? 1 : 0;
assign baud_en = (state == IDLE) ? 0 : 1;

//-- Señal de salida. Esta a 1 cuando estamos en reposo (listos
//-- para transmitir). En caso contrario esta a 0
assign ready = (state == IDLE) ? 1 : 0;

*/

endmodule




  

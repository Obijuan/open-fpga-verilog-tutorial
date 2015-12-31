//----------------------------------------------------------------------------
//-- Prueba de tranmision 1. Se transmiten ráfagas del caracter "A" cuando 
//-- la señal de dtr se activa
//------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//--
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

//--- Modulo que envia un caracter cuando load esta a 1
//--- La salida tx ESTA REGISTRADA
module fsmtx (input wire clk,       //-- Reloj del sistema (12MHz en ICEstick)
              input wire start,     //-- Activar a 1 para transmitir
              output reg tx         //-- Salida de datos serie (hacia el PC)
             );

//-- Parametro: velocidad de transmision
//-- Pruebas del caso peor: a 300 baudios
parameter BAUD =  `B300;

//-- Caracter a enviar
parameter CAR = "A";

//-- Registro de 10 bits para almacenar la trama a enviar:
//-- 1 bit start + 8 bits datos + 1 bit stop
reg [9:0] shifter;

//-- Señal de start registrada
reg start_r; 

//-- Reloj para la transmision
wire clk_baud;

//-- Reset
reg rstn = 0;

//-- Bitcounter
reg [3:0] bitc;

//--------- Microordenes
wire load;    //-- Carga del registro de desplazamiento. Puesta a 0 del
              //-- contador de bits
wire baud_en; //-- Habilitar el generador de baudios para la transmision

//-------------------------------------
//-- RUTA DE DATOS
//-------------------------------------

//-- Registrar la entrada start
//-- (para cumplir con las reglas de diseño sincrono)
always @(posedge clk)
  start_r <= start;

//-- Registro de desplazamiento, con carga paralela
//-- Cuando load_r es 0, se carga la trama
//-- Cuando load_r es 1 y el reloj de baudios esta a 1 se desplaza hacia
//-- la derecha, enviando el siguiente bit 
//-- Se introducen '1's por la izquierda
always @(posedge clk)
  //-- Reset
  if (rstn == 0)
    shifter <= 10'b11_1111_1111;

  //-- Modo carga
  else if (load == 1)
    shifter <= {CAR,2'b01};

  //-- Modo desplazamiento
  else if (load == 0 && clk_baud == 1)
    shifter <= {1'b1, shifter[9:1]};

always @(posedge clk)
  if (load == 1)
    bitc <= 0;
  else if (load == 0 && clk_baud == 1)
    bitc <= bitc + 1;

//-- Sacar por tx el bit menos significativo del registros de desplazamiento
//-- Cuando estamos en modo carga (load_r == 0), se saca siempre un 1 para 
//-- que la linea este siempre a un estado de reposo. De esta forma en el 
//-- inicio tx esta en reposo, aunque el valor del registro de desplazamiento
//-- sea desconocido
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
localparam IDLE = 0;
localparam START = 1;
localparam TRANS = 2;

//-- Estados del autómata del controlador
reg [1:0] state;

//-- Transiciones entre los estados
always @(posedge clk)

  //-- Reset del automata. Al estado inicial
  if (rstn == 0)
    state <= IDLE;

  else
    //-- Transiciones a los siguientes estados
    case (state)

      //-- Estado de reposo. Se sale cuando la señal
      //-- de start se pone a 1
      IDLE: 
        if (start_r == 1) 
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


//-- Inicializador
always @(posedge clk)
  rstn <= 1;


endmodule




  

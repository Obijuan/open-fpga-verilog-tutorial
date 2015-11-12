
//-----------------------------------------------------------------------------
//-- Microbio.  Mini procesador hola-mundo
//-----------------------------------------------------------------------------
//-- (C) BQ November 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//----- DOCUMENTACION
//-- Formato instrucciones (8 bits)
//--   CO (2 bits)    DAT (6 bits)
//--
//-- Memoria de 64 posiciones (direcciones de 6 bits)
//-- Anchura de los datos: 8 bits
//--
//-- Codigos de operacion
//-- 00 --> NOP    (consume ciclos sin hacer nada)
//-- 01 --> HALT   (Parar. Enciende led verde)
//-- 10 --> LEDS   (Establecer valor en los leds)
//-- 11 --> JP     (Saltar a la direccion indicada)

`default_nettype none
`include "divider.vh"


module microbio (input wire clk,          //-- Reloj del sistema
                 input wire rstn_ini,     //-- Reset
                 output wire [3:0] leds,  //-- leds
                 output wire stop);       //-- Indicador de stop

//-- Parametro: Periodo de funcionamiento de la CPU
parameter CPU_PERIOD = `T_1s;

//-- Parametro: fichero con el programa a cargar en la rom
parameter ROMFILE = "prog1.list";

//-- Tamaño de la memoria ROM a instanciar
localparam AW = 6;     //-- Anchura del bus de direcciones
localparam DW = 8;     //-- Anchura del bus de datos

//-- Codigo de operacion
localparam NOP = 2'b00;
localparam HALT = 2'b01;
localparam LEDS = 2'b10;
localparam JP = 2'b11;

//-- Instanciar la memoria ROM
wire [DW-1: 0] data;
wire [AW-1: 0] addr;
genrom
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(DW))
  ROM (
        .clk(clk),
        .addr(addr),
        .data(data)
      );

//-- Registrar la señal de reset
reg rstn = 0;

always @(posedge clk)
  rstn <= rstn_ini;

//-- Declaracion de las microordenes
reg cp_inc = 0;  //-- Incrementar contador de programa
reg cp_load = 0; //-- Cargar el contador de programa
reg ri_load = 0; //-- Cargar una instruccion en el registro de instruccion
reg halt = 0;    //-- Instruccion halt ejecutada
reg leds_load = 0;  //-- Mostrar un valor por los leds

//-- Contador de programa
reg [AW-1: 0] cp;

always @(posedge clk)
  if (!rstn)
    cp <= 0;
  else if (cp_load)
    cp <= DAT;
  else if (cp_inc)
    cp <= cp + 1;

assign addr = cp;

//-- Registro de instruccion
reg [DW-1: 0] ri;

//-- Descomponer la instruccion en los campos CO y DAT
wire [1:0] CO = ri[7:6];    //-- Codigo de operacion
wire [5:0] DAT = ri[5:0];   //-- Campo de datos

always @(posedge clk)
  if (!rstn)
    ri <= 0;
  else if (ri_load)
    ri <= data;

//-- Registro de stop
//-- Se pone a 1 cuando se ha ejecutado una instruccion de HALT
reg reg_stop;

always @(posedge clk)
  if (!rstn)
    reg_stop <= 0;
  else if (halt)
    reg_stop <= 1;

//-- Registro de leds
reg [3:0] leds_r;
always @(posedge clk)
  if (!rstn)
    leds_r <= 0;
  else if (leds_load)
    leds_r <= DAT[3:0];

assign leds = leds_r;

//-- Debug
//assign leds = CO;
//assign stop = reg_stop;
reg cont=0;
always @(posedge clk)
  if (clk_tic)
    cont <= cont + 1;

assign stop = cont;

//----------- UNIDAD DE CONTROL
localparam INIT = 0;
localparam FETCH = 1;
localparam EXEC = 2;

//-- Estado del automata
reg [1:0] state;
reg [1:0] next_state;

//-- Transiciones de estados
wire clk_tic;
always @(posedge clk)
  if (!rstn)
    state <= INIT;
  else
    state <= next_state;

//-- Generacion de microordenes
//-- y siguientes estados
always @(*) begin

  //-- Valores por defecto
  next_state = state;      //-- Por defecto permanecer en el mismo estado
  cp_inc = 0;
  cp_load = 0;
  ri_load = 0;
  halt = 0;
  leds_load = 0;


  case (state)
    INIT: begin
      next_state = FETCH;
    end
    FETCH: begin
      cp_inc = 1;  //-- Incrementar CP (en el siguiente estado)
      ri_load = 1; //-- Cargar la instruccion (en el siguiente estado)
      next_state = EXEC;
    end
    EXEC: begin
      next_state = FETCH;

      //-- Ejecutar la instruccion
      case (CO)
        HALT: begin
          halt = 1;
          next_state = EXEC;  //-- Permanecer en este estado indefinidamente
        end

        NOP: begin
          if (clk_tic) next_state = FETCH;
          else next_state = EXEC;
        end

        LEDS: begin
          leds_load = 1;
        end

        JP: begin
          cp_load = 1;
          next_state = INIT;
        end

      endcase

    end
  endcase

end

//-- Divisor para marcar la duracion de cada estado del automata
dividerp1 #(CPU_PERIOD)
  TIMER0 (
    .clk(clk),
    .clk_out(clk_tic)
  );


endmodule

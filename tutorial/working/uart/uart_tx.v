`include "baudgen.vh"

`default_nettype none


module uart_tx(
   input wire clk,         //-- Relog del sistema
   input wire rstn,        //-- Reset sincrono activo a nivel bajo
   input wire [7:0] data,  //-- Dato a transmitir
   input wire ws,          //-- Validacion del dato
   output reg tx           //-- Linea de transmision al exterior
);

parameter BAUD = `B115200;

//-- Registro de desplazamiento
//-- 9 bits:  8 de datos + el bit de start
reg [8:0] shifter = 0;

//-- Señal de load del registro de desplazamiento y 
//-- del contador de bits transmitidos
wire load;

//-- Señal de reloj para la transmision de datos
wire ser_clk;

//-- Almacenamiento del estado del transmisor
reg [1:0] state;

//-- Contador de bits transmitidos
reg [3:0] bitcount;

//-- Generador de reloj para transmitir datos a los baudios indicados
baudgen #(BAUD)
  DIV (
    .clk_in(clk),
    .clk_out(ser_clk),
    .restart(1'b0)
  );

//-- Registro de desplazamiento para hacer la transmision
//-- Reset sincrono activo a nivel bajo
//-- Load = 1: carga en paralelo de los datos. Se añadide bit de start
//-- Load = 0: Desplazamiento hacia la derecha
always @(posedge clk)
  //-- Reset sincrono. Cargar con valor inicial
  //-- Por defecto todo a 1, que implica linea de tx a reposo
  if (!rstn) begin
    shifter <= 9'b1_1111_1111;
    tx <= 1;
  end

  //-- Modo de carga paralelo. Se introduce dato de 8 bits
  //-- Se anade bit de start en posicion menos significativa
  //-- (para que al desplazar a la derecha salga el primero)
  else if (load == 1) begin
    shifter <= {data, 1'b0};
    tx <= 1;
  end

  //-- Modo desplazamiento (a la derecha)
  //-- Se añaden 1s por la izquierda, que se corresponden con el 
  //-- bit de stop (y linea en reposo)
  else if (load == 0 && ser_clk == 1) begin
    shifter <= {1'b1, shifter[8:1]};
    tx <= shifter[0];
  end

//-- Contador de bits
always @(posedge clk)
  if (!rstn)
    bitcount <= 0;

  else if (load == 1)
    bitcount <= 1 + 8 + 1;

  else if (load == 0 && ser_clk == 1)
    bitcount <= bitcount - 1;

//----------------------------
//-- Maquina de estados
//----------------------------

//-- Definicion de los estados del transmisor
localparam IDLE = 0;         //-- Reposo
localparam WAIT = 1;         //-- Esperar flanco bajada en wr
localparam LOAD = 2;         //-- Carga de registros y contadores
localparam TRANSMITING = 3;  //-- Transmitiendo datos


//-- Salidas del automata
assign load = (state == LOAD) ? 1 : 0;

//-- Transicion entre estados del automata
always @(posedge clk)

  //-- Reset: estado inicial
  if (!rstn)
    state <= IDLE;
    
  else

    //-- Segun el estado, analizar las entradas y 
    //-- cambiar al estado siguiente
    case (state)

      //-- Estado de reposo. Esperando a que se 
      //-- active la senal ws
      IDLE: 
        if (ws == 1)
          state <= WAIT;
        else
          state <= IDLE;

      //-- Estado de espera. Esperar a que la senal ws
      //-- se ponga a 0 (para que llegue un flanco de bajada)
      WAIT:
        if (ws == 0)
          state <= LOAD;
        else
          state <= WAIT;

      //-- Estado de carga. Se activa la senal de load para cargar
      //-- el registro de desplazamiento con el dato a transmitir
      //-- y se inicializa el contador de bits
      LOAD:
        state <= TRANSMITING;

      //-- Estado de transmision. Se estan enviando los datos en serie
      //-- Cuando el contador de bits llega a 0 se vuelve al estado de reposo
      TRANSMITING:
        if ( |bitcount == 0)
          state <= IDLE;
        else
          state <= TRANSMITING;

      //-- Para completar todos los casos y evitar ambiguedades
      default: 
        state <= IDLE;
    endcase


endmodule




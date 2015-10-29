//----------------------------------------------------------------------------
//-- Buffer de datos
//-- Se reciben datos por el puerto serie y se almacenan hasta llenar el buffer
//-- Una vez lleno, se vuelcan todos los datos, envianse de vuelta por el puerto
//-- serie
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

`include "baudgen.vh"

module buffer (input wire clk,
               input wire rx,
               output wire tx,
               output wire [3:0] leds,
               output reg debug);

//-- Velocidad de transmision
parameter BAUD = `B115200;

//-- Fichero con la rom
parameter ROMFILE = "bufferini.list";

//-- Numero de bits de la direccion de memoria
parameter AW = 4;

//-- Numero de bits de los datos almacenados en memoria
parameter DW = 8;

//-- Señal de reset
reg rstn = 0;

//-- Inicializador
always @(posedge clk)
  rstn <= 1;

//--------------------- Memoria RAM
reg [AW-1: 0] addr = 0;
wire [DW-1: 0] data_in;
wire [DW-1: 0] data_out;
reg rw;

genram
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(DW))
  RAM (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out),
        .rw(rw)
      );

//------ Contador
//-- counter enable: Se pone a 1 cuando haya que acceder a la siguiente
//-- posicion de memoria
reg cena;

always @(posedge clk)
  if (!rstn)
    addr <= 0;
  else if (cena)
    addr <= addr + 1;

//-- Overflow del contador: se pone a uno cuando todos sus bits
//-- esten a 1
wire ov = & addr;

//-------- TRANSMISOR SERIE
wire ready;
reg transmit;

//-- Instanciar la Unidad de transmision
uart_tx #(.BAUD(BAUD))
  TX0 (
    .clk(clk),
    .rstn(rstn),
    .data(data_out),
    .start(transmit),
    .ready(ready),
    .tx(tx)
  );

//-------- RECEPTOR SERIE
wire rcv;

uart_rx #(BAUD)
  RX0 (.clk(clk),         //-- Reloj del sistema
       .rstn(rstn),     //-- Señal de reset
       .rx(rx),           //-- Linea de recepción de datos serie
       .rcv(rcv),         //-- Señal de dato recibido
       .data(data_in)     //-- Datos recibidos
      );

assign leds = data_in[3:0];

//------------------- CONTROLADOR

//-- Estado del automata
reg [1:0] state;
reg [1:0] next_state;

localparam TX_WAIT = 0;
localparam TX_READ = 1;
localparam RX_WAIT = 2;
localparam RX_WRITE = 3;

//-- Transiones de estados
always @(posedge clk) 
  if (!rstn)
    state <= TX_WAIT;
  else
    state <= next_state;

//-- Generacion de microordenes
//-- y siguientes estados
always @(*) begin

  //-- Valores por defecto
  next_state = state;
  rw = 1;
  cena = 0;
  transmit = 0;
  debug = 0;

  case (state)

    //-- Esperar a que transmisor este listo para enviar
    TX_WAIT: begin
      if (ready)
        next_state = TX_READ;
      else
        next_state = TX_WAIT;
    end

    //-- Lectura del dato en memoria y transmision serie
    TX_READ: begin

      transmit = 1;
      cena = 1;

      //-- Si es el ultimo caracter pasar a recepcion
      if (ov) 
        next_state = RX_WAIT;
      else
        next_state = TX_WAIT;
    end

    //-- Esperar a que lleguen caracteres por el puerto serie
    RX_WAIT: begin

      debug = 1;

      if (rcv)
        next_state = RX_WRITE;
      else
        next_state = RX_WAIT;
    end

    //-- Escritura de dato en memoria
    RX_WRITE: begin
      rw = 0;
      cena = 1;

      //-- Si es el ultimo caracter, ir al estado inicial
      if (ov)
        next_state = TX_WAIT;
      else
        next_state = RX_WAIT;
    end
  endcase

end

endmodule





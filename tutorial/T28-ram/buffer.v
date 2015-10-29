//----------------------------------------------------------------------------
//-- Ejemplo de uso de una memoria rom generica
//-- Se reproduce en los leds la secuencia definida en el fichero rom1.list
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

//-- Numero de bits de la direccion
parameter AW = 4;
parameter DW = 8;

wire ready;
reg transmit;

wire rcv;

reg rstn=0;

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
  if (cena)
    addr <= addr + 1;

//-- Overflow del contador: se pone a uno cuando todos sus bits
//-- esten a 1
wire ov = & addr;

//-------- TRANSMISOR SERIE

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
uart_rx #(BAUD)
  RX0 (.clk(clk),         //-- Reloj del sistema
       .rstn(rstn),     //-- Señal de reset
       .rx(rx),           //-- Linea de recepción de datos serie
       .rcv(rcv),         //-- Señal de dato recibido
       .data(data_in)     //-- Datos recibidos
      );

assign leds = data_in[4:0];

//------------------- CONTROLADOR

//-- Estado del automata
reg [2: 0] state = INIT ;
reg [2: 0] next_state;

localparam INIT = 0;
localparam TX_WAIT = 1;
localparam TX_READ = 2;
localparam RX_WAIT = 3;
localparam RX_WRITE = 4;

//-- Transiones de estados
always @(posedge clk) 
  state <= next_state;


//-- Generacion de microordenes
//-- y siguientes estados
always @(*) begin
  next_state = state;
  rw = 1;
  cena = 0;
  transmit = 0;
  debug = 0;

  case (state)
    INIT: begin
      next_state = TX_WAIT;
    end

    TX_WAIT: begin
      if (ready)
        next_state = TX_READ;
      else
        next_state = TX_WAIT;
    end

    TX_READ: begin

      transmit = 1;
      cena = 1;

      if (ov) 
        next_state = RX_WAIT;
      else
        next_state = TX_WAIT;
    end

    RX_WAIT: begin

      debug = 1;

      if (rcv)
        next_state = RX_WRITE;
      else
        next_state = RX_WAIT;
    end

    RX_WRITE: begin
      rw = 0;
      cena = 1;

      if (ov)
        next_state = TX_WAIT;
      else
        next_state = RX_WAIT;
    end

  endcase

end


endmodule





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
               input wire rstn,
               input wire rx,
               output wire tx,
               output wire [4:0] leds);

//-- Velocidad de transmision
parameter BAUD = `B115200;

//-- Fichero con la rom
parameter ROMFILE = "bufferini.list";

//-- Numero de bits de la direccion
parameter AW = 4;
parameter DW = 8;

//-- Cable para direccionar la memoria
reg [AW-1: 0] addr;
wire [DW-1: 0] data_in;
wire [DW-1: 0] data_out;
reg rw;

wire ready;
reg transmit;

reg rstn_r;

//-- Registrar el reset
always @(posedge clk)
  rstn_r <= rstn;

//-------------------- Microordenes
//-- counter enable: Se pone a 1 cuando haya que acceder a la siguiente
//-- posicion de memoria
reg cena;

//-- Instanciar la memoria rom
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

//-- Contador
always @(posedge clk)
  if (rstn_r == 0)
    addr <= 0;
  else if (cena)
    addr <= addr + 1;

//-- Conectar los leds
assign leds = data_out[4:0];

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


//------------------- CONTROLADOR
localparam READ_1 = 0;  //-- Lectura en memoria
localparam TRANS_1 = 1;   //-- Comienzo de transmision de caracter
localparam TRANS_2 = 2;   //-- Esperar a que transmision se estabilice

localparam RCV_1 = 3;     //-- Recepcion de caracter

reg [1: 0] state;

always @(posedge clk)
  if (rstn_r == 0)
    state <= READ_1;
  else
    case (state)
      READ_1:
        //-- Si transmisor listo, pasar al estado de transmitir
        if (ready) 
          state <= TRANS_1;
        else
          state <= READ_1;

      TRANS_1: state <= TRANS_2;
      TRANS_2: 
        //-- Esperar a que ready se ponga a 0
        if (ready)
          state <= TRANS_2;

        //-- Si cadena entera enviada, pasar a recibir una nueva
        else if (addr == 0)
          state <= RCV_1;
        else
          state <= READ_1;

      RCV_1:  state <= RCV_1;

      default: state <= READ_1;
    endcase

always @*
  case (state)
    READ_1: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
    end

    TRANS_1: begin
      rw <= 1;
      cena <= 1;
      transmit <= 1;
    end

    TRANS_2: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
    end

    RCV_1: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
    end

    default: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
    end
  endcase


endmodule





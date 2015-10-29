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
               output wire [4:0] leds,
               output wire beep, 
               output wire gen1);

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
reg [4:0] leds_r;
wire ready;
reg transmit;

reg rstn_r;

wire tx_line;

wire rcv;
reg rcv_r;

reg ccl;


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
  if (ccl)
    addr <= 0;
  else if (cena)
    addr <= addr + 1;

//-- Overflow
wire ov = & addr;

//-- Conectar los leds
always @(posedge clk)
  leds_r <= {1'b0, addr}; //data_out[4:0];//data_in[4:0];

assign leds = leds_r;

//-------- TRANSMISOR SERIE
//-- Instanciar la Unidad de transmision
uart_tx #(.BAUD(BAUD))
  TX0 (
    .clk(clk),
    .rstn(rstn_r),
    .data(data_out),
    .start(transmit),
    .ready(ready),
    .tx(tx_line)
  );

assign tx = tx_line;
assign beep = tx_line;

//-------- RECEPTOR SERIE
uart_rx #(BAUD)
  RX0 (.clk(clk),         //-- Reloj del sistema
       .rstn(rstn_r),     //-- Señal de reset
       .rx(rx),           //-- Linea de recepción de datos serie
       .rcv(rcv),         //-- Señal de dato recibido
       .data(data_in)     //-- Datos recibidos
      );

always @(posedge clk)
  rcv_r <= rcv;


//------------------- CONTROLADOR

localparam INIT = 0;
localparam READ_1 = 1;    //-- Lectura en memoria
localparam TRANS_1 = 2;   //-- Comienzo de transmision de caracter
localparam TRANS_2 = 3;   //-- Esperar a que transmision se estabilice

localparam INITW = 4;
localparam RCV_1 = 5;     //-- Esperar a recibir caracter
localparam WRITE = 6;     //-- Escribir en memoria
localparam END = 7;       //-- Preparacion para comenzar otra vez

reg [2: 0] state;
reg [2: 0] next_state;

localparam TX_WAIT = 1;
localparam TX_READ = 2;
localparam RX_WAIT = 3;
localparam RX_WRITE = 4;

always @(posedge clk) begin
	if(rstn == 0)
		state <= INIT;
	else
		state <= next_state;
end

always @(*) begin
  next_state = state;
  rw = 1;
  cena = 0;
  transmit = 0;
  ccl = 0;

  case (state)
    INIT: begin
      ccl = 1;
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





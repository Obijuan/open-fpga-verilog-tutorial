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
               output wire [3:0] leds,
               output reg debug,
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
wire ready;
reg transmit;

reg rstn_r;

wire tx_line;

wire rcv;
reg rcv_r;


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
  if (rstn == 0)
    addr <= 0;
  else if (cena)
    addr <= addr + 1;

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

localparam WAIT_TX = 0;

always @(posedge clk) begin
	if(rstn == 0)
		state <= INIT;
	else
		state <= next_state;
end

assign leds = data_out[3:0]; // addr;

always @(*) begin
  next_state = state;
  rw = 1;
  cena = 0;
  transmit = 0;
  debug = 0;

  case (state)
    INIT: begin
      transmit = 1;
      debug = 1;
    end
  endcase

end


/*
always @(*) begin
  next_state = state;
  rw = 1;
  cena = 0;
  transmit = 0;
  ccl = 0;

  case (state)
    INIT: begin
      ccl = 1;
      next_state = READ_1;
    end

    READ_1: begin
      if (ready)
        next_state = TRANS_1;
      else
        next_state = READ_1;
    end

    TRANS_1: begin
      cena = 1;
      transmit = 1;
      next_state = TRANS_1; //TRANS_2;
    end

    TRANS_2: 
      if (addr > 4'd13)
        next_state = INITW;
      else
        next_state = READ_1; 

    INITW: begin
      ccl = 1;
      next_state = RCV_1;
    end

    RCV_1: begin
      if (rcv_r == 1) next_state = WRITE;
      else next_state = RCV_1;
    end

		WRITE: begin
      rw = 0;
      cena = 1;
      next_state = END;
    end

    END: begin
      if (addr > 4'd13)
        next_state = INIT;
      else
        next_state = RCV_1; 
    end


  endcase

end

*/

/*

always @(posedge clk)
  if (rstn_r == 0)
    state <= INIT;
  else
    case (state)
      INIT: state <= READ_1;
      READ_1: 
        //-- Esperar a que el transmisor este listo
        if (ready) 
          state <= TRANS_1;
        else
          state <= READ_1;  //-- No listo. Esperar

      TRANS_1: state <= TRANS_2;

      TRANS_2:           //-- Condicion de terminacion de lectura
          if (addr > 4)  
            state <= INITW;
          else
            state <= READ_1;

      INITW:
         state <= RCV_1;

			RCV_1: 
        if (rcv_r == 1) state <= WRITE;
        else state <= RCV_1;

      WRITE:  state <= END;

      END:  
        if (addr > 4)
          state <= INIT;
        else
          state <= RCV_1;
 

    default:
      state <= READ_1;
    endcase


assign rw = (state == WRITE) ? 0 : 1;

always @*
  case (state)
    INIT: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 1;
    end

    READ_1: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    TRANS_1: begin
      //rw <= 1;
      cena <= 1;
      transmit <= 1;
      ccl <= 0;
    end

    TRANS_2: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    INITW: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 1;
    end

    RCV_1: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    WRITE: begin
      //rw <= 0;
      cena <= 1;
      transmit <= 0;
      ccl <= 0;
    end

    END: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end
    
    default: begin
      //rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end
  endcase

*/

/*

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
        else
          state <= READ_1;

      RCV_1:  
        if (rcv)
          state <= RCV_2;
        else
          state <= RCV_1;

      RCV_2:
        if (addr == 1) 
          state <= END;
        else
          state <= RCV_1;

      END: state <= END;
        

      default: state <= READ_1;
    endcase

always @*
  case (state)
    READ_1: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    TRANS_1: begin
      rw <= 1;
      cena <= 1;
      transmit <= 1;
      ccl <= 0;
    end

    TRANS_2: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    RCV_1: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end

    RCV_2: begin
      rw <= 0;
      cena <= 1;
      transmit <= 0;
      ccl <= 0;
    end

    END: begin
      rw <= 1;
      cena <= 0;
      ccl <= 1;
      transmit <= 0;
    end

    default: begin
      rw <= 1;
      cena <= 0;
      transmit <= 0;
      ccl <= 0;
    end
  endcase
*/

endmodule





//----------------------------------------------------------------------------
//-- Unidad de recepcion serie asincrona
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
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

module uart_rx 
    #(
    parameter BAUD = `B115200
    )
    (input wire clk,         //-- Reloj del sistema
                input wire rstn,        //-- Reset
                input wire rx,          //-- Linea de recepcion serie
                output reg rcv,         //-- Indicar Dato disponible
                output reg [7:0] data); //-- Dato recibo


//-- Reloj para la recepcion
wire clk_baud;

//-- Linea de recepcion registrada
//-- Para cumplir reglas de diseño sincrono
reg rx_r;

//-- Microordenes
reg bauden;  //-- Activar señal de reloj de datos
reg clear;   //-- Poner a cero contador de bits
reg load;    //-- Cargar dato recibido


//-------------------------------------------------------------------
//--     RUTA DE DATOS
//-------------------------------------------------------------------

//-- Registrar la señal de recepcion de datos
//-- Para cumplir con las normas de diseño sincrono
always @(posedge clk)
  rx_r <= rx;

//-- Divisor para la generacion del reloj de llegada de datos 
baudgen_rx #(.BAUD(BAUD))
  baudgen0 ( 
    .clk(clk),
    .clk_ena(bauden), 
    .clk_out(clk_baud)
  );

//-- Contador de bits
reg [3:0] bitc;

always @(posedge clk)
  if (clear)
    bitc <= 4'd0;
  else if (clear == 0 && clk_baud == 1)
    bitc <= bitc + 1;


//-- Registro de desplazamiento para almacenar los bits recibidos
reg [9:0] raw_data;

always @(posedge clk)
  if (clk_baud == 1) begin
    raw_data = {rx_r, raw_data[9:1]};
  end

//-- Registro de datos. Almacenar el dato recibido
always @(posedge clk)
  if (rstn == 0)
    data <= 0;
  else if (load)
    data <= raw_data[8:1];

//-------------------------------------
//-- CONTROLADOR
//-------------------------------------
localparam IDLE = 2'd0;  //-- Estado de reposo
localparam RECV = 2'd1;  //-- Recibiendo datos
localparam LOAD = 2'd2;  //-- Almacenamiento del dato recibido
localparam DAV = 2'd3;   //-- Señalizar dato disponible 

reg [1:0] state;

//-- Transiciones entre estados
always @(posedge clk)

  if (rstn == 0)
    state <= IDLE;

  else
    case (state)

      //-- Resposo
      IDLE : 
        //-- Al llegar el bit de start se pasa al estado siguiente
        if (rx_r == 0)  
          state <= RECV;
        else
          state <= IDLE;

      //--- Recibiendo datos      
      RECV:
        //-- Vamos por el ultimo bit: pasar al siguiente estado
        if (bitc == 4'd10)
          state <= LOAD;
        else
          state <= RECV;

      //-- Almacenamiento del dato
      LOAD:
        state <= DAV;

      //-- Señalizar dato disponible
      DAV:
        state <= IDLE;

    default:
      state <= IDLE;
    endcase


//-- Salidas de microordenes
always @* begin
  bauden <= (state == RECV) ? 1 : 0;
  clear <= (state == IDLE) ? 1 : 0;
  load <= (state == LOAD) ? 1 : 0;
  rcv <= (state == DAV) ? 1 : 0;
end


endmodule



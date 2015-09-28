`include "baudgen.vh"

module scicad1 (input wire clk,
                input wire dtr,
                output wire tx
               );

parameter BAUD = `B115200;

//-- Reset
reg rstn = 0;

wire ready;

reg [7:0] data;

reg [7:0] data_r;

reg transmit;

//-- Microordenes
reg cena;      //-- Counter enable (cuando cena = 1)
reg start;  //-- Transmitir cadena (cuando transmit = 1)


//------------------------------------------------
//-- 	RUTA DE DATOS
//------------------------------------------------

//-- Inicializador
always @(posedge clk)
  rstn <= 1;

//-- Unidad de transmision
uart_tx #(.BAUD(BAUD))
  TX0 (
    .clk(clk),
    .rstn(rstn),
    .data(data_r),
    .start(start),
    .ready(ready),
    .tx(tx)
  );

//-- Multiplexor con los caracteres de la cadena a transmitir
always @*
  case (car_count)
    8'd0: data <= "H";
    8'd1: data <= "o";
    8'd2: data <= "l";
    8'd3: data <= "a";
    8'd4: data <= "!";
    8'd5: data <= ".";
    8'd6: data <= ".";
    8'd7: data <= ".";
    default: data <= ".";
  endcase

always @*
  data_r <= data;

//-- Contador de caracteres
reg [2:0] car_count;

always @(posedge clk)
  if (rstn == 0)
    car_count = 0;
  else if (cena)
    car_count = car_count + 1;

//-- Registrar señal dtr para cumplir con normas diseño sincrono
always @(posedge clk)
  transmit <= dtr;

//----------------------------------------------------
//-- CONTROLADOR
//----------------------------------------------------
localparam IDLE = 0;   //-- Reposo
localparam TXCAR = 1;  //-- Transmitiendo caracter
localparam NEXT = 2;   //-- Preparar transmision del sig caracter
localparam END = 3;    //-- Terminar

reg [1:0] state;

always @(posedge clk)
  if (rstn == 0)
    state <= IDLE;
  else
    case (state)
      IDLE: 
        if (transmit == 1) state <= TXCAR;
        else state <= IDLE;

      TXCAR: 
        if (ready == 1) state <= NEXT;
        else state <= TXCAR;

      NEXT:	
        if (car_count == 7) state <= END;
        else state <= TXCAR;

      END: 
        //--Esperar a que se termine ultimo caracter
        if (ready == 1) state <= IDLE;
        else state <= END;

      default:
         state <= IDLE;

    endcase


always @*
  case (state)
    IDLE: begin
      start <= 0;
      cena <= 0;
    end

    TXCAR: begin
      start <= 1;
      cena <= 0;
    end

    NEXT: begin
      start <= 0;
      cena <= 1;
    end

    END: begin
      start <= 0;
      cena <= 0;
    end

    default: begin
      start <= 0;
      cena <= 0;
    end
  endcase

endmodule





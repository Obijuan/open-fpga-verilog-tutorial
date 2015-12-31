//----------------------------------------------------------------------------
//-- Ejemplo de uso del transmisor serie
//-- Envio de la cadena "Hola!..." de forma continuada cuando se activa la 
//-- señal de DTR
//----------------------------------------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Comprobado su funcionamiento a todas las velocidades estandares:
//-- 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200
//----------------------------------------------------------------------------
`include "baudgen.vh"

//-- Modulo para envio de una cadena por el puerto serie
module scicad1 (input wire clk,  //-- Reloj del sistema
                input wire dtr,  //-- Señal de DTR
                output wire tx   //-- Salida de datos serie
               );

//-- Velocidad a la que hacer las pruebas
parameter BAUD = `B115200;

//-- Reset
reg rstn = 0;

//-- Señal de listo del transmisor serie
wire ready;

//-- Dato a transmitir (normal y registrado)
reg [7:0] data;
reg [7:0] data_r;

//-- Señal para indicar al controlador el comienzo de la transmision
//-- de la cadena. Es la de DTR registrada
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

//-- Instanciar la Unidad de transmision
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
//-- se seleccionan mediante la señal car_count
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

//-- Registrar los datos de salida del multiplexor
always @*
  data_r <= data;

//-- Contador de caracteres
//-- Cuando la microorden cena esta activada, se incrementa
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
localparam TXCAR = 2'd1;  //-- Transmitiendo caracter
localparam NEXT = 2'd2;   //-- Preparar transmision del sig caracter
localparam END = 3;    //-- Terminar

//-- Registro de estado del automata
reg [1:0] state;

//-- Gestionar el cambio de estado
always @(posedge clk)

  if (rstn == 0)
    //-- Ir al estado inicial
    state <= IDLE;

  else
    case (state)
      //-- Estado inicial. Se sale de este estado al recibirse la
      //-- señal de transmit, conectada al DTR
      IDLE: 
        if (transmit == 1) state <= TXCAR;
        else state <= IDLE;

      //-- Estado de transmision de un caracter. Esperar a que el 
      //-- transmisor serie este disponible. Cuando lo esta se pasa al
      //-- siguiente estado
      TXCAR: 
        if (ready == 1) state <= NEXT;
        else state <= TXCAR;

      //-- Envio del siguiente caracter. Es un estado transitorio
      //-- Cuando se llega al ultimo caracter se pasa para finalizar
      //-- la transmision 
      NEXT:	
        if (car_count == 7) state <= END;
        else state <= TXCAR;

      //-- Ultimo estado:finalizacion de la transmision. Se espera hasta
      //-- que se haya enviado el ultimo caracter. Cuando ocurre se vuelve
      //-- al estado de reposo inicial
      END: 
        //--Esperar a que se termine ultimo caracter
        if (ready == 1) state <= IDLE;
        else state <= END;

      //-- Necesario para evitar latches
      default:
         state <= IDLE;

    endcase

//-- Generacion de las microordenes
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





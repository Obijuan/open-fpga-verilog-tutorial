`default_nettype none

`define B115200 104

module uart_rx(
   input wire clk,         //-- Relog del sistema
   input wire rstn,        //-- Reset sincrono activo a nivel bajo
   input wire rx,          //-- Datos provenientes de la linea serie
   output wire [7:0] data  //-- Datos recibidos
);

wire ser_clk;
reg restart = 0;

//-- GENERADOR DEL RELOJ
baudgen #(`B115200 >> 1)
  DIV0 (
    .clk_in(clk),
    .restart(restart),
    .clk_out(ser_clk)
  );


//-- CONTADOR DE CARACTERES RECIBIDOS (PARA DEBUG)
reg [3:0] car_counter;
reg car_counter_enable = 0;

always @(posedge clk)
  if (!rstn)
    car_counter <= 0;
  else if (car_counter_enable)
    car_counter <= car_counter + 1;

//-- REGISTRO DE DATO RECIBIDO
reg [7:0] regdata = 0;
reg regdata_load = 0;

always @(posedge clk)
  if (regdata_load)
    regdata <= shifter;

//-- CONTADOR DE TICS
reg [4:0] tics_counter = 0;
reg bitcounter_enable = 0;


always @(posedge clk)
  if (!rstn)
    tics_counter <= 0;
  else if (!bitcounter_enable)
    tics_counter <= 0;
  else if (ser_clk)
    tics_counter <= tics_counter + 1;



//-- REGISTRO DE DESPLAZAMIENTO
reg [7:0] shifter = 0;
reg shift = 0;  //-- Modo: shift = 1 desplzamiento, 0 stop (no habilitado)


always @(posedge ser_clk)
  if (!rstn)
    shifter <= 8'b1111_1111;
  else if (shift & tics_counter[0]==1)
    shifter <= {rx, shifter[7:1]};



//-- MAQUINA DE ESTADOS
localparam IDLE = 0;
localparam START = 1;
localparam RECEIVING = 2;
localparam FINISH = 3;

reg [2:0] state = IDLE;

//assign data = (state == FINISH) ? 8'b0000_1000 : {6'b000000, ser_clk, 1'b0};

//assign data = {4'b0000, car_counter[0], regdata[2:0]};

assign data = regdata;

//-- Salidas del automata del receptor
always @* begin
  case (state)
    IDLE: begin
      restart <= 1;
      shift <= 0;
      bitcounter_enable <= 0;
      car_counter_enable <= 0;
      regdata_load <= 0;
      end

    START: begin
        restart <= 0;  //-- Arrancar reloj
        shift <= 1;    //-- activar reg. de desplazamiento
        bitcounter_enable <= 1;
        car_counter_enable <= 0;
        regdata_load <= 0;
      end

    RECEIVING: begin
        restart <= 0;
        shift <= 1;
        bitcounter_enable <= 1;
        car_counter_enable <= 0;
        regdata_load <= 0;
      end

    FINISH: begin
        restart <= 1;
        shift <= 0;
        bitcounter_enable <= 0;
        car_counter_enable <= 1;
        regdata_load <= 1;
      end

    default: begin
      restart <= 1; 
      shift <= 0;
      bitcounter_enable <= 0;
      car_counter_enable <= 0;
      regdata_load <= 0;
      end

  endcase
end

//-- Estados del automata
always @(posedge clk)
  if (!rstn)
    state <= IDLE;
  else
    case (state)
     
      //-- Esta inicial. Reposo
      IDLE:
        if (rx == 0)
          state <= START;
        else
          state <= IDLE;

      //-- Recibido bit de start. Arrancar el reloj serie
      //-- Habilitar registro de desplazamiento
      START:
         state <= RECEIVING; //RECEIVING;

      
      //-- Recibiendo datos sobremuesreados en el reg de desplazamiento
      RECEIVING:
         if (tics_counter == 19)
           state <= FINISH;
         else
           state <= RECEIVING;
        
      //-- Terminado. Dato disponible
      FINISH:
           state <= IDLE;
        
      default:
        state <= IDLE;
    endcase


endmodule







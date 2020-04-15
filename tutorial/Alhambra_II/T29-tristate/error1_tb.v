//-------------------------------------------------------------------
//-- tristate1_tb.v
//-- Banco de pruebas para la puerta tri-estado
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL license
//-------------------------------------------------------------------

//-------------------------------------------------------------------
//-- Este codigo simula bien, pero NO se sintetiza con Yosys + icestorm:
//-- Todavía el sopote para puertas tri-estado no es completo
//-- Mensaje de error:
/*
2.12.2. Executing Verilog-2005 frontend.
Parsing Verilog input from `/usr/local/bin/../share/yosys/ice40/arith_map.v' to AST representation.
Generating RTLIL representation for module `\_80_ice40_alu'.
Successfully finished Verilog frontend.
Mapping error1.$ternary$error1.v:22$2 ($tribuf) with simplemap.
terminate called after throwing an instance of 'std::out_of_range'
  what():  vector::_M_range_check: __n (which is 1) >= this->size() (which is 1)
Aborted (core dumped)
Makefile:173: recipe for target 'error1.bin' failed
make: *** [error1.bin] Error 134
*/

module error1_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Led a controlar
wire [1:0] leds;

//-- Instanciar el componente
error1
  dut(
    .clk(clk),
    .leds(leds)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("error1_tb.vcd");
  $dumpvars(0, error1_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule

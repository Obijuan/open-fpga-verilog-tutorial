## Descripción
Componente "hola mundo" con un pin de salida que siempre está a '1'.
Al cargarlo en la iCE40-HX8K se enciende el led LED1

## Simulación

Para realizar la simulacion entrar en el directorio y ejecutar:

$ make sim

Automaticamente se invocará al icarus verilog para hacer la compilacion / simulación y al gtkwave para ver el resultado de la simulacion gráficamente

## Síntesis

Para implementar el diseño en la FPGA ejecutamos el comando:

$ make sint MEMORY=8k

Se nos genera el fichero T01-setbit.bin que contiene la conguración de la FPGA para que se nos implemente nuestro circuito digital.

Lo descargamos en la fpga mediante el comando:

sudo iceprog T01-setbit.bin

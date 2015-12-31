## Descripción
Divisor de frecuencias genérico. Como ejemplo se hace parpadear un led a la frecuencia de 1 Hz (una vez por segundo). Este capítulo incluye 2 proyectos: un divisor entre 3, y un divisor entre M (genérico)

## Simulación

Para realizar la simulacion entrar en el directorio y ejecutar:

$ make sim

Automaticamente se invocará al icarus verilog para hacer la compilacion / simulación y al gtkwave para ver el resultado de la simulacion gráficamente

Para simular el segundo proyecto, ejecutar:

$ make sim2

## Síntesis

Para implementar el diseño en la FPGA ejecutamos el comando:

$ make sint

Se nos genera el fichero div3.bin que contiene la conguración de la FPGA para que se nos implemente nuestro circuito digital.

Lo cargamos en la fpga mediante el comando:

$sudo iceprog div3.bin

Para sintetizar el segundo proyecto, hacemos:

$ make sint2

y lo cargamos en la FPGA con:

$sudo iceprog divM.bin






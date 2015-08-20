## Descripción
Ejemplo de uso de un registro de desplazamiento de 4 bits. Se hace rotar un led en sentido horario

## Simulación

Para realizar la simulacion entrar en el directorio y ejecutar:

$ make sim

Automaticamente se invocará al icarus verilog para hacer la compilacion / simulación y al gtkwave para ver el resultado de la simulacion gráficamente

## Síntesis

Para implementar el diseño en la FPGA ejecutamos el comando:

$ make sint

Se nos genera el fichero shift4.bin que contiene la conguración de la FPGA para que se nos implemente nuestro circuito digital.

Lo descargamos en la fpga mediante el comando:

sudo iceprog shift4.bin






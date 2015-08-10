Tutorial de verilog, con herramientas libres
============================================

# Sección 1: Poniendo bits a 0 y 1

## Introducción

 El circuito digital más simple es un cable que está conectado a '1'

(setbit-1.png)

 La salida se ha denominado A.

 Para incluir este circuito en la fpga, necesitamos definirlo en lenguaje Verilog. Su código se puede ver en el fichero setbit.v

  Además necesitamos indicar por qué pin de la fpga queremos conectar el su salida A. Este mapeo se realiza en el fichero setbit.pcf. Lo sacaremos por el pin 99 que se corresponde con un led. Pero podría ser cualquier otro.

(setbit-2.png)

## Simulación

Primero realizamos una simulacion del componente, para comprobar que el codigo verilog compila y funciona como nostros esperamos. Para ello tenemos que definir en verilog un programa de prueba, que se denomina testbench: setbit_tb.v

Este codigo lo que hace es colocar nuestro componente setbit, colocar un cable a su salida A (que también lo denominamos A) y comprobar que por el cable sale un '1'. Si no es así, nos sale un mensaje de error. Este codigo también genera un fichero con el volcado de las señales de manera que las podemos ver con la herramienta gtkwave (como si fuera un osciloscopio).

Para realizar la simulacion entrar en el directorio y ejecutar:

$ make sim

Automaticamente se invocará al icarus verilog para hacer la compilacion / simulación y al gtkwave para ver el resultado de la simulacion gráficamente

(imagen 3)

Vemos que el cable A está siemepre a '1', desde el instante 0

Podemos probar a cambiar el codigo verilog para poner la señal a 0 en vez de a 1 y volver a simular. En este caso el banco de pruebas nos sacara un mensaje de error por la consola indicando que la señal NO está a 1. También lo podemos ver gráficamente.

## Síntesis

Para implementar el diseño en la FPGA ejecutamos el comando:

$ make sint

Se nos genera el fichero setbit.bin que contiene la conguración de la FPGA para que se nos implemente nuestro circuito digital.

Lo descargamos en la fpga mediante el comando:

XXXXX

El led conectado al pin 99 se deberá encender

##-- Ejercicios

* Cambiar el componente para que saque un 0. Descargarlo en la fpga. El led se debera apagar

* Volver a ponerlo a 1, pero asignarlo a otro led, cambiando el fichero setbit.pcf





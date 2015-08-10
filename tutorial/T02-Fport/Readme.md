Tutorial de verilog, con herramientas libres
============================================

# Ejemplo 2: puerto fijo de 4 bits

## Introducción

 Sacaremos un valor de 4 bits por los pines de una fpga,
para mostrar valores en binario en los leds. Estos valores
serán siempre los mismos. Cargando configuraciones con diferentes valores se cambiará el patron visible en los leds, para verificar que está todo ok.
 
(Fport-1.png)

 La salida ahora es un bus de 4 bits, denominado DATA. El mapeo de los bits se muestra en la figura Fport-2.png.Ahora en total se sacan 4 pines hacia el exterior, cada uno con un led (Fichero fport.pcf)

## Simulación

El banco de pruebas es similar al del ejemplo anterior, pero ahora en vez de comprobar sólo un bit se comprueba el patrón de 4 bits. Si no es igual al esperado se emite un mensaje de error

Para realizar la simulacion entrar en el directorio y ejecutar:

$ make sim

Desde el gtkwave vemos que el cable DATA estás siempre con el valor binario 1010

(imagen 3)

## Síntesis

Como siempre:

$ make sint

y para descargar en la fpga:

XXXX

Se encenderán 2 de los 4 leds de la placa entrenadora

##-- Ejercicios

* Cambiar el valor para sacar otro patrón por los leds

* Modificar el componente para que el bus sea de 5 bits en vez de 4 y que el quinto también salga por los leds.




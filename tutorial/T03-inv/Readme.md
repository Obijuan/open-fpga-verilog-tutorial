Tutorial de verilog, con herramientas libres
============================================

# Ejemplo 3: Puerta inversora (NOT)

## Introducción

  Modelaremos un componente que es una puerta not, con un pin de entrada (A) y otro de salida (B). Como es un circuito combinacional (que no almacena información), tanto A como B son cables.

 La salida del inversor (B) la sacamos hacia fuera de la fpga por uno de los pines donde está conectado el led. La entrada (A) la conectamos a un pin de la fpga libre. Desde el exterior, mediante un cable, introduciremos un "1" o un "0" y veremos la salida por el led. Al poner un "1" el led se debe apagar. Al poner un "0" encender. Cuando la entrada está al aire el resultado es aleatorio: puede estar encendido o apagado o variando entre ambos estados.
 
(inv-1.png)

## Simulación

En el banco de pruebas se instancia la puerta inversora y se le conectan un cable dout por la salida B. Por la entrada A conectamos un registro de 1 bit: es un elemento que funciona como una variable, a la que se le pueden asignar valores. El programa de pruebas introduce un '0' por la entrada y comprueba si por la salida se obtiene un '1' (que es el negado). Y luego al revés: se introduce un '1' y se comprueba que se obtiene un '1'.  El elemento din tiene que ser un registro porque se le asignan valores diferentes: primero un 0 y luego un 1

$ make sim

Desde el gtkwave vemos que dout es siempre el negado de din. Inicialmente, tanto din como dout tienen valores en rojo. Esto es debido a que hasta el instante 5 no ponemos din a 0, por lo que inicialmente su estado es indefinido

(imagen 3)

## Síntesis

Como siempre:

$ make sint

y para descargar en la fpga:

XXXX

Para que funcione será necesario introducir los valores digitales por el pin 20 de la fpga.


##-- Ayuda para las pruebas: inv2.v
Para poder introducir '1' y '0' por el pin de entrada del inversor, es más fácil sacar estos valores fijos por dos pines de la fpga y mediante un cable externo introducirlos según convenga por la entrada del inversor. De esta forma evitamos introducir tensiones equivocadas.

Observamos que en el fichero inv2.v tenemos 3 asignaciones: la del inversor, la de poner el pin a '1' y la de poner el pin a '0'. Todas ellas se hacen "en paralelo" (esto es un concepto muy importante)

El banco de pruebas es exactamente igual pero además se comprueban las salidas fijas, para asegurarse que están puestas a sus valores.



##-- Ejercicios

* Poner otro inversor que tenga su salida en otro led





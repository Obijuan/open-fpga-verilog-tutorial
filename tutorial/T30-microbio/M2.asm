//-- M2.asm:  Ejemplo de una secuencia infinita

ini00:
ini1: // -- aas
ini2:
    ini0:   //-- hola
ini: LEDS 0x01  //-- hahahaha
WAIT
LEDS 0x2
WAIT
LEDS 0x4
WAIT
LEDS 0x8
WAIT
LEDS 0x1
WAIT
WAIT
LEDS 0x3     //--  \
WAIT
WAIT
LEDS 0x6     //--  /
WAIT
WAIT
LEDS 0xC     //--  \
WAIT
WAIT
LEDS 0x9     //--  /
WAIT
WAIT
end:
JP 0      //-- Saltar al comienzo

HALT      //-- Esta instruccion nunca se ejecuta. No es necesaria

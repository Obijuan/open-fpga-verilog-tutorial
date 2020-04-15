//-- M1.asm:  Ejemplo de una secuencia simple, sin repeticion

LEDS 0x1  //-- Encender primer led
WAIT      //-- Esperar
LEDS 0x2  //-- Segundo led
WAIT
LEDS 0x4  //-- Tercer led
WAIT
LEDS 0x8  //-- Cuarto led
WAIT
LEDS 0x1  //-- Primer led
HALT      //-- Terminar

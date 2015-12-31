//-- M2.asm:  Ejemplo de una secuencia infinita

ini:
      LEDS 0x01
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
      LEDS 0x3
      WAIT
      WAIT
      LEDS 0x6
      WAIT
      WAIT
      LEDS 0xC
      WAIT
      WAIT
      LEDS 0x9
      WAIT
      WAIT

      JP ini      //-- Saltar al comienzo

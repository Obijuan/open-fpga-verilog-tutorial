Estado actual:

  * Transmisor: OK. Probado a todas las velocidades desde 115200 - 300 baudios
        Programa de prueba: txcar.v

  * Receptor: Funciona a todas las velocidades menos 2400 y 300. Razon desconocida
       parece que es un problema de latches
         Programa de prueba: rxcar.v

  * Ejemplo Transmision - recepción: (Eco)  Por probar a todas las velocidades
       115200: OK
       57600: ok
       38400: Recibe, pero no transmite :-(
       19200: ok
       9600: Recibe, pero no transmite :-(
       4800: ok
       2400: ok
       1200: ok
       600: ok
       300: ok




//-- TM1.asm Microbio Assembler.  Test file 2
//-- This is for debugging the Microbio assembler


        org 10
ini:
      jp label1


         ORG 0x10    //-- test
label1:  LEDS 0x01  //-- aaaa
         WAIT
         JP label2

         org 0x20
label2:
         LEDS 0x02
         WAIT
         JP label3

         org 0x30
label3:
         leds 4
         WAIT
         JP label4

         org 0x36
label4:
         LEDS 0x08
         wait       
         JP ini

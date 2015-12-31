//-----------------------------------------------------------------------------
//-- Constantes para el modulo de generacion de baudios para comunicaciones serie
//------------------------------------------------------------------------------
//-- (C) BQ. September 2015. Written by Juan Gonzalez (Obijuan)
//------------------------------------------------------------------------------

//-- Para la icestick el calculo es el siguiente:
//-- Divisor = 12000000 / BAUDIOS  (Y se redondea a numero entero)

//-- Valores de los divisores para conseguir estos BAUDIOS:

`define B115200 104
`define B57600  208
`define B38400  313

`define B19200  625
`define B9600   1250
`define B4800   2500
`define B2400   5000
`define B1200   10000
`define B600    20000
`define B300    40000






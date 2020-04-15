//-- Constantes para definir los valores del divisor segun la
//-- frecuencia deseada
//-- OJO! Estas constantes solo valen para ser reproducidas con el 
//-- componente notegen.v

//------- Frecuencias para notas musicales
`define DO_0   59959 //-- 16.352 Hz
`define DOs_0  548E6 //-- 17.324 Hz
`define RE_0   4FCF7 //-- 18.354 Hz
`define REs_0  4B54C //-- 19.445 Hz
`define MI_0   471A6 //-- 20.602 Hz
`define FA_0   431CC //-- 21.827 Hz
`define FAs_0  3F587 //-- 23.125 Hz
`define SOL_0  3BCA5 //-- 24.500 Hz
`define SOLs_0 386F4 //-- 25.957 Hz
`define LA_0   35446 //-- 27.500 Hz
`define LAs_0  32470 //-- 29.135 Hz
`define SI_0   2F74A //-- 30.868 Hz


//-- Octava: 1
`define DO_1   2CCAC //-- 32.703 Hz
`define DOs_1  2A473 //-- 34.648 Hz
`define RE_1   27E7C //-- 36.708 Hz
`define REs_1  25AA6 //-- 38.891 Hz
`define MI_1   238D3 //-- 41.203 Hz
`define FA_1   218E6 //-- 43.654 Hz
`define FAs_1  1FAC4 //-- 46.249 Hz
`define SOL_1  1DE52 //-- 48.999 Hz
`define SOLs_1 1C37A //-- 51.913 Hz
`define LA_1   1AA23 //-- 55.000 Hz
`define LAs_1  19238 //-- 58.270 Hz
`define SI_1   17BA5 //-- 61.735 Hz


//-- Octava: 2
`define DO_2   16656 //-- 65.406 Hz
`define DOs_2  1523A //-- 69.296 Hz
`define RE_2   13F3E //-- 73.416 Hz
`define REs_2  12D53 //-- 77.782 Hz
`define MI_2   11C69 //-- 82.407 Hz
`define FA_2   10C73 //-- 87.307 Hz
`define FAs_2  FD62 //-- 92.499 Hz
`define SOL_2  EF29 //-- 97.999 Hz
`define SOLs_2 E1BD //-- 103.826 Hz
`define LA_2   D511 //-- 110.000 Hz
`define LAs_2  C91C //-- 116.541 Hz
`define SI_2   BDD2 //-- 123.471 Hz


//-- Octava: 3
`define DO_3   B32B //-- 130.813 Hz
`define DOs_3  A91D //-- 138.591 Hz
`define RE_3   9F9F //-- 146.832 Hz
`define REs_3  96A9 //-- 155.563 Hz
`define MI_3   8E35 //-- 164.814 Hz
`define FA_3   8639 //-- 174.614 Hz
`define FAs_3  7EB1 //-- 184.997 Hz
`define SOL_3  7795 //-- 195.998 Hz
`define SOLs_3 70DE //-- 207.652 Hz
`define LA_3   6A89 //-- 220.000 Hz
`define LAs_3  648E //-- 233.082 Hz
`define SI_3   5EE9 //-- 246.942 Hz


//-- Octava: 4
`define DO_4   5996 //-- 261.626 Hz
`define DOs_4  548E //-- 277.183 Hz
`define RE_4   4FCF //-- 293.665 Hz
`define REs_4  4B55 //-- 311.127 Hz
`define MI_4   471A //-- 329.628 Hz
`define FA_4   431D //-- 349.228 Hz
`define FAs_4  3F58 //-- 369.994 Hz
`define SOL_4  3BCA //-- 391.995 Hz
`define SOLs_4 386F //-- 415.305 Hz
`define LA_4   3544 //-- 440.000 Hz
`define LAs_4  3247 //-- 466.164 Hz
`define SI_4   2F75 //-- 493.883 Hz


//-- Octava: 5
`define DO_5   2CCB //-- 523.251 Hz
`define DOs_5  2A47 //-- 554.365 Hz
`define RE_5   27E8 //-- 587.330 Hz
`define REs_5  25AA //-- 622.254 Hz
`define MI_5   238D //-- 659.255 Hz
`define FA_5   218E //-- 698.456 Hz
`define FAs_5  1FAC //-- 739.989 Hz
`define SOL_5  1DE5 //-- 783.991 Hz
`define SOLs_5 1C38 //-- 830.609 Hz
`define LA_5   1AA2 //-- 880.000 Hz
`define LAs_5  1924 //-- 932.328 Hz
`define SI_5   17BA //-- 987.767 Hz


//-- Octava: 6
`define DO_6   1665 //-- 1046.502 Hz
`define DOs_6  1524 //-- 1108.731 Hz
`define RE_6   13F4 //-- 1174.659 Hz
`define REs_6  12D5 //-- 1244.508 Hz
`define MI_6   11C7 //-- 1318.510 Hz
`define FA_6   10C7 //-- 1396.913 Hz
`define FAs_6  FD6 //-- 1479.978 Hz
`define SOL_6  EF3 //-- 1567.982 Hz
`define SOLs_6 E1C //-- 1661.219 Hz
`define LA_6   D51 //-- 1760.000 Hz
`define LAs_6  C92 //-- 1864.655 Hz
`define SI_6   BDD //-- 1975.533 Hz


//-- Octava: 7
`define DO_7   B33 //-- 2093.005 Hz
`define DOs_7  A92 //-- 2217.461 Hz
`define RE_7   9FA //-- 2349.318 Hz
`define REs_7  96B //-- 2489.016 Hz
`define MI_7   8E3 //-- 2637.020 Hz
`define FA_7   864 //-- 2793.826 Hz
`define FAs_7  7EB //-- 2959.955 Hz
`define SOL_7  779 //-- 3135.963 Hz
`define SOLs_7 70E //-- 3322.438 Hz
`define LA_7   6A9 //-- 3520.000 Hz
`define LAs_7  649 //-- 3729.310 Hz
`define SI_7   5EF //-- 3951.066 Hz


//-- Octava: 8
`define DO_8   599 //-- 4186.009 Hz
`define DOs_8  549 //-- 4434.922 Hz
`define RE_8   4FD //-- 4698.636 Hz
`define REs_8  4B5 //-- 4978.032 Hz
`define MI_8   472 //-- 5274.041 Hz
`define FA_8   432 //-- 5587.652 Hz
`define FAs_8  3F6 //-- 5919.911 Hz
`define SOL_8  3BD //-- 6271.927 Hz
`define SOLs_8 387 //-- 6644.875 Hz
`define LA_8   354 //-- 7040.000 Hz
`define LAs_8  324 //-- 7458.620 Hz
`define SI_8   2F7 //-- 7902.133 Hz


//-- Octava: 9
`define DO_9   2CD //-- 8372.018 Hz
`define DOs_9  2A4 //-- 8869.844 Hz
`define RE_9   27E //-- 9397.273 Hz
`define REs_9  25B //-- 9956.063 Hz
`define MI_9   239 //-- 10548.082 Hz
`define FA_9   219 //-- 11175.303 Hz
`define FAs_9  1FB //-- 11839.822 Hz
`define SOL_9  1DE //-- 12543.854 Hz
`define SOLs_9 1C3 //-- 13289.750 Hz
`define LA_9   1AA //-- 14080.000 Hz
`define LAs_9  192 //-- 14917.240 Hz
`define SI_9   17C //-- 15804.266 Hz


//-- Octava: 10
`define DO_10   166 //-- 16744.036 Hz
`define DOs_10  152 //-- 17739.688 Hz
`define RE_10   13F //-- 18794.545 Hz
`define REs_10  12D //-- 19912.127 Hz
`define MI_10   11C //-- 21096.164 Hz
`define FA_10   10C //-- 22350.607 Hz
`define FAs_10  FD //-- 23679.643 Hz
`define SOL_10  EF //-- 25087.708 Hz
`define SOLs_10 E2 //-- 26579.501 Hz
`define LA_10   D5 //-- 28160.000 Hz
`define LAs_10  C9 //-- 29834.481 Hz
`define SI_10   BE //-- 31608.531 Hz




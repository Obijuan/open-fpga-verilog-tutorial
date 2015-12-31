//-- Constantes para definir los valores del divisor segun la
//-- frecuencia deseada

//------------------------- Duraciones
//-- En segundos
`define T_1s     12000000
`define T_2s     24000000

//-- En milisegundos
`define T_500ms  6000000
`define T_250ms  3000000
`define T_200ms  2400000
`define T_100ms  1200000
`define T_10ms   120000
`define T_5ms    60000
`define T_2ms    24000
`define T_1ms    12000

//-- En microsegundos


//-------------------- Frecuencias
//-- Megaherzios  MHz
`define F_4MHz 3
`define F_3MHz 4
`define F_2MHz 6
`define F_1MHz 12

//-- Kilohercios KHz
`define F_40KHz 300
`define F_8KHz 1500
`define F_4KHz 3000
`define F_3KHz 4000
`define F_2KHz 6000
`define F_1KHz 12000

//-- Hertzios (Hz)
`define F_4Hz   3000000
`define F_3Hz   4000000
`define F_2Hz   6000000
`define F_1Hz   12000000


//------- Frecuencias para notas musicales
//-- Octava: 0
`define DO_0   733873 //-- 16.352 Hz
`define DOs_0  692684 //-- 17.324 Hz
`define RE_0   653807 //-- 18.354 Hz
`define REs_0  617111 //-- 19.445 Hz
`define MI_0   582476 //-- 20.602 Hz
`define FA_0   549784 //-- 21.827 Hz
`define FAs_0  518927 //-- 23.125 Hz
`define SOL_0  489802 //-- 24.500 Hz
`define SOLs_0 462311 //-- 25.957 Hz
`define LA_0   436364 //-- 27.500 Hz
`define LAs_0  411872 //-- 29.135 Hz
`define SI_0   388756 //-- 30.868 Hz


//-- Octava: 1
`define DO_1   366937 //-- 32.703 Hz
`define DOs_1  346342 //-- 34.648 Hz
`define RE_1   326903 //-- 36.708 Hz
`define REs_1  308556 //-- 38.891 Hz
`define MI_1   291238 //-- 41.203 Hz
`define FA_1   274892 //-- 43.654 Hz
`define FAs_1  259463 //-- 46.249 Hz
`define SOL_1  244901 //-- 48.999 Hz
`define SOLs_1 231156 //-- 51.913 Hz
`define LA_1   218182 //-- 55.000 Hz
`define LAs_1  205936 //-- 58.270 Hz
`define SI_1   194378 //-- 61.735 Hz


//-- Octava: 2
`define DO_2   183468 //-- 65.406 Hz
`define DOs_2  173171 //-- 69.296 Hz
`define RE_2   163452 //-- 73.416 Hz
`define REs_2  154278 //-- 77.782 Hz
`define MI_2   145619 //-- 82.407 Hz
`define FA_2   137446 //-- 87.307 Hz
`define FAs_2  129732 //-- 92.499 Hz
`define SOL_2  122450 //-- 97.999 Hz
`define SOLs_2 115578 //-- 103.826 Hz
`define LA_2   109091 //-- 110.000 Hz
`define LAs_2  102968 //-- 116.541 Hz
`define SI_2   97189 //-- 123.471 Hz


//-- Octava: 3
`define DO_3   91734 //-- 130.813 Hz
`define DOs_3  86586 //-- 138.591 Hz
`define RE_3   81726 //-- 146.832 Hz
`define REs_3  77139 //-- 155.563 Hz
`define MI_3   72809 //-- 164.814 Hz
`define FA_3   68723 //-- 174.614 Hz
`define FAs_3  64866 //-- 184.997 Hz
`define SOL_3  61226 //-- 195.998 Hz
`define SOLs_3 57789 //-- 207.652 Hz
`define LA_3   54545 //-- 220.000 Hz
`define LAs_3  51484 //-- 233.082 Hz
`define SI_3   48594 //-- 246.942 Hz


//-- Octava: 4
`define DO_4   45867 //-- 261.626 Hz
`define DOs_4  43293 //-- 277.183 Hz
`define RE_4   40863 //-- 293.665 Hz
`define REs_4  38569 //-- 311.127 Hz
`define MI_4   36405 //-- 329.628 Hz
`define FA_4   34361 //-- 349.228 Hz
`define FAs_4  32433 //-- 369.994 Hz
`define SOL_4  30613 //-- 391.995 Hz
`define SOLs_4 28894 //-- 415.305 Hz
`define LA_4   27273 //-- 440.000 Hz
`define LAs_4  25742 //-- 466.164 Hz
`define SI_4   24297 //-- 493.883 Hz


//-- Octava: 5
`define DO_5   22934 //-- 523.251 Hz
`define DOs_5  21646 //-- 554.365 Hz
`define RE_5   20431 //-- 587.330 Hz
`define REs_5  19285 //-- 622.254 Hz
`define MI_5   18202 //-- 659.255 Hz
`define FA_5   17181 //-- 698.456 Hz
`define FAs_5  16216 //-- 739.989 Hz
`define SOL_5  15306 //-- 783.991 Hz
`define SOLs_5 14447 //-- 830.609 Hz
`define LA_5   13636 //-- 880.000 Hz
`define LAs_5  12871 //-- 932.328 Hz
`define SI_5   12149 //-- 987.767 Hz


//-- Octava: 6
`define DO_6    11467 //-- 1046.502 Hz
`define DOs_6   10823 //-- 1108.731 Hz
`define RE_6    10216 //-- 1174.659 Hz
`define REs_6   9642 //-- 1244.508 Hz
`define MI_6    9101 //-- 1318.510 Hz
`define FA_6    8590 //-- 1396.913 Hz
`define FAs_6   8108 //-- 1479.978 Hz
`define SOL_6   7653 //-- 1567.982 Hz
`define SOLs_6  7224 //-- 1661.219 Hz
`define LA_6    6818 //-- 1760.000 Hz
`define LAs_6   6436 //-- 1864.655 Hz
`define SI_6    6074 //-- 1975.533 Hz


//-- Octava: 7
`define DO_7   5733 //-- 2093.005 Hz
`define DOs_7  5412 //-- 2217.461 Hz
`define RE_7   5108 //-- 2349.318 Hz
`define REs_7  4821 //-- 2489.016 Hz
`define MI_7   4551 //-- 2637.020 Hz
`define FA_7   4295 //-- 2793.826 Hz
`define FAs_7  4054 //-- 2959.955 Hz
`define SOL_7  3827 //-- 3135.963 Hz
`define SOLs_7 3612 //-- 3322.438 Hz
`define LA_7   3409 //-- 3520.000 Hz
`define LAs_7  3218 //-- 3729.310 Hz
`define SI_7   3037 //-- 3951.066 Hz


//-- Octava: 8
`define DO_8   2867 //-- 4186.009 Hz
`define DOs_8  2706 //-- 4434.922 Hz
`define RE_8   2554 //-- 4698.636 Hz
`define REs_8  2411 //-- 4978.032 Hz
`define MI_8   2275 //-- 5274.041 Hz
`define FA_8   2148 //-- 5587.652 Hz
`define FAs_8  2027 //-- 5919.911 Hz
`define SOL_8  1913 //-- 6271.927 Hz
`define SOLs_8 1806 //-- 6644.875 Hz
`define LA_8   1705 //-- 7040.000 Hz
`define LAs_8  1609 //-- 7458.620 Hz
`define SI_8   1519 //-- 7902.133 Hz


//-- Octava: 9
`define DO_9   1433 //-- 8372.018 Hz
`define DOs_9  1353 //-- 8869.844 Hz
`define RE_9   1277 //-- 9397.273 Hz
`define REs_9  1205 //-- 9956.063 Hz
`define MI_9   1138 //-- 10548.082 Hz
`define FA_9   1074 //-- 11175.303 Hz
`define FAs_9  1014 //-- 11839.822 Hz
`define SOL_9  957 //-- 12543.854 Hz
`define SOLs_9 903 //-- 13289.750 Hz
`define LA_9   852 //-- 14080.000 Hz
`define LAs_9  804 //-- 14917.240 Hz
`define SI_9   759 //-- 15804.266 Hz


//-- Octava: 10
`define DO_10   717 //-- 16744.036 Hz
`define DOs_10  676 //-- 17739.688 Hz
`define RE_10   638 //-- 18794.545 Hz
`define REs_10  603 //-- 19912.127 Hz
`define MI_10   569 //-- 21096.164 Hz

//-- ¡Ojo!: estas notas no son audibles por humanos
`define FA_10   537 //-- 22350.607 Hz
`define FAs_10  507 //-- 23679.643 Hz
`define SOL_10  478 //-- 25087.708 Hz
`define SOLs_10 451 //-- 26579.501 Hz
`define LA_10   426 //-- 28160.000 Hz
`define LAs_10  403 //-- 29834.481 Hz
`define SI_10   380 //-- 31608.531 Hz



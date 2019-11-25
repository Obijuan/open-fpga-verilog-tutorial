//-- Constantes para definir los valores del divisor segun la
//-- frecuencia deseada

//------------------------- Duraciones
//-- En segundos
`define T_1s     16000000
`define T_2s     32000000

//-- En milisegundos
`define T_500ms  8000000
`define T_250ms  4000000
`define T_200ms  3200000
`define T_100ms  1600000
`define T_10ms   160000
`define T_5ms    80000
`define T_2ms    32000
`define T_1ms    16000

//-- Megaherzios  MHz
`define F_4MHz 4
`define F_1MHz 16

//-- Megaherzios  MHz
`define F_4MHz 4
`define F_3MHz 5
`define F_2MHz 8
`define F_1MHz 16

//-- Kilohercios KHz
`define F_40KHz 400
`define F_8KHz 2_000
`define F_4KHz 4_000
`define F_3KHz 5_333
`define F_2KHz 8_000
`define F_1KHz 16_000

//-- Hertzios (Hz)
`define F_4Hz   4_000_000
`define F_3Hz   5_333_333
`define F_2Hz   8_000_000
`define F_1Hz   16_000_000

//------- Frecuencias para notas musicales
//-- freq = 440×2^(n/12)
//-- note = 16000000/freq
//-- n = -57..75
//-- Octava: 0
`define DO_0   978497 //-- 16.352 Hz
`define DOs_0  923578 //-- 17.324 Hz
`define RE_0   871742 //-- 18.354 Hz
`define REs_0  822815 //-- 19.445 Hz
`define MI_0   776634 //-- 20.602 Hz
`define FA_0   733044 //-- 21.827 Hz
`define FAs_0  691902 //-- 23.125 Hz
`define SOL_0  653068 //-- 24.500 Hz
`define SOLs_0 616414 //-- 25.957 Hz
`define LA_0   581818 //-- 27.500 Hz
`define LAs_0  549163 //-- 29.135 Hz
`define SI_0   518341 //-- 30.868 Hz


//-- Octava: 1
`define DO_1   489248 //-- 32.703 Hz
`define DOs_1  461789 //-- 34.648 Hz
`define RE_1   435871 //-- 36.708 Hz
`define REs_1  411407 //-- 38.891 Hz
`define MI_1   388317 //-- 41.203 Hz
`define FA_1   366522 //-- 43.654 Hz
`define FAs_1  345951 //-- 46.249 Hz
`define SOL_1  326534 //-- 48.999 Hz
`define SOLs_1 308207 //-- 51.913 Hz
`define LA_1   290909 //-- 55.000 Hz
`define LAs_1  274581 //-- 58.270 Hz
`define SI_1   259170 //-- 61.735 Hz


//-- Octava: 2
`define DO_2   244624 //-- 65.406 Hz
`define DOs_2  230894 //-- 69.296 Hz
`define RE_2   217935 //-- 73.416 Hz
`define REs_2  205703 //-- 77.782 Hz
`define MI_2   194158 //-- 82.407 Hz
`define FA_2   183261 //-- 87.307 Hz
`define FAs_2  172975 //-- 92.499 Hz
`define SOL_2  163267 //-- 97.999 Hz
`define SOLs_2 154103 //-- 103.826 Hz
`define LA_2   145454 //-- 110.000 Hz
`define LAs_2  137290 //-- 116.541 Hz
`define SI_2   129585 //-- 123.471 Hz


//-- Octava: 3
`define DO_3   122312 //-- 130.813 Hz
`define DOs_3  115447 //-- 138.591 Hz
`define RE_3   108967 //-- 146.832 Hz
`define REs_3  102851 //-- 155.563 Hz
`define MI_3   97079 //-- 164.814 Hz
`define FA_3   91630 //-- 174.614 Hz
`define FAs_3  86487 //-- 184.997 Hz
`define SOL_3  81633 //-- 195.998 Hz
`define SOLs_3 77051 //-- 207.652 Hz
`define LA_3   72727 //-- 220.000 Hz
`define LAs_3  68645 //-- 233.082 Hz
`define SI_3   64792 //-- 246.942 Hz


//-- Octava: 4
`define DO_4   61156 //-- 261.626 Hz
`define DOs_4  57723 //-- 277.183 Hz
`define RE_4   54483 //-- 293.665 Hz
`define REs_4  51425 //-- 311.127 Hz
`define MI_4   48539 //-- 329.628 Hz
`define FA_4   45815 //-- 349.228 Hz
`define FAs_4  43243 //-- 369.994 Hz
`define SOL_4  40816 //-- 391.995 Hz
`define SOLs_4 38525 //-- 415.305 Hz
`define LA_4   36363 //-- 440.000 Hz
`define LAs_4  34322 //-- 466.164 Hz
`define SI_4   32396 //-- 493.883 Hz


//-- Octava: 5
`define DO_5   30578 //-- 523.251 Hz
`define DOs_5  28861 //-- 554.365 Hz
`define RE_5   27241 //-- 587.330 Hz
`define REs_5  25712 //-- 622.254 Hz
`define MI_5   24269 //-- 659.255 Hz
`define FA_5   22907 //-- 698.456 Hz
`define FAs_5  21621 //-- 739.989 Hz
`define SOL_5  20408 //-- 783.991 Hz
`define SOLs_5 19262 //-- 830.609 Hz
`define LA_5   18181 //-- 880.000 Hz
`define LAs_5  17161 //-- 932.328 Hz
`define SI_5   16198 //-- 987.767 Hz


//-- Octava: 6
`define DO_6    15289 //-- 1046.502 Hz
`define DOs_6   14430 //-- 1108.731 Hz
`define RE_6    13620 //-- 1174.659 Hz
`define REs_6   12856 //-- 1244.508 Hz
`define MI_6    12134 //-- 1318.510 Hz
`define FA_6    11453 //-- 1396.913 Hz
`define FAs_6   10810 //-- 1479.978 Hz
`define SOL_6   10204 //-- 1567.982 Hz
`define SOLs_6  9631 //-- 1661.219 Hz
`define LA_6    9090 //-- 1760.000 Hz
`define LAs_6   8580 //-- 1864.655 Hz
`define SI_6    8099 //-- 1975.533 Hz


//-- Octava: 7
`define DO_7   7644 //-- 2093.005 Hz
`define DOs_7  7215 //-- 2217.461 Hz
`define RE_7   6810 //-- 2349.318 Hz
`define REs_7  6428 //-- 2489.016 Hz
`define MI_7   6067 //-- 2637.020 Hz
`define FA_7   5726 //-- 2793.826 Hz
`define FAs_7  5405 //-- 2959.955 Hz
`define SOL_7  5102 //-- 3135.963 Hz
`define SOLs_7 4815 //-- 3322.438 Hz
`define LA_7   4545 //-- 3520.000 Hz
`define LAs_7  4290 //-- 3729.310 Hz
`define SI_7   4049 //-- 3951.066 Hz


//-- Octava: 8
`define DO_8   3822 //-- 4186.009 Hz
`define DOs_8  3607 //-- 4434.922 Hz
`define RE_8   3405 //-- 4698.636 Hz
`define REs_8  3214 //-- 4978.032 Hz
`define MI_8   3033 //-- 5274.041 Hz
`define FA_8   2863 //-- 5587.652 Hz
`define FAs_8  2702 //-- 5919.911 Hz
`define SOL_8  2551 //-- 6271.927 Hz
`define SOLs_8 2407 //-- 6644.875 Hz
`define LA_8   2272 //-- 7040.000 Hz
`define LAs_8  2145 //-- 7458.620 Hz
`define SI_8   2024 //-- 7902.133 Hz


//-- Octava: 9
`define DO_9   1911 //-- 8372.018 Hz
`define DOs_9  1803 //-- 8869.844 Hz
`define RE_9   1702 //-- 9397.273 Hz
`define REs_9  1607 //-- 9956.063 Hz
`define MI_9   1516 //-- 10548.082 Hz
`define FA_9   1431 //-- 11175.303 Hz
`define FAs_9  1351 //-- 11839.822 Hz
`define SOL_9  1275 //-- 12543.854 Hz
`define SOLs_9 1203 //-- 13289.750 Hz
`define LA_9   1136 //-- 14080.000 Hz
`define LAs_9  1072 //-- 14917.240 Hz
`define SI_9   1012 //-- 15804.266 Hz


//-- Octava: 10
`define DO_10   955 //-- 16744.036 Hz
`define DOs_10  901 //-- 17739.688 Hz
`define RE_10   851 //-- 18794.545 Hz
`define REs_10  803 //-- 19912.127 Hz
`define MI_10   758 //-- 21096.164 Hz
`define FA_10   715 //-- 22350.607 Hz
`define FAs_10  675 //-- 23679.643 Hz
`define SOL_10  637 //-- 25087.708 Hz
`define SOLs_10 601 //-- 26579.501 Hz
`define LA_10   568 //-- 28160.000 Hz
`define LAs_10  536 //-- 29834.481 Hz
`define SI_10   506 //-- 31608.531 Hz




# Build and run

 - set env PROJDIR code directory
 - set env PP project

Examples:
 - T01-setbit
```!sh
PP=setbit PROJDIR=../ICESTICK/T01-setbit make clean
PP=setbit PROJDIR=../ICESTICK/T01-setbit make sim
PP=setbit PROJDIR=../ICESTICK/T01-setbit make
PP=setbit PROJDIR=../ICESTICK/T01-setbit make prog
```
 - T02-Fport
```!sh
PP=Fport PROJDIR=../ICESTICK/T02-Fport make clean
PP=Fport PROJDIR=../ICESTICK/T02-Fport make sim
PP=Fport PROJDIR=../ICESTICK/T02-Fport make
PP=Fport PROJDIR=../ICESTICK/T02-Fport make prog
```
 - Others
 ```!sh
PP=inv PROJDIR=../ICESTICK/T03-inv make sim
PP=counter PROJDIR=../ICESTICK/T04-counter make sim
PP=prescalers PROJDIR=../ICESTICK/T05-prescalers make sim
PP=mpres PROJDIR=../ICESTICK/T06-multiples-prescalers make sim
PP=counter4 PROJDIR=../ICESTICK/T07-contador-prescaler make sim
PP=blink4 PROJDIR=../ICESTICK/T08-register make sim
PP=init PROJDIR=../ICESTICK/T09-inicializador make sim
PP=shift4 PROJDIR=../ICESTICK/T10-shif-register make sim
PP=mux4 PROJDIR=../ICESTICK/T12-mux-4-1 make sim
PP=reginit PROJDIR=../ICESTICK/T13-reg-init make sim
PP=regreset PROJDIR=../ICESTICK/T14-regreset make sim
PP=div3 PROJDIR=../ICESTICK/T15-divisor make sim
PP=divM PROJDIR=../ICESTICK/T15-divisor make sim
PP=countsec PROJDIR=../ICESTICK/T16-countsec make sim
PP=tones PROJDIR=../ICESTICK/T17-tones make sim
PP=notas PROJDIR=../ICESTICK/T18-notas make sim
PP=secnotas PROJDIR=../ICESTICK/T19-secnotas make sim
PP=echowire1 PROJDIR=../ICESTICK/T20-serialcomm-1 make sim
PP=echowire2 PROJDIR=../ICESTICK/T20-serialcomm-1 make sim
PP=baudtx PROJDIR=../ICESTICK/T21-baud-tx make sim
PP=baudtx2 PROJDIR=../ICESTICK/T21-baud-tx make sim
PP=baudtx3 PROJDIR=../ICESTICK/T21-baud-tx make sim
PP=txtest PROJDIR=../ICESTICK/T22-syncrules make sim
PP=txtest2 PROJDIR=../ICESTICK/T22-syncrules make sim
PP=txtest3 PROJDIR=../ICESTICK/T22-syncrules make sim
PP=fsmtx PROJDIR=../ICESTICK/T23-fsmtx make sim
PP=fsmtx2 PROJDIR=../ICESTICK/T23-fsmtx make sim
PP=scicad1 PROJDIR=../ICESTICK/T24-uart-tx make sim
PP=scicad2 PROJDIR=../ICESTICK/T24-uart-tx make sim
PP=echo PROJDIR=../ICESTICK/T25-uart-rx make sim
PP=rxleds PROJDIR=../ICESTICK/T25-uart-rx make sim
PP=romhw PROJDIR=../ICESTICK/T26-rom make sim
PP=romleds PROJDIR=../ICESTICK/T26-rom make sim
PP=romleds2 PROJDIR=../ICESTICK/T26-rom make sim
PP=genromleds PROJDIR=../ICESTICK/T27-rom-param make sim
PP=romnotes PROJDIR=../ICESTICK/T27-rom-param make sim
PP=buffer PROJDIR=../ICESTICK/T28-ram make sim
PP=error1 PROJDIR=../ICESTICK/T29-tristate make sim
PP=error2 PROJDIR=../ICESTICK/T29-tristate make sim
PP=tristate1 PROJDIR=../ICESTICK/T29-tristate make sim
PP=tristate2 PROJDIR=../ICESTICK/T29-tristate make sim
```
 - T30-microbio
```!sh
python ../ICESTICK/T30-microbio/masm.py ../ICESTICK/T30-microbio/TM2.asm
PP=microbio PROJDIR=../ICESTICK/T30-microbio make clean
PP=microbio PROJDIR=../ICESTICK/T30-microbio make sim
```
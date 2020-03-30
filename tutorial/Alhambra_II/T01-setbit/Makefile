#-------------------------------------------------------
#-- Objetivo por defecto: hacer simulacion y sintesis
#-------------------------------------------------------
all: sim sint

#----------------------------------------------
#-- make sim
#----------------------------------------------
#-- Objetivo para hacer la simulacion del
#-- banco de pruebas
#----------------------------------------------
sim: setbit_tb.vcd

#-----------------------------------------------
#-  make sint
#-----------------------------------------------
#-  Objetivo para realizar la sintetis completa
#- y dejar el diseno listo para su grabacion en
#- la FPGA
#-----------------------------------------------
sint: setbit.bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
setbit_tb.vcd: setbit.v setbit_tb.v

	#-- Compilar
	iverilog -o setbit_tb.out setbit.v setbit_tb.v

	#-- Simular
	./setbit_tb.out

	#-- Ver visualmente la simulacion con gtkwave
	gtkwave setbit_tb.vcd setbit_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
setbit.bin: setbit.v setbit.pcf

	#-- Sintesis
	#OLD
	#yosys -p "synth_ice40 -blif setbit.blif" setbit.v
	yosys -p 'synth_ice40 -top setbit -json setbit.json' setbit.v

	#-- Place & route
	#OLD
	#arachne-pnr -d 8k -P tq144:4k -p setbit.pcf setbit.blif -o setbit.txt
	#NEW - use nextpnr
	nextpnr-ice40 --hx8k --package tq144:4k --json setbit.json --pcf setbit.pcf --asc setbit.asc

	#-- Generar binario final, listo para descargar en fgpa
	#OLD
	#icepack setbit.txt setbit.bin
	icepack setbit.asc setbit.bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash:
	iceprog -d i:0x0403:0x6010:0 setbit.bin

#-- Limpiar todo
clean:
	rm -f *.bin *.asc *.json *.out *.vcd *~

.PHONY: all clean

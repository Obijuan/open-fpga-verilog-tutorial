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
	yosys -p "synth_ice40 -blif setbit.blif" setbit.v

	#-- Place & route
	arachne-pnr -d 1k -p setbit.pcf setbit.blif -o setbit.txt

	#-- Generar binario final, listo para descargar en fgpa
	icepack setbit.txt setbit.bin


#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean

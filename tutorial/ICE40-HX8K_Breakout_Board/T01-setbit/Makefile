#-----------------------------------------------------------------------------
#- (C) D. Cuartielles for Arduino, December 2015
#- GPLv3 License
#- based on previous work by Obijuan for BQ
#-----------------------------------------------------------------------------
#-- Este Makefile soporta las arquitecturas de 1K y 8K de Lattice
#-- se basa en la idea de que los ficheros estaran contenidos en una
#-- carpeta que se llamara como el programa a ejecutar (al igual que se
#-- hace en Arduino o Processing), de modo que el Makefile consultara
#-- el nombre de la carpeta para lanzar la compilacion
#--
#-- Ejemplos:
#--        make sint --> compila para el procesador de 1K
#--        make sint MEMORY=8k --> compila para el procesador de 8K
#--        make sint FILE=blabla --> compila el fichero blabla.v con blabla.pcf
#-----------------------------------------------------------------------------

#-------------------------------------------------------
#-- Declaracion de variables por defecto
#-- usamos el nombre de la carpeta como nombre del programa
#-- tal y como se hace en Arduino y Processing, de modo
#-- que se simplifique la forma de llamar al Makefile
#--
#-- por defecto compila para el procesador de 1K de memoria
#-------------------------------------------------------
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
FILE = $(CURRENT_DIR)
MEMORY = "1k"

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
sim: $(FILE)_tb.vcd

#-----------------------------------------------
#-  make sint
#-----------------------------------------------
#-  Objetivo para realizar la sintetis completa
#- y dejar el diseno listo para su grabacion en
#- la FPGA
#-----------------------------------------------
sint: $(FILE).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(FILE)_tb.vcd: $(FILE).v $(FILE)_tb.v

	#-- Compilar
	iverilog $(FILE).v $(FILE)_tb.v -o $(FILE)_tb.out

	#-- Simular
	./$(FILE)_tb.out

	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $(FILE)_tb.vcd $(FILE)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(FILE).bin: $(FILE).v $(FILE).pcf

	#-- Sintesis
	yosys -p "synth_ice40 -blif $(FILE).blif" $(FILE).v

	#-- Place & route
	arachne-pnr -d $(MEMORY) -p $(FILE).pcf $(FILE).blif -o $(FILE).txt

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(FILE).txt $(FILE).bin


#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean

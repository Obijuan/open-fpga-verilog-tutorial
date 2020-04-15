#----------------------------------------
#-- Establecer nombre del componente
#----------------------------------------
NAME = romhw
DEPS = rom32x4.v

NAME2 = romleds
DEPS2 = rom16x4.v dividerp1.v

NAME3 = romleds2
DEPS3 = romfile16x4.v dividerp1.v

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
sim: $(NAME)_tb.vcd

#-----------------------------------------------
#-  make sint
#-----------------------------------------------
#-  Objetivo para realizar la sintetis completa
#- y dejar el diseno listo para su grabacion en
#- la FPGA
#-----------------------------------------------
sint: $(NAME).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME)_tb.vcd: $(NAME).v $(DEPS) $(NAME)_tb.v

	#-- Compilar
	iverilog $^ -o $(NAME)_tb.out

	#-- Simular
	./$(NAME)_tb.out

	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $@ $(NAME)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME).bin: $(NAME).pcf $(NAME).v $(DEPS)

	#-- Sintesis
	# yosys -p "synth_ice40 -blif $(NAME).blif" $(NAME).v $(DEPS)
	yosys -p 'synth_ice40 -top $(NAME) -json $(NAME).json' $(NAME).v $(DEPS)

	#-- Place & route
	# arachne-pnr -d 1k -p $(NAME).pcf $(NAME).blif -o $(NAME).txt
	nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME).json --pcf $(NAME).pcf --asc $(NAME).asc

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME).asc $(NAME).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash:
	iceprog -d i:0x0403:0x6010:0 $(NAME).bin

sim2: $(NAME2)_tb.vcd

#-----------------------------------------------
#-  make sint
#-----------------------------------------------
#-  Objetivo para realizar la sintetis completa
#- y dejar el diseno listo para su grabacion en
#- la FPGA
#-----------------------------------------------
sint2: $(NAME2).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME2)_tb.vcd: $(NAME2).v $(DEPS2) $(NAME2)_tb.v

	#-- Compilar
	iverilog $^ -o $(NAME2)_tb.out

	#-- Simular
	./$(NAME2)_tb.out

	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $@ $(NAME2)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME2).bin: $(NAME2).pcf $(NAME2).v $(DEPS2)

	#-- Sintesis
	# yosys -p "synth_ice40 -blif $(NAME2).blif" $(NAME2).v $(DEPS2)
	yosys -p 'synth_ice40 -top $(NAME2) -json $(NAME2).json' $(NAME2).v $(DEPS2)

	#-- Place & route
	# arachne-pnr -d 1k -p $(NAME2).pcf $(NAME2).blif -o $(NAME2).txt
	nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME2).json --pcf $(NAME2).pcf --asc $(NAME2).asc

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME2).asc $(NAME2).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash2:
	iceprog -d i:0x0403:0x6010:0 $(NAME2).bin


sim3: $(NAME3)_tb.vcd

#-----------------------------------------------
#-  make sint
#-----------------------------------------------
#-  Objetivo para realizar la sintetis completa
#- y dejar el diseno listo para su grabacion en
#- la FPGA
#-----------------------------------------------
sint3: $(NAME3).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME3)_tb.vcd: $(NAME3).v $(DEPS3) $(NAME3)_tb.v

	#-- Compilar
	iverilog $^ -o $(NAME3)_tb.out

	#-- Simular
	./$(NAME3)_tb.out

	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $@ $(NAME3)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME3).bin: $(NAME3).pcf $(NAME3).v $(DEPS3)

	#-- Sintesis
	# yosys -p "synth_ice40 -blif $(NAME3).blif" $(NAME3).v $(DEPS3)
	yosys -p 'synth_ice40 -top $(NAME3) -json $(NAME3).json' $(NAME3).v $(DEPS3)

	#-- Place & route
	# arachne-pnr -d 1k -p $(NAME3).pcf $(NAME3).blif -o $(NAME3).txt
	nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME3).json --pcf $(NAME3).pcf --asc $(NAME3).asc

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME3).asc $(NAME3).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash3:
		iceprog -d i:0x0403:0x6010:0 $(NAME3).bin

#-- Limpiar todo
clean:
	rm -f *.bin *.asc *.json *.out *.vcd *~

.PHONY: all clean

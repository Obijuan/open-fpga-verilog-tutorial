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
	yosys -p "synth_ice40 -blif $(NAME).blif" $(NAME).v $(DEPS)

	#-- Place & route
	arachne-pnr -d 1k -p $(NAME).pcf $(NAME).blif -o $(NAME).txt

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME).txt $(NAME).bin



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
	yosys -p "synth_ice40 -blif $(NAME2).blif" $(NAME2).v $(DEPS2)

	#-- Place & route
	arachne-pnr -d 1k -p $(NAME2).pcf $(NAME2).blif -o $(NAME2).txt

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME2).txt $(NAME2).bin




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
	yosys -p "synth_ice40 -blif $(NAME3).blif" $(NAME3).v $(DEPS3)

	#-- Place & route
	arachne-pnr -d 1k -p $(NAME3).pcf $(NAME3).blif -o $(NAME3).txt

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME3).txt $(NAME3).bin



#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean

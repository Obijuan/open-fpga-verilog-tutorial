#----------------------------------------
#-- Establecer nombre del componente
#----------------------------------------
NAME = inv
NAME2 = inv2


#-------------------------------------------------------
#-- Objetivo por defecto: hacer simulacion y sintesis
#-------------------------------------------------------
all: sim sint sim2 sint2
	
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
$(NAME)_tb.vcd: $(NAME).v $(NAME)_tb.v
	
	#-- Compilar
	iverilog $^ -o $(NAME)_tb.out
	
	#-- Simular
	./$(NAME)_tb.out
	
	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $@ $(NAME)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME).bin: $(NAME).pcf $(NAME).v 
	
	#-- Sintesis
	yosys -p "synth_ice40 -blif $(NAME).blif" $(NAME).v
	
	#-- Place & route
	arachne-pnr -d 1k -p $(NAME).pcf $(NAME).blif -o $(NAME).txt
	
	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME).txt $(NAME).bin


#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean



#----------------------------------------------
#-- make sim
#----------------------------------------------
#-- Objetivo para hacer la simulacion del
#-- banco de pruebas
#----------------------------------------------
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
$(NAME2)_tb.vcd: $(NAME2).v $(NAME2)_tb.v
	
	#-- Compilar
	iverilog $^ -o $(NAME2)_tb.out
	
	#-- Simular
	./$(NAME2)_tb.out
	
	#-- Ver visualmente la simulacion con gtkwave
	gtkwave $@ $(NAME2)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME2).bin: $(NAME2).pcf $(NAME2).v 
	
	#-- Sintesis
	yosys -p "synth_ice40 -blif $(NAME2).blif" $(NAME2).v
	
	#-- Place & route
	arachne-pnr -d 1k -p $(NAME2).pcf $(NAME2).blif -o $(NAME2).txt
	
	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME2).txt $(NAME2).bin



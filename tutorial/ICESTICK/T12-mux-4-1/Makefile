#----------------------------------------
#-- Establecer nombre del componente
#----------------------------------------
NAME = mux4
DEPS = prescaler.v



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
$(NAME).bin: $(NAME).pcf $(NAME).v 
	
	#-- Sintesis
	yosys -p "synth_ice40 -blif $(NAME).blif" $(NAME).v $(DEPS)
	
	#-- Place & route
	arachne-pnr -d 1k -p $(NAME).pcf $(NAME).blif -o $(NAME).txt
	
	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME).txt $(NAME).bin


#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean


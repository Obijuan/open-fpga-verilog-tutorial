#----------------------------------------
#-- Establecer nombre del componente
#----------------------------------------
NAME = counter



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
	arachne-pnr -d 8k -P ct256 -p $(NAME).pcf $(NAME).blif -o $(NAME).txt
	
	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME).txt $(NAME).bin

formal: $(NAME).smt2
	yosys-smtbmc $(NAME).smt2
	yosys-smtbmc -i $(NAME).smt2

$(NAME).smt2:
	yosys -ql $(NAME).yslog \
	-p "read_verilog -formal $(NAME).v" \
	-p "prep -top $(NAME) -nordff" \
	-p "write_smt2 $(NAME).smt2"

#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *.smt2 *~

.PHONY: all clean


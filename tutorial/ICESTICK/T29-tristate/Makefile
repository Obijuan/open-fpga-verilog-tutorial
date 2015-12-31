#----------------------------------------
#-- Establecer nombre del componente
#----------------------------------------
NAME = tristate1
DEPS = divider.v

NAME2 = tristate2
DEPS2 = dividerp1.v

NAME3 = error1
DEPS3 =

NAME4 = error2
DEPS4 =

NAME5 = error3
DEPS5 =

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


sim4: $(NAME4)_tb.vcd

sint4: $(NAME4).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME4)_tb.vcd: $(NAME4).v $(DEPS4) $(NAME4)_tb.v

		#-- Compilar
		iverilog $^ -o $(NAME4)_tb.out

		#-- Simular
		./$(NAME4)_tb.out

		#-- Ver visualmente la simulacion con gtkwave
		gtkwave $@ $(NAME4)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME4).bin: $(NAME4).pcf $(NAME4).v $(DEPS4)

		#-- Sintesis
		yosys -p "synth_ice40 -blif $(NAME4).blif" $(NAME4).v $(DEPS4)

		#-- Place & route
		arachne-pnr -d 1k -p $(NAME4).pcf $(NAME4).blif -o $(NAME4).txt

		#-- Generar binario final, listo para descargar en fgpa
		icepack $(NAME4).txt $(NAME4).bin

sim5: $(NAME5)_tb.vcd
sint5: $(NAME5).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME5)_tb.vcd: $(NAME5).v $(DEPS5) $(NAME5)_tb.v

				#-- Compilar
				iverilog $^ -o $(NAME5)_tb.out

				#-- Simular
				./$(NAME5)_tb.out

				#-- Ver visualmente la simulacion con gtkwave
				gtkwave $@ $(NAME5)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME5).bin: $(NAME5).pcf $(NAME5).v $(DEPS5)

				#-- Sintesis
				yosys -p "synth_ice40 -blif $(NAME5).blif" $(NAME5).v $(DEPS5)

				#-- Place & route
				arachne-pnr -d 1k -p $(NAME5).pcf $(NAME5).blif -o $(NAME5).txt

				#-- Generar binario final, listo para descargar en fgpa
				icepack $(NAME5).txt $(NAME5).bin

#----------------------------------------------------
sim6: $(NAME6)_tb.vcd
sint6: $(NAME6).bin

#-------------------------------
#-- Compilacion y simulacion
#-------------------------------
$(NAME6)_tb.vcd: $(NAME6).v $(DEPS6) $(NAME6)_tb.v

				#-- Compilar
				iverilog $^ -o $(NAME6)_tb.out

				#-- Simular
				./$(NAME6)_tb.out

				#-- Ver visualmente la simulacion con gtkwave
				gtkwave $@ $(NAME6)_tb.gtkw &

#------------------------------
#-- Sintesis completa
#------------------------------
$(NAME6).bin: $(NAME6).pcf $(NAME6).v $(DEPS6)

				#-- Sintesis
				yosys -p "synth_ice40 -blif $(NAME6).blif" $(NAME6).v $(DEPS6)

				#-- Place & route
				arachne-pnr -d 1k -p $(NAME6).pcf $(NAME6).blif -o $(NAME6).txt

				#-- Generar binario final, listo para descargar en fgpa
				icepack $(NAME6).txt $(NAME6).bin





#-- Limpiar todo
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~

.PHONY: all clean

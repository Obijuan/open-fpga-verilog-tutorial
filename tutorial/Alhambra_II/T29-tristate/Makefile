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
	yosys -p 'synth_ice40 -top $(NAME) -json $(NAME).json' $(NAME).v $(DEPS)

	#-- Place & route
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
	yosys -p 'synth_ice40 -top $(NAME2) -json $(NAME2).json' $(NAME2).v $(DEPS2)

	#-- Place & route
	nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME2).json --pcf $(NAME2).pcf --asc $(NAME2).asc

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME2).asc $(NAME2).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash2:
	iceprog -d i:0x0403:0x6010:0 $(NAME2).bin

sim2: $(NAME2)_tb.vcd


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
	yosys -p 'synth_ice40 -top $(NAME3) -json $(NAME3).json' $(NAME3).v $(DEPS3)

	#-- Place & route
	nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME3).json --pcf $(NAME3).pcf --asc $(NAME3).asc

	#-- Generar binario final, listo para descargar en fgpa
	icepack $(NAME3).asc $(NAME3).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash3:
	iceprog -d i:0x0403:0x6010:0 $(NAME3).bin

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
		yosys -p 'synth_ice40 -top $(NAME4) -json $(NAME4).json' $(NAME4).v $(DEPS4)

		#-- Place & route
		nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME4).json --pcf $(NAME4).pcf --asc $(NAME4).asc

		#-- Generar binario final, listo para descargar en fgpa
		icepack $(NAME4).asc $(NAME4).bin

#------------------------------
#-- Upload the bitsream to board
#------------------------------
flash4:
		iceprog -d i:0x0403:0x6010:0 $(NAME4).bin

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
				yosys -p 'synth_ice40 -top $(NAME5) -json $(NAME5).json' $(NAME5).v $(DEPS5)

				#-- Place & route
				nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME5).json --pcf $(NAME5).pcf --asc $(NAME5).asc

				#-- Generar binario final, listo para descargar en fgpa
				icepack $(NAME5).asc $(NAME5).bin

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
				yosys -p 'synth_ice40 -top $(NAME6) -json $(NAME6).json' $(NAME6).v $(DEPS6)

				#-- Place & route
				nextpnr-ice40 --hx8k --package tq144:4k --json $(NAME6).json --pcf $(NAME6).pcf --asc $(NAME6).asc

				#-- Generar binario final, listo para descargar en fgpa
				icepack $(NAME6).asc $(NAME6).bin





#-- Limpiar todo
clean:
	rm -f *.bin *.asc *.json *.out *.vcd *~

.PHONY: all clean

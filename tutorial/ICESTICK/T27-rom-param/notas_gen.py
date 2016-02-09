#------------------------------------------------------------------------------
#-- Generacion automatica de las tablas con las frecuencias y valores
#-- de los divisores para tocas todas las notas musicales en la iCEstick
#--
#-- Genera todas las constantes en formato Verilog, para poder incluir
#-- la tabla directametne en nuestros programas
#------------------------------------------------------------------------------
#-- (C) BQ. September-2015. Written by Juan Gonzalez (Obijuan)
#------------------------------------------------------------------------------
import math as m

#---------------------------------------------
#-- octavas: 0 - 10
#-- Notas: 1 - 12
#--    1 - DO
#--    2 - DO#
#--    3 - RE
#--    4 - RE#
#--    5 - MI
#--    6 - FA
#--    7 - FA#
#--    8 - SOL
#--    9 - SOL#
#--    10 - LA
#--    11 - LA#
#--    12 - SI

##-- Diccionario con los nombres de las notas
nname = {1: 'DO',   2: 'DOs', 3: 'RE',   4 : 'REs',
         5: 'MI',   6: 'FA',  7: 'FAs',  8: 'SOL',
         9: 'SOLs', 10: 'LA', 11: 'LAs', 12: 'SI'};

#-- Calcular la frecuencia de una nota de una octava
def freq(note, octave = 4):
	return 440.0 * m.exp(((octave-4)+(note-10)/12.0) * m.log(2))
	
#-- Calcular el valor del divisor para tocar la nota en la FPGA
#-- de la placa iCEstick
def divisor(note, octave = 4):
	return int(round(12000000 / (2*freq(note, octave))))

#-- Imprimir la table, con salida verilog
def print_table(octave = 4):
	print("//-- Octava: {}".format(octave))
	for note in range(12):
		#-- Print table in verilog sintax
		print("`define {}_{} {:X} //-- {:.3f} Hz".format(
		       nname[note + 1], 
		       octave, 
		       divisor(note+1, octave), 
		       freq(note+1, octave)))
	print("\n")

#-- Programa principal
#-- Sacar la tabla por la pantalla
for oct in range(11):
	print_table(oct)






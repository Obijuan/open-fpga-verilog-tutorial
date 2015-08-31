import math as m

#---------------------------------------------
#-- octaves: 0 - 10
#-- Notes: 1 - 12
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

##-- Dictionary with note's names
nname = {1: 'DO',   2: 'DOs', 3: 'RE',   4 : 'REs',
         5: 'MI',   6: 'FA',  7: 'FAs',  8: 'SOL',
         9: 'SOLs', 10: 'LA', 11: 'LAs', 12: 'SI'};

#-- Calculate the frequency of a given note, in the given octave
def freq(note, octave = 4):
	return 440.0 * m.exp(((octave-4)+(note-10)/12.0) * m.log(2))
	
#-- Calculate the divisor value for playing the note in the
#-- iCEstick FPGA board	
def divisor(note, octave = 4):
	return int(m.ceil(12000000 / freq(note, octave)))

#-- Print the table of notes, frequencies and divisor values
def print_table(octave = 4):
	print("//-- Octava: {}".format(octave))
	for note in range(12):
		#-- Print table in verilog sintax
		print("`define {}_{} {} //-- {:.3f} Hz".format(
		       nname[note + 1], 
		       octave, 
		       divisor(note+1, octave), 
		       freq(note+1, octave)))
	print("\n")

#-- Main proggram	
#-- Print the note table as verilog code
for oct in range(11):
	print_table(oct)






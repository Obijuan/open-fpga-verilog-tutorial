#------------------------------------------------------
# Create a rom memory with the given string stored
#------------------------------------------------------
# (c) BQ october 2015. Written by Juan gonzalez (obijuan)
#--------------------------------------------------------

##-- String to store into the rom
cad = " ola k ase......"

##-- output the characters as hexadecimal numbers
##-- one per row
for c in cad:
  print("{:X}".format(ord(c)))



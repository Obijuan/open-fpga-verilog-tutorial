# ---
# --  Ensamblador para MICROBIO
# --  Python 3

# -- Microbio Nemonic list
nemonic = ["WAIT", "HALT", "LEDS", "JP"]

# -- Symbol table. It is used for storing the pairs label - address
simtable = {}

# -- Program: AST
prog = []

# -- Current address
addr = 0


class Instruction:
    """Microbio instruction class"""

    def __init__(self, co, dat):
        """Create the instruction from the co and dat fields"""
        self._co = co
        self._dat = dat
        self._addr = 0

    def mcode(self):
        """Return the machine code"""

        return (self._co << 6) + self._dat

    def __str__(self):
        """Print the instruction"""
        if nemonic[self._co] in ["LEDS", "JP"]:
            return "{} 0x{:X}".format(nemonic[self._co], self._dat)
        else:
            return nemonic[self._co]


def is_comment_cad(cad):
    """Return True if the string is a comment"""

    # -- At least the string len should be 2 for being a comment
    if len(cad) < 2:
        return False

    comment = cad[0:2]
    if (comment == "//"):
        return True
    else:
        return False


def is_comment(line):
    """Return True if the line is a comment or a blank"""

    # -- Divide the line into words
    lwords = line.split()

    # -- A blank line is considered a comment
    if len(lwords) == 0:
        return True

    return is_comment_cad(lwords[0])


def is_label(word):
    """Return True if the word is a label"""
    list = word.split(":")
    if (len(list) == 2 and list[1] == ''):
        return True
    else:
        return False


def is_instruction_cad(cad):
    inst = cad.upper()
    if inst in nemonic:
        return True, inst
    else:
        return False


def is_instruction(line):
    if len(line) == 0:
        return False, ""

    cad = line[0]
    return is_instruction_cad(cad)


def remove_comments(line):
    """Return the same line without comments
       The line is a list of strings
    """

    new = []
    for cad in line:
        if is_comment_cad(cad):
            break
        else:
            new.append(cad)

    return new


def is_hexdigit(dat):
    dat_list = dat.upper()
    return dat_list[0:2] == "0X"


def parse_dat(dat):
    if dat.isdigit():
        return True, int(dat)

    if is_hexdigit(dat):
        return True, int(dat, 16)

    return False, 0


def parse_instruction(line):

    if line[0] == "LEDS" or line[0] == "JP":
        co = nemonic.index(line[0])
        dat = parse_dat(line[1])
        return True, co, dat

    if line[0] == "HALT" or line[0] == "WAIT":
        co = nemonic.index(line[0])
        return True, co, 0

    return False, 0, 0


def parse_arguments():
    """Parse the arguments, open the asm file and return the raw contents"""

    import argparse
    description = """
        Microbio assembler. The prog.list file with the machine code is generated output
    """
    # -- Add the assembler description
    parser = argparse.ArgumentParser(description=description)

    # -- Add the assembler argument: asmfile
    parser.add_argument("asmfile", help="Microbio asembly file (.asm)")

    # -- Parse the anguments
    args = parser.parse_args()

    # -- File to assembly
    asmfile = args.asmfile

    # -- Read the file
    with open(asmfile, mode='r') as f:
        raw = f.read()

    return raw


def parse_label(label):
    # -- Insert the label in the symbol table
    simtable[label] = addr


def parse_line(line, nline):
    global addr
    words = line.split()

    # -- Check if the first word is a label
    if is_label(words[0]):

        # -- Parse the label
        parse_label(words[0])

        # -- Remove the label from the words list to parser
        words = words[1:]

        # -- If there is no more words, the line is finished
        if len(words) == 0:
            return True

    # -- If there is a comment, the line is ignored
    if is_comment_cad(words[0]):
        return True

    # -- If it is reached, it should be a instruction
    # -- Parse the instruction
    if not words[0] in nemonic:
        print("ERROR: Unkwown instruction {} in line {}".format(words[0], nline))
        return False

    if words[0] == "HALT" or words[0] == "WAIT":
        # -- Get the opcode
        co = nemonic.index(words[0])

        # -- Create the instruction
        inst = Instruction(co, 0)

        # -- Insert in the AST tree
        prog.append(inst)

        # -- Increment the address
        addr += 1
        return True

    # -- It should be the LEDS or JP instruction
    # -- There should be al least two more words: for the nemonic and the data
    if len(words) == 1:
        print("ERROR: No data for the instruction {} in line {}".format(words[0], nline))
        return False

    # -- Read the opcode
    co = nemonic.index(words[0])

    # -- Read the data
    okdat, dat = parse_dat(words[1])

    # -- Invalid data
    if not okdat:
        print("ERROR: Invalid data for the instruction {} in line {}".format(words[0], nline))
        return False

    # -- Create the instruction
    inst = Instruction(co, dat)

    # -- Insert in the AST tree
    prog.append(inst)

    # -- Increment the address
    addr += 1

    return True


if __name__ == "__main__":

    # -- Read the raw file. It returns a list of lines
    rawlines = parse_arguments().splitlines()
    # print(rawlines)
    print()

    for i, line in enumerate(rawlines):

        # -- If the whole line is a comment, ignore it!
        if (is_comment(line)):
            continue

        # print("[{}] {}".format(i+1, line))
        # print("[{}] {}".format(i+1, line.split()))
        # -- Parse line
        if not parse_line(line, i+1):
            break

    """
    for line in rawlines:
        listline = line.split()
        if (not is_comment_line(listline)):
            listline2 = remove_comments(listline)
            ok, inst = is_instruction(listline2)
            if (ok):
                ok, co, dat = parse_instruction(listline2)
                inst = Instruction(co, dat)
                prog.append(inst)
    """

    # -- Print the symbol table
    print()
    print("Symbol table:")
    for key in simtable:
        print("{} = {}".format(key, simtable[key]))

    # -- Print the parsed code
    print()
    print("Microbio assembly program:\n")
    for inst in prog:
        print(inst)

    # -- Print the machine cod
    print()
    print("Machine code:\n")
    for inst in prog:
        print("{:02X}   //-- {}".format(inst.mcode(), inst.__str__()))

    # -- Write the machine code in the prog.list file
    with open("prog.list", mode='w') as f:
        for inst in prog:
            f.write("{:02X}   //-- {}\n".format(inst.mcode(), inst.__str__()))

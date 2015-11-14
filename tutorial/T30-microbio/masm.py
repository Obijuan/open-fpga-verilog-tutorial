# ---
# --  Ensamblador para MICROBIO
# --  Python 3

# -- Microbio Nemonic list
nemonic = ["WAIT", "HALT", "LEDS", "JP"]

# -- Assembler directives
ORG = "ORG"

# -- default output file
OUTPUT_FILE = "prog.list"

# -- Symbol table. It is used for storing the pairs label - address
simtable = {}

# -- Program: AST
prog = []

# -- Current address
addr = 0


class Instruction:
    """Microbio instruction class"""

    def __init__(self, co, dat, addr, nline=0, label=""):
        """Create the instruction from the co and dat fields"""
        self._co = co
        self._dat = dat
        self._addr = addr    # Address where the instruction should be placed
        self.label = label
        self.nline = nline

    def mcode(self):
        """Return the machine code"""

        return (self._co << 6) + self._dat

    def __str__(self):
        """Print the instruction"""
        saddr = "[{:02X}]".format(self._addr)
        if nemonic[self._co] in ["LEDS", "JP"]:
            return "{} {} 0x{:X}".format(saddr, nemonic[self._co], self._dat)
        else:
            return "{} {}".format(saddr, nemonic[self._co])


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
        Microbio assembler. The prog.list file with the machine code is \
        generated output
    """
    # -- Add the assembler description
    parser = argparse.ArgumentParser(description=description)

    # -- Add the assembler argument: asmfile
    parser.add_argument("asmfile", help="Microbio asembly file (.asm)")
    parser.add_argument("-verbose", help="verbose mode on", action="store_true")

    # -- Parse the anguments
    args = parser.parse_args()

    # -- File to assembly
    asmfile = args.asmfile

    # -- Read the file
    with open(asmfile, mode='r') as f:
        raw = f.read()

    return raw.upper(), args.verbose


def parse_label(label):
    # -- Insert the label in the symbol table
    simtable[label[:-1]] = addr


def parse_line(line, nline):
    global addr
    words = line.split()

    # print("Parsing: {}".format(words))

    # -- check if it is an ORG directive
    if words[0] == ORG:
        # -- Check that there one more word (for the argument)
        if (len(words) == 1):
            print("ERROR: No address is given after ORG in line {}".format(nline))
            return False

        # -- Read the argument. It should be a number
        # -- Read the data
        okdat, dat = parse_dat(words[1])

        # -- Invalid data
        if not okdat:
            print("ERROR: ORG {}: Invalid address in line {}".format(words[1], nline))
            return False

        # -- Update the address
        addr = dat

        # -- Check that there are no more instruccion in the same line
        # -- Except comments
        words = words[2:]

        # -- If no more words to parse, return
        if len(words) == 0:
            return True

        if is_comment_cad(words[0]):
            return True
        else:
            print("Syntax error in line {}: Unknow command {}".format(nline, words[0]))
            return False

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
        inst = Instruction(co, 0, addr)

        # -- Insert in the AST tree
        prog.append(inst)

        # -- Increment the address
        addr += 1

        # -- Check that there are only comments or nothing after these nemonics
        words = words[1:]

        # -- If no more words to parse, return
        if len(words) == 0:
            return True

        if is_comment_cad(words[0]):
            return True
        else:
            print("Syntax error in line {}: Unknow command".format(nline))
            return False

    # -- It should be the LEDS or JP instruction
    # -- There should be al least two more words: for the nemonic and the data
    if len(words) == 1:
        print("ERROR: No data for the instruction {} in line {}".format(words[0], nline))
        return False

    # -- Read the opcode
    co = nemonic.index(words[0])
    label = ""

    # -- Parse the LEDS instruction
    if words[0] == "LEDS":
        # -- Read the data
        okdat, dat = parse_dat(words[1])

        # -- Invalid data
        if not okdat:
            print("ERROR: Invalid data for the instruction {} in line {}".format(words[0], nline))
            return False

    # -- Parse the JP instruction
    if words[0] == "JP":
        # -- Read the data
        okdat, dat = parse_dat(words[1])

        # -- Invalid data
        if not okdat:
            # -- Check if words[1] is a label
            label = words[1]
            # dat = simtable[words[1]]

    # -- Create the instruction
    inst = Instruction(co, dat, addr, nline, label)

    # -- Insert in the AST tree
    prog.append(inst)

    # -- Increment the address
    addr += 1

    # -- Remove the processed words
    words = words[2:]

    # -- If no more words to parse, return
    if len(words) == 0:
        return True

    # -- There can only be comments. If not, it is a syntax error
    if is_comment_cad(words[0]):
        return True
    else:
        print("Syntax error in line {}: Unknow command".format(nline))
        return False


if __name__ == "__main__":

    parse_ok = True

    # -- Read the raw file. It returns a list of lines
    rawlines, verbose = parse_arguments()
    rawlines = rawlines.splitlines()
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
            parse_ok = False
            break

    if parse_ok:

        # -- Check if all the labels are ok
        for inst in prog:
            if (inst._co == nemonic.index("JP")):
                try:
                    inst._dat = simtable[inst.label]
                except KeyError:
                    print("ERROR: Label {} unknow in line {}".format(inst.label, inst.nline))
                    import sys
                    sys.exit()

        if verbose:
            # -- Print the symbol table
            print()
            print("Symbol table:\n")
            for key in simtable:
                print("{} = 0x{:02X}".format(key, simtable[key]))

            # -- Print the parsed code
            print()
            print("Microbio assembly program:\n")
            for inst in prog:
                print("{}".format(inst))

        # -- Print the machine cod
        if verbose:
            print()
            print("Machine code:\n")

        # -- Write the machine code in the prog.list file
        addr = 0
        with open(OUTPUT_FILE, mode='w') as f:
            for inst in prog:
                output = ""
                if addr != inst._addr:
                    # -- There is a gap in the addresses
                    output = "@{:02X}\n".format(inst._addr)
                    addr = inst._addr

                output += "{:02X}   //-- {}".format(inst.mcode(), inst)
                f.write(output+"\n")
                addr += 1
                if verbose:
                    print(output)

        print("\nFile {} successfully generated".format(OUTPUT_FILE))

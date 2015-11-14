# ---
# --  Ensamblador para MICROBIO
# --  Python 3
import sys


class Prog(object):
    def __init__(self):
        self.dir = 0   # -- Current address
        self.linst = []  # -- List of instructions

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
prog2 = Prog()

# -- Current address
addr = 0


class SyntaxError(Exception):
    def __init__(self, value, msg, nline):
        self.value = value
        self.msg = msg
        self.nline = nline


class Instruction(object):
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
    if is_label(label):
        # -- Inset the label in the symbol table
        # -- TODO: Check for duplicates!
        simtable[label[:-1]] = prog2.dir
        return True
    else:
        return False


def parse_org(lwords, nline):
    if not lwords[0] == "ORG":
        return False

    if len(lwords) == 1:
        msg = "ERROR: No address is given after ORG in line {}".format(nline)
        raise SyntaxError(0, msg, nline)

    # -- Read the argument. It should be a number
    okdat, dat = parse_dat(lwords[1])

    # -- Invalid data
    if not okdat:
        msg = "ERROR: ORG {}: Invalid address in line {}".format(lwords[1], nline)
        raise SyntaxError(0, msg, nline)

    # -- Update the address
    global addr
    addr = dat
    prog2.dir = dat

    # -- Check that there are no more instruccion in the same line
    # -- Except comments
    lwords = lwords[2:]

    # -- If no more words to parse, return
    if len(lwords) == 0:
        return True

    if is_comment_cad(lwords[0]):
        return True
    else:
        msg = "Syntax error in line {}: Unknow command {}".format(nline, lwords[0])
        raise SyntaxError(0, msg, nline)


def parse_instruction(lwords, nline):
    if not lwords[0] in nemonic:
        msg = "ERROR: Unkwown instruction {} in line {}".format(lwords[0], nline)
        raise SyntaxError(0, msg, nline)


def parse_line(line,  nline):
    global addr
    words = line.split()

    # -- Check if the line was an ORG directive
    if parse_org(words, nline):
        return

    # -- Check if the word is a label
    if parse_label(words[0]):
        words = words[1:]
        if len(words) == 0:
            return

    # -- If there is a comment, the line is ignored
    if is_comment_cad(words[0]):
        return

    # -- Parse the instruction
    parse_instruction(words, nline)

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
    prog2.dir += 1
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

        # -- Parse line
        try:
            parse_line(line, i+1)
        except SyntaxError as e:
            print(e.msg)
            sys.exit()
            break

    if parse_ok:

        # -- Check if all the labels are ok
        for inst in prog:
            if (inst._co == nemonic.index("JP")):
                try:
                    inst._dat = simtable[inst.label]
                except KeyError:
                    print("ERROR: Label {} unknow in line {}".format(inst.label, inst.nline))
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

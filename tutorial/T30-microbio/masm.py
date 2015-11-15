# ---
# --  Ensamblador para MICROBIO
# --  Python 3
import sys


class Prog(object):
    """Abstract syntax Tree for the assembled program"""

    def __init__(self):
        self.addr = 0   # -- Current address
        self.linst = []  # -- List of instructions

    def add_instruction(self, inst):
        """Add the instruction in the current address. The current dir is incremented
        """

        # -- Assign the current address
        inst.addr = self.addr

        # -- Insert the instruction
        self.linst.append(inst)

        # -- Increment the current address
        self.addr += 1

    def __str__(self):
        """Print the current program (in assembly language)"""
        str = ""
        for inst in self.linst:
            str += "{}\n".format(inst)

        return str

    def machine_code(self):
        """Generate the program in microbio machine code"""

        addr = 0
        code = ""
        for inst in self.linst:
            inst_ascii = ""
            if addr != inst.addr:
                # -- There is a gap in the addresses
                inst_ascii = "@{:02X}\n".format(inst.addr)
                addr = inst.addr

            inst_ascii += "{:02X}   //-- {}".format(inst.mcode(), inst)
            code += inst_ascii + "\n"
            addr += 1

        return code


class Instruction(object):
    """Microbio instruction class"""

    def __init__(self, co, dat, addr=0, label=""):
        """Create the instruction from the co and dat fields"""
        self._co = co       # -- Opcode
        self._dat = dat     # -- Instruction argument
        self.addr = addr    # -- Address where the instruction is stored in memory
        self.label = label  # -- Label (if any)

    def mcode(self):
        """Return the machine code"""
        return (self._co << 6) + self._dat

    def __str__(self):
        """Print the instruction"""
        saddr = "[{:02X}]".format(self.addr)
        if nemonic[self._co] in ["LEDS", "JP"]:
            return "{} {} 0x{:X}".format(saddr, nemonic[self._co], self._dat)
        else:
            return "{} {}".format(saddr, nemonic[self._co])


class SyntaxError(Exception):
    def __init__(self, msg, nline):
        self.msg = msg
        self.nline = nline


# -- Microbio Nemonic list
nemonic = ["WAIT", "HALT", "LEDS", "JP"]

# -- Assembler directives
ORG = "ORG"

# -- Symbol table. It is used for storing the pairs label - address
simtable = {}


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


def parse_label(prog, label):
    if is_label(label):
        # -- Inset the label in the symbol table
        # -- TODO: Check for duplicates!
        simtable[label[:-1]] = prog.addr
        return True
    else:
        return False


def parse_org(prog, lwords, nline):
    if not lwords[0] == "ORG":
        return False

    if len(lwords) == 1:
        msg = "ERROR: No address is given after ORG in line {}".format(nline)
        raise SyntaxError(msg, nline)

    # -- Read the argument. It should be a number
    okdat, dat = parse_dat(lwords[1])

    # -- Invalid data
    if not okdat:
        msg = "ERROR: ORG {}: Invalid address in line {}".format(lwords[1], nline)
        raise SyntaxError(msg, nline)

    # -- Update the address
    prog.addr = dat

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
        raise SyntaxError(msg, nline)


def parse_instruction_arg0(prog, lwords, nline):
    """Parse the instruction that have no arguments: HALT and WAIT
    """
    if (lwords[0] == "HALT" or lwords[0] == "WAIT"):
        # -- Get the opcode
        co = nemonic.index(lwords[0])

        # -- Create the instruction
        inst = Instruction(co, 0)

        # -- Insert in the AST tree
        prog.add_instruction(inst)

        # -- Check that there are only comments or nothing after these nemonics
        lwords = lwords[1:]

        # -- If no more words to parse, return
        if len(lwords) == 0:
            return True

        if is_comment_cad(lwords[0]):
            return True
        else:
            msg = "Syntax error in line {}: Unknow command".format(nline)
            raise SyntaxError(msg, nline)
            return False
    else:
        # -- The instructions are not HALT or WAIT
        return False


def parse_instruction_leds(prog, lwords, nline):
    # -- Parse the LEDS instruction
    if lwords[0] == "LEDS":
        # -- Read the data
        okdat, dat = parse_dat(lwords[1])

        # -- Invalid data
        if not okdat:
            msg = "ERROR: Invalid data for the instruction {} in line {}".format(lwords[0], nline)
            raise SyntaxError(msg, nline)

        # -- Read the opcode
        co = nemonic.index(lwords[0])

        # -- Create the instruction
        inst = Instruction(co, dat)

        # -- Insert in the AST tree
        prog.add_instruction(inst)

        return True

    else:
        return False


def parse_instruction_jp(prog, lwords, nline):
    # -- Parse the JP instruction
    if lwords[0] == "JP":
        # -- Read the data
        okdat, dat = parse_dat(lwords[1])
        label = ""

        # -- Invalid number: it should be a label
        if not okdat:
            # -- Check if words[1] is a label
            label = lwords[1]
            # dat = simtable[words[1]]

        # -- Read the opcode
        co = nemonic.index(lwords[0])

        # -- Create the instruction
        inst = Instruction(co, dat, label=label)

        # -- Insert in the AST tree
        prog.add_instruction(inst)

        return True

    else:
        return False


def parse_instruction_arg1(prog, lwords, nline):
    """Parse the instructions with 1 argument: LEDS and JP
    """
    # -- Check that there are at least 2 words in the line (1 for the nemonic and
    # -- one for the argument. If not, raise an exception)
    if len(lwords) == 1:
        msg = "ERROR: No data for the instruction {} in line {}".format(lwords[0], nline)
        raise SyntaxError(msg, nline)

    # -- Parse the leds instruction
    parse_instruction_leds(prog, lwords, nline)

    # -- Parse the jp instruction
    parse_instruction_jp(prog, lwords, nline)

    # -- Parse the comments, if any
    lwords = lwords[2:]

    # -- If no more words to parse, return
    if len(lwords) == 0:
        return True

    # -- There can only be comments. If not, it is a syntax error
    if is_comment_cad(lwords[0]):
        return True
    else:
        msg = "Syntax error in line {}: Unknow command".format(nline)
        raise SyntaxError(msg, nline)

    return False


def parse_instruction(prog, lwords, nline):

    # -- Check if the first word is a correct nemonic
    if not lwords[0] in nemonic:
        msg = "ERROR: Unkwown instruction {} in line {}".format(lwords[0], nline)
        raise SyntaxError(0, msg, nline)

    # -- Check if it is a nenomic with no arguments (WAIT or HALT)
    if parse_instruction_arg0(prog, lwords, nline):
        return True

    # -- Check if it is a nenomic with 1 argument (LEDS, JP)
    if parse_instruction_arg1(prog, lwords, nline):
        return True

    return False


def parse_line(prog, line,  nline):
    global addr
    words = line.split()

    # -- Check if the line was an ORG directive
    if parse_org(prog, words, nline):
        return

    # -- Check if the word is a label
    if parse_label(prog, words[0]):
        words = words[1:]
        if len(words) == 0:
            return

    # -- If there is a comment, the line is ignored
    if is_comment_cad(words[0]):
        return

    # -- Parse the instruction
    if parse_instruction(prog, words, nline):
        return


def syntax_analisis(prog, asmfile):
    """Perform the syntax analisis"""

    asmfile = asmfile.splitlines()

    # -- Syntax analisis: line by line
    for nline, line in enumerate(asmfile):

        # -- If the whole line is a comment, ignore it!
        if (is_comment(line)):
            continue

        # -- Parse line
        try:
            parse_line(prog, line, nline+1)

        # -- There was a syntax error. Print the message and exit
        except SyntaxError as e:
            print(e.msg)
            sys.exit()


if __name__ == "__main__":

    # -- default output file with the machine code for MICROBIO
    OUTPUT_FILE = "prog.list"

    # -- Process the arguments. Return the source file and the verbose flag
    asmfile, verbose = parse_arguments()

    # -- Create a blank AST for storing the processed program
    prog = Prog()

    # -- Perform the sintax analisis. The sintax errors are reported
    # -- In case of errors, it exits
    syntax_analisis(prog, asmfile)

    # -- Semantics analisis: Check if all the labels are ok
    for inst in prog.linst:
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
        print(prog)

        # -- Print the machine cod
        print()
        print("Machine code:\n")
        print(prog.machine_code())

    # -- Write the machine code in the prog.list file
    with open(OUTPUT_FILE, mode='w') as f:
        f.write(prog.machine_code())

    print("\nFile {} successfully generated".format(OUTPUT_FILE))

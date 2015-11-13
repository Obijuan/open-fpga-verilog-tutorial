# ---
# --  Ensamblador para MICROBIO
# --  Python 3

# -- Microbio Nemonic list
nemonic = ["WAIT", "HALT", "LEDS", "JP"]


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


def is_comment_line(listline):
    """Return True if the line is a comment or a blank"""

    # -- A blank line is considered a comment
    if len(listline) == 0:
        return True

    return is_comment_cad(listline[0])


def is_instruction_cad(cad):
    inst = cad.upper()
    if inst in ["LEDS", "HALT"]:
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
        return int(dat)

    if is_hexdigit(dat):
        return int(dat, 16)

    return 0


def parse_instruction(line):

    if line[0] == "LEDS" or line[0] == "JP":
        co = nemonic.index(line[0])
        dat = parse_dat(line[1])
        return True, co, dat

    if line[0] == "HALT" or line[0] == "WAIT":
        co = nemonic.index(line[0])
        return True, co, 0

    return False, 0, 0

if __name__ == "__main__":

    # -- Fichero a ensamblar
    filename = "M0.asm"
    with open(filename, mode='r') as f:
        raw = f.read()

    print()
    prog = []

    l2 = []
    for line in raw.splitlines():
        # print(line)
        listline = line.split()
        if (not is_comment_line(listline)):
            listline2 = remove_comments(listline)
            ok, inst = is_instruction(listline2)
            if (ok):
                ok, co, dat = parse_instruction(listline2)
                inst = Instruction(co, dat)
                prog.append(inst)

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

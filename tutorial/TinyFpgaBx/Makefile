# Makefile borrowed from https://github.com/cliffordwolf/icestorm/blob/master/examples/icestick/Makefile
#
# The following license is from the icestorm project and specifically applies to this file only:
#
#  Permission to use, copy, modify, and/or distribute this software for any
#  purpose with or without fee is hereby granted, provided that the above
#  copyright notice and this permission notice appear in all copies.
#
#  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

TT ?= T01
PP ?= setbit
PROJDIR ?= ../ICESTICK/$(TT)-$(PP)
PROJ := $(PROJDIR)/$(PP)
SRCS := $(filter-out $(wildcard $(PROJDIR)/*_tb.v), $(wildcard $(PROJDIR)/*.v))

PIN_DEF = pins.pcf
DEVICE = lp8k
PKG = cm81

all: $(PROJ).rpt $(PROJ).bin

sim: $(PROJ)_tb.gtkw

$(PROJ)_tb.out: $(PROJ).v $(PROJ)_tb.v $(SRCS)
	iverilog -I . $^ -o $@

%_tb.vcd: %_tb.out
	./$<
	mv *.vcd $(PROJDIR)/

%.gtkw: %.vcd
	gtkwave $< -O $@

#%.blif: %.v *.v 
#	yosys -q -p 'synth_ice40 -top $(PROJ) -blif $@' $^

#%.asc: $(PIN_DEF) %.blif
#	arachne-pnr -d 8k -P $(PKG) -o $@ -p $^

%.json: %.v $(SRCS)
	yosys -q -p 'synth_ice40 -top $(PP) -json $@' $^

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 --pcf-allow-unconstrained --lp8k --package $(PKG) --freq 20 --json $(PROJ).json --pcf $(PIN_DEF) --asc $(PROJ).asc

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

prog: $(PROJ).bin
	tinyprog -p $<

clean:
	rm -f $(PROJ).blif $(PROJ).json $(PROJ).asc $(PROJ).rpt $(PROJ).bin $(PROJ)_tb.out $(PROJ)_tb.vcd $(PROJ)_tb.gtkw 

.SECONDARY:
.PHONY: all prog clean

#gawk sort order
#export LC_CTYPE=C

.SUFFIXES: .asm .o .gb

TEMP_OUTPUT := rgbds_out.txt
# file header
INCLUDE_HEADER ?= 1
SCRATCH_DEST ?= 0
# 

all: clean bootstrap.gb base16out hexout


bootstrap.o: bootstrap.asm
	rgbasm -p 0xff -o bootstrap.o bootstrap.asm | tee $(TEMP_OUTPUT)

bootstrap.gb: bootstrap.o
	rgblink -n bootstrap.sym -l bootstrap.link -o $@ $<

clean:
	rm -f bootstrap.o bootstrap.gb

do: clean bootstrap.gb

base16: clean bootstrap.gb base16out

base16out:
	python char_encode.py $(TEMP_OUTPUT) base16 $(INCLUDE_HEADER) $(SCRATCH_DEST)

hex: clean bootstrap.gb hexout

hexout:
	python char_encode.py $(TEMP_OUTPUT) hex $(INCLUDE_HEADER) $(SCRATCH_DEST)

reversed: clean bootstrap.gb
	python char_encode.py $(TEMP_OUTPUT) reversed $(INCLUDE_HEADER) $(SCRATCH_DEST)
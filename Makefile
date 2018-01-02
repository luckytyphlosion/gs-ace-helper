#gawk sort order
#export LC_CTYPE=C

.SUFFIXES: .asm .o .gb

TEMP_OUTPUT := rgbds_out.txt
all: bootstrap.gb


bootstrap.o: bootstrap.asm
	rgbasm -p 0xff -o bootstrap.o bootstrap.asm &> $(TEMP_OUTPUT)

bootstrap.gb: bootstrap.o
	rgblink -n bootstrap.sym -l bootstrap.link -o $@ $<

clean:
	rm -f bootstrap.o bootstrap.gb

do: clean bootstrap.gb

base16: clean bootstrap.gb
	python char_encode.py $(TEMP_OUTPUT) base16

hex: clean bootstrap.gb
	python char_encode.py $(TEMP_OUTPUT) hex

reversed: clean bootstrap.gb
	python char_encode.py $(TEMP_OUTPUT) reversed
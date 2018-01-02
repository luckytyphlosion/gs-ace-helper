#gawk sort order
#export LC_CTYPE=C

.SUFFIXES: .asm .o .gb

all: bootstrap.gb


bootstrap.o: bootstrap.asm
	rgbasm -p 0xff -o bootstrap.o bootstrap.asm

bootstrap.gb: bootstrap.o
	rgblink -n bootstrap.sym -l bootstrap.link -o $@ $<
	


clean:
	rm -f bootstrap.o bootstrap.gb

do: clean bootstrap.gb

base16: clean bootstrap.gb

hex: clean bootstrap.gb
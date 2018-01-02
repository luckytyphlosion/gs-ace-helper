output = ""
COUNTS = (0xa6,) # (0xc2,0x27)
bytes = None
output = ""

with open("bootstrap.gb", "rb") as f:
	for count in COUNTS:
		bytes = bytearray(f.read(count))
		output += "".join(("%x" % byte).zfill(2) for byte in bytes) + "\n"

with open("dump.asm", "w+") as f:
	f.write(output)

# with open("dump.bin", "wb+") as f:
#	f.write(bytes)
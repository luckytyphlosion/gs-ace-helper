output = ""
COUNTS = (0xa6,)
bytes = None
output = ""

with open("bootstrap.gb", "rb") as f:
	for count in COUNTS:
		bytes = bytearray(f.read(count))
		output += "".join(("%x" % byte).zfill(2) for byte in bytes) + "\n"

with open("dump.asm", "w+") as f:
	f.write(output)
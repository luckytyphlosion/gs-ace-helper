import sys
import os
import errno

# lazy
global_chars = (
	("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P"),
	("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"),
)

def encode_addr(addr):
	encoded_addr = ""
	for i in range(3,-1,-1):
		encoded_addr += chars[(addr >> i * 4) & 0xf]

	return encoded_addr

def rgbds_hex_to_int(hex_str):
	return (int(hex_str.replace("$","").split()[1], 16) if "$" in hex_str else int(hex_str, 16))


reverse_endianness = False
include_file_header = int(sys.argv[3]) == True
scratch_dest = rgbds_hex_to_int(sys.argv[4])


if sys.argv[2] == "base16":
	encoding_type = 0
elif sys.argv[2] == "hex":
	encoding_type = 1
elif sys.argv[2] == "reversed":
	encoding_type = 0
	reverse_endianness = True
	include_file_header = False
else:
	sys.stdout.write("fail 1")
	sys.exit()

chars = global_chars[encoding_type]

with open(sys.argv[1], "r") as f:
	rgbds_out = f.readlines()

include_filename = ""
bootstrap_addr = 0
sram_bank = 0
sram_addr = 0

for line in rgbds_out:
	if line.startswith("include_file "):
		include_filename = os.path.splitext(os.path.basename(line.split('"')[1]))[0]
	elif line.startswith("bootstrap_offset "):
		bootstrap_addr = rgbds_hex_to_int(line)
	elif line.startswith("sram_bank "):
		sram_bank = rgbds_hex_to_int(line)
	elif line.startswith("sram_offset "):
		sram_addr = rgbds_hex_to_int(line)

if include_filename == "" or bootstrap_addr == 0:
	sys.stdout.write("fail 2")
	sys.exit()

if sram_addr == 0:
	include_file_header = False

include_file_header = include_file_header * 1

with open("bootstrap.sym", "r") as f:
	symfile = f.readlines()

bootstrap_len = 0

for line in symfile:
	if line.strip().endswith("EndOfBootstrap"):
		bootstrap_len = int(line.split()[0].split(":")[1], 16)
		break

dump_output = ""

with open("bootstrap.gb", "rb") as f:
	bytes = bytearray(f.read(bootstrap_len))
	dump_output += "".join(("%x" % byte).zfill(2) for byte in bytes) + "\n"

try:
	os.makedirs("outputs")
except OSError as e:
	if e.errno != errno.EEXIST:
		raise

with open("outputs/" + include_filename + "_bytes.txt", "w+") as f:
	f.write(dump_output)

checksum = 0
encode_output = ""

if not reverse_endianness:
	if sram_addr == 0:
		temp_addr = bootstrap_addr
	else:
		temp_addr = sram_addr

	encode_output += "BootstrapHeader: %s%s%s\n" % (
		chr(ord("A") | sram_bank | (1 << 3 if scratch_dest else 0) | (encoding_type << 4)),
		encode_addr(temp_addr),
		chr(ord("A") | include_file_header)
		)

	if scratch_dest:
		encode_output += "ScratchHeader: %s\n" % encode_addr(scratch_dest)
	
	if include_file_header:
		encode_output += "ExecuteHeader: %s%sA\n\n" % (
			chr(ord("A") | sram_bank | 1 << 2 | (encoding_type << 4)),
			encode_addr(temp_addr)
			)
	else:
		encode_output += "ExecuteHeader: %s%sA\n\n" % (
			"/" if encoding_type else "-",
			encode_addr(temp_addr)
			)

if include_file_header:
	encode_output += encode_addr(bootstrap_addr) + "\nchecksum: %s\n\n" % ((bootstrap_addr >> 8) + (bootstrap_addr & 0xff))

for i, byte in enumerate(bytes):
	if reverse_endianness:
		encode_output += chars[byte & 0xf] + chars[(byte >> 4) & 0xf]
	else:
		encode_output += chars[(byte >> 4) & 0xf] + chars[byte & 0xf]
	checksum = (checksum + byte) & 0xffff

	end_of_message = (i % 16 == 15)
	end_of_bootstrap = (i == (len(bytes) - 1))
	end_of_line = (i % 8 == 7)

	if reverse_endianness:
		if end_of_message:
			encode_output += "\n"
	else:
		if end_of_bootstrap:
			if end_of_message:
				encode_output += "\nchecksum: %s\n\n!\nchecksum: 0\n" % checksum
				break
			elif end_of_line:
				encode_output += "\n"
		
			encode_output += "!\nchecksum: %s\n" % checksum
			break
		elif end_of_message:
			encode_output += "\nchecksum: %s\n" % checksum
			checksum = 0

	if end_of_line:
		encode_output += "\n"

with open("outputs/%s_%s.txt" % (include_filename, sys.argv[2]), "w+") as f1, open("immediate_output.txt", "w+") as f2:
	f1.write(encode_output)
	f2.write(encode_output)

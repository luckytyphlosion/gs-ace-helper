INCLUDE "charmap.asm"
INCLUDE "macros.asm"
INCLUDE "constants.asm"

READABLE EQU 0

SECTION "Bootstrap", ROM0
Bootstrap::

	include_file $d6f3, $0, $0000, "examples/bootstrap_main.asm"
	include_file $c800, $0, $a4d2, "examples/gen_tids.asm", 1
	include_file $e850, $0, $0000, "examples/mail_bootstrap.asm"
	include_file $f8bf, $0, $0000, "examples/pre_bootstrap.asm"
	include_file $f8bf, $0, $0000, "examples/mail_bootstrap_box_names.asm"
	include_file $c800, $0, $a498, "examples/confirmation.asm"

EndOfBootstrap::
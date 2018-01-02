INCLUDE "charmap.asm"
INCLUDE "macros.asm"
INCLUDE "constants.asm"

READABLE EQU 0

SECTION "Bootstrap", ROM0
Bootstrap::

	include_file $d6f3, $0000, "examples/bootstrap_main.asm"
	include_file $c800, $a498, "examples/gen_tids.asm", 1
	include_file $e850, $0000, "examples/mail_bootstrap.asm"
	include_file $f8bf, $0000, "examples/pre_bootstrap.asm"
	include_file $f8bf, $0000, "examples/mail_bootstrap_box_names.asm"
	include_file $c800, $0000, "examples/confirmation.asm"

EndOfBootstrap::
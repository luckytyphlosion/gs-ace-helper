INCLUDE "charmap.asm"
INCLUDE "macros.asm"
INCLUDE "constants.asm"

READABLE EQU 0

SECTION "Bootstrap", ROM0
Bootstrap::

	include_file $d6f3, $0000, "bootstrap_main.asm"
	include_file $c800, $a498, "gen_tids.asm", 1
	include_file $e850, $0000, "mail_bootstrap.asm"
	include_file $f8bf, $0000, "pre_bootstrap.asm"
	include_file $f8bf, $0000, "mail_bootstrap_box_names.asm"
	include_file $c800, $0000, "confirmation.asm"
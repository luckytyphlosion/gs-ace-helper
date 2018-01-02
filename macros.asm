text_waitbutton: macro
	db WAIT_BUTTON
	endm

deciram: macro
	db TX_NUM
	dw \1 ; address
	dn \2, \3 ; bytes, digits
	endm

dn: MACRO
	rept _NARG / 2
	db (\1) << 4 + (\2)
	shift
	shift
	endr
	ENDM

lb: MACRO ; r, hi, lo
	ld \1, (\2 & $ff) << 8 + (\3 & $ff)
	ENDM

ln: MACRO ; r, hi, lo
	ld \1, (\2 & $f) << 4 + (\3 & $f)
	ENDM

coord: MACRO
; register, x, y[, origin]
	if _NARG < 4
		ld \1, wTileMap + SCREEN_WIDTH * (\3) + (\2)
	else
		ld \1, \4 + SCREEN_WIDTH * (\3) + (\2)
	endc
	ENDM

callba: MACRO
	ld a, \1
	ld hl, \2
	rst $08
ENDM

predef: MACRO
	ld a, \1PredefID
	call Predef
ENDM

callw: MACRO
	if _NARG == 1
		call \1 + BOOTSTRAP_OFFSET
	else
		call \1, \2 + BOOTSTRAP_OFFSET
	endc
ENDM

jpw: MACRO
	if _NARG == 1
		jp \1 + BOOTSTRAP_OFFSET
	else
		jp \1, \2 + BOOTSTRAP_OFFSET
	endc
ENDM

ldw: MACRO
	if "\1" == "hl"
		ld hl, \2 + BOOTSTRAP_OFFSET
	elif "\1" == "de"
		ld de, \2 + BOOTSTRAP_OFFSET
	elif "\1" == "bc"
		ld bc, \2 + BOOTSTRAP_OFFSET
	elif "\1" == "a"
		ld a, [\2 + BOOTSTRAP_OFFSET]
		; ld a, [STRSUB("\2",STRIN("\2","["),STRIN("\2","]")) + BOOTSTRAP_OFFSET]
	elif "\2" == "a"
		ld [\1 + BOOTSTRAP_OFFSET], a
		; ld [STRSUB("\1",STRIN("\1","["),STRIN("\1","]")) + BOOTSTRAP_OFFSET], a
	ENDC
ENDM

lds: MACRO
	if "\1" == "hl"
		ld hl, \2 + SRAM_OFFSET + 4
	elif "\1" == "de"
		ld de, \2 + SRAM_OFFSET + 4
	elif "\1" == "bc"
		ld bc, \2 + SRAM_OFFSET + 4
	endc
ENDM

ldsm: MACRO
	if READABLE
		if (\3 == 0) || (\3 == "offset")
			ldw \1, \2
		else
			ld \1, \2
		endc
	else
		ldrw \1, \2, \3, \4
	endc
ENDM

ldrw: MACRO
	if (\3 == 0) || (\3 == "offset")
		if "\1" == "a"
			if \4 == 0 ; low
				db $fa, $fa, (\2 + BOOTSTRAP_OFFSET) >> 8
			else
				db $fa, (\2 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) & $ff
			endc
		elif "\2" == "a"
			if \4 == 0 ; low
				db $ea, $ea, (\1 + BOOTSTRAP_OFFSET) >> 8
			else
				db $ea, (\1 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) & $ff
			endc
		else
			if \4 == 0 ; low
				db (\2 + BOOTSTRAP_OFFSET) >> 8, (\2 + BOOTSTRAP_OFFSET) >> 8, (\2 + BOOTSTRAP_OFFSET) >> 8
			elif \4 == 1 ; high
				db (\2 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) & $ff
			else
				db (\2 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) & $ff, (\2 + BOOTSTRAP_OFFSET) >> 8
			endc
		endc
	else
		if "\1" == "a"
			if \4 == 0 ; low
				db $fa, $fa, \2 >> 8
			else
				db $fa, \2 & $ff, \2 & $ff
			endc
		elif "\2" == "a"
			if \4 == 0 ; low
				db $ea, $ea, \1 >> 8
			else
				db $ea, \1 & $ff, \1 & $ff
			endc
		else
			if \4 == 0 ; low
				db \2 >> 8, \2 >> 8, \2 >> 8
			elif \4 == 1 ; high
				db \2 & $ff, \2 & $ff, \2 & $ff
			else
				db \2 & $ff, \2 & $ff, \2 >> 8
			endc
		endc
	endc
ENDM

include_file: MACRO
IF _NARG == 4
BOOTSTRAP_OFFSET EQUS "\1"
SRAM_OFFSET EQUS "\2"
INCLUDE \3
PRINTT "include_file \3\n"
PRINTT "bootstrap_offset "
PRINTV \1
PRINTT "\n"
ENDC
ENDM

const_def: MACRO
const_value = 0
ENDM

const: MACRO
\1 EQU const_value
const_value = const_value + 1
ENDM

shift_const: MACRO
\1 EQU (1 << const_value)
const_value = const_value + 1
ENDM
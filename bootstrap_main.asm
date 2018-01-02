; 1 char: flags 1
; bit 0-1: sram bank
; bit 2: bootstrap or execute
; bit 3: specify bootstrap mail buffer scratch dest
; bit 4: base16 or hex encoding. base16 assumes little endian, hex encoding assumes big endian
; if upper 7 bits are %1110001 (- or /), execute directly. bit 4 corresponds to jump encoding
; 4 chars: bootstrap dest or execute src
; 1 char: flags 2
; bit 0: don't include header

hChecksumPrint EQU $ffe9

callw2: MACRO
	IF _NARG == 1
		call (\1 - CharPairPointerDecode) + wCmdQueue + 6 * 4
	ELSE
		call \1, (\2 - CharPairPointerDecode) + wCmdQueue + 6 * 4
	ENDC
ENDM

	callw _Bootstrap
	jp CloseSRAM

_Bootstrap::
	ld hl, wBoxNames
	ld a, [hli]
	ld b, a
	add a
	jr c, .headerNotFromMail
	push hl
	ld de, wc1d5
	push de
	callba $4, _ComposeMailMessage
	pop de
	ld a, [de]
	res 7, a
	ld [de], a
	ld b, a
	ld hl, wBoxNames
	call CopyName2	
	pop hl
.headerNotFromMail
	callw2 CharPairPointerDecode
	ld h, d
	ld l, e ; hl = bootstrap dest or execute src
	ld a, b
	cp "-"
	jr c, .notDirectExecute
	jp hl
.notDirectExecute
	and $3
	bit 2, b
	jr z, .bootstrap
	call OpenSRAM
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	push de ; execute dest
	jp CopyBytes ; returns into de, which is the destination
.bootstrap
	bit 3, b ; specify bootstrap buffer dest
	push af
	push de ; save dest for later
	ld de, $c755 ; default
	ld hl, wBoxNames + 9 * 2
	callw2 nz, CharPairPointerDecode
	push de
.getBootstrapCharsLoop
	push de ; push mail dest buffer
.retryMail
	ld de, wc1d5 ; temp buffer for mail message
	callba $4, _ComposeMailMessage
	pop de ; get mail dest buffer
	push de ; push mail dest buffer
	ld hl, wc1d5
	ld bc, 0
	jr .handleLoop
; hl = temp mail buffer
; de = scratch space dest
.checksumMsgLoop
	callw2 CharPairDecode
	ld [de], a
	inc de
	add c
	ld c, a
	jr nc, .handleLoop
	inc b
.handleLoop
	callw CheckNewlineChar
	ld a, [hl]
	cp "@"
	jr z, .doneChecksum
	cp "!"
	jr nz, .checksumMsgLoop
.doneChecksum
	push af ; push "!" flag
	push de ; push end of compiled message
	ld hl, hChecksumPrint + 1
	ld a, c
	ld [hld], a
	ld [hl], b
	ld d, h
	ld e, l
	coord hl, 5, 0
	lb bc, PRINTNUM_LEADINGZEROS | PRINTNUM_LEFTALIGN | 2, 5
	call PrintNum ; leftover function in GS
	call YesNoBox
	pop de ; pop end of compiled message
	pop bc ; pop flags

	jr c, .retryMail
	pop hl ; pop start of mail message (ignored)
	bit 0, b ; "@" has bit 0 set
	jr z, .getBootstrapCharsLoop
.bootstrapFinished
; perform de - hl
	pop hl
	ld a, e
	sub l
	ld c, a
	ld a, d
	sbc h
	ld b, a
	pop de ; sram dest
	pop af ; sram bank
	call OpenSRAM
	ld a, [wBoxNames + 5]
	rra
	jr c, .noHeader
	dec bc
	dec bc
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de
	inc bc
	inc bc
.noHeader
	jp CopyBytes

CheckNewlineChar:
	ld a, [hl]
	cp $4e
	ret nz
	inc hl
	ret

; sectioned at unused space after wCmdQueue
CharPairPointerDecode:
	callw2 CharPairDecode
	ld d, a
	callw2 CharPairDecode
	ld e, a
	ret

CharPairDecode:
	push bc
	callw2 ReadAndFilterChar
	add a
	add a
	add a
	add a
	ld b, a
	callw2 ReadAndFilterChar
	and $f
	or b
	pop bc
	ret

ReadAndFilterChar:
	callw CheckNewlineChar
	ld a, [wBoxNames]
	bit 4, a
	ld a, [hli]
	ret z
	add a, 10
	ret

; event flags
; unused: d7d7 to d7ff
EndOfFile::
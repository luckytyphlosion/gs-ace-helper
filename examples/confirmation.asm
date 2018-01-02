; 29544 (hopefully)
hChecksumPrint EQU $ffe9

	ld hl, $d6f3
	ld bc, $c2
	callw .Checksum
	push de
	ld hl, $d41d
	ld bc, $27
	callw .Checksum
	ld h, d
	ld l, e
	pop de
	add hl, de
	ld a, h
	ld [hChecksumPrint], a
	ld a, l
	ld [hChecksumPrint + 1], a
	ldw hl, .ChecksumText
	jp PrintText

.Checksum:
	ld a, [hROMBank]
	push af
	ld a, $5
	rst $10
	call Checksum
	pop af
	ld [hROMBank], a
	ret

.ChecksumText:
	deciram hChecksumPrint, 2, 5
	text_waitbutton
	db "@"
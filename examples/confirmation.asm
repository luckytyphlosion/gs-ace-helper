; 59346 (hopefully)
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
	ld de, 0
.loop
	ld a, [hli]
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	sla e
	rl d
	jr nc, .noCarry2
	inc e
.noCarry2
	dec bc
	ld a, b
	or c
	jr nz, .loop	
	ret

.ChecksumText:
	deciram hChecksumPrint, 2, 5
	text_waitbutton
	db "@"
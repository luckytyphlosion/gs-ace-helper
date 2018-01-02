IF 1 ; instant text
; A 0 9 'v B é 'm 2
; p 'v 9 é G 't . 9
; é é 't 'v ♂ é × 2
; P pk ♀ 4 Z 'l ? 'd
; é Z 'l p p p 0 'd
; é y 't 'm ♀ ♀
	db "A" ; or
	or "9" ; $ff get $ff
	sub "B" ; $81 get $7e
	ldw wTM01WriteAddress + 1, a
	db $50

	xor a
	sub "9" ; $ff get $01
	ld [wTMsHMs + 8], a ; get tm09
	add sp, $ff
	db $50

wTM01WriteAddress:
	ld [$d5ea], a ; converted to $d57e
	sub "♂" ; $ef get $12
	ldw wEndJumpHighByteAddress + 2, a
	db $50

	adc a ; coincidence intensifies (get $25)
	pop hl
	push af
	ld a, [wOptions]
	and "'d" ; $d0, sets instant text
	db $50

	ld [wOptions], a
	xor a 
	xor a ; filler
	xor a
	or "'d" ; $d0 get $d0
	db $50

	ld [wItems], a
wEndJumpHighByteAddress:
	jp nc, $f5f5
	db $50
ELSE
; A 0 9 'v B é 'm 2
; p 'v 9 é G 't . 9
; é é 't 'v ♂ é . 2
; P pk ♀ p p p 0 'd
; é y 't 'm ♀ ♀
	db "A" ; or
	or "9" ; $ff get $ff
	sub "B" ; $81 get $7e
	ldw wTM01WriteAddress + 1, a
	db $50

	xor a
	sub "9" ; $ff get $01
	ld [wTMsHMs + 8], a ; get tm09
	add sp, $ff
	db $50

wTM01WriteAddress:
	ld [$d5ea], a ; converted to $d57e
	sub "♂" ; $ef get $12
	ldw wEndJumpHighByteAddress + 2, a
	db $50

	adc a ; coincidence intensifies (get $25)
	pop hl
	push af
	xor a 
	xor a ; filler
	xor a
	or "'d" ; $d0 get $d0
	db $50

	ld [wItems], a
wEndJumpHighByteAddress:
	jp nc, $f5f5
	db $50
ENDC
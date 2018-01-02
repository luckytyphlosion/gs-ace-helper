; p 'v b 'v X ♀ 'v 3
; é ? 2 'v p é ♂ 2
; H 0 n é 5 2 0 9
; 'v ; ♀ pk p p 'v 6
; 'l x x x 't 4 5 2
; 'v 9 x x - 0 . 'l
; ♀ 'd
	xor a
	sub "b" ; $a1 get $5f
	sub "X" ; $97 get $c8
	push af
	sub "3" ; $f9 get $cf (rst 08 opcode)
	db $50

	ldw wRST08Address, a
	sub "p" ; $af get $20 (jr nz opcode)
	ldw wJRNZAddress, a
	db $50

	add a ; $20 get $40
	or "n" ; $ad get $ed (inverse of 19)
MailFunctionCallLoop:
	ld [$f8fb], a
	or "9" ; $ff get $ff
	db $50

	sub ";" ; $9d get $62, flags = $40 ($6240)
	push af
	pop hl ; get $6240
	xor a
	xor a ; padding
	sub "6" ; $fc get $04
	db $50
	
	pop de ; get mail buffer address
	or a ; more padding
	or a
wRST08Address:
	or a
	push de
	ld a, [$f8fb] ; count
	db $50

	sub "9" ; $ff increment count
	or a
wJRNZAddress:
if READABLE
	jr nz, MailFunctionCallLoop
else
	or a
	db (MailFunctionCallLoop - @ - 1) & $ff
endc
	or "." ; get $e800 in flags, fallthrough to $e850
	pop de
	db $50

	push af
	ret nc
	db $50
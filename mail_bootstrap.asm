; afd6ffea80e8ea88e8d6ffea9ee8d6ff4eea9fe8d6e6ea89e8d6fcea70e8d6f9
; a8a8e8ea92e8d6feea8fe8ea98e8d69b4e
; f3d6878fd48ee8d4d4d4b0d6f8f5f5fe4efefbd680f5d18787878787b2b2b2f1
; d6ffd0b7d28ee8

; 16, 15
; p 'v 9 é A . é I . 'v 9 é [ . 'v 9
; é ] . 'v ? é J . 'v 6 é po . 'v 3
; 16
; i i . é S . 'v 8 é P . é Y . 'v )
; 16, 15
; / 'v H P 's O . 's 's 's q 'v 5 ♀ ♀ 8
; 8 5 'v A ♀ 'l H H H H H s s s ×
; 7
; 'v 9 'd x 'm O .

	xor a
	sub "9" ; $ff get $01
	ldw wLDBC1Address, a
	ldw wLDBC2Address, a
	sub "9" ; $ff get $02
	ldw wLDBCAAddress, a
	sub "9" ; $ff get $03
	db $4e
	ldw wIncBCAddress, a
	sub "?" ; $e6 get $1d
	ldw wLDBC2Address + 1, a
	sub "6" ; $e2 get $21
	ldw wLDHLAddress, a
	sub "3" ; $f9 get $28

wLDHLAddress:
	ldsm hl, wBootstrapSource, "offset", -1
	ldw wJRZAddress, a
	sub "8" ; $fe get $2a
	ldw wLDAHLI1Address, a
	ldw wLDAHLI2Address, a
	sub ")" ; $9b get $8f
wLDBC1Address:
	; ldsm bc, $d6f3, "no_offset", -1
if READABLE
	ld bc, $d6f3
else
	db $4e
	db "/", "'v" ; $d6f3
endc
	add a ; get $1e
	adc a ; get $3d
	callw nc, EncodeMailBootstrap
wLDBC2Address:
	ldsm bc, $d41d, "no_offset", 0 ; wCmdQueue + 6 * 4
	or b ; get $d4
	sub "5" ; $f8 get $d9
EncodeMailBootstrap:
	push af
EncodeMailBootstrap_skipNewline:
wLDAHLI1Address:
if READABLE
	ld a, [hli]
else
	push af
endc
	cp $4e
wJRZAddress:
if READABLE
	jr z, EncodeMailBootstrap_skipNewline
else
	db $fe
	db (EncodeMailBootstrap_skipNewline - @ - 1) & $ff
endc
	add a
	add a
	add a
	add a
	push af
	pop de
wLDAHLI2Address:
if READABLE
	ld a, [hli]
else
	pop de
endc
	sub "A"
	or d
wLDBCAAddress:
if READABLE
	ld [bc], a
else
	or d
endc
wIncBCAddress:
if READABLE
	inc bc
else
	or d
endc
	pop af

	sub $ff
	ret nc
	or a
	jpw nc, EncodeMailBootstrap

wBootstrapSource::
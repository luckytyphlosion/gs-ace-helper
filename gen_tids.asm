	ld hl, wPartyCount
	ld a, [hl]
	cp 6
	jr nz, .notSix
	dec [hl]
.notSix
	ld hl, wBoxNames + 2 * 9
	callw CharPairDecode
	ld [wCurPartySpecies], a
	callw CharPairDecode
	ld [wCurPartyLevel], a
	ld a, [hli]
	sub "A" ; count
	inc a
	push af
	ld a, [hl]
	bit 1, a ; shiny
	push af
	bit 0, a
	set 0, a
	ld [hl], a
	jr nz, .doNotInitTID
	lds hl, wStoredTID
	ld [hli], a
	ld [hl], a
.doNotInitTID
	xor a
	ld [wMonType], a
.addToSixLoop
	predef TryAddMonToParty
	ld a, [wPartyCount]
	cp 6
	jr nz, .addToSixLoop
	dec a
	ld [wCurPartyMon], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	pop af
	jr z, .notShiny
	ld hl, wPartyMon6DVs
	ln a, 10, 10
	ld [hli], a
	ld [hl], a
.notShiny
	pop bc
.loop
	push bc
	callw IncrementTID
	predef SentGetPkmnIntoFromBox
	pop bc
	jr c, .fullBox
	dec b
	jr nz, .loop
.fullBox
	ld a, [wBoxNames]
	and $3
	call OpenSRAM
	lds hl, wStoredTID + 1
	dec [hl]
	jr nz, .noUnderflow
	dec hl
	dec [hl]
.noUnderflow
	call CloseSRAM
	callba $5, SaveGameData
	ld de, SFX_SAVE
	jp PlaySFX

IncrementTID:
	xor a
	call OpenSRAM
	lds hl, wStoredTID
	ld a, [hli]
	ld [wPartyMon6ID], a
	ld a, [hl]
	ld [wPartyMon6ID + 1], a
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	jp CloseSRAM

CharPairDecode:
	push bc
	ld a, [hli]
	add 10
	add a
	add a
	add a
	add a
	ld b, a
	ld a, [hli]
	add 10
	and $f
	or b
	pop bc
	ret

wStoredTID::
EndOfFile::
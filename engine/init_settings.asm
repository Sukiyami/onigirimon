InitCrystalData: ; 48000
	ld a, $1
	ld [wd474], a
	xor a
	ld [wd473], a
	ld [PlayerGender], a
	ld [wd475], a
	ld [wd476], a
	ld [wd477], a
	ld [wd478], a
	ld [wd002], a
	ld [wd003], a
	; could have done "ld a, [wd479] \ and %11111100", saved four operations
	ld a, [wd479]
	res 0, a
	ld [wd479], a
	ld a, [wd479]
	res 1, a
	ld [wd479], a
	ret
; 4802f

INCLUDE "misc/mobile_12.asm"

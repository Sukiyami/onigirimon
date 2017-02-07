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

InitLanguage:
	call InitLanguageScreen
	call LoadLanguageScreenPal
	call LoadLanguageScreenTile
	call WaitBGMap2
	call SetPalettes
	ld hl, TextJump_PlayInSubbedOrDubbed
	call PrintText
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	call WaitBGMap2
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	cp 1
	jr z, .Dubbed
	ld c, 20
	call DelayFrames
	ret
	
.Dubbed:
	ld hl, .Donut
	ld de, RedsName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld de, ENGINE_DUBBED
	ld b, SET_FLAG
	callba EngineFlagAction
	ret

.Donut: db "DONUT@"
	
.MenuDataHeader:
	db $40 ; flags
	db 04, 05 ; start coords
	db 09, 13 ; end coords
	dw .MenuData2
	db 1 ; default option
	
.MenuData2:
	db $a1 ; flags
	db 2 ; items
	db "Subbed@"
	db "Dubbed@"
	
TextJump_PlayInSubbedOrDubbed:
	;Play in subbed? Or play in dubbed?
	text_jump Text_PlayInSubbedOrDubbed
	db "@"
	
InitLanguageScreen:
	ld a, $10
	ld [MusicFade], a
	ld a, MUSIC_NONE
	ld [MusicFadeIDLo], a
	ld a, $0
	ld [MusicFadeIDHi], a
	ld c, 16
	call DelayFrames
	call ClearBGPalettes
	call InitCrystalData
	call LoadFontsExtra
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, $0
	call ByteFill
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	call ByteFill
	ret

LoadLanguageScreenPal:
	ld hl, .Palette
	ld de, UnknBGPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	callba ApplyPals
	ret

.Palette:
	RGB 31, 31, 31
	RGB 09, 30, 31
	RGB 01, 11, 31
	RGB 00, 00, 00
	
LoadLanguageScreenTile:
	ld de, .LightBlueTile
	ld hl, VTiles2 tile $00
	lb bc, BANK(.LightBlueTile), 1
	call Get2bpp
	ret
	
.LightBlueTile:
INCBIN "gfx/intro/gender_screen.2bpp"
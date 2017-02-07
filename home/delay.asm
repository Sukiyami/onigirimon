DelayFrame:: ; 45a
; Wait for one frame
	ld a, 1
	ld [VBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt ; rgbasm adds a nop after this instruction by default
	ld a, [VBlankOccurred]
	and a
	jr nz, .halt
	ret
; 468


DelayFrames:: ; 468
; Wait c frames
	srl c
	jr nz, .loop
	ld c, 1
.loop
	call DelayFrame
	dec c
	jr nz, .loop
	ret
; 46f
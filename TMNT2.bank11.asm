    .db 05
    BEQ JMP_OBJS_UNK ; Not set, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear.
RET_CC: ; 0B:0008, 0x016008
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE HOLD_NOT_ZERO ; != 0, goto.
    LDA #$16
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move state.
    LDA #$7C
    STA OBJ_ANIMATION_DISPLAY[18],X
HOLD_NOT_ZERO: ; 0B:0017, 0x016017
    LDA RANDOM_VALS?[2] ; Load random.
    LSR A ; >> 2
    LSR A
    AND #$01 ; Keep 0x01
    EOR OBJ_ANIMATION_DISPLAY[18],X ; Invert animate.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 1
    LDA #$03 ; Load
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set
    BCS SHIFTED_ONE ; 1 shifted off, do.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    RTS ; Leave.
SHIFTED_ONE: ; 0B:003C, 0x01603C
    JMP SET_XOBJ_SWITCHES_AND_ANIMATION ; State mod.
JMP_OBJS_UNK: ; 0B:003F, 0x01603F
    JMP SUB_UNK_SLOTS_AND_INIT
S15_EXJ_RTN_A: ; 0B:0042, 0x016042
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR XPOS_RTN_RET_?? ; Do rtn.
    BCC SKIP_EXIT ; Ret CC, skip exit.
    JMP INIT_OBJECT[X]_DATA_FULL ; Exit with init.
SKIP_EXIT: ; 0B:004F, 0x01604F
    LDA RANDOM_VALS?[2] ; Get random.
    LSR A ; >> 2, /4
    LSR A
    LDA #$82 ; Seed val.
    BCC SHIFTED_ZERO ; If zero, use val.
    LDA #$83 ; Carry set, use this.
SHIFTED_ZERO: ; 0B:0059, 0x016059
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    LDA RANDOM_VALS?[2] ; Load rand.
    LSR A ; >> 1, /2
    AND #$01 ; Keep bottom bit.
    EOR OBJ_ANIMATION_DISPLAY[18],X ; Eor val.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
    RTS ; Leave.
    .db 60 ; Oops? Mistake? TODO.
SUB_SWITCH_XOBJ_UNK: ; 0B:0069, 0x016069
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    ASL A ; << 1, *2. To word pointer.
    TAY ; To Y index.
    LDA PTR_TBL_UNK_L,Y ; Move pointer.
    STA TMP_00
    LDA PTR_TBL_UNK_H,Y
    STA TMP_01
    .db 6C ; JMP [TMP_00], but also 0x0000 PTR from dtable? Weird.
PTR_TBL_UNK_L: ; 0B:0079, 0x016079
    LOW(TMP_00)
PTR_TBL_UNK_H: ; 0B:007A, 0x01607A
    HIGH(TMP_00)
    LOW(RTN_RTS)
    HIGH(RTN_RTS)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
    LOW(RTN_E)
    HIGH(RTN_E)
    LOW(RTN_F)
    HIGH(RTN_F)
    LOW(RTN_G)
    HIGH(RTN_G)
    LOW(RTN_H)
    HIGH(RTN_H)
    LOW(RTN_I)
    HIGH(RTN_I)
    LOW(RTN_J)
    HIGH(RTN_J)
    LOW(RTN_K)
    HIGH(RTN_K)
    LOW(RTN_L)
    HIGH(RTN_L)
    LOW(RTN_M)
    HIGH(RTN_M)
    LOW(RTN_D)
    HIGH(RTN_D)
    LOW(RTN_G)
    HIGH(RTN_G)
    LOW(RTN_RTS)
    HIGH(RTN_RTS)
    LOW(RTN_N)
    HIGH(RTN_N)
    LOW(RTN_O)
    HIGH(RTN_O)
    LOW(RTN_RTS)
    HIGH(RTN_RTS)
    LOW(RTN_RTS)
    HIGH(RTN_RTS)
RTN_RTS: ; 0B:00A3, 0x0160A3
    .db 60 ; Just leave.
    LDA ARR_SPRITE_OBJ_TIMER?+1
    BNE 0B:00D2
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:00CE
    LDA TMP_16
    CMP #$27
    BCC 0B:00CE
    CMP #$34
    BCS 0B:00BF
    JSR 0A:1863
    SEC
    RTS
    LDA TMP_16
    CMP #$47
    BCC 0B:00D2
    CMP #$4A
    BCS 0B:00CE
    JSR RTN_UNK
    SEC
    RTS
    CLC
    LDA #$01
    RTS
    CLC
    LDA #$00
    RTS
RTN_B: ; 0B:00D6, 0x0160D6
    LDA 712_FLAG_PALETTE_UNK
    BNE 0B:00E2
    JSR 0B:00A4
    BCS 0B:00EB
    BEQ 0B:00EB
    LDA TMP_16
    CMP #$20
    BCS 0B:00EB
    JMP 0A:19C0
    RTS
RTN_L: ; 0B:00EC, 0x0160EC
    LDY #$04
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    CMP #$1C
    BEQ 0B:00E2
    INY
    CPY #$12
    BCC 0B:00EE
    LDA #$02
    STA OBJ_ENABLED_STATE+MORE?[18],X
    JSR SUB_GFX_BANKS_FROM_STATE
    JMP RTN_B
RTN_N: ; 0B:0105, 0x016105
    LDY #$04
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    CMP #$21
    BEQ 0B:00EB
    INY
    CPY #$12
    BCC 0B:0107
    LDA #$02
    STA OBJ_ENABLED_STATE+MORE?[18],X
    JSR SUB_GFX_BANKS_FROM_STATE
    JMP RTN_B
RTN_C: ; 0B:011E, 0x01611E
    LDA 712_FLAG_PALETTE_UNK
    BNE 0B:012A
    JSR 0B:00A4
    BCS 0B:00EB
    BEQ 0B:00EB
    LDA TMP_16
    CMP #$20
    BCS 0B:0133
    JMP 0A:1A41
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:00EB
    CMP #$F0
    BCS 0B:00EB
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:00EB
    JMP 0A:1B2E
RTN_D: ; 0B:0148, 0x016148
    LDA TMP_16
    CMP #$20
    BCS 0B:0151
    JMP SUB_SEC0x03_TERT0x05_HOLD0x00
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:016B
    CMP #$F0
    BCS 0B:016B
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:016B
    JSR 0A:1C14
    LDA #$0C
    JMP SND_BANKED_DISPATCH
    RTS
RTN_E: ; 0B:016C, 0x01616C
    LDA TMP_16
    CMP #$20
    BCS 0B:0175
    JMP 0A:19C0
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:018A
    CMP #$F0
    BCS 0B:018A
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:018A
    JMP 0A:1B3E
    RTS
RTN_O: ; 0B:018B, 0x01618B
    LDA TMP_16
    CMP #$20
    BCS 0B:0194
    JMP 0A:19C0
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:01A9
    CMP #$F0
    BCS 0B:01A9
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:01A9
    JMP 0A:1B4E
    RTS
RTN_F: ; 0B:01AA, 0x0161AA
    LDA TMP_16
    CMP #$20
    BCS 0B:01BD
    JSR RANDOMNESS?
    AND #$07
    BEQ 0B:01BA
    JMP SUB_CLEAR_UNK_SEC0x03_TERT0x09
    JMP 0A:1CB1
    CMP #$30
    BCC 0B:01D4
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:01D4
    LDA TMP_16
    CMP #$70
    BCC 0B:01D1
    JMP 0A:1CA5
    JMP 0A:1CAB
    RTS
RTN_G: ; 0B:01D5, 0x0161D5
    LDA TMP_16
    CMP #$20
    BCS 0B:01DE
    JMP 0A:19C0
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:01F3
    CMP #$F0
    BCS 0B:01F3
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:01F3
    JMP 0A:1D61
    RTS
RTN_H: ; 0B:01F4, 0x0161F4
    LDA TMP_16
    CMP #$20
    BCS 0B:01FD
    JMP 0A:1DF6
    RTS
RTN_I: ; 0B:01FE, 0x0161FE
    LDA TMP_16
    CMP #$20
    BCS 0B:0207
    JMP 0A:1A51
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:021C
    CMP #$F0
    BCS 0B:021C
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:021C
    JMP 0A:1B5E
    RTS
RTN_J: ; 0B:021D, 0x01621D
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:0237
    CMP #$F0
    BCS 0B:0237
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:0237
    JSR 0A:1E82
    LDA #$2E
    JMP SND_BANKED_DISPATCH
    RTS
RTN_K: ; 0B:0238, 0x016238
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    SEC
    LDA OBJ_POS_X??[18],X
    SBC OBJ_POS_X??[18],Y
    BPL 0B:0249
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_17
    LDA TMP_16
    CMP #$20
    BCS 0B:025A
    LDA TMP_17
    CMP #$03
    BCS 0B:0270
    JMP 0A:19C0
    CMP #$30
    BCC 0B:0270
    CMP #$5A
    BCS 0B:0270
    LDA OBJ_POS_X?[18],X
    CMP #$10
    BCC 0B:0270
    CMP #$F0
    BCS 0B:0270
    JMP 0A:1EE9
    RTS
RTN_M: ; 0B:0271, 0x016271
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    BMI 0B:0294
    JSR 0B:00A4
    LDA OBJ_POS_X_DELTA?[18],X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BNE 0B:029D
    JSR RANDOMNESS?
    AND #$07
    BNE 0B:029D
    JSR 0A:1863
    JMP 0B:029D
    LDY TMP_10
    CPY #$32
    BCS 0B:029D
    JMP 0A:1FB6
    RTS
HEALTH_NONZERO: ; 0B:029E, 0x01629E
    JSR XOBJ_WRITE_PLAYER_FOCUS
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Set for pair.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switch and tert.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA OBJ_DATA_UNK_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set pos.
    LDA OBJ_DATA_UNK_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; Load from Y.
    ASL A ; << 2, *4.
    ASL A
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; A from X
    AND #$BF ; Keep 1011.1111
    BCC BIT_0x40_NOT_SET
    ORA #$40 ; Set if was.
BIT_0x40_NOT_SET: ; 0B:02CD, 0x0162CD
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store to X.
    LDY #$00 ; Data index.
    BCS BIT_0x40_WAS_SET
    LDY #$02 ; Data index.
BIT_0x40_WAS_SET: ; 0B:02D6, 0x0162D6
    LDA DATA_UNK_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store to obj.
    LDA DATA_UNK_B,Y
    STA OBJ_POS_X_DELTA?[18],X ; Store to obj.
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do sub.
    LDA #$2B
    JSR SND_BANKED_DISPATCH ; Play sound.
HEALTH_ANIMATION_RTN: ; 0B:02EA, 0x0162EA
    LDY OBJECT_DATA_HEALTH?[18],X ; Load health
    BNE ANIMATION_FROM_STATE ; Has health.
    LDA #$05 ; Animation.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load
    CPY #$0A ; If _ #$0A
    BEQ ANIMATION_FROM_STATE ; ==, goto.
    CPY #$10 ; If _ #$10
    BNE STORE_ANIMATION_DIRECT ; !=, direct.
ANIMATION_FROM_STATE: ; 0B:02FC, 0x0162FC
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load state.
    LDA ANIMATION_FROM_STATE,Y ; Get value from index.
STORE_ANIMATION_DIRECT: ; 0B:0302, 0x016302
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    RTS
DATA_UNK_A: ; 0B:0306, 0x016306
    .db 80 ; 0x40 clear.
DATA_UNK_B: ; 0B:0307, 0x016307
    .db FF
    .db 80 ; 0x40 set.
    .db 00
OBJ_DATA_UNK_A: ; 0B:030A, 0x01630A
    .db 80
OBJ_DATA_UNK_B: ; 0B:030B, 0x01630B
    .db FF
HEALTH_ZERO: ; 0B:030C, 0x01630C
    LDA TMP_09 ; Load
    PHA ; Save
    JSR XOBJ_WRITE_PLAYER_FOCUS ; Do.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    BNE HEALTH_NONZERO
    CLC ; Prep add
    LDA 4C6_OBJ_UNK[18],X ; Load
    ADC #$E8 ; Add val.
    STA 4C6_OBJ_UNK[18],X ; Store back.
    LDY #$02 ; Index.
    BNE HEALTH_ZERO_ENTRY ; Always taken.
HEALTH_NONZERO: ; 0B:0324, 0x016324
    LDY #$00 ; Index.
HEALTH_ZERO_ENTRY: ; 0B:0326, 0x016326
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store to pair.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set sec/tert
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA DATA_HEALTH_BASED_A,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Move to obj.
    LDA DATA_HEALTH_BASED_B,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    PLA ; Restore.
    CMP #$04 ; If _ #$04
    BCS VAL_GTE_0x04 ; >=, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from extra.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; A from Y.
    JMP LT_0x04 ; Goto.
VAL_GTE_0x04: ; 0B:034F, 0x01634F
    TAY ; A to Y
    LDA OBJ_POS_X_DELTA?[18],Y ; Load from obj.
    LSR A ; >> 1, /2. Determine based on 0x80 not 0x40.
LT_0x04: ; 0B:0354, 0x016354
    ASL A ; << 2, *4.
    ASL A
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    AND #$BF ; Keep 1011.1111
    BCC SHIFTED_CLEAR
    ORA #$40 ; Set direction related.
SHIFTED_CLEAR: ; 0B:035F, 0x01635F
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store back.
    LDY #$00 ; If set.
    BCS SHIFTED_WAS_SET
    LDY #$02 ; If clear.
SHIFTED_WAS_SET: ; 0B:0368, 0x016368
    LDA DATA_OBJ_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store to obj.
    LDA DATA_OBJ_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    JSR HEALTH_ANIMATION_RTN ; Do rtn.
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$2B
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
DATA_OBJ_A: ; 0B:0382, 0x016382
    .db 00
DATA_OBJ_B: ; 0B:0383, 0x016383
    .db FE
    .db 00
    .db 02
DATA_HEALTH_BASED_A: ; 0B:0386, 0x016386
    .db 00
DATA_HEALTH_BASED_B: ; 0B:0387, 0x016387
    .db FE
    .db 80
    .db FE
HANDLER_0x01_MULTISWITCH_E: ; 0B:038A, 0x01638A
    LOW(S01_MSE_RTN_A) ; Bg stuff, init stuff, move.
    HIGH(S01_MSE_RTN_A)
    LOW(S01_MSE_RTN_B) ; Same as other, alt val for first rtn.
    HIGH(S01_MSE_RTN_B)
    LOW(S01_MSE_RTN_C) ; General obj stuff.
    HIGH(S01_MSE_RTN_C)
    LOW(S01_MSE_RTN_D) ; Sound, lots of setup, spawns things, more.
    HIGH(S01_MSE_RTN_D)
S01_MSE_RTN_A: ; 0B:0392, 0x016392
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear obj data.
    LDA #$0C ; Val?
    BNE ALT_ENTER ; Always taken.
S01_MSE_RTN_B: ; 0B:039B, 0x01639B
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear obj data.
    LDA #$20 ; Val?
ALT_ENTER: ; 0B:03A2, 0x0163A2
    JSR MOVE_UNK_RET_?? ; Do rtn.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair tert.
    BNE PAIR_TERT_NONZERO ; Has val, goto.
    BCS SUB_RET_CS ; Otherwise, branch on sub ret.
    BCC SUB_RET_CC ; One of these two always taken.
PAIR_TERT_NONZERO: ; 0B:03AE, 0x0163AE
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI SUB_RET_CC ; If negative, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP 4D8_OBJ_UNK+1,X ; If _ pair unk.
    BCS SUB_RET_CS ; >=, goto.
SUB_RET_CC: ; 0B:03BB, 0x0163BB
    JSR HEALTH_ANIMATION_RTN ; Do
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCC RTN_OKAY ; If okay, goto.
    DEC 556_OBJ_STATUS_FLAGS_A[18],X ; --
    BPL RTN_OKAY ; If positive, skip.
    LDA #$02
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set otherwise.
RTN_OKAY: ; 0B:03D0, 0x0163D0
    JSR MOVE_Y_FINALIZE ; Pos.
    LDA OBJ_POS_X?[18],X ; Load
    STA TMP_06 ; Save for now.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC XPOS_RTN_CC ; Ret CC, goto.
    LDA #$01 ; Update flag.
    LDY OBJ_POS_X_DELTA?[18],X ; Load
    BPL USE_VAL_ASIS ; If positive, use 0x01.
    LDA #$02 ; 0x02 otherwise.
USE_VAL_ASIS: ; 0B:03E6, 0x0163E6
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set flag.
XPOS_RTN_CC: ; 0B:03E9, 0x0163E9
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load flag.
    BNE RTS ; If set, leave.
    LDY OBJ_POS_X?[18],X ; Load
    LDA OBJ_POS_X??[18],X ; Load from obj.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK+1,X ; Add with pair.
    JSR UNK_SUB_B ; Do rtn.
    BNE RTS ; If return nonzero, leave.
    JSR SUB_UNK ; Do other sub if other routine was zero.
RTS: ; 0B:0400, 0x016400
    RTS ; Leave.
SUB_RET_CS: ; 0B:0401, 0x016401
    LDA 4C6_OBJ_UNK+1,X
    STA 4C6_OBJ_UNK[18],X
    LDA #$00
    STA 4D8_OBJ_UNK[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    ORA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$14
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    JSR OBJ_PAIR_SWITCH_MOD
    LDA OBJECT_DATA_HEALTH?[18],X
    BEQ 0B:0424
    JMP OBJ_STATE_MOVE_TO_S02_T00
    JMP JMP_TO_FINALIZE
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$1E
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    RTS
S01_MSE_RTN_C: ; 0B:0437, 0x016437
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    LDA OBJ_DATA[2] ; Move vals to obj.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA+1
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JMP FINALIZE ; Goto end.
VAL_EQ_ZERO: ; 0B:0453, 0x016453
    JSR MOVE?_RTN_IDK ; Do rtn.
    BCC FINALIZE ; Ret CC, goto.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear
    JSR MOVE_Y_FINALIZE ; Do.
    JMP JMP_TO_FINALIZE ; Jesus just fall through, lol.
FINALIZE: ; 0B:0463, 0x016463
    JSR HEALTH_ANIMATION_RTN ; Do.
    JMP MOVE_Y_FINALIZE ; Move final, abuse RTS.
OBJ_DATA: ; [2], 0B:0469, 0x016469
    .db C0
    .db 00
SET_XOBJ_SWITCHES_AND_ANIMATION: ; 0B:046B, 0x01646B
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$7E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set disp.
    RTS
S01_MSE_RTN_D: ; 0B:0480, 0x016480
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BEQ HOLD_EXPIRED ; == 0, goto.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC XPOS_RTN_CC ; Ret cc, goto.
    JMP SUB_UNK_SLOTS_AND_INIT ; Otherwise, do.
XPOS_RTN_CC: ; 0B:0495, 0x016495
    LDA RANDOM_VALS?[2] ; Load
    LSR A ; >> 2
    LSR A
    AND #$01 ; Keep botom bit.
    EOR OBJ_ANIMATION_DISPLAY[18],X ; Invert in obj.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
    RTS ; Leave.
HOLD_EXPIRED: ; 0B:04A2, 0x0164A2
    JSR RTN_NEW_OBJ_UNK ; Get new if possible.
    LDA #$E8
    STA 4C6_OBJ_UNK[18],X ; Store to handling.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    ASL A ; << 2
    ASL A
    LDY #$00 ; Init.
    BCS SHIFT_RESULT_CS ; If CS, goto.
    INY ; Alt.
SHIFT_RESULT_CS: ; 0B:04B7, 0x0164B7
    CLC ; Prep add.
    LDA OBJ_DATA,Y ; Load zero, lol.
    ADC OBJ_POS_X?[18],X ; Add
    STA OBJ_POS_X?[18],X ; Store.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ASL A ; << 1
    LDY #$00 ; Y=
    BCC SHIFT_RESULT_CC ; If CC, goto.
    LDY #$02 ; Alt Y val.
SHIFT_RESULT_CC: ; 0B:04CB, 0x0164CB
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA DATA_HEALTH_BASED_A,Y ; Load index 0x00/0x02?
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store to.
    LDA DATA_HEALTH_BASED_B,Y ; 0xFE always?
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store to.
    LDA DATA_OBJ_A,Y ; 0x00 always?
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set.
    LDA DATA_OBJ_B,Y ; 0xFE/0x02 always?
    STA OBJ_POS_X_DELTA?[18],X ; Set obj.
    JSR HEALTH_ANIMATION_RTN ; Do.
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$2B
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
OBJ_DATA: ; 0B:04FB, 0x0164FB
    .db 00 ; You can choose any value as long as it's zero, lol.
    .db 00
RTN_NEW_OBJ_UNK: ; 0B:04FD, 0x0164FD
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Objs free?
    BCC NO_OBJS_FREE ; No, skip this.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y is obj handling, X new obj.
    LDA OBJ_POS_X?[18],Y ; Copy from handling to new.
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X_SUBPIXEL?[18],Y
    STA OBJ_POS_X_SUBPIXEL?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    LDA OBJ_POS_Y??[18],Y
    STA OBJ_POS_Y??[18],X
    LDA OBJ_STATE_DIR_RELATED_C[18],Y
    STA OBJ_STATE_DIR_RELATED_C[18],X
    LDA OBJ_POS_X_DELTA?[18],Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 503_OBJ_POS_X_LARGEST?[18],X
    STA 520_OBJ_POS_X_LARGE?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$20 ; Move new to state.
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$82
    STA OBJ_ANIMATION_DISPLAY[18],X
NO_OBJS_FREE: ; 0B:054C, 0x01654C
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore
    RTS ; Leave.
JMP_TO_FINALIZE: ; 0B:0550, 0x016550
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    LDA 0B:0D56,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$17
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
HANDLER_0x01_MULTISWITCH_F: ; 0B:0569, 0x016569
    LOW(S01_MSF_RTN_A) ; Plays sound.
    HIGH(S01_MSF_RTN_A)
    LOW(S01_MSF_RTN_B) ; This one doesn't.
    HIGH(S01_MSF_RTN_B)
    LOW(S01_MSF_RTN_B)
    HIGH(S01_MSF_RTN_B)
    LOW(S01_MSF_RTN_B)
    HIGH(S01_MSF_RTN_B)
    LOW(S01_MSF_RTN_B)
    HIGH(S01_MSF_RTN_B)
S01_MSF_RTN_A: ; 0B:0573, 0x016573
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE HOLD_NOT_EXPIRED ; Not done, goto.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP ENTER_ALT_RTN
S01_MSF_RTN_B: ; 0B:0585, 0x016585
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE HOLD_NOT_EXPIRED ; Hold not expired, goto.
ENTER_ALT_RTN: ; 0B:058F, 0x01658F
    LDY OBJ_TERTIARY_SWITCH?[18],X ; Load Y from obj.
    LDA OBJ_DATA_PER_TERT,Y ; Load per tert.
    BEQ SUB_UNK_SLOTS_AND_INIT ; If 0, goto.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to animation display.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    LDA #$06 ; Set hold.
    STA OBJ_ANIM_HOLD_TIMER?[18],X
HOLD_NOT_EXPIRED: ; 0B:05A2, 0x0165A2
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do rtn.
    BCC RTS ; CC, leave.
    DEC 556_OBJ_STATUS_FLAGS_A[18],X ; --
    BEQ RTS ; If 0, leave.
    LDA #$02
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set.
RTS: ; 0B:05B4, 0x0165B4
    RTS ; Leave.
OBJ_DATA_PER_TERT: ; 0B:05B5, 0x0165B5
    .db 01
    .db 02
    .db 03
    .db 00
SUB_UNK_SLOTS_AND_INIT: ; 0B:05B9, 0x0165B9
    JSR SUB_OBJ_SLOTS_UNK ; Do rtn.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init Xobj.
    INX ; Obj++
    JSR INIT_OBJECT[X]_DATA_FULL ; Init pair.
    DEX ; Original obj again.
    NOP ; Shoutout to homelessrhino for praising the non-wate of cycles in NES games. :D
    RTS ; Leave.
OBJ_STATE_0x15_HANDLER: ; 0B:05C6, 0x0165C6
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Store Xobj pre-emptively.
    JSR HANDLER_SUB ; Do sub.
    JMP S15_INIT_OBJ_CHANCE? ; Goto.
HANDLER_SUB: ; 0B:05CF, 0x0165CF
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    BEQ SECONDARY_ZERO ; == 0, goto.
    JMP MULTISWITCH_S15 ; Goto otherwise.
SECONDARY_ZERO: ; 0B:05D7, 0x0165D7
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    BNE TERT_HAS_VALUE ; Goto if non-zero.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Set to 0x01 if zero.
    RTS ; Leave.
TERT_HAS_VALUE: ; 0B:05E0, 0x0165E0
    LDY 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Index from.
    LDA S15_DATA_A,Y ; Load data.
    ASL A ; << 3, *8.
    ASL A
    ASL A
    TAY ; Replace Y index.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load from obj.
    ASL A ; << 2, *4
    ASL A
    PHP ; Save status.
    LDA S15_DATA_B,Y ; Load other data.
    BCS LAST_SHIFT_OFF_ONE ; Shift off 1, skip compliment.
    EOR #$FF ; Compliment A otherwise.
    CLC
    ADC #$01
LAST_SHIFT_OFF_ONE: ; 0B:05FA, 0x0165FA
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],X ; Add
    STA OBJ_POS_X?[18],X ; Store back.
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Load
    BEQ LOAD_ZERO_A ; == 0, goto.
    LDA #$00
    STA OBJ_POS_X_DELTA?[18],X ; Set to zero.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    JMP S15_FINALIZING ; Goto.
LOAD_ZERO_A: ; 0B:0611, 0x016611
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    BEQ LOAD_ZERO_B ; == 0, goto.
    STY TMP_07 ; Save index to TMP.
    TAY ; Loaded to index.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load from that obj.
    TAY ; Put that value to Y.
    SEC ; Prep sub.
    LDA OBJ_POS_X??[18],X ; Load from Xobj.
    SBC OBJ_POS_X??[18],Y ; Sub with Yobj.
    STA TMP_03 ; Store to TMP.
    BPL RESULT_POSITIVE ; If positive, skip comp.
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 0B:062D, 0x01662D
    STA TMP_01 ; Store diff between.
    LDY #$00 ; Val A
    CMP #$20 ; Diff _ #$20
    BCC DIFF_LT_0x20 ; <, goto.
    LDY #$02 ; Val B
    LDA TMP_03 ; Load diff before compliment.
    BPL DIFF_LT_0x20 ; If positive at all, goto.
    LDY #$04 ; Val
DIFF_LT_0x20: ; 0B:063D, 0x01663D
    LDA DATA_A,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set from data.
    LDA DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Set.
    LDA DATA_B_0x00
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set
L_0B:064F: ; 0B:064F, 0x01664F
    LDA DATA_B_0x01
    STA OBJ_POS_X_DELTA?[18],X ; Set
    LDY TMP_07 ; Load earlier index.
    JMP S15_FINALIZING ; Goto.
LOAD_ZERO_B: ; 0B:065A, 0x01665A
    LDA DATA_C,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set these from Y index.
    LDA DATA_D,Y
    STA OBJ_POS_X_DELTA?[18],X
S15_FINALIZING: ; 0B:0666, 0x016666
    PLP ; Pull status.
    BCS SKIP_INVERTATION_OF_OBJ_THINGS ; Carry was set, skip.
    SEC ; Prep sub.
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invert both of these values.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
SKIP_INVERTATION_OF_OBJ_THINGS: ; 0B:067A, 0x01667A
    LDA DATA_UNK,Y ; Load.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK[18],X ; Add to.
    STA 4C6_OBJ_UNK[18],X ; Store back.
    LDA DATA_E,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store
    LDA DATA_F,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store
    JSR MOVE_Y_FINALIZE ; Do.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA DATA_WORDS,Y ; Load
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set from index.
    INC 707_UNK ; ++
    AND #$01 ; Keep 0x01 from animation.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move to S:0x02, T:0x03.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
DATA_B_0x00: ; 0B:06B1, 0x0166B1
    .db 00
DATA_B_0x01: ; 0B:06B2, 0x0166B2
    .db 01
DATA_A: ; 0B:06B3, 0x0166B3
    .db 00
DATA_B: ; 0B:06B4, 0x0166B4
    .db 00
    .db 00
    .db FF
    .db 00
    .db 01
MULTISWITCH_S15: ; 0B:06B9, 0x0166B9
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Get state.
    SEC
    SBC #$15 ; Zero base.
    ASL A ; << 1, *2. Word size.
    TAY ; To Y index.
    LDA S15_MULTISWITCH_L,Y ; Move pointer.
    STA TMP_00
    LDA S15_MULTISWITCH_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Get tertiary.
    ASL A ; << 1, *2. Word size.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Get from ptr, index from tertiary.
    STA TMP_02 ; Store to TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02] ; Run code pointed to.
S15_MULTISWITCH_L: ; 0B:06DC, 0x0166DC
    LOW(S15_EXTRA_A) ; Not too bad.
S15_MULTISWITCH_H: ; 0B:06DD, 0x0166DD
    HIGH(S15_EXTRA_A) ; 0x00
    LOW(S15_EXTRA_B) ; Not too bad either.
    HIGH(S15_EXTRA_B) ; 0x01
    LOW(S15_EXTRA_C) ; Same as 0x00 routines.
    HIGH(S15_EXTRA_C) ; 0x02
    LOW(S15_EXTRA_D) ; Does meh.
    HIGH(S15_EXTRA_D) ; 0x03
    LOW(S15_EXTRA_E) ; Very smol, tells to update??
    HIGH(S15_EXTRA_E) ; 0x04
    LOW(S15_EXTRA_F) ; Medium, both the same rtn.
    HIGH(S15_EXTRA_F) ; 0x05
    LOW(S15_EXTRA_G) ; Medium, few rtns in one.
    HIGH(S15_EXTRA_G) ; 0x06
    LOW(S15_EXTRA_H) ; Single rtn.
    HIGH(S15_EXTRA_H) ; 0x07
    LOW(S15_EXTRA_I) ; The usual.
    HIGH(S15_EXTRA_I) ; 0x08
    LOW(S15_EXTRA_B) ; Copy.
    HIGH(S15_EXTRA_B) ; 0x09
    LOW(S15_EXTRA_D) ; Copy.
    HIGH(S15_EXTRA_D) ; 0x0A
    LOW(S15_EXTRA_J) ; Single rtn.
    HIGH(S15_EXTRA_J) ; 0x0B
    LOW(S15_EXTRA_K) ; Single rtn.
    HIGH(S15_EXTRA_K) ; 0x0C
    LOW(S15_EXTRA_L) ; More usual.
    HIGH(S15_EXTRA_L) ; 0x0D
S15_INIT_OBJ_CHANCE?: ; 0B:06F8, 0x0166F8
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, leave.
    LDA RANDOM_VALS?[2] ; Load random.
    EOR 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Invert bits with.
    LSR A ; >> 1, /2.
    BCS RTS ; If shifted off 1, leave.
    CPX #$07 ; If Xobj _ #$07
    BCC RTS ; <, leave.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do rtn.
    LSR A ; >> 1, /2.
    BCS EXTENDED ; Do routine if shifted 1.
    LSR A
    BCS EXTENDED ; Do routine if shifted 1.
RTS: ; 0B:0712, 0x016712
    RTS ; Leave.
EXTENDED: ; 0B:0713, 0x016713
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load.
    SEC
    SBC #$15 ; Get base of 0x00, will be >= 0x15.
    TAY ; To Y index.
    LDA STATE_0x15_MULTISWITCH_RTN_DATA,Y ; Load
    BNE RTS ; Nonzero, leave.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init Xobj, abuse RTS.
RTS: ; 0B:0722, 0x016722
    .db 60
STATE_0x15_MULTISWITCH_RTN_DATA: ; 0B:0723, 0x016723
    .db 00 ; T/F for initing obj data.
    .db 00
    .db 00
    .db 01
    .db 01
    .db 00
    .db 01
    .db 01
    .db 01
    .db 00
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT?: ; 0B:0732, 0x016732
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Test if any unused.
    BCS UNUSED_OBJ_EXISTS ; True.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; X from.
    RTS ; Leave, carry clear.
UNUSED_OBJ_EXISTS: ; 0B:073B, 0x01673B
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; From scratch.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Y.
    ASL A ; << 1, *2. Word index.
    TAY ; To index.
    LDA DATA_OBJ_EXISTS,Y ; Load
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Store to OBJ.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y again.
    LDA OBJ_POS_X?[18],Y ; YOBJ to XOBJ
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    INC OBJ_POS_X??[18],X ; ++ on X
    LDA 4C6_OBJ_UNK[18],Y
    STA 4C6_OBJ_UNK[18],X
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; To different in X.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; Load
    AND #$40 ; Keep 0x40
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store to X.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load
    AND #$7F ; Keep 0x7F
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store to other on X.
    TAY ; To Y index.
    LDA HEALTHS_PER_STATE,Y
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y from./
    INC 706_UNK ; ++ unk
    TXA ; Xobj to A.
    TAY ; A to Yobj.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; X from scratch.
    SEC ; Return CS.
    RTS
SUB_UNK_RET_CC_PASS_CS_FAILED?: ; 0B:078E, 0x01678E
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS INIT_OBJ_EXIT_CS ; Ret CS, goto.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS INIT_OBJ_EXIT_CS ; Ret CS, goto.
    RTS ; Leave, CC.
INIT_OBJ_EXIT_CS: ; 0B:0799, 0x016799
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj.
    SEC ; Set carry.
    RTS ; Leave.
S15_EXTRA_A: ; 0B:079E, 0x01679E
    LOW(S15_MULTISWITCH_A) ; Does quite a bit.
    HIGH(S15_MULTISWITCH_A)
    LOW(S15_MULTISWITCH_B) ; Much simpler.
    HIGH(S15_MULTISWITCH_B)
S15_EXTRA_C: ; 0B:07A2, 0x0167A2
    LOW(S15_MULTISWITCH_A)
    HIGH(S15_MULTISWITCH_A)
    LOW(S15_MULTISWITCH_B)
    HIGH(S15_MULTISWITCH_B)
S15_EXTRA_E: ; 0B:07A6, 0x0167A6
    LOW(S15_EXE_RTN_A) ; Smol.
    HIGH(S15_EXE_RTN_A)
    LOW(S15_EXE_RTN_A) ; Same smol.
    HIGH(S15_EXE_RTN_A)
S15_MULTISWITCH_A: ; 0B:07AA, 0x0167AA
    JSR SUB_UNK_RET_CC_PASS_CS_FAILED? ; Do sub.
    BCS CLEAR+RTS ; Goto.
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set data.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do
    AND #$03 ; Keep 0000.0011
    BEQ CLEAR+RTS ; If == 0, goto.
    LSR A ; >> 1
    BCC SKIP_SOUND
    LDA #$29
    JSR SND_BANKED_DISPATCH ; Play sound.
SKIP_SOUND: ; 0B:07C3, 0x0167C3
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    LDA #$A9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
CLEAR+RTS: ; 0B:07D0, 0x0167D0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear obj data.
    RTS ; Leave.
S15_EXE_RTN_A: ; 0B:07D6, 0x0167D6
    JSR SUB_UNK_RET_CC_PASS_CS_FAILED? ; Do sub.
    BCS RTS ; Ret CS, goto.
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
RTS: ; 0B:07E0, 0x0167E0
    RTS
S15_MULTISWITCH_B: ; 0B:07E1, 0x0167E1
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE SKIP_REINIT
    JMP INIT_OBJECT[X]_DATA_FULL ; Reinit, abuse RTS.
SKIP_REINIT: ; 0B:07E9, 0x0167E9
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    RTS ; Leave.
S15_EXTRA_L: ; 0B:07EF, 0x0167EF
    LOW(S15_EXL_RTN_A) ; Usual. High health.
    HIGH(S15_EXL_RTN_A)
    LOW(S15_EXL_RTN_B) ; Portions shared. The usual.
    HIGH(S15_EXL_RTN_B)
S15_EXL_RTN_A: ; 0B:07F3, 0x0167F3
    JSR SUB_UNK_RET_CC_PASS_CS_FAILED? ; Do sub.
    BCS RTS ; Ret CS, leave.
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do sub.
    AND #$03 ; Keep 0000.0011
    BEQ EXIT_CLEAR_BEXTRA ; == 0, goto.
    LSR A ; >> 1, /2
    BCC SHIFTED_CC ; If CC, goto.
    LDA #$28
    JSR SND_BANKED_DISPATCH ; Play sound.
SHIFTED_CC: ; 0B:0811, 0x016811
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    LDA #$A0
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim display.
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JMP EXIT_CLEAR_BEXTRA ; Leave.
S15_EXL_RTN_B: ; 0B:0821, 0x016821
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BMI EXIT_INIT ; Hold super expired.
    LDA RANDOM_VALS?[2] ; Load rand
    LSR A ; >> 1, /2
    BCC EXIT_CLEAR_BEXTRA ; Shift off 1, exit.
    INC 4C6_OBJ_UNK[18],X ; ++ unk.
    JSR MOVE_Y_FINALIZE ; Do sub.
EXIT_CLEAR_BEXTRA: ; 0B:0831, 0x016831
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear B extra.
RTS: ; 0B:0836, 0x016836
    RTS ; Leave.
EXIT_INIT: ; 0B:0837, 0x016837
    JMP INIT_OBJECT[X]_DATA_FULL
S15_EXTRA_B: ; 0B:083A, 0x01683A
    LOW(S15_EXB_RTN_A) ; Does a bit.
    HIGH(S15_EXB_RTN_A)
    LOW(S15_EXB_RTN_B) ; Does much less.
    HIGH(S15_EXB_RTN_B)
S15_EXB_RTN_A: ; 0B:083E, 0x01683E
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS LEAVE_REINIT ; Ret CS, goto.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS LEAVE_REINIT ; CS, goto.
    JSR MOVE?_RTN_IDK ; Do.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BNE HAS_VALUE ; If nonzero, goto.
    BCS RET_CS ; Ret branches.
    BCC SET_EXTRA/HEALTH ; CC, goto.
HAS_VALUE: ; 0B:0854, 0x016854
    CMP 4C6_OBJ_UNK[18],X ; If _ VAL
    BCS SET_EXTRA/HEALTH ; >=, goto.
RET_CS: ; 0B:0859, 0x016859
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    STA 4C6_OBJ_UNK[18],X ; Store to.
    LDA #$03
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$1E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
SET_EXTRA/HEALTH: ; 0B:086C, 0x01686C
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    JMP MOVE_Y_FINALIZE ; Do, abuse RTS.
S15_EXB_RTN_B: ; 0B:0879, 0x016879
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BEQ LEAVE_REINIT ; If == 0, goto.
    LDA #$00
    STA OBJECT_DATA_HEALTH?[18],X ; Clear these otherwise.
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
LEAVE_REINIT: ; 0B:0887, 0x016887
    JMP INIT_OBJECT[X]_DATA_FULL
S15_EXTRA_D: ; 0B:088A, 0x01688A
    LOW(S15_EXD_RTN_A) ; Does a lot.
    HIGH(S15_EXD_RTN_A)
    LOW(S15_EXD_RTN_B) ; Does less, uses other stuff.
    HIGH(S15_EXD_RTN_B)
    LOW(S15_EXD_RTN_C) ; Finished.
    HIGH(S15_EXD_RTN_C)
S15_EXD_RTN_C: ; 0B:0890, 0x016890
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BMI EXIT_INIT ; Expired, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    RTS ; Leave.
EXIT_INIT: ; 0B:089B, 0x01689B
    JMP INIT_OBJECT[X]_DATA_FULL ; Leave with init.
S15_EXD_RTN_A: ; 0B:089E, 0x01689E
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS MOVE?+RET_CS ; Ret CS, goto.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS MOVE?+RET_CS ; Ret CS, goto.
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$20 ; If _ #$20
    BCC SOUND_HEALTH_EXTRAS ; <, goto.
MOVE?+RET_CS: ; 0B:08B5, 0x0168B5
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    SEC ; Prep sub.
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Get inverted.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back to.
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],X ; Invert this, too.
    STA OBJ_POS_X_DELTA?[18],X
    JSR XPOS_RTN_RET_?? ; Do RTN.
SOUND_HEALTH_EXTRAS: ; 0B:08CC, 0x0168CC
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    AND #$03 ; Keep the bottom bits.
    BEQ UPDATE_BITS_UNSET ; Neither set, goto.
    LSR A ; >> 1, /2.
    BCC UPDATE_BITS_UNSET ; Carried 0, goto.
    LDA #$29
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$A9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JMP RTS_CLEAR_EXTRA ; Leave.
UPDATE_BITS_UNSET: ; 0B:08F7, 0x0168F7
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL HOLD_POSITIVE ; If positive, goto.
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
HOLD_POSITIVE: ; 0B:0904, 0x016904
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$07 ; Keep 0000.0111
    TAY ; To Y index.
    LDA UNK_STATE_ANIMS,Y ; Load to display.
    STA OBJ_ANIMATION_DISPLAY[18],X
RTS_CLEAR_EXTRA: ; 0B:0910, 0x016910
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    RTS ; Leave.
S15_EXD_RTN_B: ; 0B:0916, 0x016916
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS INIT_RTS ; CS ret, goto.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear ??
    JSR XPOS_RTN_RET_?? ; Do.
    BCC SOUND_HEALTH_EXTRAS ; Ret CC, goto.
INIT_RTS: ; 0B:0928, 0x016928
    JMP INIT_OBJECT[X]_DATA_FULL
UNK_STATE_ANIMS: ; 0B:092B, 0x01692B
    .db 25
    .db 26
    .db 27
    .db 28
    .db 29
    .db 2A
    .db 2B
    .db 2C
S15_EXTRA_F: ; 0B:0933, 0x016933
    LOW(S15_EXF_RTN_A) ; Same for both.
    HIGH(S15_EXF_RTN_A)
    LOW(S15_EXF_RTN_A) ; Same for both.
    HIGH(S15_EXF_RTN_A)
S15_EXF_RTN_A: ; 0B:0937, 0x016937
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS EXIT_INIT ; Ret CS, goto.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_INIT ; Ret CS, leave.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load 
    CMP #$03 ; If _ #$03
    BEQ SKIP_UNK ; ==, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL SKIP_UNK ; Not expired, goto.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set longer.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
SKIP_UNK: ; 0B:0958, 0x016958
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Get step.
    LDA ANIM_DATA_UNK,Y ; Animation based on step.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set obj.
    LDA #$83
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    RTS ; Leave.
EXIT_INIT: ; 0B:096C, 0x01696C
    JMP INIT_OBJECT[X]_DATA_FULL
ANIM_DATA_UNK: ; 0B:096F, 0x01696F
    .db 52
    .db 53
    .db 54
    .db 55
S15_EXTRA_G: ; 0B:0973, 0x016973
    LOW(S15_EXG_RTN_A) ; Hold, stuff.
    HIGH(S15_EXG_RTN_A)
    LOW(S15_EXG_RTN_A)
    HIGH(S15_EXG_RTN_A)
    LOW(S15_EXG_RTN_A)
    HIGH(S15_EXG_RTN_A)
    LOW(S15_EXG_RTN_B) ; Hold, stuff, a few exits.
    HIGH(S15_EXG_RTN_B)
    LOW(S15_EXG_RTN_C) ; Middle of the above one, basically.
    HIGH(S15_EXG_RTN_C)
    LOW(S15_EXG_RTN_C)
    HIGH(S15_EXG_RTN_C)
    LOW(S15_EXG_RTN_C)
    HIGH(S15_EXG_RTN_C)
S15_EXG_RTN_A: ; 0B:0981, 0x016981
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA #$18
    JSR MOVE_UNK_RET_?? ; Do.
    BCS SET_OBJ_ATTRS ; Ret CS, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_INIT ; Ret CS, exit.
    JSR MOVE_UNK_RET_?? ; Do.
    BCS EXIT_INIT ; Ret CS, exit.
    JSR MOVE_Y_FINALIZE ; Do.
    JSR SUB_RANDOM_MOD_ANIM_DISPLAY ; Do.
    JMP SUB_MORE_IF_EXTRA+CLEAR ; Goto.
SUB_RANDOM_MOD_ANIM_DISPLAY: ; 0B:09A3, 0x0169A3
    LDA RANDOM_VALS?[2] ; Load random.
    LSR A ; >> 1, /2
    BCC RTS ; 0 to carry, leave.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load displayed.
    EOR #$01 ; Invert.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
RTS: ; 0B:09B0, 0x0169B0
    RTS ; Leave.
SET_OBJ_ATTRS: ; 0B:09B1, 0x0169B1
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
EXIT_INIT: ; 0B:09C1, 0x0169C1
    JMP INIT_OBJECT[X]_DATA_FULL
S15_EXG_RTN_B: ; 0B:09C4, 0x0169C4
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do sub.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BEQ HOLD_ZERO ; == 0, goto.
    JSR SUB_RANDOM_MOD_ANIM_DISPLAY ; Random display.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR SUB_MORE_IF_EXTRA+CLEAR ; Do
    LDA #$21
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
S15_EXG_RTN_C: ; 0B:09DC, 0x0169DC
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE HOLD_NOT_EXPIRED ; Not expired, goto.
HOLD_ZERO: ; 0B:09E4, 0x0169E4
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    LDY OBJ_TERTIARY_SWITCH?[18],X ; Load tert
    LDA ENEMY_UNK_EXTRA_DATA,Y
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    LDA ENEMY_UNK_DISPLAY_DATA,Y
    BEQ EXIT_INIT ; == 0, skip.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set otherwise.
HOLD_NOT_EXPIRED: ; 0B:09FD, 0x0169FD
    JSR MOVE_Y_FINALIZE ; Do.
SUB_MORE_IF_EXTRA+CLEAR: ; 0B:0A00, 0x016A00
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load extra.
    BEQ SKIP_RTN ; == 0, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do if has extra.
SKIP_RTN: ; 0B:0A08, 0x016A08
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
OBJ_ANIM_DISPLAY_DATA: ; 0B:0A0D, 0x016A0D
    RTS ; Leave. Mistake? TODO: Solve.
    .db 01
ENEMY_UNK_EXTRA_DATA: ; 0B:0A0F, 0x016A0F
    .db 02
    .db 03
    .db 00
    .db 00
    .db 89
    .db 8A
    .db 00
S15_EXTRA_H: ; 0B:0A16, 0x016A16
    LOW(S15_EXH_RTN_A) ; Does a smol.
    HIGH(S15_EXH_RTN_A)
S15_EXH_RTN_A: ; 0B:0A18, 0x016A18
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    BCS EXIT_INIT ; Ret CS, exit init.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC EXIT_SET_EXTRA ; Ret CC, goto.
EXIT_INIT: ; 0B:0A22, 0x016A22
    JMP INIT_OBJECT[X]_DATA_FULL ; Abuse RTS.
EXIT_SET_EXTRA: ; 0B:0A25, 0x016A25
    LDA #$8B
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    RTS ; Leave.
S15_EXTRA_K: ; 0B:0A2B, 0x016A2B
    LOW(S15_EXK_RTN_A) ; Smol.
    HIGH(S15_EXK_RTN_A)
S15_EXK_RTN_A: ; 0B:0A2D, 0x016A2D
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do rtn.
    BCS EXIT_INIT ; Ret CS, gotro.
    JSR XPOS_RTN_RET_?? ; Do rtn.
    BCC CONTINUE_RTN ; Ret CC, don't exit.
EXIT_INIT: ; 0B:0A37, 0x016A37
    JMP INIT_OBJECT[X]_DATA_FULL ; Init exit.
CONTINUE_RTN: ; 0B:0A3A, 0x016A3A
    LDA #$AF
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    RTS ; Leave.
S15_EXTRA_I: ; 0B:0A40, 0x016A40
    LOW(S15_EXI_RTN_A) ; The usual.
    HIGH(S15_EXI_RTN_A)
    LOW(S15_EXI_RTN_B) ; More usual.
    HIGH(S15_EXI_RTN_B)
    LOW(S15_EXI_RTN_B)
    HIGH(S15_EXI_RTN_B)
    LOW(S15_EXI_RTN_B)
    HIGH(S15_EXI_RTN_B)
S15_EXI_RTN_A: ; 0B:0A48, 0x016A48
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do routine.
    LDA #$40
    JSR MOVE_UNK_RET_?? ; Do.
    BCS SET_ATTRS+SOUND ; Ret CS, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set.
    JSR UNK_SUB_A ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    JMP EXIT_CLEAR_EXTRA_B ; Goto.
SET_ATTRS+SOUND: ; 0B:0A65, 0x016A65
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$21
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_CLEAR_EXTRA_B: ; 0B:0A74, 0x016A74
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    RTS ; Leave.
S15_EXI_RTN_B: ; 0B:0A7A, 0x016A7A
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE EXIT_IDK ; != 0, goto.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    LDY OBJ_TERTIARY_SWITCH?[18],X ; Index from tert.
    LDA #$C6
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    LDA OBJ_ANIM_DISPLAY_DATA,Y ; Load anim display.
    BEQ EXIT_INIT ; == 0, exit.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim display.
EXIT_IDK: ; 0B:0A97, 0x016A97
    JMP SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do, abuse RTS.
EXIT_INIT: ; 0B:0A9A, 0x016A9A
    JMP INIT_OBJECT[X]_DATA_FULL
S15_EXTRA_J: ; 0B:0A9D, 0x016A9D
    LOW(S15_EXJ_RTN_A) ; Maybe made by different person? Weird layout, usual stuff.
    HIGH(S15_EXJ_RTN_A)
RTN_BACKGROUND_TILE_RELATED?: ; 0B:0A9F, 0x016A9F
    STY TMP_00 ; Store OBJ Xpos.
    LDY LEVEL/SCREEN_ON ; Load screen
    CPY #$02 ; If _ #$02
    BNE SCREEN_NE_TWO ; !=, goto.
    SEC ; Prep sub.
    SBC #$34 ; Sub from A. A is pos, but unk what.
    BCS SUB_NO_UNDERFLOW ; No underflow, >= 0x34
    BCC SUB_UNDERFLOW ; Underflow
SCREEN_NE_TWO: ; 0B:0AAE, 0x016AAE
    SEC ; Prep sub.
    SBC #$30 ; Sub from A.
    BCC SUB_UNDERFLOW ; Underflow.
SUB_NO_UNDERFLOW: ; 0B:0AB3, 0x016AB3
    CLC ; Prep add
    ADC 81_UNK ; Add with val.
    BCS SUBTRACT_0xC0 ; Overflow, do sub.
    CMP #$C0 ; If _ #$C0
    BCC ADD_NO_OVERFLOW_LT_0xC0 ; <, goto.
SUBTRACT_0xC0: ; 0B:0ABC, 0x016ABC
    SBC #$C0 ; Subtract is already seeded, carry set here both ways. Val?
ADD_NO_OVERFLOW_LT_0xC0: ; 0B:0ABE, 0x016ABE
    AND #$F0 ; Keep upper.
    LSR A ; >> 1, /2.
    STA TMP_01 ; To TMP.
    CLC ; Prep add.
    LDA TMP_00 ; Load  OBJ Xpos.
    ADC B1_SCROLL_X_COPY_IRQ_ZP[2] ; Add with scroll.
    PHA ; Save
    ROL A ; << 1, *2.
    EOR NAMETABLE_FOCUS_VAL?[2] ; Invert focus.
    STA TMP_00 ; Store to TMP.
    PLA ; Pull added positions.
    LSR A ; >> 5, /16
    LSR A
    LSR A
    LSR A
    LSR A
    PHP ; Save status, for carry later.
    ORA TMP_01 ; Or val with store upper shifted.
    LSR TMP_00 ; >> 1, /2. Val is Xpos with scroll, inverted with screen focus.
    BCC SKIP_ADD ; Carry clear, skip add.
    ADC #$5F ; Add 0x60, carry set here.
SKIP_ADD: ; 0B:0ADD, 0x016ADD
    TAY ; To Y index.
    LDA 740_UNK,Y ; Load val from index.
    PLP ; Restore status.
    PHP ; Save for recall again.
    BCC SKIP_UPP_TO_LOWER_SHIFT ; CC on status, goto.
    LSR A ; >> 4, /16. Move upper to lower.
    LSR A
    LSR A
    LSR A
SKIP_UPP_TO_LOWER_SHIFT: ; 0B:0AE9, 0x016AE9
    PLP ; Pull status again.
    AND #$0F ; Keep bottom bits.
UNDERFLOW_REENTRY: ; 0B:0AEC, 0x016AEC
    STA 8C_UNK ; Store to.
    RTS ; Leave.
SUB_UNDERFLOW: ; 0B:0AEF, 0x016AEF
    LDA #$00 ; Load
    BEQ UNDERFLOW_REENTRY ; Always taken.
UNK_SUB_B: ; 0B:0AF3, 0x016AF3
    JSR RTN_BACKGROUND_TILE_RELATED?
    TAY
    LDA BG_DATA_RELATED?,Y
    RTS
BG_DATA_RELATED?: ; 0B:0AFB, 0x016AFB
    .db 00
    .db 00
    .db 00
    .db 01
    .db 00
    .db 02
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
SUB_UNK: ; 0B:0B0B, 0x016B0B
    LDA #$06
    STA TMP_06
    LDY OBJ_POS_X?[18],X
    LDA OBJ_POS_X??[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR RTN_BACKGROUND_TILE_RELATED?
    BCC 0B:0B42
    ASL A
    ASL A
    ASL A
    ASL A
    CMP #$50
    BEQ 0B:0B62
    CPY #$08
    BCC 0B:0B60
    CPY #$60
    BCC 0B:0B32
    CPY #$68
    BCC 0B:0B60
    TYA
    SEC
    SBC #$08
    TAY
    LDA 740_UNK,Y
    AND #$F0
    DEC TMP_07
    BNE 0B:0B22
    BEQ 0B:0B60
    CMP #$05
    BEQ 0B:0B62
    CPY #$08
    BCC 0B:0B60
    CPY #$60
    BCC 0B:0B52
    CPY #$68
    BCC 0B:0B60
    TYA
    SEC
    SBC #$08
    TAY
    LDA 740_UNK,Y
    AND #$0F
    DEC TMP_07
    BNE 0B:0B42
    CLC
    RTS
    SEC
    RTS
OBJ_DATA_EXTRA_FLAGS: ; 0B:0B64, 0x016B64
    .db 00 ; 1 = True
    .db 00
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
NEXT_OBJ_INDEX_PER_STATE: ; 0B:0B7A, 0x016B7A
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 06
    .db 00
    .db 07
    .db 00
    .db 00
    .db 00
    .db 09
    .db 08
    .db 00
    .db 00
    .db 00
    .db 00
OBJ_DATA_INDEX_UNK: ; 0B:0B90, 0x016B90
    .db 00
    .db 00
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
HEALTHS_PER_STATE: ; 0B:0BA5, 0x016BA5
    .db FF
    .db FF
    .db FF
    .db 80
    .db FF
    .db 80
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db 80
    .db FF
    .db FF
    .db FF
COMPARE_PER_SCREEN_UNK: ; 0B:0BBB, 0x016BBB
    .db 24
    .db 24
    .db 1C
    .db 17
    .db 15
    .db 0F
    .db 0B
    .db 06
    .db 0A
    .db 0C
    .db 09
    .db 09
    .db 09
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
COMPLETE_STATE_DATA: ; 0B:0BDC, 0x016BDC
    .db 00
    .db 00
    .db 00
    .db 00
    .db 06
    .db 07
    .db 08
    .db 07
    .db 06
    .db 07
    .db 08
    .db 07
    .db 06
    .db 07
    .db 08
    .db 07
    .db 13
    .db 14
    .db 15
    .db 14
    .db 06
    .db 07
    .db 08
    .db 07
    .db 1F
    .db 20
    .db 21
    .db 20
    .db 06
    .db 07
    .db 08
    .db 07
    .db 2D
    .db 2E
    .db 2F
    .db 2E
    .db 40
    .db 41
    .db 42
    .db 41
    .db 4C
    .db 4D
    .db 4E
    .db 4D
    .db 06
    .db 07
    .db 08
    .db 07
    .db 06
    .db 07
    .db 08
    .db 07
    .db 3C
    .db 3D
    .db 3E
    .db 3D
    .db 15
    .db 15
    .db 15
    .db 15
    .db 08
    .db 08
    .db 08
    .db 08
    .db 7A
    .db 7B
    .db 7A
    .db 7B
    .db 06
    .db 07
    .db 08
    .db 07
    .db 06
    .db 07
    .db 08
    .db 07
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 8C
    .db 8D
    .db 8E
    .db 8D
    .db 94
    .db 95
    .db 96
    .db 95
    .db 9A
    .db 9B
    .db 9C
    .db 9B
    .db 8C
    .db 8D
    .db 8E
    .db 8D
STATE_DATA_LOAD: ; 0B:0C64, 0x016C64
    .db 00
    .db 00
    .db 1E
    .db 21
    .db 00
    .db 00
    .db 20
    .db 00
    .db 1F
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
DATA_OBJ_EXISTS: ; 0B:0C8C, 0x016C8C
    .db 00
DATA_WORDS: ; 0B:0C8D, 0x016C8D
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 15
    .db 12
    .db 16
    .db 1D
    .db 17
    .db 1C
    .db 00
    .db 00
    .db 18
    .db 25
    .db 00
    .db 00
    .db 19
    .db 45
    .db 1A
    .db 52
    .db 1B
    .db 3A
    .db 1C
    .db 38
    .db 1D
    .db 3F
    .db 16
    .db 1D
    .db 18
    .db 25
    .db 00
    .db 00
    .db 21
    .db 89
    .db 22
    .db 9F
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
S15_DATA_A: ; 0B:0CBA, 0x016CBA
    .db 00
    .db 00
    .db 00
    .db 01
    .db 02
    .db 03
    .db 00
    .db 04
    .db 00
    .db 05
    .db 06
    .db 07
    .db 08
    .db 09
    .db 0A
    .db 0B
    .db 00
    .db 0C
    .db 0D
    .db 00
    .db 00
    .db 00
S15_DATA_B: ; 0B:0CD0, 0x016CD0
    .db 00
DATA_UNK: ; 0B:0CD1, 0x016CD1
    .db 00
DATA_C: ; 0B:0CD2, 0x016CD2
    .db 00
DATA_D: ; 0B:0CD3, 0x016CD3
    .db 00
DATA_E: ; 0B:0CD4, 0x016CD4
    .db 00
DATA_F: ; 0B:0CD5, 0x016CD5
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db EF
    .db 00
    .db 03
    .db A0
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db E2
    .db 00
    .db 04
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db E4
    .db 00
    .db 02
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db E2
    .db 00
    .db 02
    .db 80
    .db FE
    .db 00
    .db 00
    .db 14
    .db E2
    .db 00
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0F
    .db D8
    .db 80
    .db 03
    .db 00
    .db FF
    .db 00
    .db 00
    .db 0A
    .db EF
    .db 80
    .db 03
    .db C0
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0A
    .db DA
    .db 80
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
ANIMATION_FROM_STATE: ; 0B:0D40, 0x016D40
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 4F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 80
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 50
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 81
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db 05
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
L_0B:0FDE: ; 0B:0FDE, 0x016FDE
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
L_0B:11A0: ; 0B:11A0, 0x0171A0
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
L_0B:14EB: ; 0B:14EB, 0x0174EB
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db 2B

    .db 0E
IDK_CODE: ; 17:0001, 0x02E001
    SEC ; Prep sub.
    LDA 4C6_OBJ_UNK[18],Y ; Load
    SBC #$18 ; If _ #$18
    BMI VAL_NEGATIVE ; Negative, goto.
    LDA #$80 ; Seed val.
VAL_NEGATIVE: ; 17:000B, 0x02E00B
    STA TMP_0D ; Store val.
    LDA 4C6_OBJ_UNK[18],X ; Load
    STA TMP_0F ; Store to.
L_17:0012: ; 17:0012, 0x02E012
    JSR TONS_OF_MATH_AND_INVERTS_TODO ; Do sub.
    SEC ; Prep sub.
    SBC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Sub with.
    BPL RESULT_POSITIVE
    CLC ; Prep add.
    ADC #$20 ; Add val.
    AND #$1F ; Keep bits.
RESULT_POSITIVE: ; 17:0020, 0x02E020
    TAY ; To Y index.
    BEQ Y_EQ_ZERO ; == 0, goto.
    CMP #$10 ; If _ #$10
    LDA #$FE ; Val.
    BCS VAL_GTE_0x10
    LDA #$01 ; Alt val.
VAL_GTE_0x10: ; 17:002B, 0x02E02B
    ADC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Add with.
    AND #$1F ; Keep bits.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store back.
    LDY #$02 ; Val.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load.
    JSR MORE_TONS_OF_CRAP ; Do sub.
    LDA TMP_08 ; Load TMP's.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store to OBJ.
    LDA TMP_09
    STA OBJ_POS_X_DELTA?[18],X
    LDA TMP_0A
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_0B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
Y_EQ_ZERO: ; 17:004F, 0x02E04F
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do.
    BCC L_17:0070 ; CC, goto.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    BMI L_17:0062 ; Negative, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE CLEAR_ATTR ; != 0, goto.
    LDA #$01
    BNE STORE_ATTR ; != 0, goto.
L_17:0062: ; 17:0062, 0x02E062
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE CLEAR_ATTR ; != 0, goto.
    LDA #$02 ; Store attr.
    BNE STORE_ATTR ; Always taken, store as-is.
CLEAR_ATTR: ; 17:006B, 0x02E06B
    LDA #$00 ; Clear val.
STORE_ATTR: ; 17:006D, 0x02E06D
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store.
L_17:0070: ; 17:0070, 0x02E070
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BEQ VAL_EQ_ZERO
    CMP #$01 ; If _ #$01
    BNE NE_0x01 ; !=, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; A from.
    CMP #$40 ; If _ #$40
    BCC VAL_EQ_ZERO ; <, goto.
    LDA #$3F ; Seed highest val.
    STA OBJ_POS_X_CONFIRMED[18],X ; Set attr.
    JMP VAL_EQ_ZERO ; Goto.
NE_0x01: ; 17:0088, 0x02E088
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$C0 ; If _ #$C0
    BCS VAL_EQ_ZERO ; >=, goto.
    LDA #$C0
    STA OBJ_POS_X_CONFIRMED[18],X ; Seed lowest.
VAL_EQ_ZERO: ; 17:0094, 0x02E094
    JSR MOVE_UNK_RET_CS_POS_CS_NEG ; Do.
    LDY 4C6_OBJ_UNK[18],X ; Y from.
    LDA #$08 ; A =
    CPY #$08 ; If _ #$08
    BCC OOB_FIX ; <, goto.
    LDA #$F8 ; A =
    CPY #$F8 ; If _ #%F8
    BCC LT_0xF8 ; <, goto.
OOB_FIX: ; 17:00A6, 0x02E0A6
    STA 4C6_OBJ_UNK[18],X ; Store out of bounds fixed val.
LT_0xF8: ; 17:00A9, 0x02E0A9
    JSR L_17:011D ; Do.
    JSR MOVE_UNK_RET_?? ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI VAL_NEGATIVE ; If negative, goto.
    SEC ; Prep sub.
    LDA OBJ_POS_X??[18],X ; Load
    SBC #$80 ; -= 0x80.
    BCC EXIT_NO_ANIM ; Underflow, goto.
    STA TMP_00 ; Store result.
    SEC ; Prep sub.
    LDA #$80 ; Load
    SBC 4C6_OBJ_UNK[18],X ; Sub with.
    EOR #$FF ; Compliment result.
    CLC
    ADC #$01
    CLC ; Prep add.
    ADC TMP_00 ; Add with.
    BCC EXIT_NO_ANIM ; No overflow, no anim.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store result.
    JMP L_17:00DD ; Goto.
VAL_NEGATIVE: ; 17:00D4, 0x02E0D4
    CLC ; Prep add.
    ADC OBJ_POS_X??[18],X ; Add with.
    BCC EXIT_NO_ANIM ; No overflow, goto.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store result.
L_17:00DD: ; 17:00DD, 0x02E0DD
    JSR HOLD/ANIM_HELPER ; Do.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$02 ; If _ #$02
    BNE RTS ; !=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE RTS ; Set, goto.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; LKoad
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    BNE RTS ; If any bits set, leave.
    SEC ; Prep sub.
    LDA OBJ_POS_Y_CONFIRMED+17,X ; Load -1Pair
    SBC OBJ_POS_X_CONFIRMED[18],X ; Sub with us.
    BPL RESULT_POSITIVE ; Positive, goto.
    EOR #$FF ; Invert result.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 17:0102, 0x02E102
    CMP #$08 ; If _ #$08
    BCS RTS ; >=, leave.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP #$98 ; If _ #$98
    BCC RTS ; <, leave.
    CMP #$C0 ; If _ #$C0
    BCS RTS ; >=, leave.
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary otherwise. Shredder moving maybe?
RTS: ; 17:0116, 0x02E116
    RTS ; Leave.
EXIT_NO_ANIM: ; 17:0117, 0x02E117
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Show no animation.
    RTS
L_17:011D: ; 17:011D, 0x02E11D
    LDY OBJ_SECONDARY_SWITCH?[18],X
    DEY
    BEQ L_17:0143
    SEC
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    SBC OBJ_POS_X??[18],X
    STA TMP_00
    BPL L_17:0133
    EOR #$FF
    CLC
    ADC #$01
L_17:0133: ; 17:0133, 0x02E133
    CMP #$03
    LDY #$00
    BCC L_17:0164
    LDY #$02
    LDA TMP_00
    BMI L_17:0164
    LDY #$04
    BNE L_17:0164
L_17:0143: ; 17:0143, 0x02E143
    SEC
    LDY 5C2_OBJ_DATA_PTR/MISC_INDEX+17,X
    LDA OBJ_POS_X??[18],Y
    SBC OBJ_POS_X??[18],X
    STA TMP_00
    BPL L_17:0156
    EOR #$FF
    CLC
    ADC #$01
L_17:0156: ; 17:0156, 0x02E156
    CMP #$04
    LDY #$00
    BCC L_17:0164
    LDY #$02
    LDA TMP_00
    BMI L_17:0164
    LDY #$04
L_17:0164: ; 17:0164, 0x02E164
    LDA L_17:0171,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA L_17:0172,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
L_17:0171: ; 17:0171, 0x02E171
    .db 00
L_17:0172: ; 17:0172, 0x02E172
    .db 00
    .db C0
    .db FF
    .db 40
    .db 00
STATE_0x71_SUBSWITCH_C: ; 17:0177, 0x02E177
    CLC ; Prep add.
    LDA OBJ_POS_X_DELTA?+17,X ; Load
    ADC OBJ_POS_X_SUBPIXEL?[18],X ; Add with.
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store to.
    LDA 4D8_OBJ_UNK+17,X ; Load -1Pair
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add with.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Load -1 pair.
    STA OBJ_POS_X??[18],X ; Store to.
    LDA OBJ_ENABLED_STATE+MORE?+17,X ; Load
    AND #$40 ; Keep bit.
    EOR #$40 ; Invert.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    LDA #$C8
    STA OBJ_ANIMATION_DISPLAY[18],X ; sET ANIM.
    LDA #$00
    STA TMP_00 ; Clear TMP.
    SEC
    LDA OBJ_POS_Y_CONFIRMED+17,X ; -1Pair load.
    SBC OBJ_POS_X_CONFIRMED[18],X ; Suub with.
    BPL RESULT_POSITIVE
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 17:01B1, 0x02E1B1
    CMP #$04 ; If _ #$04
    BCS DIFF_GTE_0x04 ; >=, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$03 ; Keep bits.
    BNE RTS ; Any set, goto. 3 in 4 to leave.
    INC TMP_00 ; ++
DIFF_GTE_0x04: ; 17:01BD, 0x02E1BD
    LDA OBJ_POS_Y_CONFIRMED+17,X ; Load -1Pair
    CMP OBJ_POS_X_CONFIRMED[18],X ; If _ Us
    BEQ VAL_EQ ; ==, goto.
    LDA #$FF ; Val.
    BCC CMP_LT ; <, goto.
    LDA #$00 ; Val seed.
CMP_LT: ; 17:01CB, 0x02E1CB
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add to.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store back.
VAL_EQ: ; 17:01D1, 0x02E1D1
    LDA TMP_00 ; Load
    BEQ RTS ; Not set, leave.
    INC 4C6_OBJ_UNK[18],X ; Mod.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP #$C8 ; If _ #$C8
    BCC RTS ; <, goto.
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Clear attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Don't disp.
    DEX ; Mod obj.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from obj.
    AND #$FE ; Keep bits.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back, making even.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Move hold.
    JSR GFX/ANIM_HELPER ; Animate.
    INX ; Fix obj.
RTS: ; 17:01FA, 0x02E1FA
    RTS ; Leave.
NEW_OBJ_THINGY: ; 17:01FB, 0x02E1FB
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$01 ; Set bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    INX ; Next obj.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attrs.
    LDA #$BB
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$05
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA OBJ_ENABLED_STATE+MORE?+17,X ; Move from handling to this.
    AND #$40 ; Keep bit.
    EOR #$40 ; Invert it.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to new.
    LDA OBJ_POS_Y_CONFIRMED+17,X ; Move from handling.
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Move from handling.
    STA OBJ_POS_X??[18],X
    LDA #$C8
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$00
    STA OBJ_POS_X_DELTA?[18],X ; Clear attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JSR HOLD/ANIM_HELPER ; Do.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Mistake again, lol. Not stored to.
    RTS ; Leave.
HOLD/ANIM_HELPER: ; 17:0258, 0x02E258
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE
    LDA #$05
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
HOLD_POSITIVE: ; 17:0265, 0x02E265
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Range bits.
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Load from arr.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to anim.
    RTS ; Leave.
OBJ_DATA: ; 17:0272, 0x02E272
    .db C8
    .db C9
    .db CA
    .db CB
    LDA #$01
    STA FLAG_RUN_CORE_SWITCH?
    JSR SOUND_RESET/INIT_RTN?
    LDA #$7E
    JSR SND_BANKED_DISPATCH
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$04
    STA OBJ_POS_X_SUBPIXEL?[18],X
    LDA #$96
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    JMP SET_GFX/ANIM_HELPER
RTN_A: ; 17:02AD, 0x02E2AD
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR SET_GFX/ANIM_HELPER ; Do.
    INC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; ++
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    CMP #$32 ; If _ #$32
    BCC VAL_LT_0x32 ; <, goto.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear attr.
VAL_LT_0x32: ; 17:02C4, 0x02E2C4
    CMP #$13 ; If _ #$13
    BCC LT_0x13 ; <, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$01 ; Keep bit.
    BNE LT_0x13 ; BIT_SET
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear. 50% chance to.
LT_0x13: ; 17:02D1, 0x02E2D1
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear attrs.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JSR SET_GFX/ANIM_HELPER ; Do.
    LDA #$5B
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
COUNT_ALL_OBJS_0x73_COUNT_CMP_#$05: ; 17:02E9, 0x02E2E9
    LDA #$00
    STA TMP_07 ; Clear count.
    LDY #$07 ; Obj start.
CHECK_ALL_OBJS: ; 17:02EF, 0x02E2EF
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from obj.
    CMP #$73 ; If _ #$73
    BNE VAL_NE
    INC TMP_07 ; ++ matched.
VAL_NE: ; 17:02F8, 0x02E2F8
    INY ; Next obj.
    CPY #$12 ; If _ #$12
    BCC CHECK_ALL_OBJS ; <, check all, loop.
    LDA TMP_07 ; Load count.
    CMP #$05 ; If _ #$05
    RTS ; RTS after CMP.
RTN_B: ; 17:0302, 0x02E302
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
    BPL RTS ; If positive, leave.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from.
    LDA OBJ_DATA_A,Y ; Load
    CMP #$80 ; If _ #$80
    BEQ VAL_EQ_0x80 ; ==, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Move attrs to TMP.
    STA TMP_00
    LDA OBJ_POS_X??[18],X
    STA TMP_01
    JSR COUNT_ALL_OBJS_0x73_COUNT_CMP_#$05 ; Do.
    BCS EXIT_RESTORE ; >= 0x05, goto. Limit.
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Do.
    BCS OBJ_RECEIVED ; Received OBJ, goto.
EXIT_RESTORE: ; 17:032A, 0x02E32A
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load from scratch. Mistake, not stored. 3x now!
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
RTS: ; 17:0332, 0x02E332
    RTS ; Leave.
OBJ_RECEIVED: ; 17:0333, 0x02E333
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y from. Mistake. TODO: Why this stuff.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],Y ; A from Yobj.
    TAY ; to index.
    CLC ; Prep add.
    LDA OBJ_DATA_A,Y ; Load data.
    ADC TMP_00 ; Add with.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to.
    ROR A ; Rotate
    EOR OBJ_DATA_A,Y ; Invert with data.
    BMI VAL_NEGATIVE ; If negative, goto.
    LDA OBJ_DATA_B,Y ; Load.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    INC TMP_01 ; ++
    LDA TMP_01 ; Load
    STA OBJ_POS_X??[18],X ; Store to obj.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK[18],X ; Add with.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to.
    ROR A ; Rotate
    EOR OBJ_DATA_B,Y ; Invert with data.
    BMI VAL_NEGATIVE ; If negative, goto.
    LDA #$73
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set enable.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Small hold.
VAL_NEGATIVE: ; 17:037A, 0x02E37A
    INY ; Next Yobj pair.
    INY
    TYA ; to A.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore from scratch. Mistake, not stored.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store Yobj val to our obj.
    LDA #$05
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    RTS ; Leave.
VAL_EQ_0x80: ; 17:0389, 0x02E389
    DEC OBJ_POS_X_SUBPIXEL?[18],X ; --
    LDA OBJ_POS_X_SUBPIXEL?[18],X ; Load
    CMP #$02 ; If _ #$02
    BCS VAL_GTE_0x02 ; >=, goto.
    LDA #$D2
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$D3
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA #$D5
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear attr.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
VAL_GTE_0x02: ; 17:03AD, 0x02E3AD
    LDA OBJ_POS_X_SUBPIXEL?[18],X ; Load
    BEQ EXIT_STATE_MOD ; == 0, goto.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear attrs.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JMP RTN_B ; Goto alt rtn.
EXIT_STATE_MOD: ; 17:03BD, 0x02E3BD
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
    LDA #$20
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    RTS ; Leave.
OBJ_DATA_A: ; 17:03CB, 0x02E3CB
    .db 18
OBJ_DATA_B: ; 17:03CC, 0x02E3CC
    .db E8
    .db F4
    .db F4
    .db 10
    .db CC
    .db E8
    .db D8
    .db 00
    .db E8
    .db 00
    .db C4
    .db E8
    .db F0
    .db EC
    .db C8
    .db 10
    .db F0
    .db 00
    .db D8
    .db 80
    .db 80
OBJ_STATE_0x73_HANDLER: ; 17:03E1, 0x02E3E1
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim disp.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Next index.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$03 ; If _ #$03
    BEQ BITS_EQ_ZERO ; ==, goto.
    BCC RTS ; <, goto.
    JMP INIT_OBJECT[X]_DATA_FULL ; >=, die.
BITS_EQ_ZERO: ; 17:0402, 0x02E402
    DEC OBJ_ANIMATION_DISPLAY[18],X ; --
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
RTS: ; 17:040A, 0x02E40A
    RTS ; Leave.
RTN_C: ; 17:040B, 0x02E40B
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; A from.
    LDY #$00 ; Val A.
    CMP #$01 ; If _ #$01
    BEQ VAL_MATCH ; ==, goto.
    INY ; Val B.
    CMP #$18 ; If _ #$18
    BEQ VAL_MATCH ; ==, goto.
    INY ; Val C.
    CMP #$30 ; If _ #$30
    BEQ VAL_MATCH ; ==, goto.
    CMP #$60 ; If _ #$60
    BCC RTS ; <, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$23
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim hold.
RTS: ; 17:0432, 0x02E432
    RTS ; Leave.
VAL_MATCH: ; 17:0433, 0x02E433
    STY TMP_02 ; Val to. Data to use.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Move attrs to TMP.
    STA TMP_00
    LDA OBJ_POS_X??[18],X
    STA TMP_01
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; STORE SCRATCHPAD, FINALLY. Not a mistake!
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Do.
    BCC RET_CC ; Failed to get, goto.
    LDA #$74 ; X is a new object here.
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set new obj's state.
    LDA TMP_01
    STA OBJ_POS_X??[18],X ; Store to new.
    DEC OBJ_POS_X??[18],X ; --
    LDA #$00
    STA OBJ_POS_Y_CONFIRMED[18],X ; Clear attrs.
    STA 4B4_OBJ_SPEED?[18],X
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA #$02
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Set attr.
    LDA #$01
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    LDY TMP_02 ; Y from, data to use.
    LDA OBJ_DATA_A,Y ; Load
    CLC ; Prep add.
    ADC TMP_00 ; Add to.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to obj.
    LDA OBJ_DATA_B,Y ; Load.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to.
    SEC ; Prep sub.
    LDA TMP_01 ; Load
    SBC #$08 ; -= 0x08.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store to.
    JMP EXIT_CREATED ; Goto.
RET_CC: ; 17:0485, 0x02E485
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --, don't move until we spawn it.
EXIT_CREATED: ; 17:0488, 0x02E488
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore Xobj.
RTS: ; 17:048B, 0x02E48B
    RTS ; Leave.
OBJ_DATA_A: ; 17:048C, 0x02E48C
    .db 00
    .db F2
    .db 0E
OBJ_DATA_B: ; 17:048F, 0x02E48F
    .db D9
    .db D8
    .db D8
OBJ_STATE_0x74_HANDLER: ; 17:0492, 0x02E492
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA #$20 ; Load
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add with.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store back.
    BCC NO_OVERFLOW
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; Carry inc.
NO_OVERFLOW: ; 17:04A5, 0x02E4A5
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store to.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC OBJ_POS_Y_CONFIRMED[18],X ; Add with.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to.
    CMP STATUS_FLAGS_B/OBJ_FOCUS[18],X ; If _ attr
    BCC RTS ; <, goto.
    LDA #$4C
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP INIT_OBJECT[X]_DATA_FULL ; Die.
RTN_D: ; 17:04C5, 0x02E4C5
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Mod.
    LDA #$23
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
RTS: ; 17:04DA, 0x02E4DA
    RTS ; Leave.
RTN_E: ; 17:04DB, 0x02E4DB
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Mod anim.
    LDA #$50
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
RTS: ; 17:04F0, 0x02E4F0
    RTS ; Leave.
RTN_F: ; 17:04F1, 0x02E4F1
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    LDA #$FF
    STA 5F8_OBJ_SETS_UNK ; Set ??
    INX ; Next obj.
    JSR INIT_OBJECT[X]_DATA_FULL ; Kill.
    INX ; And after.
    JSR INIT_OBJECT[X]_DATA_FULL ; Kill.
    DEX ; Back to us.
    DEX
RTS: ; 17:050A, 0x02E50A
    RTS ; Leave.
OBJ_STATE_0x75_HANDLER: ; 17:050B, 0x02E50B
    JSR BOSS_COUNTERS_MOD? ; Do.
    JSR BLINK_HANDLER ; Blink.
    JSR OBJ_HEALTH_THINGS/STATE_STUFF ; Do.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; LOad
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on.
    LOW(STATE_0x75_ALT_SWITCH)
    HIGH(STATE_0x75_ALT_SWITCH)
    LOW(STATE_0x75_SWITCH_B)
    HIGH(STATE_0x75_SWITCH_B)
    LOW(STATE_0x75_SWITCH_C)
    HIGH(STATE_0x75_SWITCH_C)
    LOW(STATE_0x75_SWITCH_D)
    HIGH(STATE_0x75_SWITCH_D)
    LOW(STATE_0x75_SWITCH_E)
    HIGH(STATE_0x75_SWITCH_E)
    LOW(STATE_0x75_SWITCH_F)
    HIGH(STATE_0x75_SWITCH_F)
STATE_0x75_ALT_SWITCH: ; 17:0526, 0x02E526
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x75_ALTSWITCH_A)
    HIGH(STATE_0x75_ALTSWITCH_A)
    LOW(STATE_0x75_ALTSWITCH_B)
    HIGH(STATE_0x75_ALTSWITCH_B)
    LOW(STATE_0x75_ALTSWITCH_C)
    HIGH(STATE_0x75_ALTSWITCH_C)
STATE_0x75_ALTSWITCH_A: ; 17:0532, 0x02E532
    LDA #$DC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDY #$21
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set color.
    LDA #$70 ; Val.
    LDY TWO_PLAYERS_FLAG ; 2P?
    BEQ 1P_GAME ; Not set, goto.
    LDA #$90 ; 2P health.
1P_GAME: ; 17:0547, 0x02E547
    STA OBJECT_DATA_HEALTH?[18],X ; Store health.
    LDA #$17
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$DA
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JSR OBJECT_X_MOVE? ; Do.
    LDA #$60
    JMP SND_BANKED_DISPATCH ; Play sound.
STATE_0x75_ALTSWITCH_B: ; 17:0564, 0x02E564
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDA #$C0
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set attr.
    LDA #$20
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDY #$00 ; File.
    JSR RTN_ANIMATION_INITD ; Do.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_MOVE: ; 17:057B, 0x02E57B
    JMP OBJECT_X_MOVE? ; Goto. Abuse RTS.
STATE_0x75_ALTSWITCH_C: ; 17:057E, 0x02E57E
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
VAL_NONZERO: ; 17:058B, 0x02E58B
    LDY #$00 ; File.
    JSR RTN_ANIMATION_CONTINUE ; Do.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x75_SWITCH_B: ; 17:0593, 0x02E593
    LDA #$DC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Mod GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    JSR FIND_PLAYER_FOCUS_HELPER ; Focus.
    LDY #$00 ; File.
    JSR RTN_ANIMATION_INITD ; Do.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP OBJECT_X_MOVE? ; Move.
STATE_0x75_SWITCH_C: ; 17:05AF, 0x02E5AF
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_0x75_RTN_A)
    HIGH(SWITCH_0x75_RTN_A)
    LOW(SWITCH_0x75_RTN_B)
    HIGH(SWITCH_0x75_RTN_B)
SWITCH_0x75_RTN_A: ; 17:05B9, 0x02E5B9
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Get focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary of focus.
    AND #$08 ; Keep bit.
    BEQ BIT_NOT_SET ; Not set, goto.
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary if set.
    JMP OBJECT_X_MOVE? ; Exit.
BIT_NOT_SET: ; 17:05CF, 0x02E5CF
    JSR SET_FOCUS_LEFT/RIGHT_FLAG_FOR_OBJ_X->Y ; Move L/R.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_00 ; Store.
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_01 ; Store.
    LDA 709_UNK_CB_INDEX ; Load
    AND #$02 ; Test bit.
    BNE BIT_SET
    LDA 708_UNK ; Load
    CMP #$10 ; If _ #$10
    BCS BIT_SET ; >=, goto.
REENTER: ; 17:05EA, 0x02E5EA
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
BIT_SET: ; 17:05F0, 0x02E5F0
    LDA TMP_00 ; Load
    CMP #$28 ; If _ #$28
    BCS OOB_A ; >=, goto.
    LDA TMP_01 ; Load
    CMP #$0A ; If _ #$0A
    BCS OOB_B ; >=, goto.
    BCC LT_BOTH_VALS ; <, goto.
OOB_A: ; 17:05FE, 0x02E5FE
    LDA TMP_01 ; Load
    CMP #$08 ; If _ #$08
    BCC OOR_LT_0x08 ; <, goto.
    LDA TMP_12 ; Load
    ASL A ; << 1, *2.
    ORA TMP_10 ; Or with val.
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_DELTA?[18],X ; Set attrs from data.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_C,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA OBJ_DATA_D,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    JMP EXIT_ANIM_CONTINUE ; Goto.
OOB_B: ; 17:0627, 0x02E627
    LDA TMP_10 ; Load
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_E,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Attrs from data.
    LDA OBJ_DATA_F,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    JMP EXIT_ANIM_CONTINUE ; Goto, abuse RTS.
OOR_LT_0x08: ; 17:063A, 0x02E63A
    LDA TMP_12 ; Load
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_G,Y
    STA OBJ_POS_X_DELTA?[18],X ; Attrs from data.
    LDA OBJ_DATA_H,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
EXIT_ANIM_CONTINUE: ; 17:064A, 0x02E64A
    LDY #$00 ; File.
    JSR RTN_ANIMATION_CONTINUE ; Play sound.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
LT_BOTH_VALS: ; 17:0652, 0x02E652
    LDA 708_UNK ; Load
    CMP #$F0 ; If _ #$F0
    BCS REENTER ; >=, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_DATA_A: ; 17:0664, 0x02E664
    .db 01
OBJ_DATA_B: ; 17:0665, 0x02E665
    .db 00
OBJ_DATA_C: ; 17:0666, 0x02E666
    .db 00
OBJ_DATA_D: ; 17:0667, 0x02E667
    .db C0
    .db 01
    .db 00
    .db FF
    .db 40
    .db FF
    .db 00
    .db 00
    .db C0
    .db FF
    .db 00
    .db FF
    .db 40
OBJ_DATA_G: ; 17:0674, 0x02E674
    .db 01
OBJ_DATA_H: ; 17:0675, 0x02E675
    .db 00
    .db FF
    .db 00
OBJ_DATA_E: ; 17:0678, 0x02E678
    .db 00
OBJ_DATA_F: ; 17:0679, 0x02E679
    .db C0
    .db FF
    .db 40
SWITCH_0x75_RTN_B: ; 17:067C, 0x02E67C
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Focus obj.
    JSR SET_FOCUS_LEFT/RIGHT_FLAG_FOR_OBJ_X->Y ; Set flag.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_00 ; Store diff.
    CMP #$70 ; If _ #$70
    BCS EXIT_SWITCHES ; >=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$28 ; If _ #$28
    BCC EXIT_SWITCHES ; <, goto.
    BCS POS_GT_0x28 ; >=, goto.
VAL_EQ_ZERO: ; 17:069F, 0x02E69F
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$E0 ; If _ #$E0
    BCS EXIT_SWITCHES ; >=, goto.
POS_GT_0x28: ; 17:06A6, 0x02E6A6
    LDA TMP_12 ; Load.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_DELTA?[18],X ; Store attr.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDY #$02 ; File.
    JSR RTN_ANIMATION_CONTINUE ; Animate.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
EXIT_SWITCHES: ; 17:06BE, 0x02E6BE
    LDA #$04
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_DATA_A: ; 17:06C9, 0x02E6C9
    .db FD
OBJ_DATA_B: ; 17:06CA, 0x02E6CA
    .db 00
    .db 03
    .db 00
STATE_0x75_SWITCH_D: ; 17:06CD, 0x02E6CD
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_0x75_RTN_D_ALT_A)
    HIGH(SWITCH_0x75_RTN_D_ALT_A)
    LOW(SWITCH_0x75_RTN_D_ALT_B)
    HIGH(SWITCH_0x75_RTN_D_ALT_B)
    LOW(SWITCH_0x75_RTN_D_ALT_C)
    HIGH(SWITCH_0x75_RTN_D_ALT_C)
    LOW(SWITCH_0x75_RTN_D_ALT_D)
    HIGH(SWITCH_0x75_RTN_D_ALT_D)
    LOW(SWITCH_0x75_RTN_D_ALT_E)
    HIGH(SWITCH_0x75_RTN_D_ALT_E)
    LOW(SWITCH_0x75_RTN_D_ALT_F)
    HIGH(SWITCH_0x75_RTN_D_ALT_F)
    LOW(SWITCH_0x75_RTN_D_ALT_G)
    HIGH(SWITCH_0x75_RTN_D_ALT_G)
    LOW(SWITCH_0x75_RTN_D_ALT_H)
    HIGH(SWITCH_0x75_RTN_D_ALT_H)
SWITCH_0x75_RTN_D_ALT_A: ; 17:06E3, 0x02E6E3
    LDA #$DE
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDA #$E1
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_B: ; 17:0701, 0x02E701
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDA #$E2
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$C3
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$0A
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_MOVE: ; 17:0718, 0x02E718
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_C: ; 17:071B, 0x02E71B
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE
    LDA #$DC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA #$17
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDY #$00 ; File.
    JSR RTN_ANIMATION_INITD ; Animate.
    LDA #$1C
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_MOVE: ; 17:073A, 0x02E73A
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_D: ; 17:073D, 0x02E73D
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move switches.
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_MOVE: ; 17:074C, 0x02E74C
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_E: ; 17:074F, 0x02E74F
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDA #$DC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA #$DD
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JSR RTN_GET_OBJ_PAIR_IN_Y_RET_CC_SUCCESS ; Get OBJ.
    BCS EXIT_FAIL ; Fail, skip other code.
    LDA #$76
    STA OBJ_ENABLED_STATE+MORE?[18],Y ; Set state.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Move attrs to new.
    STA OBJ_POS_X_CONFIRMED[18],Y
    LDA OBJ_POS_X??[18],X
    STA OBJ_POS_X??[18],Y
    SEC ; Prep sub.
    SBC #$30 ; -= 0x30
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
    STA 4C6_OBJ_UNK[18],Y ; Store to.
    TXA ; X to A.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],Y ; Focus on creator.
    TYA ; New to A.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store new to creator.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_FAIL: ; 17:078E, 0x02E78E
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_F: ; 17:0791, 0x02E791
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary.
    CMP #$01 ; If _ #$01
    BNE EXIT_MOVE ; !=, goto.
    LDA #$04
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_MOVE: ; 17:07A3, 0x02E7A3
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_G: ; 17:07A6, 0x02E7A6
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load focus.
    JSR SET_FOCUS_LEFT/RIGHT_FLAG_FOR_OBJ_X->Y ; Do.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_16 ; Store diff.
    CMP #$C0 ; If _ #$C0
    BCS LARGE_DIFF ; >=, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$0F ; Keep bits.
    ASL A ; << 2, *4.
    ASL A
    CLC ; Prep add.
    ADC TMP_16 ; Add with.
    BCC NO_OVERFLOW
    LDA #$FF ; Max val.
NO_OVERFLOW: ; 17:07C7, 0x02E7C7
    STA TMP_16 ; Store result.
LARGE_DIFF: ; 17:07C9, 0x02E7C9
    LDA TMP_16 ; Load
    BPL VAL_POSITIVE ; If positive, goto.
    LDA #$80 ; Load if negative.
VAL_POSITIVE: ; 17:07CF, 0x02E7CF
    STA TMP_04 ; Store result.
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_15 ; Store to.
    STA TMP_02 ; Store to.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus from Xobj.
    STY TMP_17 ; Store to.
    LDA #$00
    STA TMP_01 ; Clear TMPs.
    STA TMP_03
    JSR EXTREME_RANDOMNESS_INIT ; Do.
    LDY TMP_17 ; Y from. Focus.
    LDA #$DF
    STA OBJ_ANIMATION_DISPLAY[18],Y ; Set attr of focus.
    LDA #$77
    STA OBJ_ENABLED_STATE+MORE?[18],Y ; Set state.
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],Y ; Init switches.
    STA OBJ_TERTIARY_SWITCH?[18],Y
    LDA TMP_16 ; Load
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Move data to TMP.
    STA TMP_0D
    LDA OBJ_DATA_B,Y
    STA TMP_0C
    LDY TMP_17 ; Y from. Focus.
    LDA TMP_0D ; Load
    STA OBJ_POS_X_DELTA?[18],Y ; To focus.
    LDA TMP_0C ; Load
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y ; To focus.
    LDA TMP_00 ; Load
    STA TMP_0E ; To.
    LDA TMP_01 ; Load
    STA TMP_0F ; To.
    JSR EXTREME_RANDOMNESS_2_INIT ; Do.
    LDY TMP_17 ; Y from.
    LDA TMP_09 ; Load
    STA 520_OBJ_POS_X_LARGE?[18],Y ; To focus.
    LDA TMP_0A ; Load
    STA 503_OBJ_POS_X_LARGEST?[18],Y ; To focus.
    LDA TMP_12 ; Load
    BEQ SKIP_INVERT_A ; == 0, goto.
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],Y ; Invert.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y ; Store back.
    LDA #$00 ; Prep invert.
    SBC OBJ_POS_X_DELTA?[18],Y ; Invert and carry.
    STA OBJ_POS_X_DELTA?[18],Y ; Store back.
SKIP_INVERT_A: ; 17:0843, 0x02E843
    LDA TMP_10 ; Load
    BEQ SKIP_INVERT_B
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC 520_OBJ_POS_X_LARGE?[18],Y ; Invert.
    STA 520_OBJ_POS_X_LARGE?[18],Y ; Store back.
    LDA 503_OBJ_POS_X_LARGEST?[18],Y ; Load
    SBC #$00 ; Subtract nothing.
    STA 503_OBJ_POS_X_LARGEST?[18],Y ; Store back. Probably a mistake, lol.
SKIP_INVERT_B: ; 17:0858, 0x02E858
    LDA TMP_16 ; Load
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_C,Y ; Move from data.
    STA TMP_01
    LDA OBJ_DATA_D,Y
    STA TMP_00
    LDA TMP_16 ; Load
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    TAY ; To Y index.
    LDA OBJ_DATA_E,Y
    LDY TMP_17 ; Load Y from.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],Y ; Store attr.
    LDA TMP_01
    STA 532_OBJ_UNK_POS_DELTA?[18],Y ; Attr from.
    LDA TMP_00
    STA 544_OBJ_UNK_POS_DELTA?[18],Y ; Attr from.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],Y ; Health.
    LDA #$C0
    STA OBJECT_DATA_EXTRA_B?[18],Y ; Set attr.
    LDA TMP_16
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Set attr.
    LDA #$78
    STA OBJ_ENABLED_STATE+MORE?+1,Y ; Set pair state.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$DE
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$0F
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_RTN_D_ALT_H: ; 17:08AA, 0x02E8AA
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
VAL_NE_ZERO: ; 17:08B9, 0x02E8B9
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_DATA_A: ; 17:08BC, 0x02E8BC
    .db 00
OBJ_DATA_B: ; 17:08BD, 0x02E8BD
    .db 20
    .db 00
    .db 40
    .db 00
    .db 60
    .db 00
    .db 80
    .db 00
    .db A0
    .db 00
    .db C0
    .db 00
    .db E0
    .db 01
    .db 00
    .db 01
    .db 28
    .db 01
    .db 48
    .db 01
    .db 68
    .db 01
    .db 88
    .db 01
    .db A8
    .db 01
    .db C8
    .db 01
    .db E8
    .db 02
    .db 08
    .db 02
    .db 28
    .db 02
    .db 48
    .db 02
    .db 68
    .db 02
    .db 88
    .db 02
    .db B0
    .db 02
    .db D0
    .db 02
    .db F0
    .db 03
    .db 10
    .db 03
    .db 30
    .db 03
    .db 50
    .db 03
    .db 70
    .db 03
    .db 90
    .db 03
    .db B0
    .db 03
    .db D0
    .db 03
    .db F0
    .db 04
    .db 10
OBJ_DATA_C: ; 17:08FC, 0x02E8FC
    .db FE
OBJ_DATA_D: ; 17:08FD, 0x02E8FD
    .db 80
    .db FE
    .db C0
    .db FE
    .db 00
    .db FD
    .db C0
    .db FD
    .db 80
    .db FD
    .db 60
    .db FD
    .db 40
    .db FD
    .db 20
    .db FD
    .db 00
    .db FC
    .db E0
    .db FC
    .db C0
    .db FC
    .db A0
    .db FC
    .db 80
    .db FC
    .db 60
    .db FC
    .db 40
    .db FC
    .db 20
    .db FC
    .db 00
    .db FB
    .db E0
    .db FB
    .db C0
    .db FB
    .db A0
    .db FB
    .db 80
    .db FB
    .db 60
    .db FB
    .db 40
    .db FB
    .db 20
    .db FB
    .db 00
    .db FA
    .db E0
    .db FA
    .db C0
    .db FA
    .db A0
    .db FA
    .db 80
    .db FA
    .db 60
    .db FA
    .db 40
    .db FA
    .db 20
OBJ_DATA_E: ; 17:093C, 0x02E93C
    .db 20
    .db 21
    .db 22
    .db 23
    .db 24
    .db 25
    .db 26
    .db 27
    .db 29
    .db 2A
    .db 2B
    .db 2C
    .db 2D
    .db 2E
    .db 2F
    .db 30
    .db 31
    .db 32
    .db 33
    .db 34
    .db 35
    .db 36
    .db 37
    .db 38
    .db 39
    .db 3A
    .db 3B
    .db 3C
    .db 3D
    .db 3E
    .db 3F
    .db 40
STATE_0x75_SWITCH_E: ; 17:095C, 0x02E95C
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_0x75_SWITCH_E_TERT_A)
    HIGH(SWITCH_0x75_SWITCH_E_TERT_A)
    LOW(SWITCH_0x75_SWITCH_E_TERT_B)
    HIGH(SWITCH_0x75_SWITCH_E_TERT_B)
SWITCH_0x75_SWITCH_E_TERT_A: ; 17:0966, 0x02E966
    LDA #$DF
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDA #$E3
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attrs.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA #$1E
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_0x75_SWITCH_E_TERT_B: ; 17:098C, 0x02E98C
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC LT_0x04 ; <, goto.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load.
    AND #$03 ; Range with bits.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store back.
LT_0x04: ; 17:09A6, 0x02E9A6
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    CLC ; Prep add.
    ADC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Add with.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; --
    BNE VAL_NE_ZERO ; != 0, goto.
    JSR FIND_PLAYER_FOCUS_HELPER ; Focus.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    JSR SET_FOCUS_LEFT/RIGHT_FLAG_FOR_OBJ_X->Y ; Get diff.
    LDA 4C6_OBJ_UNK[18],Y ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CMP #$D8 ; If _ #$D8
    BCC LT_0xD8 ; << goto.
VAL_EQ_ZERO: ; 17:09C9, 0x02E9C9
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$11 ; If _ #$11
    BCS LT_0xD8 ; >=, goto.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$30 ; If _ #$30
    BCS LT_0xD8 ; >=, goto.
VAL_MATCH: ; 17:09D7, 0x02E9D7
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    CMP #$40 ; If _ #$40
    BCC VAL_LT_0x40 ; <, goto. 1 in 4 to goto.
    LDA #$0C
    STA 70E_OBJ_UNK ; Set attr, 3 in 4 to do.
VAL_LT_0x40: ; 17:09E7, 0x02E9E7
    LDA #$00 ; Seed val.
    BEQ EXIT_TERT/SPRITE ; Always taken.
LT_0xD8: ; 17:09EB, 0x02E9EB
    LDY #$07 ; Obj.
LOOP_ALL_OBJS: ; 17:09ED, 0x02E9ED
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state.
    CMP #$76 ; If _ #$76
    BEQ VAL_MATCH ; ==, goto.
    INY ; Next pair.
    INY
    CPY #$11 ; If _ #$11
    BCC LOOP_ALL_OBJS ; <, loop.
    LDA #$DC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDY #$00 ; File.
    JSR RTN_ANIMATION_INITD ; Animate.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$08
    STA 70E_OBJ_UNK ; Set attr.
    LDA #$01 ; Switch val.
EXIT_TERT/SPRITE: ; 17:0A13, 0x02EA13
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert from A.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load attr.
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
VAL_NE_ZERO: ; 17:0A26, 0x02EA26
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x75_SWITCH_F: ; 17:0A29, 0x02EA29
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x75_SWITCH_F_TERT_A)
    HIGH(STATE_0x75_SWITCH_F_TERT_A)
    LOW(STATE_0x75_SWITCH_F_TERT_B)
    HIGH(STATE_0x75_SWITCH_F_TERT_B)
    LOW(STATE_0x75_SWITCH_F_TERT_C)
    HIGH(STATE_0x75_SWITCH_F_TERT_C)
STATE_0x75_SWITCH_F_TERT_A: ; 17:0A35, 0x02EA35
    LDA #$DF
    .db 85 ;  STA ZP_R2-R5_BANK_VALUES+2, meant inst. Set GFX.
STATE_0x41_ALT: ; 17:0A38, 0x02EA38
    .db 31 ; AND [FILE_PLAYER_OBJ_USE_B+1],Y
    LDA #$DD ; LDA #$DD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5 ; Set GFX.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    LDA #$E4
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    AND #$04 ; Test bit.
    BNE BIT_SET ; Set, goto.
    LDA #$02 ; Alt val seed.
    BNE VAL_SEEDED ; Always taken.
BIT_SET: ; 17:0A5B, 0x02EA5B
    LDA #$FE ; Val if set.
VAL_SEEDED: ; 17:0A5D, 0x02EA5D
    STA OBJ_POS_X_DELTA?[18],X ; Store attr.
    LDA #$FA
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    INC FLAG_RUN_CORE_SWITCH? ; ++
    JSR SOUND_RESET/INIT_RTN? ; Sound.
    LDA #$58
    JSR SND_BANKED_DISPATCH ; Play souund.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x75_SWITCH_F_TERT_B: ; 17:0A76, 0x02EA76
    LDY #$00
    LDA #$80
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Do.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI VAL_NEGATIVE ; Negative, goto.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_DELTAS?
    STA 4C6_OBJ_UNK[18],X ; Clear more attrs.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No disp.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
VAL_NEGATIVE: ; 17:0A94, 0x02EA94
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    BPL VAL_POSITIVE ; If positive, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$31 ; If _ #$31
    BCS EXIT_MOVE ; >=, goto.
    BCC LT_0x31 ; <, goto.
VAL_POSITIVE: ; 17:0AA2, 0x02EAA2
    .db BD ; LDA OBJ_POS_X[18],X
OBJ_STATE_0x41_HANDLER: ; 17:0AA3, 0x02EAA3
    .db 7E ; ROR $C904,X
    .db 04 ; NOP D undocumented.
    .db C9 ; CMP #$D0. If _ #$D0
    .db D0 ; BNE 0x90
    .db 90 ; BCC L_17:0AAC. <, goto.
    .db 03 ; Invalid instruction. SLO (zp,x). Shift value into A, and OR A with value.
LT_0x31: ; 17:0AA9, 0x02EAA9
    .db 20 ; JSR to clearing obj attrs. Clear attrs 1546.
    .db 46 ; LSR $F5
    .db F5 ; SBC $4C,X
EXIT_MOVE: ; 17:0AAC, 0x02EAAC
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x75_SWITCH_F_TERT_C: ; 17:0AAF, 0x02EAAF
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    AND #$03 ; Keep bits.
    BNE BITS_SET ; Any set, goto. 3 in 4 to take.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
BITS_SET: ; 17:0AB9, 0x02EAB9
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$01 ; Use as index.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BPL EXIT_MOVE ; If positive, goto.
LOOP_DESTROY_ALL_OBJS: ; 17:0ACD, 0x02EACD
    JSR INIT_OBJECT[X]_DATA_FULL ; Die.
    INX ; Next obj.
    CPX #$12 ; If _ #$12
    BCC LOOP_DESTROY_ALL_OBJS ; <, goto.
    RTS ; Leave.
EXIT_MOVE: ; 17:0AD6, 0x02EAD6
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_DATA_A: ; 17:0AD9, 0x02EAD9
    .db E4 ; Anim alternation.
    .db 00
RTN_ANIMATION_INITD: ; 17:0ADB, 0x02EADB
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear step.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear attr.
RTN_ANIMATION_CONTINUE: ; 17:0AE3, 0x02EAE3
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    BNE EXIT_HELD ; != 0, goto.
    LDA FILE_A,Y ; Move file PTR.
    STA TMP_08
    LDA FILE_B,Y
    STA TMP_09
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Move step.
    LDY #$00 ; Stream index.
    LDA [TMP_08],Y ; Load data from file.
    CMP 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; If _ OBJ.step
    BCS VAL_GTE_STEP ; File >= Obj, goto.
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Reset step.
VAL_GTE_STEP: ; 17:0B03, 0x02EB03
    INY ; Stream++
    LDA [TMP_08],Y ; Load from file.
    STA TMP_0A ; Store to.
    INY ; Stream++
    LDA [TMP_08],Y ; Load from file.
    STA TMP_0B ; Store to.
    INY ; Stream++
    LDA [TMP_08],Y ; Load from file.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to hold.
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Index into data from step.
    LDA [TMP_0A],Y ; Load from alt file.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to anim.
EXIT_HELD: ; 17:0B1B, 0x02EB1B
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    RTS ; Leave.
FILE_A: ; 17:0B1F, 0x02EB1F
    LOW(FILE_A)
FILE_B: ; 17:0B20, 0x02EB20
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
FILE_A: ; 17:0B23, 0x02EB23
    .db 02 ; Format: [STEP_CMP, DATA_PTR, HOLD]
    LOW(ANIM_DATA)
    HIGH(ANIM_DATA)
    .db 08
FILE_B: ; 17:0B27, 0x02EB27
    .db 02
    LOW(ANIM_DATA)
    HIGH(ANIM_DATA)
    .db 04
ANIM_DATA: ; 17:0B2B, 0x02EB2B
    .db DC
    .db DA
    .db DB
OBJ_STATE_0x76_HANDLER: ; 17:0B2E, 0x02EB2E
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x76_ALT_SWITCH)
    HIGH(STATE_0x76_ALT_SWITCH)
    LOW(STATE_0x76_SWITCH_B)
    HIGH(STATE_0x76_SWITCH_B)
    LOW(STATE_0x76_SWITCH_C)
    HIGH(STATE_0x76_SWITCH_C)
STATE_0x76_ALT_SWITCH: ; 17:0B3A, 0x02EB3A
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x76_ALTSWITCH_A)
    HIGH(STATE_0x76_ALTSWITCH_A)
    LOW(STATE_0x76_ALTSWITCH_B)
    HIGH(STATE_0x76_ALTSWITCH_B)
    LOW(STATE_0x76_ALTSWITCH_C)
    HIGH(STATE_0x76_ALTSWITCH_C)
    LOW(STATE_0x76_ALTSWITCH_D)
    HIGH(STATE_0x76_ALTSWITCH_D)
    LOW(STATE_0x76_ALTSWITCH_E)
    HIGH(STATE_0x76_ALTSWITCH_E)
STATE_0x76_ALTSWITCH_A: ; 17:0B4A, 0x02EB4A
    LDA #$DF
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    LDA #$C0
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x76_ALTSWITCH_B: ; 17:0B5F, 0x02EB5F
    LDA 4C6_OBJ_UNK[18],X ; Load
    BPL VAL_POSITIVE ; Positive, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
VAL_POSITIVE: ; 17:0B67, 0x02EB67
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Do.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP #$C0 ; If _ #$C0
    BCC EXIT_MOVE
    CMP #$C6 ; If _ #$C6
    BCS EXIT_MOVE ; >=, goto.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Get focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from focus.
    CMP #$03 ; If _ #$03
    BNE EXIT_TERT_MOVE ; !=, goto.
    LDA #$C0
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_MOVE: ; 17:0B96, 0x02EB96
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
EXIT_TERT_MOVE: ; 17:0B99, 0x02EB99
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x76_ALTSWITCH_C: ; 17:0B9F, 0x02EB9F
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Do.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI EXIT_MOVE ; Negative, goto.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    LDA #$06
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$E0
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$11
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_MOVE: ; 17:0BC3, 0x02EBC3
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x76_ALTSWITCH_D: ; 17:0BC6, 0x02EBC6
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDA #$E9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$05
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_MOVE: ; 17:0BD8, 0x02EBD8
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x76_ALTSWITCH_E: ; 17:0BDB, 0x02EBDB
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    JMP INIT_OBJECT[X]_DATA_FULL ; Die.
STATE_0x76_SWITCH_B: ; 17:0BE3, 0x02EBE3
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary.
    CMP #$03 ; If _ #$03
    BNE NO_SECONDARY_MATCH ; !=, goto.
    LDA OBJ_TERTIARY_SWITCH?[18],Y ; Load tert.
    CMP #$04 ; If _ #$04
    BCS RTS ; >=, leave.
NO_SECONDARY_MATCH: ; 17:0BF4, 0x02EBF4
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
RTS: ; 17:0BF7, 0x02EBF7
    RTS ; Leave.
STATE_0x76_SWITCH_C: ; 17:0BF8, 0x02EBF8
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Do.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI EXIT_MOVE ; Negative, goto.
    LDA #$06
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$E0
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$11
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_MOVE: ; 17:0C20, 0x02EC20
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_STATE_0x77_HANDLER: ; 17:0C23, 0x02EC23
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x77_SWITCH_A)
    HIGH(STATE_0x77_SWITCH_A)
    LOW(STATE_0x77_SWITCH_B)
    HIGH(STATE_0x77_SWITCH_B)
    LOW(STATE_0x77_SWITCH_C)
    HIGH(STATE_0x77_SWITCH_C)
STATE_0x77_SWITCH_A: ; 17:0C2F, 0x02EC2F
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    CMP #$02 ; If _ #$02
    BEQ VAL_MATCH ; ==, goto.
    LDY #$00 ; Val.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Val from.
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Do.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI MOVE/STATE_STUFF ; If negative, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI MOVE/STATE_STUFF ; If negative, goto.
VAL_MATCH: ; 17:0C4B, 0x02EC4B
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    JSR CLEAR_OBJ_ATTRS_DELTAS?
    LDA #$06
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$E0
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Fix.
    LDA #$11
    JSR SND_BANKED_DISPATCH ; Play sound.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
MOVE/STATE_STUFF: ; 17:0C6B, 0x02EC6B
    JSR OBJECT_X_MOVE? ; Do.
    JSR OBJ_POS_BASED_INIT_CLEAR ; Do.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load enabled.
    BEQ NOT_ENABLED ; Not enabled, goto.
    RTS ; Leave.
STATE_0x77_SWITCH_B: ; 17:0C77, 0x02EC77
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE MOVE/STATE_STUFF ; != 0, goto.
    LDA #$E9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$05
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP MOVE/STATE_STUFF ; Goto, abuse RTS.
STATE_0x77_SWITCH_C: ; 17:0C8C, 0x02EC8C
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE MOVE/STATE_STUFF ; != 0, goto.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
NOT_ENABLED: ; 17:0C94, 0x02EC94
    INX ; Next obj.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init. Abuse RTS.
OBJ_STATE_0x78_HANDLER: ; 17:0C98, 0x02EC98
    LDA #$EA
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    LDA OBJ_POS_Y_CONFIRMED+17,X ; Move.
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Move.
    STA OBJ_POS_X??[18],X
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Move.
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
BOSS_COUNTERS_MOD?: ; 17:0CB7, 0x02ECB7
    LDA 70E_OBJ_UNK ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 70E_OBJ_UNK ; --
VAL_EQ_ZERO: ; 17:0CBF, 0x02ECBF
    CLC ; Prep add.
    LDA 708_UNK ; Load
    ADC #$01 ; Add with.
    STA 708_UNK ; Store back.
    LDA 709_UNK_CB_INDEX ; Load
    ADC #$00 ; Carry add.
    STA 709_UNK_CB_INDEX ; Store back.
    CMP #$08 ; If _ #$08
    BCC RTS ; <, leave.
    LDA #$00
    STA 709_UNK_CB_INDEX ; Clear attr.
RTS: ; 17:0CD9, 0x02ECD9
    RTS ; Leave.
BLINK_HANDLER: ; 17:0CDA, 0x02ECDA
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    BEQ RTS ; == 0, leave.
    CMP #$05 ; If _ #$05
    BEQ RTS ; ==, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    CMP #$20 ; If _ #$20
    BCS RTS ; >=, leave.
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    TAY ; to Y index.
    LDA BLINK_FRAMES_DATA,Y ; Load data.
    STA TMP_00 ; Store to.
    INC 704_OBJ_USE_UNK ; ++
    LDA 704_OBJ_USE_UNK ; Load
    CMP TMP_00 ; If _ TMP
    BCC L_17:0D10 ; <, goto.
    LDA #$00
    STA 704_OBJ_USE_UNK ; Clear.
    INC 705_UNK ; ++
    INC 705_UNK ; ++
    LDA 705_UNK ; Load
    AND #$02 ; Keep bit only.
    STA 705_UNK ; Store back.
L_17:0D10: ; 17:0D10, 0x02ED10
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load.
    AND #$FC ; Keep 1111.1100
    ORA 705_UNK ; Or with the created value.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to the obj.
RTS: ; 17:0D1B, 0x02ED1B
    RTS ; Leave.
BLINK_FRAMES_DATA: ; 17:0D1C, 0x02ED1C
    .db 01 ; 2
    .db 04 ; 4
    .db 08 ; 8
    .db 10 ; 16
OBJ_HEALTH_THINGS/STATE_STUFF: ; 17:0D20, 0x02ED20
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CMP #$04 ; If _ #$04
    BCS VAL_EQ_ZERO ; >=, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    CMP #$00 ; If ret _ #$00
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CMP #$02 ; If _ #$02
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA 70E_OBJ_UNK ; Load
    BNE VAL_EQ_ZERO ; != 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BNE HAS_HEALTH ; != 0, goto.
    LDA #$05 ; Switch state to.
    BNE SWITCH_VAL_SEEDED
HAS_HEALTH: ; 17:0D42, 0x02ED42
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$04 ; Switch state to.
SWITCH_VAL_SEEDED: ; 17:0D49, 0x02ED49
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switch.
    LDA #$17
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
VAL_EQ_ZERO: ; 17:0D56, 0x02ED56
    RTS ; Leave.
EXTREME_RANDOMNESS_INIT: ; 17:0D57, 0x02ED57
    LDA #$00
    STA TMP_00
    STA TMP_05
    STA TMP_06
    STA TMP_07
    LDY #$18 ; Loop count.
LOOPY: ; 17:0D63, 0x02ED63
    ASL TMP_00 ; <<
    ROL TMP_01 ; <<
    ROL TMP_02 ; <<
    ROL TMP_05 ; <<
    ROL TMP_06 ; <<
    ROL TMP_07 ; <<
    LDA TMP_06 ; <<, load.
    CMP TMP_04 ; If _ TMP_04
    BNE BRANCH_LT ; !=, goto.
    LDA TMP_05 ; LKoad
    CMP TMP_03 ; If _ TMP_03
BRANCH_LT: ; 17:0D79, 0x02ED79
    BCC NEXT_LOOP ; <, goto.
    LDA TMP_05 ; Load
    SBC TMP_03 ; -=
    STA TMP_05 ; Store back.
    LDA TMP_06 ; Load
    SBC TMP_04 ; -=
    STA TMP_06 ; Store back.
    INC TMP_00 ; ++
NEXT_LOOP: ; 17:0D89, 0x02ED89
    DEY ; Loop--
    BNE LOOPY ; != 0, goto.
    RTS ; Leave.
EXTREME_RANDOMNESS_2_INIT: ; 17:0D8D, 0x02ED8D
    LDA #$00
    STA TMP_0A ; Clear TMPs.
    STA TMP_0B
    LDY #$10 ; Y from.
Y_NONZERO: ; 17:0D95, 0x02ED95
    ROR TMP_0D ; >>
    ROR TMP_0C ; >>
    BCC CARRY_0x0 ; Shifted 0x0, goto.
    CLC ; Prep add.
    LDA TMP_0A ; Load
    ADC TMP_0E ; Add to.
    STA TMP_0A ; Store back.
    LDA TMP_0B ; Load
    ADC TMP_0F ; Add to.
    STA TMP_0B ; Store back.
CARRY_0x0: ; 17:0DA8, 0x02EDA8
    ROR TMP_0B ; >>
    ROR TMP_0A ; >>
    ROR TMP_09 ; >>
    ROR TMP_08 ; >>
    DEY ; Y--
    BNE Y_NONZERO ; Loop.
    RTS ; Leave.
OBJ_STATE_0x3B_HANDLER: ; 17:0DB4, 0x02EDB4
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    BEQ DO_SWITCH ; == 0, goto.
    CMP #$04 ; If _ #$04
    BCS DO_SWITCH ; >=, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do rtn 0x01 - 0x03
    CMP #$00 ; If A _ #$00
    BEQ DO_SWITCH ; ==, goto.
    CMP #$02 ; If A _ #$02
    BEQ DO_SWITCH ; ==, goto.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
DO_SWITCH: ; 17:0DD2, 0x02EDD2
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Switch on secondary.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3B_SUBSWITCH_A)
    HIGH(STATE_0x3B_SUBSWITCH_A)
    LOW(STATE_0x3B_SUBSWITCH_B)
    HIGH(STATE_0x3B_SUBSWITCH_B)
    LOW(STATE_0x3B_SUBSWITCH_C)
    HIGH(STATE_0x3B_SUBSWITCH_C)
    LOW(STATE_0x3C_SUBSWITCH_D) ; <<<
    HIGH(STATE_0x3C_SUBSWITCH_D)
    LOW(STATE_0x3C_SUBSWITCH_E)
    HIGH(STATE_0x3C_SUBSWITCH_E)
    LOW(STATE_0x3C_SUBSWITCH_F)
    HIGH(STATE_0x3C_SUBSWITCH_F)
STATE_0x3B_SUBSWITCH_A: ; 17:0DE4, 0x02EDE4
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3B_SUB_0x00_SWITCH_A)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_A)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_B) ; Cross bank thingy. TODO.
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_B)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_C)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_C)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_D)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_D)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_E)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_E)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_F)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_F)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_G)
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_G)
    LOW(STATE_0x3B_SUB_0x00_SWITCH_H) ; Moves secondary, clears tert.
    HIGH(STATE_0x3B_SUB_0x00_SWITCH_H)
STATE_0x3B_SUB_0x00_SWITCH_A: ; 17:0DFA, 0x02EDFA
    LDA #$D7
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$D9
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDY #$19
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$94
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$18
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$BA
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    BNE EXIT_X_MOVE/TERT_INC ; Always taken.
STATE_0x3B_SUB_0x00_SWITCH_B: ; 17:0E1D, 0x02EE1D
    TXA ; Xobj to A.
    PHA ; Save.
    LDA 5FE_UNK ; Load
    CLC ; Prep add.
    ADC #$4B ; Add val. Val?
    JSR BACKGROUND_UPDATING_INTERFACE ; Do.
    PLA ; Pull saved Xobj val.
    TAX ; Back to X.
    LDA BG_UPDATING_FLAG_UNK ; Load
    BNE EXIT_X_MOVE ; != 0, goto.
    INC 5FE_UNK ; ++
EXIT_X_MOVE/TERT_INC: ; 17:0E31, 0x02EE31
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_X_MOVE: ; 17:0E34, 0x02EE34
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3B_SUB_0x00_SWITCH_C: ; 17:0E37, 0x02EE37
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE EXIT_MOVE ; != 0, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Inc
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    CMP #$01 ; If _ #$01
    BNE NE_0x01 ; !=, goto.
    LDA #$39
    JSR SND_BANKED_DISPATCH ; Play sound first go.
NE_0x01: ; 17:0E4B, 0x02EE4B
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    CMP #$19 ; If _ #$19
    BCC LT_0x19 ; <, goto.
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear.
    BEQ EXIT_X_MOVE/TERT_INC ; Always taken.
LT_0x19: ; 17:0E59, 0x02EE59
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA OBJ_DATA_B,Y
    TAY ; To Y.
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Change color.
EXIT_MOVE: ; 17:0E6B, 0x02EE6B
    JMP OBJECT_X_MOVE? ; Goto.
OBJ_DATA_A: ; 17:0E6E, 0x02EE6E
    .db 08
OBJ_DATA_B: ; 17:0E6F, 0x02EE6F
    .db 19
    .db 08
    .db 1A
    .db 08
    .db 1B
    .db 07
    .db 19
    .db 07
    .db 1A
    .db 07
    .db 1B
    .db 06
    .db 19
    .db 06
    .db 1A
    .db 06
    .db 1B
    .db 05
    .db 19
    .db 05
    .db 1A
    .db 05
    .db 1B
    .db 04
    .db 19
    .db 04
    .db 1A
    .db 04
    .db 1B
    .db 03
    .db 19
    .db 03
    .db 1A
    .db 03
    .db 1B
    .db 02
    .db 19
    .db 02
    .db 1A
    .db 02
    .db 1B
    .db 01
    .db 19
    .db 01
    .db 1A
    .db 01
    .db 1B
    .db 08
    .db 19
STATE_0x3B_SUB_0x00_SWITCH_D: ; 17:0EA0, 0x02EEA0
    JSR SET_GFX/ANIM/STATE_HELPER ; Do.
    LDA #$FF
    STA OBJ_POS_X_DELTA?[18],X ; Set attr.
    LDA #$80
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attr.
    LDA #$01
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Set.
    LDA #$FE
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set.
    LDA #$0C
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3B_SUB_0x00_SWITCH_E: ; 17:0EC2, 0x02EEC2
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_DELTA ; != 0, goto.
    JSR SUB_GFX/ANIM_HELPER ; Set up.
    LDA #$18
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_DELTA: ; 17:0ED2, 0x02EED2
    LDY #$00 ; Mod vals.
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3B_SUB_0x00_SWITCH_F: ; 17:0EDF, 0x02EEDF
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE NONZERO ; != 0, goto.
    LDA #$D7
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5 ; Swap GFX.
    LDA #$97
    STA OBJ_ANIMATION_DISPLAY[18],X ; Swap anim.
    INX ; Next obj.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Fix obj index.
    LDA #$0C
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
NONZERO: ; 17:0EFD, 0x02EEFD
    LDA 4C6_OBJ_UNK[18],X ; Load
    BEQ EXIT_MOVE ; == 0, goto.
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Mod.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI EXIT_MOVE ; If negative, exit.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    STA 4C6_OBJ_UNK[18],X ; Also clear this.
EXIT_MOVE: ; 17:0F17, 0x02EF17
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3B_SUB_0x00_SWITCH_G: ; 17:0F1A, 0x02EF1A
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE NONZERO ; != 0, goto.
    LDA #$98
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    JMP NONZERO ; Goto other routine code.
STATE_0x3B_SUB_0x00_SWITCH_H: ; 17:0F35, 0x02EF35
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_UNIQUE ; != 0, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_UNIQUE: ; 17:0F42, 0x02EF42
    JMP NONZERO ; Goto other state code.
STATE_0x3B_SUBSWITCH_B: ; 17:0F45, 0x02EF45
    JSR FIND_PLAYER_FOCUS_HELPER ; Do.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_MOVE: ; 17:0F4B, 0x02EF4B
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3B_SUBSWITCH_C: ; 17:0F4E, 0x02EF4E
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3B_SUB_0x02_SWITCH_A) ; Grande.
    HIGH(STATE_0x3B_SUB_0x02_SWITCH_A)
    LOW(STATE_0x3B_SUB_0x02_SWITCH_B) ; Smol.
    HIGH(STATE_0x3B_SUB_0x02_SWITCH_B)
STATE_0x3B_SUB_0x02_SWITCH_A: ; 17:0F58, 0x02EF58
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Keep 0000.0100
    LSR A ; >> 1
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Set from.
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_B,Y ; Set from.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    JSR SUB_ANIM_HELPER_FROM_TIMER+STEP ; Set anim and do step stuff.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Keep 0000.0011
    BEQ BITS_NOT_SET ; == 0, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$98 ; If _ #$98
    BNE EXIT_MOVE ; !=, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$20 ; If _ #$20
    BCC EXIT_MOVE ; <, goto.
    CMP #$E0 ; If _ #$E0
    BCS EXIT_MOVE ; >=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$01 ; Keep 0000.0001
    BNE BIT_SET ; Was set, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    ORA #$04 ; Set bit.
    JMP STATUS_SEEDED ; Goto.
BIT_SET: ; 17:0F96, 0x02EF96
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$FB ; Keep 1111.1011
STATUS_SEEDED: ; 17:0F9B, 0x02EF9B
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set status.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    LDA #$30
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$3F ; Keep 0011.1111
    CLC ; Prep add.
    ADC #$A0 ; Add to.
    STA OBJ_POS_X??[18],X ; Set attr.
    LDA #$00
    BEQ INDEX_STORE ; Always taken.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    LSR A ; >> 1, /2.
    ORA IRQ/SCRIPT_RUN_COUNT? ; Or with. Either 0x01 set, will be set.
    AND #$01 ; Keep 0x01.
INDEX_STORE: ; 17:0FBE, 0x02EFBE
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store. 0x00 - 0x01 (randomly)
    LDA #$05
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    JMP OBJECT_X_MOVE? ; Exit, abuse RTS.
BITS_NOT_SET: ; 17:0FCC, 0x02EFCC
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ EXIT_MOVE ; == 0, goto.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_13 ; Store to.
    LDA OBJ_POS_X_DELTA?[18],X ; Load from Xobj.
    BMI VAL_NEGATIVE ; Negative, goto.
    LDA TMP_12 ; Load
    BEQ NEGATIVE_UNSET ; == 0, goto.
    BNE EXIT_MOVE ; Always taken, is set.
VAL_NEGATIVE: ; 17:0FE7, 0x02EFE7
    LDA TMP_12 ; Load
    BEQ EXIT_MOVE ; If == 0, goto.
NEGATIVE_UNSET: ; 17:0FEB, 0x02EFEB
    LDA TMP_13 ; Load
    CMP #$20 ; If _ #$20
    BCC EXIT_MOVE ; <, goto.
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$08 ; If _ #$08
    BCC VAL_SEED_0xFF ; <, goto.
    LDA TMP_10 ; Load
    BNE SEED_0xFF ; != 0, goto.
    LDA #$01
    BNE SEEDED_A ; Always taken.
SEED_0xFF: ; 17:1000, 0x02F000
    LDA #$FF ; Seed.
SEEDED_A: ; 17:1002, 0x02F002
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Set attr.
    BNE EXIT_MOVE ; != 0, goto.
VAL_SEED_0xFF: ; 17:1007, 0x02F007
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Do.
    CMP #$70 ; If _ #$70
    BCS EXIT_MOVE ; >=, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$98 ; If _ #$98
    BNE EXIT_MOVE ; !=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Keep 0000.0100
    BNE BIT_SET ; If set, goto.
    LDA TMP_12 ; Load
    BEQ EXIT_MOVE ; If == 0, goto.
    BNE MOVE_SECONDARY ; Always taken, goto.
BIT_SET: ; 17:1022, 0x02F022
    LDA TMP_12 ; Load
    BNE EXIT_MOVE ; != 0, goto.
MOVE_SECONDARY: ; 17:1026, 0x02F026
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_MOVE: ; 17:1029, 0x02F029
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
OBJ_DATA_A: ; 17:102C, 0x02F02C
    .db FE
OBJ_DATA_B: ; 17:102D, 0x02F02D
    .db 00
    .db 02
    .db 00
STATE_0x3B_SUB_0x02_SWITCH_B: ; 17:1030, 0x02F030
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT ; != 0, goto.
    DEC OBJ_TERTIARY_SWITCH?[18],X ; Tert--
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT: ; 17:103B, 0x02F03B
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
STATE_0x3C_SUBSWITCH_D: ; 17:103E, 0x02F03E
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3C_SUB_0x03_SWITCH_A)
    HIGH(STATE_0x3C_SUB_0x03_SWITCH_A)
    LOW(STATE_0x3C_SUB_0x03_SWITCH_B)
    HIGH(STATE_0x3C_SUB_0x03_SWITCH_B)
    LOW(STATE_0x3C_SUB_0x03_SWITCH_C)
    HIGH(STATE_0x3C_SUB_0x03_SWITCH_C)
    LOW(STATE_0x3C_SUB_0x03_SWITCH_D)
    HIGH(STATE_0x3C_SUB_0x03_SWITCH_D)
    LOW(STATE_0x3C_SUB_0x03_SWITCH_E) ; Moves secondary -= 2
    HIGH(STATE_0x3C_SUB_0x03_SWITCH_E)
STATE_0x3C_SUB_0x03_SWITCH_A: ; 17:104E, 0x02F04E
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$B7
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$95
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Keep bit.
    BNE BIT_SET ; != 0, goto. Set.
    LDA #$FD ; Seed negative.
    BNE VAL_SEEDED ; Always taken.
BIT_SET: ; 17:106B, 0x02F06B
    LDA #$03 ; Seed positive.
VAL_SEEDED: ; 17:106D, 0x02F06D
    STA OBJ_POS_X_DELTA?[18],X ; Store attr.
    LDA #$FA
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP EXIT_ATTRS/DELTA ; Goto.
STATE_0x3C_SUB_0x03_SWITCH_B: ; 17:107B, 0x02F07B
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE ATTR_EXIT_DECIDE ; != 0, goto.
    JSR SET_GFX/ANIM/STATE_HELPER ; Set things.
    LDA #$20
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
ATTR_EXIT_DECIDE: ; 17:108B, 0x02F08B
    LDA 4C6_OBJ_UNK[18],X ; Load attr.
    BEQ EXIT_MOVE ; == 0, goto. Just exit move.
EXIT_ATTRS/DELTA: ; 17:1090, 0x02F090
    LDY #$00 ; Move delta.
    LDA #$50
    JSR ADD_A/Y_TO_DELTA_UNK_C
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Dol.
    LDA 4C6_OBJ_UNK[18],X ; Load attr.
    BMI EXIT_MOVE ; If negative, skip.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    STA 4C6_OBJ_UNK[18],X ; Also this one.
EXIT_MOVE: ; 17:10A5, 0x02F0A5
    JMP OBJECT_X_MOVE? ; Exit.
STATE_0x3C_SUB_0x03_SWITCH_C: ; 17:10A8, 0x02F0A8
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE ATTR_EXIT_DECIDE ; != 0, goto.
    LDA #$D6
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Swap GFX.
    LDA #$D7
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    INX ; Pair obj.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Fix object ptr.
    LDA #$97
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP ATTR_EXIT_DECIDE ; Goto.
STATE_0x3C_SUB_0x03_SWITCH_D: ; 17:10CA, 0x02F0CA
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE ATTR_EXIT_DECIDE ; != 0, goto.
    LDA #$98
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP ATTR_EXIT_DECIDE ; Exit.
STATE_0x3C_SUB_0x03_SWITCH_E: ; 17:10DF, 0x02F0DF
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE ATTR_EXIT_DECIDE ; != 0, goto.
    LDA #$BA
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear.
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Secondary-=2
    DEC OBJ_SECONDARY_SWITCH?[18],X
    JMP ATTR_EXIT_DECIDE ; Exit.
STATE_0x3C_SUBSWITCH_E: ; 17:10FA, 0x02F0FA
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    BNE TERT_NONZERO ; != 0, goto.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR SUB_GFX/ANIM_HELPER ; Set attrs.
    LDA #$3C
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair enabled.
    LDA #$FD
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    AND #$04 ; Test bit.
    BNE TO_LEFT_SET ; != 0, goto. Was set.
    LDA #$02 ; Seed positive.
    BNE VAL_SEEDED ; Always taken.
TO_LEFT_SET: ; 17:111A, 0x02F11A
    LDA #$FE ; Negative val.
VAL_SEEDED: ; 17:111C, 0x02F11C
    STA OBJ_POS_X_DELTA?[18],X ; Set attr.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert++
    LDA #$2B
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP EXIT_DELTA ; Exit.
TERT_NONZERO: ; 17:1135, 0x02F135
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?[18],X
    CMP #$04
    BCC L_17:114A
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    AND #$03
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
L_17:114A: ; 17:114A, 0x02F14A
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    ORA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK
    LDA 4C6_OBJ_UNK[18],X
    BMI L_17:11AB
    INX
    JSR INIT_OBJECT[X]_DATA_FULL
    DEX
    JSR CLEAR_OBJ_ATTRS_DELTAS?
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    JSR CLEAR_OBJ_ATTRS_UNK_1546
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$D6
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4
    LDA #$D7
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA OBJECT_DATA_HEALTH?[18],X
    BEQ L_17:1194
    LDA #$01
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JSR SUB_ANIM_HELPER_FROM_TIMER+STEP
    LDA #$01
    BNE L_17:119B
L_17:1194: ; 17:1194, 0x02F194
    LDA #$95
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$05
L_17:119B: ; 17:119B, 0x02F19B
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
L_17:11AB: ; 17:11AB, 0x02F1AB
    LDA OBJECT_DATA_HEALTH?[18],X
    BNE L_17:11BE
    LDA OBJ_POS_X_CONFIRMED[18],X
    CMP #$10
    BCC L_17:11BB
    CMP #$F0
    BCC L_17:11BE
L_17:11BB: ; 17:11BB, 0x02F1BB
    JSR CLEAR_OBJ_ATTRS_UNK_1546
L_17:11BE: ; 17:11BE, 0x02F1BE
    JMP OBJECT_X_MOVE?
STATE_0x3C_SUBSWITCH_F: ; 17:11C1, 0x02F1C1
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Switch on tert.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3C_SUB_0x0E_SWITCH_A)
    HIGH(STATE_0x3C_SUB_0x0E_SWITCH_A)
    LOW(STATE_0x3C_SUB_0x0E_SWITCH_B)
    HIGH(STATE_0x3C_SUB_0x0E_SWITCH_B)
STATE_0x3C_SUB_0x0E_SWITCH_A: ; 17:11CB, 0x02F1CB
    LDY #$08 ; Seed Yobj start.
LOOP_0x08_TO_0x0E: ; 17:11CD, 0x02F1CD
    LDA #$3D ; Set Yobj state.
    STA OBJ_ENABLED_STATE+MORE?[18],Y
    LDA OBJ_POS_X??[18],X ; Load from Xobj.
    CLC ; Prep add.
    ADC #$01 ; Add.
    STA OBJ_POS_X??[18],Y ; Store to Yobj.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load Xobj.
    STA 556_OBJ_STATUS_FLAGS_A[18],Y ; Store to Yobj.
    STY TMP_17 ; Store Yobj to TMP.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from Xobj.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA TMP_DATA_A,Y ; Seed TMP from index.
    STA TMP_00
    LDA TMP_DATA_B,Y
    STA TMP_01
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Test bit 0x04.
    BEQ NOT_TO_LEFT_FLAG
    LDA TMP_00 ; Load TMP.
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
    STA TMP_00 ; Store back.
NOT_TO_LEFT_FLAG: ; 17:1202, 0x02F202
    LDY TMP_17 ; Load Yobj.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj.
    CLC ; Prep add.
    ADC TMP_00 ; Add with TMP.
    STA OBJ_POS_X_CONFIRMED[18],Y ; To Yobj.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load from Xobj.
    AND #$03 ; Keep 0x03
    STA TMP_16 ; Store to TMP.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj.
    CMP #$21 ; If _ #$21
    BCC LT_0x21 ; <, goto.
    CMP #$E0 ; If _ #$E0
    BCC LT_0xE0 ; <, goto.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load from Yobj.
    CMP #$20 ; If _ #$20
    BCS LT_0xE0 ; >=, goto.
    LDY TMP_16 ; Load index.
    LDA DATA_UNK_A,Y ; Load ??
    JMP DATA_ENTRY ; Goto.
LT_0x21: ; 17:122E, 0x02F22E
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load
    CMP #$E0 ; If _ #$E0
    BCC LT_0xE0 ; <, goto.
    LDY TMP_16 ; Index from.
    LDA DATA_UNK_B,Y ; Load data.
DATA_ENTRY: ; 17:123A, 0x02F23A
    STA TMP_15 ; Store to temp.
    LDY TMP_17 ; Yobj from.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load from Xobj.
    AND #$04 ; Keep L/R.
    ORA TMP_15 ; Set other attr.
    STA 556_OBJ_STATUS_FLAGS_A[18],Y ; Store to Yobj.
LT_0xE0: ; 17:1248, 0x02F248
    LDA 4C6_OBJ_UNK[18],X ; Load from Xobj.
    CLC ; Prep add.
    ADC TMP_01 ; Add with.
    STA 4C6_OBJ_UNK[18],Y ; Store to.
    INC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Inc attr.
    INY ; Inc Yobj.
    CPY #$0F ; If Yobj _ #$0F
    BCS ALL_OBJS_COMPLETED ; >=, goto.
    JMP LOOP_0x08_TO_0x0E ; Loop large.
ALL_OBJS_COMPLETED: ; 17:125C, 0x02F25C
    LDA #$80
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set Xobj.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JSR OBJECT_X_MOVE? ; Do.
    LDA #$2D
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
STATE_0x3C_SUB_0x0E_SWITCH_B: ; 17:126C, 0x02F26C
    LDY #$00 ; No anim.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$01 ; Keep bit.
    BEQ BIT_CLEAR ; Not set, goto.
    LDY #$95 ; Y if clear. Alt anim.
BIT_CLEAR: ; 17:1276, 0x02F276
    TYA ; To A.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; != 0, goto.
    LDA #$00
    STA BG_UPDATE_FLAG_UNK ; Clear.
    JMP INIT_OBJECT[X]_DATA_FULL ; Clear OBJ.
EXIT_MOVE: ; 17:1286, 0x02F286
    JMP OBJECT_X_MOVE?
SET_GFX/ANIM/STATE_HELPER: ; 17:1289, 0x02F289
    LDA #$D6
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4
    LDA #$D9
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA #$99
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$3C
    STA OBJ_ENABLED_STATE+MORE?+1,X
    RTS
SUB_GFX/ANIM_HELPER: ; 17:129C, 0x02F29C
    LDA #$D6
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$D9
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDA #$A7
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
TMP_DATA_A: ; 17:12AA, 0x02F2AA
    .db F0
TMP_DATA_B: ; 17:12AB, 0x02F2AB
    .db EC
    .db F0
    .db F4
    .db 00
    .db E8
    .db 00
    .db F8
    .db 10
    .db EC
    .db 10
    .db F4
    .db 20
    .db D8
DATA_UNK_A: ; 17:12B8, 0x02F2B8
    .db 01
    .db 01
    .db 00
DATA_UNK_B: ; 17:12BB, 0x02F2BB
    .db 02
    .db 00
    .db 02
SUB_ANIM_HELPER_FROM_TIMER+STEP: ; 17:12BE, 0x02F2BE
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$08 ; If _ #$08
    BCC LT_0x08 ; <, goto.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Keep 0000.0011
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store back.
LT_0x08: ; 17:12D8, 0x02F2D8
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    CLC ; Prep add.
    ADC #$95 ; Add anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set from.
    RTS
OBJ_STATE_0x3C_HANDLER: ; 17:12E2, 0x02F2E2
    LDA #$9A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim to display.
    LDA OBJ_POS_Y_CONFIRMED+17,X ; Load from Obj[17]
    STA OBJ_POS_X_CONFIRMED[18],X ; Set to Xobj.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Load from 17.
    SEC ; Prep sub.
    SBC #$01 ; -= 1
    STA OBJ_POS_X??[18],X ; Set Xobj.
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Load from 17.
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set in Xobj.
    JMP OBJECT_X_MOVE? ; Exit.
OBJ_STATE_0x3D_HANDLER: ; 17:12FF, 0x02F2FF
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$08 ; If _ #$08
    BCC LT_0x08 ; <, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load attr.
    CMP #$03 ; If _ #$03
    BCC CLEAR_HOLD_TIMER ; <, goto.
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$06 ; If _ #$06
    BCC CLEAR_STEP_45A
    JMP INIT_OBJECT[X]_DATA_FULL ; Destroy object.
CLEAR_STEP_45A: ; 17:1320, 0x02F320
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear step.
CLEAR_HOLD_TIMER: ; 17:1325, 0x02F325
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
LT_0x08: ; 17:132A, 0x02F32A
    LDY #$00 ; Anim seed.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$01 ; Keep bottom bit.
    BNE VAL_SEEDED_Y
    LDA #$9B ; Base anim.
    CLC ; Prep add.
    ADC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Add with step.
    BNE ANIM_SEEDED
VAL_SEEDED_Y: ; 17:133A, 0x02F33A
    TYA ; Put to A.
ANIM_SEEDED: ; 17:133B, 0x02F33B
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    JMP OBJECT_X_MOVE? ; Exit, abuse RTS.
OBJ_STATE_0x3E_HANDLER: ; 17:1341, 0x02F341
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    BEQ SUB_AND_SWITCH ; == 0, goto.
    CMP #$04 ; If _ #$04
    BCS SUB_AND_SWITCH ; >=, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do sub 0x01 - 0x03.
    CMP #$00 ; Ret _ #$00
    BEQ SUB_AND_SWITCH ; ==, goto.
    CMP #$02 ; Ret _ #$02
    BEQ SUB_AND_SWITCH ; ==, goto.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
SUB_AND_SWITCH: ; 17:135F, 0x02F35F
    JSR FILL_OUT_UNASSIGNED_PLAYER_ANIMS ; Do.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Switch val.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3E_SWITCH_A)
    HIGH(STATE_0x3E_SWITCH_A)
    LOW(STATE_0x3E_SWITCH_B)
    HIGH(STATE_0x3E_SWITCH_B)
    LOW(STATE_0x3E_SWITCH_C)
    HIGH(STATE_0x3E_SWITCH_C)
    LOW(STATE_0x3E_SWITCH_D)
    HIGH(STATE_0x3E_SWITCH_D)
    LOW(STATE_0x3E_SWITCH_E)
    HIGH(STATE_0x3E_SWITCH_E)
    LOW(STATE_0x32_SWITCH_F) ; Piggy backs off another state here.
    HIGH(STATE_0x32_SWITCH_F)
STATE_0x3E_SWITCH_A: ; 17:1374, 0x02F374
    LDA #$CC
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX.
    LDA #$CD
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    LDY #$1C
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$0C
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$14
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$6A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JSR OBJECT_X_MOVE? ; Move.
    LDA #$09
    JMP SND_BANKED_DISPATCH ; Exit playing sound, abusing RTS.
STATE_0x3E_SWITCH_B: ; 17:139B, 0x02F39B
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP OBJECT_X_MOVE? ; Exit.
STATE_0x3E_SWITCH_C: ; 17:13A1, 0x02F3A1
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Switch on tert.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_RTN_A) ; Tons here.
    HIGH(SWITCH_RTN_A)
    LOW(SWITCH_RTN_B)
    HIGH(SWITCH_RTN_B)
    LOW(SWITCH_RTN_C)
    HIGH(SWITCH_RTN_C)
    LOW(SWITCH_RTN_D)
    HIGH(SWITCH_RTN_D)
    LOW(SWITCH_RTN_E)
    HIGH(SWITCH_RTN_E)
    LOW(SWITCH_RTN_F)
    HIGH(SWITCH_RTN_F)
NEGATIVE_A: ; 17:13B3, 0x02F3B3
    LDA #$FE ; Seed negative.
    BNE NEGATIVE_A ; Always taken.
SWITCH_RTN_A: ; 17:13B7, 0x02F3B7
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    JSR SUB_SOLVE_P1/P2_INDEX ; Get Y index.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    AND #$08 ; TYest bit.
    BEQ BIT_NOT_SET ; Not set, goto.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load
    CMP #$50 ; If _ #$50
    BCC BIT_NOT_SET ; <, goto.
    CMP #$B0
    BCS BIT_NOT_SET ; >=, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
BIT_NOT_SET: ; 17:13D8, 0x02F3D8
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Keep 0000.0011
    BEQ NO_BITS_SET ; == 0, goto.
    AND #$01 ; Test bottom most bit.
    BNE NEGATIVE_A ; Seed A with other val.
    LDA #$02 ; Positive.
NEGATIVE_A: ; 17:13E5, 0x02F3E5
    STA OBJ_POS_X_DELTA?[18],X ; Store to attr.
    JMP OBJECT_X_MOVE? ; Goto, exit.
NO_BITS_SET: ; 17:13EB, 0x02F3EB
    JSR SUB_SOLVE_P1/P2_INDEX ; Get index. This call isn't needed.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from player.
    AND #$03 ; Keep 0000.0011
    CMP #$03 ; If _ #$03
    BNE BOTH_BITS_NOT_SET ; != 0x03, goto.
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$0C ; If _ #$0C
    BCS BOTH_BITS_NOT_SET ; >=, goto.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$70 ; If _ #$70
    BCS BOTH_BITS_NOT_SET ; >=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Keep.
    BNE BIT_0x04_SET ; != 0, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj.
    CMP #$D0 ; If _ #$D0
    BCS BOTH_BITS_NOT_SET ; >=, goto.
    BCC SKIP_?? ; <, goto.
BIT_0x04_SET: ; 17:1415, 0x02F415
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$30 ; If _ #$30
    BCC BOTH_BITS_NOT_SET ; <, goto.
SKIP_??: ; 17:141C, 0x02F41C
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    BPL RUN_POSITIVE ; Positive, goto.
    JMP NEXT_SECONDARY_CLEAR_TERT_OUTRO ; Goto far away.
RUN_POSITIVE: ; 17:1423, 0x02F423
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Exit, move.
BOTH_BITS_NOT_SET: ; 17:142B, 0x02F42B
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    AND #$01 ; Test.
    BEQ BIT_NOT_SET ; Not set, goto.
    JMP ALT_PATH_B ; Goto other path.
BIT_NOT_SET: ; 17:1435, 0x02F435
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    AND #$08 ; Test bit.
    BNE BIT_SET ; != 0, was set, goto.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load
    CMP #$E0 ; If _ #$E0
    BCC POS_LT_0x30 ; <, goto.
    BCS EXIT_NEXT_TERT ; >=, goto.
BIT_SET: ; 17:1445, 0x02F445
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load Xobj.
    CMP #$20 ; If _ #$20
    BCS POS_LT_0x30 ; >=, goto.
EXIT_NEXT_TERT: ; 17:144C, 0x02F44C
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
POS_LT_0x30: ; 17:1452, 0x02F452
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_08 ; Save.
    CMP #$08 ; If _ #$08
    BCC DIFF_LT_0x08 ; <, goto.
    LDA TMP_10 ; Load 
    BNE DIFF_FLAG_SET ; If set, goto.
    JSR SET_ATTR_HELPER_A ; Set attr.
    JMP DIFF_LT_0x08 ; Goto.
DIFF_FLAG_SET: ; 17:1465, 0x02F465
    JSR SET_ATTR_HELPER_B ; Set other attr.
DIFF_LT_0x08: ; 17:1468, 0x02F468
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Test 0x08
    BNE BIT_0x08_SET ; Set, goto.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Do sub.
    STA TMP_09 ; Save diff.
    LDA TMP_12 ; Load flag.
    BEQ FLAG_UNSET ; Not set, goto.
    LDA TMP_09 ; Load diff.
    CMP #$28 ; If _ #$28
    BCC FLAG_UNSET ; <, goto.
    CMP #$38 ; If _ #$38
    BCC SYNC ; <, goto.
    JSR SET_ATTR_HELPER_D ; Set attr.
    JMP SYNC ; Goto.
FLAG_UNSET: ; 17:1488, 0x02F488
    JSR SET_ATTR_HELPER_C ; Set attr.
SYNC: ; 17:148B, 0x02F48B
    JMP 96_THINGY ; Goto.
BIT_0x08_SET: ; 17:148E, 0x02F48E
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    STA TMP_09 ; Store diff.
    LDA TMP_12 ; Load flag.
    BNE ATTR_SET+96_THINGY ; Set, goto.
    LDA TMP_09 ; Load diff.
    CMP #$2A ; If _ #$2A
    BCC ATTR_SET+96_THINGY ; <, goto.
    CMP #$3A ; If _ #$3A
    BCC 96_THINGY ; <, goto.
    JSR SET_ATTR_HELPER_C ; Set attrs.
    JMP 96_THINGY ; Goto.
ATTR_SET+96_THINGY: ; 17:14A7, 0x02F4A7
    JSR SET_ATTR_HELPER_D ; Set attrs.
96_THINGY: ; 17:14AA, 0x02F4AA
    LDA 96_UNK ; Load
    AND #$01 ; Keep
    BNE BIT_SET
HAS_VAL: ; 17:14B0, 0x02F4B0
    JMP STATE_SWITCH_OUTRO ; Goto.
BIT_SET: ; 17:14B3, 0x02F4B3
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    BNE HAS_VAL ; If nonzero, goto.
    JMP GENERAL_ATTR_THINGS ; Zero, goto.
ALT_PATH_B: ; 17:14BB, 0x02F4BB
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    AND #$08 ; Keep bit 0x08.
    BNE BIT_SET ; If set, goto.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load from Yobj.
    CMP #$20 ; If _ #$20
    BCS YOBJ_POS_GTE_0x20 ; >=, goto.
    BCC 17:14D2 ; <, goto.
BIT_SET: ; 17:14CB, 0x02F4CB
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load Yobj.
    CMP #$E0 ; If _ #$E0
    BCC YOBJ_POS_GTE_0x20 ; <, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
YOBJ_POS_GTE_0x20: ; 17:14D8, 0x02F4D8
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Find diff.
    STA TMP_08 ; Store diff.
    LDA OBJ_POS_X??[18],Y ; Load from Yobj.
    CMP #$B8 ; If _ #$B8
    BCC LT_0xB8 ; <, goto.
    LDA TMP_10 ; Load flag.
    BNE SET_ATTRS_B ; Set, goto.
    LDA TMP_08 ; Load diff.
    CMP #$28 ; If _ #$28
    BCC SET_ATTRS_B ; <, goto.
    CMP #$38 ; If _ #$38
    BCS SET_ATTRS_A ; >=, goto.
    BCC SKIP_ATTR_SET ; <, goto.
LT_0xB8: ; 17:14F4, 0x02F4F4
    LDA TMP_08 ; Load diff.
    BEQ SET_ATTRS_A ; == 0, goto.
    LDA TMP_08 ; Load diff.
    CMP #$28 ; If _ #$28
    BCC SET_ATTRS_A ; <, goto.
    CMP #$38 ; If _ #$38
    BCC SKIP_ATTR_SET ; <, goto.
SET_ATTRS_B: ; 17:1502, 0x02F502
    JSR SET_ATTR_HELPER_B ; Set attrs.
    JMP SKIP_ATTR_SET ; Skip.
SET_ATTRS_A: ; 17:1508, 0x02F508
    JSR SET_ATTR_HELPER_A ; Set attr B.
SKIP_ATTR_SET: ; 17:150B, 0x02F50B
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Test bit.
    BNE OTHER_DIFF ; Set, goto.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Do sub.
    STA TMP_09 ; Store.
    LDA TMP_12 ; Load flag.
    BNE LT_0x28 ; Set, goto.
    LDA TMP_09 ; Load 
    CMP #$28 ; If _ #$28
    BCC LT_0x28 ; <, goto.
    CMP #$38 ; If _ #$38
    BCC LT_0x38 ; <, goto.
    JSR SET_ATTR_HELPER_C ; Set attr.
    JMP LT_0x38 ; Goto.
LT_0x28: ; 17:152B, 0x02F52B
    JSR SET_ATTR_HELPER_D ; Set attr.
LT_0x38: ; 17:152E, 0x02F52E
    JMP SYNC
OTHER_DIFF: ; 17:1531, 0x02F531
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Find diff.
    STA TMP_09 ; Store.
    LDA TMP_12 ; Load flag.
    BEQ FLAG_NOT_SET ; Not set, goto.
    LDA TMP_09 ; Load diff.
    CMP #$28 ; If _ #$28
    BCC FLAG_NOT_SET ; <, goto.
    CMP #$38 ; If _ #$38
    BCC SYNC ; <, goto.
    JSR SET_ATTR_HELPER_D ; Set attr.
    JMP SYNC ; Goto.
FLAG_NOT_SET: ; 17:154A, 0x02F54A
    JSR SET_ATTR_HELPER_C ; Set attr.
SYNC: ; 17:154D, 0x02F54D
    LDA 96_UNK ; Load ??
    AND #$02 ; Keep bit.
    BEQ STATE_SWITCH_OUTRO ; NMot set, goto.
    LDA OBJ_POS_X_DELTA?[18],X ; Load.
    BNE STATE_SWITCH_OUTRO ; Goto outro.
GENERAL_ATTR_THINGS: ; 17:1558, 0x02F558
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$01 ; Keep bit.
    BNE NEXT_SECONDARY_CLEAR_TERT_OUTRO ; If set, goto.
    LDA #$20
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$05
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$09
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP STATE_SWITCH_OUTRO ; Goto.
NEXT_SECONDARY_CLEAR_TERT_OUTRO: ; 17:1570, 0x02F570
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JMP OUTRO_FINAL ; Outro.
STATE_SWITCH_OUTRO: ; 17:157B, 0x02F57B
    LDA TMP_08 ; Load
    CMP #$0C ; If _ #$0C
    BCS OUTRO_FINAL ; >=, goto.
    LDA TMP_09 ; Load
    CMP #$20 ; If _ #$20
    BCS OUTRO_FINAL ; >=, goto.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
OUTRO_FINAL: ; 17:158F, 0x02F58F
    JSR ANIM_SOLVE ; Get anim.
    JSR MOD_DIRECTION_TO_PLAYER_FOCUSED? ; Do.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_B: ; 17:1598, 0x02F598
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$01 ; Keep bit.
    BNE BIT_SET ; Set, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Keep bit.
    BNE BIT_0x08_SET ; != 0, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj.
    CMP #$E0 ; If _ #$E0
    BCC EXIT_TERT_PREV ; <, goto.
    BCS BIT_0x08_SET ; >=, goto? Mistake, lol.
BIT_0x08_SET: ; 17:15B5, 0x02F5B5
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
    LDA OBJ_POS_X??[18],X ; Load.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move next tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
BIT_SET: ; 17:15C6, 0x02F5C6
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Keep bit.
    BNE BIT_0x08_SET_B ; != 0, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$20 ; If _ #$20
    BCS EXIT_TERT_PREV ; >=, prev tert.
    BCC BIT_0x08_SET_B ; <, goto. Mistake 2x, lol.
BIT_0x08_SET_B: ; 17:15D6, 0x02F5D6
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
    LDA OBJ_POS_X??[18],X ; Load.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Move to.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
EXIT_TERT_PREV: ; 17:15E7, 0x02F5E7
    DEC OBJ_TERTIARY_SWITCH?[18],X ; Tert--
    JSR ANIM_SOLVE ; Solve anim.
    JSR MOD_DIRECTION_TO_PLAYER_FOCUSED? ; Mod dir.
    JMP OBJECT_X_MOVE? ; Move to Xobj.
SWITCH_RTN_C: ; 17:15F3, 0x02F5F3
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load attr.
    AND #$01 ; Test bit.
    BNE BIT_SET_0x01 ; Set, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Test bit.
    BNE BIT_SET_0x08 ; Set, goto.
BIT_SET_0x08_B: ; 17:1601, 0x02F601
    LDA #$FF
    STA OBJ_POS_X_DELTA?[18],X ; Set to negative?
ENTER_AFTER_DELTA_CHANGE: ; 17:1606, 0x02F606
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load.
    CMP #$21 ; If _ #$21
    BCC LT_0x21 ; <, goto.
    AND #$1F ; Keep these.
    EOR #$1F ; Invert val.
    CLC
    ADC #$01 ; Fix compliment.
LT_0x21: ; 17:1614, 0x02F614
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Load data.
    STA TMP_00 ; Store to TMP.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from obj.
    CMP #$C0 ; If _ #$C0
    BCC LT_0xC0 ; <, goto.
    LDA TMP_00 ; Load
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
    STA TMP_00 ; Store back.
LT_0xC0: ; 17:162A, 0x02F62A
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from Xobj.
    CLC ; Prep add.
    ADC TMP_00 ; Add val.
    STA OBJ_POS_X??[18],X ; Set attr with.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load val.
    CMP #$40 ; If _ #$40
    BCC EXIT_ANIM_SOLVE_AND_MORE ; <, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    EOR #$08 ; Invert bit.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store back.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
BIT_SET_0x01: ; 17:164D, 0x02F64D
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$08 ; Test bit.
    BNE BIT_SET_0x08_B ; Set, goto.
BIT_SET_0x08: ; 17:1654, 0x02F654
    LDA #$01 ; Val.
    STA OBJ_POS_X_DELTA?[18],X ; Set positive.
    BNE ENTER_AFTER_DELTA_CHANGE ; != 0, goto.
EXIT_ANIM_SOLVE_AND_MORE: ; 17:165B, 0x02F65B
    JSR ANIM_SOLVE ; Solve anim.
    JSR MOD_DIRECTION_TO_PLAYER_FOCUSED? ; Mod attr.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_D: ; 17:1664, 0x02F664
    LDA #$6D
    STA OBJ_ANIMATION_DISPLAY[18],X ; Change animation.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Test bit.
    BNE BIT_SET_0x04 ; Set, goto.
    LDA #$02 ; Seed positive.
    BNE VAL_SEEDED
BIT_SET_0x04: ; 17:1674, 0x02F674
    LDA #$FE ; Seed negative.
VAL_SEEDED: ; 17:1676, 0x02F676
    STA OBJ_POS_X_DELTA?[18],X ; Store move.
    LDA #$F9 ; Val??
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set ??
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_E: ; 17:1684, 0x02F684
    LDY #$00
    LDA #$80
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Mod vals.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Do rtn.
    BMI EXIT_MOVE ; Negative, goto.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    STA 4C6_OBJ_UNK[18],X ; Clear this too.
    LDA #$00 ; Not needed.
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
EXIT_MOVE: ; 17:169E, 0x02F69E
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_F: ; 17:16A1, 0x02F6A1
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    JSR SUB_SOLVE_P1/P2_INDEX ; Get P1/P2 from Obj settings.
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BEQ TIMER_EQ_ZERO ; == 0, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$01 ; Test bit.
    BNE DIFF_RTN ; Set, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$04 ; Test bit.
    BEQ BIT_0x04_UNSET
    LDA #$02 ; Seed pos.
    BNE VAL_SEEDED ; Always taken.
BIT_0x04_UNSET: ; 17:16C1, 0x02F6C1
    LDA #$FE ; See negative.
VAL_SEEDED: ; 17:16C3, 0x02F6C3
    STA OBJ_POS_X_DELTA?[18],X ; Store attr.
    JMP EXIT_PREP ; Goto.
DIFF_RTN: ; 17:16C9, 0x02F6C9
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$0C ; If _ #$0C
    BCC LT_0x0C ; <, goto.
    LDA TMP_10 ; Load flag. Xobj > Yobj.
    BNE SEED_NEGATIVE ; Set, goto.
    LDA #$02 ; Seed positive.
    BNE VAL_SEEDED ; Always taken.
SEED_NEGATIVE: ; 17:16D8, 0x02F6D8
    LDA #$FE ; Seed negative.
VAL_SEEDED: ; 17:16DA, 0x02F6DA
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Store.
LT_0x0C: ; 17:16DD, 0x02F6DD
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    LDA TMP_12 ; Flag.
    BNE FLAG_SET ; Set, goto.
    LDA #$02 ; Seed positive.
    BNE VAL_SEEDED ; Always taken.
FLAG_SET: ; 17:16E8, 0x02F6E8
    LDA #$FE ; Seed negative.
VAL_SEEDED: ; 17:16EA, 0x02F6EA
    STA OBJ_POS_X_DELTA?[18],X ; Store val.
EXIT_PREP: ; 17:16ED, 0x02F6ED
    JSR SUB_SOLVE_P1/P2_INDEX ; Get P1/P2 index.
    JSR FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$0C ; If _ #$0C
    BCS EXIT_RTN ; >=, goto.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    CMP #$20 ; If _ #$20
    BCS EXIT_RTN ; >=, goto.
TIMER_EQ_ZERO: ; 17:16FE, 0x02F6FE
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_RTN: ; 17:1706, 0x02F706
    JSR ANIM_SOLVE ; Do.
    JSR MOD_DIRECTION_TO_PLAYER_FOCUSED? ; Do.
    JMP OBJECT_X_MOVE? ; Leave.
STATE_0x3E_SWITCH_D: ; 17:170F, 0x02F70F
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Switch on tert.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_RTN_A)
    HIGH(SWITCH_RTN_A)
    LOW(SWITCH_RTN_B)
    HIGH(SWITCH_RTN_B)
    LOW(SWITCH_RTN_C)
    HIGH(SWITCH_RTN_C)
    LOW(SWITCH_RTN_D)
    HIGH(SWITCH_RTN_D)
    LOW(SWITCH_RTN_E)
    HIGH(SWITCH_RTN_E)
    LOW(SWITCH_RTN_F)
    HIGH(SWITCH_RTN_F)
    LOW(SWITCH_RTN_G)
    HIGH(SWITCH_RTN_G)
SWITCH_RTN_A: ; 17:1723, 0x02F723
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$6A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_B: ; 17:1734, 0x02F734
    JSR RTN_GET_OBJ_PAIR_IN_Y_RET_CC_SUCCESS ; Get pair.
    BCS OBJ_FAILED ; Failed, just do move.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load from Xobj.
    STA 556_OBJ_STATUS_FLAGS_A[18],Y ; Store to Yobj.
    AND #$04 ; Keep bit.
    BNE BIT_0x04_SET ; Set, goto.
    LDA #$04 ; Seed val.
    BNE VAL_SEEDED ; Val seeded.
BIT_0x04_SET: ; 17:1747, 0x02F747
    LDA #$FC ; Seed negative.
VAL_SEEDED: ; 17:1749, 0x02F749
    CLC ; Prep add.
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add with.
    STA OBJ_POS_X_CONFIRMED[18],Y ; To Yobj.
    LDA OBJ_POS_X??[18],X ; From Xobj.
    STA OBJ_POS_X??[18],Y ; To Yobj.
    LDA #$E2
    STA 4C6_OBJ_UNK[18],Y ; Set new obj attr.
    LDA #$3F
    STA OBJ_ENABLED_STATE+MORE?[18],Y ; Set new obj state.
    LDA #$6C
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
OBJ_FAILED: ; 17:176D, 0x02F76D
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_C: ; 17:1770, 0x02F770
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE ; Nonzero, leave.
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Secondary--
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load attr.
    AND #$F7 ; Keep 1111.0111
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store to.
    CLC ; Prep add.
    LDA 95_UNK ; Load val.
    ADC #$FF ; Carry if nonzero, -= 1.
    STA 95_UNK ; Store.
    LDA 96_UNK ; Load val.
    ADC #$00 ; Carry add. If 95 was nonzero, this will +1, otherwise, +0.
    STA 96_UNK ; Store to.
EXIT_MOVE: ; 17:1792, 0x02F792
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_D: ; 17:1795, 0x02F795
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$6A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear step.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Tert++
    JSR OBJECT_X_MOVE? ; Do.
    LDA #$15
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS for exit.
SWITCH_RTN_E: ; 17:17B3, 0x02F7B3
    JSR UPDATE_ANIMATION_HELPER ; Do sub.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_F: ; 17:17B9, 0x02F7B9
    LDY #$02 ; Seed val.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$04 ; Test bit.
    BEQ BIT_0x04_NOT_SET ; Unset, goto.
    LDY #$FE ; Seed negative.
BIT_0x04_NOT_SET: ; 17:17C4, 0x02F7C4
    TYA ; To A.
    STA OBJ_POS_X_DELTA?[18],X ; Store to obj.
    LDA #$10
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JSR ANIM_SOLVE ; Solve anim.
    JMP OBJECT_X_MOVE? ; Goto, abuse RTS.
SWITCH_RTN_G: ; 17:17D6, 0x02F7D6
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE TIMER_NONZERO ; != 0, goto.
    LDA #$00
TERT_SEEDED_IN_A: ; 17:17DD, 0x02F7DD
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_MOVE: ; 17:17E5, 0x02F7E5
    JMP OBJECT_X_MOVE? ; Exit, abuse RTS.
TIMER_NONZERO: ; 17:17E8, 0x02F7E8
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$04 ; Test bit.
    BNE BIT_SET ; Set, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$F0 ; If _ #$F0
    BCC EXIT_MOVE ; <, goto.
    BCS SEED_0x01 ; >=, goto.
BIT_SET: ; 17:17F8, 0x02F7F8
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$10 ; If _ #$10
    BCS EXIT_MOVE ; >=, goto.
SEED_0x01: ; 17:17FF, 0x02F7FF
    LDA #$01 ; Tert seed.
    BNE TERT_SEEDED_IN_A ; Always taken.
STATE_0x3E_SWITCH_E: ; 17:1803, 0x02F803
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_RTN_A)
    HIGH(SWITCH_RTN_A)
    LOW(SWITCH_RTN_B)
    HIGH(SWITCH_RTN_B)
SWITCH_RTN_A: ; 17:180D, 0x02F80D
    JSR CLEAR_OBJ_ATTRS_UNK_154F ; Clear attrs.
    LDA #$6D
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$30
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDY #$02 ; Seed val.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$04 ; Test bit.
    BEQ BIT_0x04_UNSET
    LDY #$FE ; Seed negative.
BIT_0x04_UNSET: ; 17:1825, 0x02F825
    TYA ; To A.
    STA OBJ_POS_X_DELTA?[18],X ; Store to X.
    LDA #$FE
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set negative attr.
    LDA #$14
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JSR OBJECT_X_MOVE? ; Move.
    LDA #$2B
    JMP SND_BANKED_DISPATCH ; PLay sound, leave RTS abuse.
SWITCH_RTN_B: ; 17:183E, 0x02F83E
    LDY #$00
    LDA #$20
    JSR ADD_A/Y_TO_DELTA_UNK_C ; Mod.
    JSR MOVE_OBJ_ATTR_BY_DELTA_UNK ; Mod.
    BMI RET_NEGATIVE ; If negative, goto.
    JSR CLEAR_OBJ_ATTRS_DELTAS? ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    STA 4C6_OBJ_UNK[18],X ; Clear.
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Adjust back to base obj.
    LDA #$02 ; Secondary seed.
    LDY OBJECT_DATA_HEALTH?[18],X ; Health.
    BNE SECONDARY_SEEDED ; != 0, goto.
    LDA #$6E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim for zero health.
    LDA #$05 ; Seed secondary.
SECONDARY_SEEDED: ; 17:1869, 0x02F869
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store secondary.
RET_NEGATIVE: ; 17:186C, 0x02F86C
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$04 ; Test bit.
    BEQ BIT_0x04_UNSET ; Unset, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$10 ; If _ #$10
    BCS EXIT_MOVE ; >=, goto.
    BCC EXIT_CLEAR_ATTRS ; <, goto.
BIT_0x04_UNSET: ; 17:187C, 0x02F87C
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$F0 ; If _ #$F0
    BCC EXIT_MOVE ; <, goto.
EXIT_CLEAR_ATTRS: ; 17:1883, 0x02F883
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
EXIT_MOVE: ; 17:1886, 0x02F886
    JMP OBJECT_X_MOVE? ; Goto. Abuse RTS.
UPDATE_ANIMATION_HELPER: ; 17:1889, 0x02F889
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CMP #$08 ; If _ #$08
    BCC UPDATE_ANIM_STUFF ; <, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    CMP #$08 ; If _ #$08
    BCC UPDATE_ANIM_STUFF ; <, goto.
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear step.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
UPDATE_ANIM_STUFF: ; 17:18AB, 0x02F8AB
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DISP_DATA,Y ; Move data to attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA OBJ_EXTRA_DATA,Y
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS ; Leave.
OBJ_DISP_DATA: ; 17:18BD, 0x02F8BD
    .db 6A
OBJ_EXTRA_DATA: ; 17:18BE, 0x02F8BE
    .db 14
    .db 6F
    .db BD
    .db 70
    .db BD
    .db AC
    .db BE
    .db AC
    .db BE
    .db 70
    .db BD
    .db 6F
    .db BD
    .db 6A
    .db 14
SUB_SOLVE_P1/P2_INDEX: ; 17:18CD, 0x02F8CD
    LDY #$00 ; Index.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BPL RTS ; If positive, goto.
    LDY #$02 ; If negative, different index.
RTS: ; 17:18D6, 0x02F8D6
    RTS
SET_ATTR_HELPER_A: ; 17:18D7, 0x02F8D7
    LDA #$01
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
SET_ATTR_HELPER_B: ; 17:18DD, 0x02F8DD
    LDA #$FF
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
SET_ATTR_HELPER_C: ; 17:18E3, 0x02F8E3
    LDA #$01
    STA OBJ_POS_X_DELTA?[18],X
    RTS
SET_ATTR_HELPER_D: ; 17:18E9, 0x02F8E9
    LDA #$FF
    STA OBJ_POS_X_DELTA?[18],X
    RTS
MOD_DIRECTION_TO_PLAYER_FOCUSED?: ; 17:18EF, 0x02F8EF
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$03 ; Keep 0000.0011
    BEQ NOT_BITS_SET
    LDY #$00 ; Val?
    AND #$01 ; Test bit.
    BNE BIT_SET ; If set, use as-is.
    LDY #$04 ; Alt val.
BIT_SET: ; 17:18FE, 0x02F8FE
    TYA ; To A.
    JMP A_SEEDED ; Goto.
NOT_BITS_SET: ; 17:1902, 0x02F902
    LDY #$00 ; Player index.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    BPL KEEP_Y ; Positive, use val.
    LDY #$02 ; Alt val, P2.
KEEP_Y: ; 17:190B, 0x02F90B
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Get diff.
    LDA #$00 ; Seed val.
    LDY TMP_12 ; Load flag.
    BNE A_SEEDED ; Set, goto.
    LDA #$04 ; Alt A seed.
A_SEEDED: ; 17:1916, 0x02F916
    STA TMP_00 ; Store to TMP.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$FB ; Keep 1111.1011
    ORA TMP_00 ; Set flag solved.
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back.
    RTS ; Leave.
ANIM_SOLVE: ; 17:1923, 0x02F923
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Move hold.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load.
    CMP #$08 ; If _ #$08
    BCC HOLD_LT_0x08 ; <, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Move entry.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$01 ; Keep bit.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store back.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
HOLD_LT_0x08: ; 17:193D, 0x02F93D
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    CLC
    ADC #$6A ; Add anim base.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS
FILL_OUT_UNASSIGNED_PLAYER_ANIMS: ; 17:1947, 0x02F947
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    BNE VAL_NONZERO ; !=, goto.
    INC DD_UNK ; Inc on count.
VAL_NONZERO: ; 17:194D, 0x02F94D
    LDA DD_UNK ; Load count.
    AND #$02 ; Keep bit.
    ASL A ; << 3, *8
    ASL A
    ASL A
    STA TMP_01 ; Store to TMP.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$EF ; Keep 1110.1111
    ORA TMP_01 ; Set bit kept.
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back.
    LDA #$00
    STA TMP_00 ; Clear.
    LDY #$07 ; Yobj seed.
LOOP_OBJS: ; 17:1966, 0x02F966
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Yobj.
    CMP #$3E ; If _ #$3E
    BEQ BREAKOUT ; ==, goto. Break out on obj.
NEXT_YOBJ_LOOP: ; 17:196D, 0x02F96D
    INY ; Next obj pair.
    INY
    CPY #$11 ; If _ #$11
    BCC LOOP_OBJS ; <, goto.
    RTS ; Leave.
BREAKOUT: ; 17:1974, 0x02F974
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary of Xobj.
    CMP #$02 ; If _ #$02
    BNE SECONDARY_NOT_0x02 ; !=, goto.
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load Xobj tert.
    BNE NEXT_YOBJ_LOOP ; != 0, goto.
SECONDARY_NOT_0x02: ; 17:1980, 0x02F980
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load Xobj status.
    AND #$10 ; Keep bit.
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    STA TMP_17 ; Store to. 0x00 or 0x02. Index.
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BNE 2P_FLAG_SET ; 2P, goto.
P2_ANIM_ZERO: ; 17:198E, 0x02F98E
    STY TMP_10 ; Store Yobj matched earlier.
    LDY TMP_17 ; Load flag.
    LDA 1P_PTRS_L,Y ; Seed ptr.
    STA TMP_08
    LDA 1P_PTRS_H,Y
    STA TMP_09
FP_SEEDED: ; 17:199C, 0x02F99C
    LDY TMP_00 ; Index from TMP_00.
    LDA [TMP_08],Y ; Load from fp.
    STA TMP_11 ; Store to.
    LDY TMP_10 ; Load Yobj again.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],Y ; Load from Yobj.
    AND #$08 ; Keep 0000.1000
    ORA TMP_11 ; Or with data.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],Y ; Store back.
    INC TMP_00 ; Stream++
    JMP NEXT_YOBJ_LOOP ; Goto, loop on more Yobjs.
2P_FLAG_SET: ; 17:19B3, 0x02F9B3
    LDA OBJ_ANIMATION_DISPLAY[18] ; Load from P1.
    BEQ P1_ANIM_ZERO ; == 0, goto.
    LDA OBJ_ANIMATION_DISPLAY+2 ; Load from P2.
    BEQ P2_ANIM_ZERO ; == 0, goto.
    STY TMP_10 ; Save Yobj.
    LDY TMP_17 ; Load index.
    LDA 2P_PTRS_P2_L,Y ; Seed ptr.
    STA TMP_08
    LDA 2P_PTRS_P2_H,Y
    STA TMP_09
    JMP FP_SEEDED
P1_ANIM_ZERO: ; 17:19CE, 0x02F9CE
    STY TMP_10 ; Save Yobj.
    LDY TMP_17 ; Load index.
    LDA 2P_PTRS_P1_L,Y ; Seed ptr.
    STA TMP_08
    LDA 2P_PTRS_P1_H,Y
    STA TMP_09
    JMP FP_SEEDED
1P_PTRS_L: ; 17:19DF, 0x02F9DF
    LOW(1P_DATA_A)
1P_PTRS_H: ; 17:19E0, 0x02F9E0
    HIGH(1P_DATA_A)
    LOW(1P_DATA_B)
    HIGH(1P_DATA_B)
1P_DATA_A: ; 17:19E3, 0x02F9E3
    .db 00
    .db 01
1P_DATA_B: ; 17:19E5, 0x02F9E5
    .db 01
    .db 00
2P_PTRS_P1_L: ; 17:19E7, 0x02F9E7
    LOW(2P_P1_DATA_A)
2P_PTRS_P1_H: ; 17:19E8, 0x02F9E8
    HIGH(2P_P1_DATA_A)
    LOW(2P_P1_DATA_B)
    HIGH(2P_P1_DATA_B)
2P_P1_DATA_A: ; 17:19EB, 0x02F9EB
    .db 80
    .db 81
2P_P1_DATA_B: ; 17:19ED, 0x02F9ED
    .db 81
    .db 80
2P_PTRS_P2_L: ; 17:19EF, 0x02F9EF
    LOW(2P_P2_DATA_A)
2P_PTRS_P2_H: ; 17:19F0, 0x02F9F0
    HIGH(2P_P2_DATA_A)
    LOW(2P_P2_DATA_B)
    HIGH(2P_P2_DATA_B)
2P_P2_DATA_A: ; 17:19F3, 0x02F9F3
    .db 00
    .db 80
2P_P2_DATA_B: ; 17:19F5, 0x02F9F5
    .db 80
    .db 00
OBJ_DATA: ; 17:19F7, 0x02F9F7
    .db 00
    .db 08
    .db 0B
    .db 0D
    .db 0F
    .db 11
    .db 12
    .db 14
    .db 15
    .db 16
    .db 17
    .db 18
    .db 19
    .db 19
    .db 1A
    .db 1B
    .db 1B
    .db 1C
    .db 1C
    .db 1D
    .db 1D
    .db 1E
    .db 1E
    .db 1E
    .db 1F
    .db 1F
    .db 1F
    .db 1F
    .db 20
    .db 20
    .db 20
    .db 20
    .db 20
OBJ_STATE_0x3F_HANDLER: ; 17:1A18, 0x02FA18
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x3F_SUBSWITCH_A)
    HIGH(STATE_0x3F_SUBSWITCH_A)
    LOW(STATE_0x3F_SUBSWITCH_B)
    HIGH(STATE_0x3F_SUBSWITCH_B)
STATE_0x3F_SUBSWITCH_A: ; 17:1A22, 0x02FA22
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    LDA #$BF
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$71
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDY #$03 ; Val seed.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    AND #$04 ; Test bit.
    BNE VAL_SEEDED ; Set, goto.
    LDY #$FD ; Seed alt.
VAL_SEEDED: ; 17:1A3C, 0x02FA3C
    TYA ; To A.
    STA OBJ_POS_X_DELTA?[18],X ; Store val.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    JSR OBJECT_X_MOVE? ; Do.
    LDA #$13
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
STATE_0x3F_SUBSWITCH_B: ; 17:1A4B, 0x02FA4B
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    JSR OBJECT_X_MOVE? ; Do.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Test bits.
    BEQ RTS ; Neither set, leave.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init if set. Abuse RTS.
RTS: ; 17:1A5B, 0x02FA5B
    RTS ; Leave.
OBJ_STATE_0x40_HANDLER: ; 17:1A5C, 0x02FA5C
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$08 ; If _ #$08
    BCC SKIP_STEP/SOUND ; <, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    LSR A ; >> 1, /2
    BCC SKIP_STEP/SOUND ; If was even, goto. 0x00, 0x02, 0x04, etc.
    LDA #$22
    JSR SND_BANKED_DISPATCH ; Play sound of odd. 0x01,0x03, etc.
SKIP_STEP/SOUND: ; 17:1A79, 0x02FA79
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    AND #$01 ; Keep bit.
    CLC ; Prep add.
    ADC #$A8 ; Add with anim base.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim val.
    LDA #$01
    STA OBJ_POS_X_DELTA?[18],X ; Set positive.
    LDA #$40
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set.
    JSR OBJECT_X_MOVE? ; Do.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    CMP #$02 ; If _ #$02
    BEQ RTS ; == 0, goto.
    JMP OBJ_POS_BASED_INIT_CLEAR ; Do.
RTS: ; 17:1A9B, 0x02FA9B
    .db 60 ; Leave.
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db 37

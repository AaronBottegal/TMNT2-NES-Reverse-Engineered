    .db 01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
RTS: ; 0D:0004, 0x01A004
    RTS ; Leave.
DIE: ; 0D:0005, 0x01A005
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj pair.
    INX
    JSR INIT_OBJECT[X]_DATA_FULL
    RTS ; Leave.
SOUND/ANIM/HOLD/CLC_HELPER: ; 0D:000D, 0x01A00D
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
RTS_CC: ; 0D:001C, 0x01A01C
    CLC ; Clear carry.
    RTS ; Leave.
HOLD_ANIM_RET_CS_FINISHED: ; 0D:001E, 0x01A01E
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL RTS_CC ; If positive, goto.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Anim++
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS_CC ; <, leave CC.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear anim.
    SEC ; Ret CS.
    RTS
SET_PAIR_SECONDARY/HOLD: ; 0D:0039, 0x01A039
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?+1,X ; Set pair secondary.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Set pair hold.
    RTS
OBJ_STATE_0x5C_HANDLER: ; 0D:0044, 0x01A044
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    BNE HAS_VAL ; != 0, goto.
    RTS ; Leave.
HAS_VAL: ; 0D:004A, 0x01A04A
    DEY ; --
    BEQ STATE_0x01 ; Was 0x01, goto.
    JMP STATE_NOT_0x01 ; Goto.
STATE_0x01: ; 0D:0050, 0x01A050
    LDA #$13
    JSR SND_BANKED_DISPATCH ; Play sound.
    DEX ; Mod object.
    JSR SUB_DETECTING_?? ; Do on Xobj-1
    INX ; Fix obj.
    ASL A ; << 1, *2.
    STA TMP_06 ; Store.
    ASL A ; << 1, *2. *4 total.
    STA TMP_05 ; Store to.
    LDA OBJ_ENABLED_STATE+MORE?+17,X ; Load Xobj-1 attr.
    AND #$40 ; Test bit.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to next obj.
    ASL A ; << 2, *4. To carry.
    ASL A
    LDA TMP_05 ; Load
    BCC SHIFTED_0x0 ; CC, goto, shifted 0x0.
    ORA #$02 ; Set if set.
SHIFTED_0x0: ; 0D:0070, 0x01A070
    TAY ; Val to index.
    CLC ; Prep add.
    LDA ATTR_DATA_A,Y ; Load indexed.
    ADC OBJ_POS_Y??+17,X ; Add with.
    STA OBJ_POS_X?[18],X ; Store to us.
    CLC ; Prep add.
    LDA ATTR_DATA_B,Y ; Load
    ADC 4B4_OBJ_SPEED?+17,X ; Add with.
    STA 4C6_OBJ_UNK[18],X ; Store to us.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Copy to us.
    STA OBJ_POS_X??[18],X
    JSR MOVE_Y_FINALIZE ; Do.
    LDY TMP_06 ; Y from.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BEQ HOLD_EQ_ZERO ; == 0, goto.
    LDA ANIM_DATA_A,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
HOLD_EQ_ZERO: ; 0D:009C, 0x01A09C
    LDA ANIM_DATA_B,Y ; Load attr.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA ATTR_DATA_C,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs from Yindex.
    LDA ATTR_DATA_D,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDY TMP_05 ; Index from.
    LDA ATTR_DATA_E,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move more attrs.
    LDA ATTR_DATA_F,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA ATTR_DATA_G,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA ATTR_DATA_H,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; Dir to carry.
    ASL A
    BCC RTS ; Shifted 0x0, leave. Skip invert.
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Prep sub.
    SBC OBJ_POS_X_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_DELTA?[18],X ; Store to.
RTS: ; 0D:00E3, 0x01A0E3
    RTS ; Leave.
STATE_NOT_0x01: ; 0D:00E4, 0x01A0E4
    DEY
    BNE STATE_NOT_0x02 ; != 0x02, goto.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_UNK ; Ret CS, goto.
    JSR MOVE_UNK_RET_??
    BCS EXIT_UNK ; Ret CS, goto.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG ; Do.
    BCS ALT ; Ret CS, alt routine.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$03 ; Keep bits.
    CMP OBJ_TERTIARY_SWITCH?+17,X ; If val _ extra
    BNE RTS ; !=, leave.
    LDA #$A5
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set otherwise. 1 in 4.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
RTS: ; 0D:010A, 0x01A10A
    RTS ; Leave.
ALT: ; 0D:010B, 0x01A10B
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear attr.
    LDA OBJ_POS_X??[18],X ; Move attr.
    STA OBJ_POS_Y??[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear. More mistakes with LD #$00 lol.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    LDA #$19
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
STATE_NOT_0x02: ; 0D:0129, 0x01A129
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Move step.
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    LDA ATTR_DATA_I,Y ; Data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set from.
    BNE RTS ; != 0, leave.
EXIT_UNK: ; 0D:0141, 0x01A141
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Clear attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$3F ; Keep bits 0011.1111
    ORA #$10 ; Set 0001.0000
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to hold. Random length, min 0x10.
RTS: ; 0D:0153, 0x01A153
    RTS ; Leave.
ATTR_DATA_I: ; 0D:0154, 0x01A154
    .db 19
    .db 18
    .db 19
    .db 00 ; Special.
ATTR_DATA_C: ; 0D:0158, 0x01A158
    .db 20
ATTR_DATA_D: ; 0D:0159, 0x01A159
    .db 02
    .db 20
    .db 03
    .db C0
    .db 01
ATTR_DATA_E: ; 0D:015E, 0x01A15E
    .db 52
ATTR_DATA_F: ; 0D:015F, 0x01A15F
    .db FF
ATTR_DATA_G: ; 0D:0160, 0x01A160
    .db E1
ATTR_DATA_H: ; 0D:0161, 0x01A161
    .db 01
    .db A6
    .db FF
    .db 08
    .db FE
    .db 1F
    .db FE
    .db 40
    .db 00
ATTR_DATA_A: ; 0D:016A, 0x01A16A
    .db F8
ATTR_DATA_B: ; 0D:016B, 0x01A16B
    .db 08
    .db 08
    .db 08
    .db F0
    .db FF
    .db 10
    .db FF
    .db F0
    .db 05
    .db 10
    .db 05
ANIM_DATA_A: ; 0D:0176, 0x01A176
    .db 16
ANIM_DATA_B: ; 0D:0177, 0x01A177
    .db 17
    .db 12
    .db 13
    .db 14
    .db 15
OBJ_STATE_0x5A_HANDLER: ; 0D:017C, 0x01A17C
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Xobj to.
    JSR RTN_MULTISWITCH ; Do switch.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load.
    CMP #$02 ; If _ #$02
    BNE RTS ; !=, goto.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    BNE HELD ; Held, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Invert attr.
    LSR A ; >> 1, /2.
    BEQ RTS ; == 0, leave.
    LDA #$0C
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 1, /2.
    BCS SHIFTED_0x01 ; Shifted 0x01, goto.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    BEQ RTS ; No hold, leave.
HELD: ; 0D:01A6, 0x01A1A6
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    NOP ; LSR option kept in the original code? lol. Mistake?
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    BCC SHIFTED_CLEAR ; Shifted clear, goto.
    ORA #$01 ; Set bit.
SHIFTED_CLEAR: ; 0D:01B9, 0x01A1B9
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store attr.
RTS: ; 0D:01BC, 0x01A1BC
    RTS ; Leave.
SHIFTED_0x01: ; 0D:01BD, 0x01A1BD
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BEQ HEALTH_EQ_ZERO ; == 0, goto.
    LDA #$2C
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ NOT_2P ; Not set, goto.
    LDA TMP_0D ; Load
    LSR A ; >> 1, /2.
    LDY #$02 ; Index P2.
    BCS SHIFTED_BIT ; Shifted off 0x1, goto.
NOT_2P: ; 0D:01D2, 0x01A1D2
    LDY #$00 ; Index P1.
SHIFTED_BIT: ; 0D:01D4, 0x01A1D4
    TYA ; To A.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set focus.
    LDA #$28
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold for us.
    RTS ; Leave.
HEALTH_EQ_ZERO: ; 0D:01DE, 0x01A1DE
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    JMP SOUND/ANIM/HOLD/CLC_HELPER ; Goto.
RTN_A: ; 0D:01EB, 0x01A1EB
    JSR HOLD_ANIM_RET_CS_FINISHED ; Do.
    BCC RTS ; CC, goto. Not finished.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
RTS: ; 0D:01F8, 0x01A1F8
    RTS ; Leave.
RTN_B: ; 0D:01F9, 0x01A1F9
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE CONTINUED ; != 0, goto.
    JSR INIT_OBJECT[X]_DATA_FULL ; Die.
    INX
    JSR INIT_OBJECT[X]_DATA_FULL
    DEX
CONTINUED: ; 0D:0206, 0x01A206
    RTS ; Leave.
OBJ_STATE_0x5B_HANDLER: ; 0D:0207, 0x01A207
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Obj from.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Yobj.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Alt obj from.
    ORA OBJ_ENABLED_STATE+MORE?[18],Y ; Or with Yobj.
    BEQ BOTH_STATES_DISABLED ; Both zero, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    LSR A ; >> 1, /2.
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Y from Xobj.
    BCS FIFTY_FIFTY ; Shifted 0x1, goto.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Alt focus.
FIFTY_FIFTY: ; 0D:0220, 0x01A220
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Y.
    BEQ OBJ_DISABLED ; == 0, disabled, goto.
    LDA OBJ_POS_X?[18],Y ; Move from Yobj to Xobj.
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_Y??[18],X
    LDA #$04
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
OBJ_DISABLED: ; 0D:0237, 0x01A237
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear anim.
    RTS ; Leave.
BOTH_STATES_DISABLED: ; 0D:023D, 0x01A23D
    JSR INIT_OBJECT[X]_DATA_FULL ; Init us.
    LDA #$0B ; Count?
    STA TMP_00 ; Store.
    LDA #$00 ; Seed init.
    LDY #$07 ; Obj.
LOOP_TO_COUNT: ; 0D:0248, 0x01A248
    ORA OBJ_ENABLED_STATE+MORE?[18],Y ; Or with Yobj state.
    INY ; Next Yobj.
    DEC TMP_00 ; Count--
    BNE LOOP_TO_COUNT ; != 0, goto.
    TAY ; Val to Y.
    BNE RTS ; Some enabled, continue by leaving now.
    DEC 710_BOSS_WHICH_HIT? ; --
    BMI 710_NEGATIVE ; Negative, goto.
    JMP OBJ_CREATION_RTN_UNK ; Waiting, goto.
RTS: ; 0D:025B, 0x01A25B
    RTS ; Leave.
710_NEGATIVE: ; 0D:025C, 0x01A25C
    LDA #$00
    STA 8B_BOSS?_UNK ; Clear var.
    RTS
RTN_MULTISWITCH: ; 0D:0261, 0x01A261
    JSR RTN_UNK ; Do.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    ASL A
    TAY
    LDA FILE_PTR_L,Y ; Load PTR for.
    STA TMP_00 ; Move to TMP_00
    LDA FILE_PTR_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    ASL A
    TAY
    LDA [TMP_00],Y ; Load from file.
    STA TMP_02 ; Move to TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02] ; Run RTN.
FILE_PTR_L: ; 0D:0284, 0x01A284
    LOW(FILE_A)
FILE_PTR_H: ; 0D:0285, 0x01A285
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_D)
    HIGH(FILE_D)
FILE_A: ; 0D:0290, 0x01A290
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_B: ; 0D:0292, 0x01A292
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
FILE_C: ; 0D:029A, 0x01A29A
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_D: ; 0D:029E, 0x01A29E
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
L_0D:02A2: ; 0D:02A2, 0x01A2A2
    LDA #$01
    STA 710_BOSS_WHICH_HIT?
OBJ_CREATION_RTN_UNK: ; 0D:02A7, 0x01A2A7
    LDA #$07
    STA TMP_08 ; Set to 0x07. Used for Obj indexes, but 0x07, idk.
    STA TMP_09
    STA TMP_0A
    STA TMP_0B
    LDA #$03 ; Max count. 0x04 creations.
    STA TMP_10 ; Index into TMP_08, slot.
SLOTS: ; 0D:02B5, 0x01A2B5
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Get pair.
    BCS OBJ_GET_FAIL ; Fail, goto.
    LDY TMP_10 ; Slot index.
    TXA ; Obj index found to A.
    STA TMP_08,Y ; Obj to arr.
    LDA #$5A
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set enabled.
    LDA #$5C
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?+1,X ; Set pair.
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Clear attrs.
    STA OBJ_SECONDARY_SWITCH?+1,X
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA TMP_10 ; Load index we slotted.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store to obj.
    DEC TMP_10 ; Slot--
    BPL SLOTS ; Slot positive, goto.
OBJ_GET_FAIL: ; 0D:02E3, 0x01A2E3
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Try again?
    BCS RTS ; Fail, goto.
    LDA #$5B
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set enabled.
    STA OBJ_ENABLED_STATE+MORE?+1,X ; And pair.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attrs.
    STA 556_OBJ_STATUS_FLAGS_A+1,X
    LDA TMP_08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attrs from TMP. Slots.
    LDA TMP_09
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA TMP_0A
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    LDA TMP_0B
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X
RTS: ; 0D:030C, 0x01A30C
    RTS ; Leave.
RTN_A: ; 0D:030D, 0x01A30D
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear
    LDA #$7C
    STA OBJ_POS_X?[18],X ; Set attr.
    LDA #$98
    STA OBJ_POS_X??[18],X ; Set attr.
    LDA #$D8
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JSR MOVE_Y_FINALIZE ; Do.
    JSR GFX/DISP_STUFF ; Do.
    LDA #$06
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA #$00 ; Wtf is this shit. Mistake.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear these, too.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Y from.
    LDA DATA_A,Y
    STA OBJ_TERTIARY_SWITCH?+1,X ; Pair tert.
    LDA DATA_B,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step.
    LDA DATA_C,Y
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Pair hold.
    JSR EXTRA_TO_ATTRS ; Do.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attrs from index.
    LDA DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA DATA_C,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA DATA_D,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND TWO_PLAYERS_FLAG ; And with flag. If not set, will always be P1. Nice/cool code.
    ASL A ; << 1, *2.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to focus.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
DATA_A: ; 0D:037F, 0x01A37F
    .db 0E
    .db 0B
    .db 07
    .db 04
DATA_B: ; 0D:0383, 0x01A383
    .db 01
    .db 11
    .db 21
    .db 31
DATA_C: ; 0D:0387, 0x01A387
    .db 28
    .db 3C
    .db 50
    .db 64
DATA_B: ; 0D:038B, 0x01A38B
    .db 08
DATA_A: ; 0D:038C, 0x01A38C
    .db 00
    .db 00
    .db 00
    .db 00
    .db 40
    .db 08
    .db 40
DATA_A: ; 0D:0393, 0x01A393
    .db 08
DATA_B: ; 0D:0394, 0x01A394
    .db FF
DATA_C: ; 0D:0395, 0x01A395
    .db 43
DATA_D: ; 0D:0396, 0x01A396
    .db 00
    .db 80
    .db FF
    .db DF
    .db 00
    .db 80
    .db 00
    .db DF
    .db 00
    .db F8
    .db 00
    .db 43
    .db 00
RTN_A: ; 0D:03A3, 0x01A3A3
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE JMP_TO_EXTRA_TO_ATTRS ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JSR PAIR_ATTR_SET+MAIN_CLEARS ; Do.
    JMP JMP_TO_EXTRA_TO_ATTRS ; Goto, abuse RTS.
RTN_B: ; 0D:03B1, 0x01A3B1
    JSR RTN_B ; Do.
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load
    CMP #$00 ; If _ #$00
    BNE JMP_TO_EXTRA_TO_ATTRS ; !=, goto.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    EOR #$03 ; Invert bits.
    TAY ; To Y index.
    LDA DATA_B,Y ; Load data.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set from.
    JMP JMP_TO_EXTRA_TO_ATTRS ; Goto.
RTN_C: ; 0D:03CF, 0x01A3CF
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE JMP_TO_EXTRA_TO_ATTRS ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert when expired.
    LDA #$28
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Seed on move.
JMP_TO_EXTRA_TO_ATTRS: ; 0D:03DC, 0x01A3DC
    JMP EXTRA_TO_ATTRS ; Goto.
RTN_D: ; 0D:03DF, 0x01A3DF
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BEQ EXTENDED ; == 0, goto.
    JSR XPOS_RTN_RET_?? ; DO.
    JSR MOVE_UNK_RET_?? ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    JMP EXTRA_TO_ATTRS ; Goto.
EXTENDED: ; 0D:03F0, 0x01A3F0
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set states.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA OBJ_POS_X?[18],X ; Load
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Store to pair.
    LDA OBJ_POS_X??[18],X ; Load
    CLC ; Prep add.
    ADC #$1C ; Add
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Store to pair.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    EOR #$01 ; Invert.
    AND #$01 ; Keep.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    LDA #$5A
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    LDA #$07
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set attr.
    RTS ; Leave.
EXTRA_TO_ATTRS: ; 0D:0424, 0x01A424
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1, *2. Word index.
    TAY ; To Y index.
    LDA DATA_A,Y
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store.
    LDA DATA_B,Y ; Index mod for attrs in JMP.
    JMP EXIT_GFX/INDEX_MOD_STORE
GFX/DISP_STUFF: ; 0D:0435, 0x01A435
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JSR SUB_DETECTING_??
    ASL A ; << 2, *4.
    ASL A
EXIT_GFX/INDEX_MOD_STORE: ; 0D:043D, 0x01A43D
    STA TMP_00 ; Store to.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$03 ; Keep 0000.0011
    ORA TMP_00 ; Set bits.
    TAY ; To index.
    LDA DISP_DATA,Y ; Load on index.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$34
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$2D
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
SUB_DETECTING_??: ; 0D:0455, 0x01A455
    JSR RTN_BOX_DETECT? ; Do.
    LDY #$02 ; Index.
    LDA TMP_10 ; Load
    CMP #$20 ; If _ #$20
    BCS EXIT ; >=, goto.
    DEY ; = 1
    LDA TMP_13 ; Load
    BPL EXIT ; If positive, use.
    DEY ; = 0
EXIT: ; 0D:0466, 0x01A466
    TYA ; To A.
    RTS ; Leave.
DISP_DATA: ; 0D:0468, 0x01A468
    .db 0B
    .db BE
    .db B8
    .db BE
    .db 09
    .db BC
    .db B6
    .db BC
    .db 0A
    .db BD
    .db B7
    .db BD
RTN_A: ; 0D:0474, 0x01A474
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    BCC GOT_FOCUS ; Got focus, goto.
    JSR GFX/DISP_STUFF ; Do.
    JMP PAIR_ATTR_SET+MAIN_CLEARS+TERT ; Goto.
GOT_FOCUS: ; 0D:047F, 0x01A47F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from player.
    AND #$04 ; Test bit.
    BEQ SEED_STEP ; Unset, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BPL RE-ENTERUNSET ; If positive, re-enter.
    JSR GFX/DISP_STUFF ; Do.
    JMP PAIR_ATTR_SET+MAIN_CLEARS+TERT ; Goto.
SEED_STEP: ; 0D:0494, 0x01A494
    LDA #$07
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Seed step again.
RE-ENTERUNSET: ; 0D:0499, 0x01A499
    JSR DIFFS_TO_ATTRS_UNK ; Do.
    JSR SET_ATTR_UNK_A ; Do.
    JSR SET_ATTR_UNK_B ; Do.
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load pair.
    BNE PAIR_VAL ; != 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; --
    BNE PAIR_VAL ; != 0, goto.
    JSR SET_PAIR_SECONDARY/HOLD ; Do if zero.
PAIR_VAL: ; 0D:04AF, 0x01A4AF
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    JSR RTN_UNK ; Do.
    CLC ; Prep add.
    LDA TMP_08 ; Load
    ADC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Add with pair.
    CMP #$1B ; If _ #$1B
    BCS VAL_GT ; >=, goto.
    LDA #$1B ; Seed min.
VAL_GT: ; 0D:04C1, 0x01A4C1
    CMP #$E5 ; If _ #$E5
    BCC RANGED ; <, goto.
    LDA #$E5 ; Seed highest.
RANGED: ; 0D:04C7, 0x01A4C7
    STA OBJ_POS_X?[18],X ; Store val.
    CLC ; Prep add.
    LDA TMP_09 ; Load
    ADC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Add with.
    STA OBJ_POS_X??[18],X ; Store to.
    JSR MOVE_Y_FINALIZE ; Do.
    JSR SUB_RANGED_UNK ; Do.
    JSR SUB_RANGED/RANDOM_THINGIES ; Do.
    JMP GFX/DISP_STUFF ; Goto.
SUB_RANGED_UNK: ; 0D:04DF, 0x01A4DF
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load.
    LSR A ; >> 1, /2.
    BCS BIT_SET ; Set, goto.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$78 ; If _ #$78
    BCC LT_0x78 ; <, goto.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Reset.
LT_0x78: ; 0D:04F4, 0x01A4F4
    JMP RTS ; Goto. What odd code, rofl. Just RTS. Mistakeish, meh.
BIT_SET: ; 0D:04F7, 0x01A4F7
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$78 ; If _ #$78
    BCC RTS ; <, goto.
    LDA #$77 ; Seed highest.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store to.
RTS: ; 0D:0506, 0x01A506
    RTS ; Leave.
SUB_RANGED/RANDOM_THINGIES: ; 0D:0507, 0x01A507
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ VAL_0x00 ; == 0, goto.
    CMP #$3C ; If _ #$3C
    BEQ SUBTRACT_PATH ; ==, goto.
    RTS ; Leave.
VAL_0x00: ; 0D:0511, 0x01A511
    DEC OBJ_TERTIARY_SWITCH?+1,X ; Pair--
    BPL ADD_PATH
    LDA #$06
    STA OBJ_TERTIARY_SWITCH?+1,X ; Move tert.
    JSR FOCUS_FIND_SEED_0x80 ; Do.
ADD_PATH: ; 0D:051E, 0x01A51E
    LDA OBJ_POS_X?[18],X ; Load
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    CMP OBJ_POS_X?[18],Y ; If Xobj _ Yobj
    BCS RTS ; >=, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    BCC ADD_CONTINUE ; Shifted 0b0, not set.
    JSR COUNTER_RANDOMNESS_BAD ; Do.
    LSR A ; >> 1, /2.
    BCS RTS ; Shifted 0x01, leave. 50% chance to not do still.
ADD_CONTINUE: ; 0D:0535, 0x01A535
    CLC ; Prep add.
    LDA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Load pair.
    ADC #$32 ; Add with.
    BCS RTS ; Overflow, leave.
    CMP #$1B ; If _ #$1B
    BCC RTS ; <, leave.
    CMP #$E5 ; If _ #$E5
    BCS RTS ; >=, goto.
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Store pair.
    SEC ; Prep sub.
    LDA #$3C ; Load
    SBC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Sub with.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store to.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    EOR #$01 ; Invert bit.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store back.
RTS: ; 0D:0559, 0x01A559
    RTS ; Leave.
SUBTRACT_PATH: ; 0D:055A, 0x01A55A
    LDA OBJ_POS_X?[18],X ; Load
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Get focus index.
    CMP OBJ_POS_X?[18],Y ; If Xobj _ Yobj
    BCC RTS ; <, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    BCC SUBTRACT_CONTINUE
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    LSR A ; >> 1, /2.
    BCS RTS ; Shifted 0x1, leave. 50% chance again.
SUBTRACT_CONTINUE: ; 0D:0571, 0x01A571
    SEC ; Prep sub.
    LDA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Load
    SBC #$32 ; Suubtract.
    BCC RTS ; Underflow, goto.
    CMP #$1B ; If _ #$1B
    BCC RTS ; <, goto.
    CMP #$E5 ; If _ #$E5
    BCS RTS ; >=, goto.
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Store to pair.
    SEC ; Prep sub.
    LDA #$3C ; Load
    SBC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Subtract.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store to.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    EOR #$01 ; Invert bit.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store back.
RTS: ; 0D:0595, 0x01A595
    RTS ; Leave.
PAIR_ATTR_SET+MAIN_CLEARS+TERT: ; 0D:0596, 0x01A596
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
PAIR_ATTR_SET+MAIN_CLEARS: ; 0D:059B, 0x01A59B
    LDA #$10
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Set pair attr.
    LDA #$01
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Set pair attr.
    LDA #$00
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Clear attr.
    LDA #$00
    STA 4D8_OBJ_UNK[18],X ; Clear more attrs. More crappy code/mistakes with LD 0's.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
RTS: ; 0D:05B2, 0x01A5B2
    RTS ; Leave.
RTN_B: ; 0D:05B3, 0x01A5B3
    JSR GFX/DISP_STUFF ; Do.
    JSR RTN_IDK_RET_CC_CONTINUE? ; Do.
    BCC RET_CC ; CC, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; --
    BMI PAIR_NEG_A ; If negative, goto.
RET_CC: ; 0D:05C0, 0x01A5C0
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; lOAD
    BMI PAIR_NEG_B ; If negative, goto.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI RTS ; If negative, leave.
    CMP #$01 ; If _ #$01
    BCC RTS ; <, leave.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    BEQ RTS ; == 0, leave.
    JMP REENTER ; Goto.
PAIR_NEG_B: ; 0D:05D6, 0x01A5D6
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BPL RTS ; If positive, leave.
    CMP #$FF ; If _ #$FF
    BCS RTS ; >=, ==, goto.
REENTER: ; 0D:05DF, 0x01A5DF
    LDA #$01 ; Load
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Load
    BPL VAL_POSITIVE ; Store if positive.
    LDA #$FF ; Negative otherwise.
VAL_POSITIVE: ; 0D:05E8, 0x01A5E8
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store. attr.
    LDA #$00
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Clear attr.
    SEC ; Prep sub.
    SBC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Invert since zero seeded.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Store back.
    JSR RTN_IDK_RET_CC_CONTINUE? ; Do.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
PAIR_NEG_A: ; 0D:05FD, 0x01A5FD
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$D8
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
RTN_IDK_RET_CC_CONTINUE?: ; 0D:060A, 0x01A60A
    LDA #$00
    STA TMP_07 ; Clear.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Load pair.
    BPL PAIR_POSITIVE
    DEC TMP_07 ; -- if negative.
PAIR_POSITIVE: ; 0D:0615, 0x01A615
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add with.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    STA TMP_00 ; Store to.
    ADC TMP_07 ; Mod with, -= 1/0.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store to.
    CLC ; Prep add.
    EOR TMP_00 ; Invert with.
    BPL SAVE_STATUS_CC ; If positive, goto.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Load pair.
    BMI SAVE_STATUS_CC ; If negative, goto.
    SEC ; Set carry if invert negative and pair positive.
SAVE_STATUS_CC: ; 0D:0631, 0x01A631
    PHP ; Save status.
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4D8_OBJ_UNK[18],X ; Add with.
    STA 4D8_OBJ_UNK[18],X ; Store.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4C6_OBJ_UNK[18],X ; Add carry.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    JSR MOVE_Y_FINALIZE ; Do.
    PLP ; Pull status from above.
    RTS ; Leave.
    LDA OBJ_POS_X?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    CMP TMP_14
    ROL A
    AND #$01
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA TMP_00
    LDY 503_OBJ_POS_X_LARGEST?[18],X
    BMI 0D:0661
    EOR #$01
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDY TMP_00
    LDA 0D:06AB,Y
    CLC
    ADC OBJ_POS_X?[18],X
    PHA
    ROR A
    EOR 0D:06AB,Y
    ASL A
    PLA
    BCC 0D:068C
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    EOR #$01
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA TMP_00
    EOR #$01
    STA TMP_00
    TAY
    LDA 0D:06AB,Y
    CLC
    ADC OBJ_POS_X?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    LDA OBJ_POS_X??[18],X
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X
    ASL TMP_00
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    AND #$01
    ORA TMP_00
    TAY
    LDA 0D:06AD,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS
    ORA PPU_DATA,Y
    ???
    ORA [77_UNK,X]
SET_ATTR_UNK_A: ; 0D:06B1, 0x01A6B1
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Load
    ADC OBJ_POS_X_SUBPIXEL?[18],X ; Add with.
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store to.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ADC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Add with pair.
    CMP #$1B ; If _ #$1B
    BCC RTS ; <, goto.
    CMP #$E5 ; If _ #$E5
    BCS RTS ; >=, goto.
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Store otherwise. 0x1B - 0xE4.
RTS: ; 0D:06CC, 0x01A6CC
    RTS ; Leave.
SET_ATTR_UNK_B: ; 0D:06CD, 0x01A6CD
    CLC ; Prep add.
    LDA 520_OBJ_POS_X_LARGE?[18],X ; Load
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store to.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ADC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Add with pair.
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Store to pair.
    CMP #$9C ; If _ #$9C
    BCS ALT_PATH ; >=, goto.
    LDA #$9C
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Set attr A.
    BNE RTS ; Always taken.
ALT_PATH: ; 0D:06EB, 0x01A6EB
    CMP #$D3 ; If _ #$D3
    BCC RTS ; <, leave.
    LDA #$D2
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Set attr B.
RTS: ; 0D:06F4, 0x01A6F4
    RTS
RTN_UNK: ; 0D:06F5, 0x01A6F5
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    ASL A
    TAY
    LDA 0D:072C,Y
    STA TMP_04
    LDA 0D:072D,Y
    STA TMP_05
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X?[18],Y
    STA TMP_14
    CLC
    ADC TMP_04
    PHA
    ROR A
    EOR TMP_04
    ASL A
    PLA
    BCS 0D:0719
    STA TMP_14
    LDA OBJ_POS_X??[18],Y
    STA TMP_15
    CLC
    ADC TMP_05
    PHA
    ROR A
    EOR TMP_05
    ASL A
    PLA
    BCS 0D:072B
    STA TMP_15
    RTS
    BRK
    BRK
    BNE 0D:0760
    BMI 0D:0702
    BMI 0D:0764
DIFFS_TO_ATTRS_UNK: ; 0D:0734, 0x01A734
    LDA OBJ_POS_X?[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_14 ; Sub with.
    BPL SKIP_INVERT ; If positive, goto.
    EOR #$FF ; Invert.
    CLC ; Prep add.
    ADC #$01 ; Add compliment.
SKIP_INVERT: ; 0D:0741, 0x01A741
    STA TMP_10 ; Store diff to.
    CMP #$10 ; If _ #$10
    LDA #$00 ; Val A.
    BCC VAL_LT ; <, goto.
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_14 ; If _ TMP_14
    LDA #$02 ; Val B.
    BCS VAL_LT ; >=, goto.
    LDA #$04 ; Val C.
VAL_LT: ; 0D:0754, 0x01A754
    STA TMP_00 ; Store val.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 3, *8.
    ASL A
    ASL A
    ORA TMP_00 ; Or with val.
    TAY ; To Y index.
    LDA ATTR_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set.
    LDA ATTR_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X ; Set.
    LDA OBJ_POS_X??[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_15 ; Sub with.
    BPL SKIP_INVERT ; If positive, goto.
    EOR #$FF ; Invert.
    CLC
    ADC #$01
SKIP_INVERT: ; 0D:0778, 0x01A778
    STA TMP_11 ; Store diff.
    CMP #$08 ; If _ #$08
    LDA #$00 ; Val A.
    BCC LT_0x08 ; <, goto.
    LDA OBJ_POS_X??[18],X ; Load
    CMP TMP_15 ; If _ TMP_15
    LDA #$02 ; Val B.
    BCS LT_0x08 ; >=, goto.
    LDA #$04 ; Val C.
LT_0x08: ; 0D:078B, 0x01A78B
    STA TMP_00 ; Store val.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load.
    ASL A ; << 3, *8.
    ASL A
    ASL A
    ORA TMP_00 ; Set other bits from val.
    TAY ; To index.
    LDA ATTR_DATA_C,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set attrs.
    LDA ATTR_DATA_D,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
ATTR_DATA_A: ; 0D:07A3, 0x01A7A3
    .db 00
ATTR_DATA_B: ; 0D:07A4, 0x01A7A4
    .db 00
    .db C0
    .db FF
    .db 40
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 80
    .db FF
    .db 80
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
ATTR_DATA_C: ; 0D:07C3, 0x01A7C3
    .db 00
ATTR_DATA_D: ; 0D:07C4, 0x01A7C4
    .db 00
    .db E0
    .db FF
    .db 20
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db C0
    .db FF
    .db 40
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db A0
    .db FF
    .db 60
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 80
    .db FF
    .db 80
    .db 00
    .db 00
    .db 00
RTN_UNK: ; 0D:07E3, 0x01A7E3
    STA TMP_00 ; Store to.
    LDY #$00 ; = 0
    STY TMP_01 ; Cler.
    CMP #$3D ; If A _ #$3D
    BCC LT_0x3D ; <, goto.
    LDA #$78 ; Load
    SBC TMP_00 ; -=
    STA TMP_00 ; Store result.
    LDY #$02
    STY TMP_01 ; Set val.
LT_0x3D: ; 0D:07F7, 0x01A7F7
    CMP #$1F ; If _ #$1F
    BCC LT_0x1F ; <, goto.
    LDA #$3C ; Load
    SBC TMP_00 ; -=
    STA TMP_00 ; Store result.
    LDA TMP_01 ; Load
    ORA #$01 ; Set bit.
    STA TMP_01 ; Store back.
LT_0x1F: ; 0D:0807, 0x01A807
    LDA TMP_00 ; Load bits.
    ASL A ; << 1, *2.
    TAY ; To index.
    LDA TMP_DATA_A,Y ; Seed TMP from index.
    STA TMP_08
    LDA TMP_DATA_B,Y
    STA TMP_09
    LSR TMP_01 ; >> 1, /2. Bit test.
    BCC BIT_UNSET_0x01 ; If not set, goto.
    LDA #$00 ; Seed invert.
    SBC TMP_08 ; Invert.
    STA TMP_08 ; Store back.
BIT_UNSET_0x01: ; 0D:081F, 0x01A81F
    LSR TMP_01
    BCC BIT_UNSET_0x02 ; Leave.
    LDA #$00 ; Seed invert.
    SBC TMP_09 ; Invert.
    STA TMP_09 ; Store back.
BIT_UNSET_0x02: ; 0D:0829, 0x01A829
    RTS ; Leave.
TMP_DATA_A: ; 0D:082A, 0x01A82A
    .db 19
TMP_DATA_B: ; 0D:082B, 0x01A82B
    .db 00
    .db 19
    .db 01
    .db 19
    .db 03
    .db 19
    .db 04
    .db 19
    .db 05
    .db 18
    .db 07
    .db 18
    .db 08
    .db 17
    .db 0A
    .db 17
    .db 0B
    .db 16
    .db 0D
    .db 16
    .db 0E
    .db 15
    .db 0F
    .db 14
    .db 10
    .db 13
    .db 12
    .db 13
    .db 13
    .db 12
    .db 14
    .db 11
    .db 15
    .db 10
    .db 16
    .db 0F
    .db 17
    .db 0D
    .db 18
    .db 0C
    .db 18
    .db 0B
    .db 19
    .db 0A
    .db 1A
    .db 09
    .db 1A
    .db 07
    .db 1B
    .db 06
    .db 1B
    .db 05
    .db 1C
    .db 04
    .db 1C
    .db 02
    .db 1C
    .db 01
    .db 1C
    .db 00
    .db 1C
OBJ_STATE_0x5E_HANDLER: ; 0D:0868, 0x01A868
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BEQ VAL_ZERO_A
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
VAL_ZERO_A: ; 0D:0870, 0x01A870
    LDA 4D8_OBJ_UNK[18],X ; Load
    BEQ VAL_ZERO_B ; == 0, goto.
    DEC 4D8_OBJ_UNK[18],X ; --
VAL_ZERO_B: ; 0D:0878, 0x01A878
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Y from
    LDA OBJ_DATA_A,Y ; Load
    BEQ DATA_ZERO ; If zero, goto.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load attr.
    BEQ DATA_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
DATA_ZERO: ; 0D:0888, 0x01A888
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR RTN_MULTISWITCH ; Switch rtn.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ EXIT ; If zero, leave.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    CMP #$02 ; If _ #$02
    BCC EXIT ; <, leave.
    CMP #$04 ; If _ #$04
    BEQ EXIT ; ==, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ VAL_ZERO_D ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
VAL_ZERO_D: ; 0D:08AE, 0x01A8AE
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do rtn.
    STA TMP_00 ; Store result.
    PLA ; Pull health.
    LDY 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load index from obj.
    BEQ ATTR_ZERO ; == 0, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store pulled health if nonzero.
ATTR_ZERO: ; 0D:08BC, 0x01A8BC
    LSR TMP_00 ; >> 1
    BCC EXIT ; Shifted off 0x0, leave.
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP FOCUS_CHANGE ; Do.
EXIT: ; 0D:08C8, 0x01A8C8
    JMP MISC_OBJ_END ; Goto.
OBJ_DATA_A: ; 0D:08CB, 0x01A8CB
    .db 00
    .db 00
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
RTN_MULTISWITCH: ; 0D:08D2, 0x01A8D2
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ASL A
    TAY
    LDA 0D:08F2,Y
    STA TMP_00
    LDA 0D:08F3,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X
    ASL A
    TAY
    LDA [TMP_00],Y
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02]
    LOW(FILE_A)
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
    LOW(FILE_F)
    HIGH(FILE_F)
FILE_A: ; 0D:08FE, 0x01A8FE
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_B: ; 0D:0900, 0x01A900
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_C: ; 0D:0902, 0x01A902
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
    LOW(RTN_E)
    HIGH(RTN_E)
FILE_D: ; 0D:090C, 0x01A90C
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_E: ; 0D:0910, 0x01A910
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_F: ; 0D:0912, 0x01A912
    LOW(RTN_A) ; From other place.
    HIGH(RTN_A)
    LOW(RTN_B) ; From other place.
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
RTN_A: ; 0D:091A, 0x01A91A
    LDY #$13 ; Palette.
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Do.
    LDA #$00
    STA 707_SWITCHED_ON?? ; Set.
    LDA #$03
    STA 70D_UNK ; Set.
    JSR GFX/ANIM_HELPER ; Do.
    LDA #$9C
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    CLC ; Prep add.
    ADC OBJ_POS_X??[18],X ; Add val.
    STA OBJ_POS_Y??[18],X ; Store attr.
    LDA #$BE
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA 4D8_OBJ_UNK[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$09
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    LDA #$00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Clear attrs. More #$00 sloppiness/mistakes.
    STA ARR_SPRITE_OBJ_TIMER?+1
    STA 704_OBJ_USE_UNK
    LDA #$60
    JSR SND_BANKED_DISPATCH ; Play sound.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
RTN_A: ; 0D:0961, 0x01A961
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR MOVE_UNK_RET_??_SEEDED_VAL ; Do.
    PHP ; Save status returned.
    CLC ; Prep add.
    LDA 4C6_OBJ_UNK[18],X ; Load val.
    ADC OBJ_POS_X??[18],X ; Add attr.
    STA OBJ_POS_Y??[18],X ; Store to.
    PLP ; Pull returned status.
    BCC RTS ; Was CC, leave.
    LDA #$31
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$00
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Clear pair attrs.
    STA OBJ_ANIMATION_DISPLAY+1,X
    STA 4C6_OBJ_UNK[18],X ; Clear other attrs.
    STA 4D8_OBJ_UNK[18],X
    LDA OBJ_POS_X??[18],X ; Move to other attr.
    STA OBJ_POS_Y??[18],X
SWITCH/HOLD_EXTENDED_HELPER: ; 0D:0990, 0x01A990
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$46
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JMP GFX/ANIM_HELPER ; Goto.
RTN_A: ; 0D:09A2, 0x01A9A2
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$72
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
RTS: ; 0D:09AF, 0x01A9AF
    RTS ; Leave.
SWITCH/HOLD/GFX_HELPER: ; 0D:09B0, 0x01A9B0
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    JMP GFX/ANIM_HELPER ; Goto.
RTN_B: ; 0D:09C2, 0x01A9C2
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$7F ; If _ #$7F
    BCS HOLD_EXCEEDED ; >=, goto.
    AND #$1F ; Keep 0001.1111
    BNE RTS ; Every 32 frames, do.
    LDA #$10 ; Load val.
    EOR OBJ_ANIMATION_DISPLAY[18],X ; Invert bit from val.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
RTS: ; 0D:09D8, 0x01A9D8
    RTS ; Leave.
HOLD_EXCEEDED: ; 0D:09D9, 0x01A9D9
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP FOCUS_CLOSEST_PLAYER ; Goto.
RTN_C: ; 0D:09E7, 0x01A9E7
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    JSR TMP_SEED_RTN_FROM_FOCUS_OBJ ; Do.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    STA TMP_00 ; Store to.
    ORA OBJ_POS_X_DELTA?[18],X ; Or with.
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Or with.
    BEQ ALL_VALUES_SETTLED_TO_0x00 ; All zero, goto.
    LDA TMP_10 ; Load
    CMP #$30 ; If _ #$30
    BCS VAL_GT_0x30 ; >=, goto.
    SEC ; Prep sub.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Yobj from.
    LDA OBJ_POS_X??[18],Y ; Load from Yobj.
    SBC OBJ_POS_X??[18],X ; Sub from Xobj.
    BPL RESULT_POSITIVE ; Positive, goto. TODO: Shouldn't branch on carry?
    EOR #$FF ; Invert result.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 0D:0A14, 0x01AA14
    CMP #$11 ; If _ #$11
    BCC ALL_VALUES_SETTLED_TO_0x00 ; <, goto.
VAL_GT_0x30: ; 0D:0A18, 0x01AA18
    LDA TMP_00 ; Load
    BEQ VAL_ZERO ; == 0, goto.
RTN_D: ; 0D:0A1C, 0x01AA1C
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    BNE VAL_NONZERO
    JSR COUNTER_RANDOMNESS_BAD ; Do random.
    AND #$03 ; Keep bits.
    BNE VAL_NONZERO ; != 0, goto.
    JMP SWITCH/HOLD_EXTENDED_HELPER ; 1 in 4 chance to do.
VAL_NONZERO: ; 0D:0A2A, 0x01AA2A
    JSR RTN_UNK_A ; Do.
    JMP ANIM/GFX_HELPER ; Goto.
ALL_VALUES_SETTLED_TO_0x00: ; 0D:0A30, 0x01AA30
    LDA 4D8_OBJ_UNK[18],X ; Load.
    BNE RTN_D ; != 0, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$62 ; If _ #$62
    BNE RTN_D ; !=, goto.
    JMP STATE/ATTRS_HELPER ; Goto otherwise.
VAL_ZERO: ; 0D:0A3F, 0x01AA3F
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BNE RTN_D ; != 0, goto.
    LDA TMP_10 ; Load
    CMP #$64 ; If _ #$64
    BCS RTN_D ; >=, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$62 ; If _ #$62
    BNE RTN_D ; !=, goto.
    LDA #$45
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP SWITCHES/HOLD/GFX/ANIM_HELPER ; Goto.
RTN_E: ; 0D:0A59, 0x01AA59
    RTS ; Leave. Nothing here, lol.
STATE/ATTRS_HELPER: ; 0D:0A5A, 0x01AA5A
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00 ; These LDA #$00's are getting ridiculous, lol. Mistakes.
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    RTS
RTN_A: ; 0D:0A6F, 0x01AA6F
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear.
    LDA #$02
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set to, lol. Mistake.
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$28 ; If _ #$28
    BCS HOLD_EXCEEDED ; >=, goto.
    LDY #$00 ; Index.
    CMP #$07 ; If _ #$07
    BCC INDEX_DECIDED ; <, goto.
    INY ; Index++
    CMP #$0B ; If _ #$0B
    BCS VAL_OVER_0x0B ; >=, goto.
    LDA #$02
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDA #$94
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JMP INDEX_DECIDED ; Goto. Could have used BNE, mistake.
VAL_OVER_0x0B: ; 0D:0AA0, 0x01AAA0
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
INDEX_DECIDED: ; 0D:0AA5, 0x01AAA5
    TYA ; To A.
    ASL A ; << 2, *4.
    ASL A
    TAY ; Back to index.
    LDA OBJ_DATA_A,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attrs from index.
    LDA OBJ_DATA_B,Y
    STA ZP_R2-R5_BANK_VALUES+2
    LDA OBJ_DATA_C,Y
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
HOLD_EXCEEDED: ; 0D:0ABA, 0x01AABA
    LDA #$50
    STA 4D8_OBJ_UNK[18],X ; Set attr.
    LDA #$30
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attrs.
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$1F ; Keep bits 0001.1111
    BNE VAL_NONZERO ; != 0, goto.
    JMP SWITCH/HOLD/GFX_HELPER ; Goto. 1 in 32 frames.
VAL_NONZERO: ; 0D:0ADA, 0x01AADA
    DEC OBJ_SECONDARY_SWITCH?[18],X ; --
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    JMP SET_GFX/ANIM_HELPER ; Goto.
OBJ_DATA_A: ; 0D:0AE5, 0x01AAE5
    .db 66
    .db 00 ; Unused.
OBJ_DATA_B: ; 0D:0AE7, 0x01AAE7
    .db A8
OBJ_DATA_C: ; 0D:0AE8, 0x01AAE8
    .db A9
    .db 67
    .db 00 ; Unused.
    .db A9
    .db AA
SWITCHES/HOLD/GFX/ANIM_HELPER: ; 0D:0AED, 0x01AAED
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold
    LDA #$A8
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$A9
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$65
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS
RTN_B: ; 0D:0B0A, 0x01AB0A
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$14 ; If _ #$14
    BCS VAL_GT_0x14 ; >=, goto.
    AND #$03 ; Keep bits.
    BNE RTS ; 3 in 4 to take.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; 1 in 4 to run. LOad
    LSR A ; >> 2, /4.
    LSR A
    AND #$01 ; Keep bit.
    STA TMP_07 ; Store to.
    JMP OBJ_SPAWN_RTN ; Goto.
RTS: ; 0D:0B24, 0x01AB24
    RTS ; Leave.
VAL_GT_0x14: ; 0D:0B25, 0x01AB25
    LDA #$64
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$30
    STA 4D8_OBJ_UNK[18],X ; Set attr.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$0F ; Keep 0000.1111
    BNE LIKELY_RTN ; 15 in 16 to take.
    JMP SWITCH/HOLD/GFX_HELPER ; 1 in 16 to run.
LIKELY_RTN: ; 0D:0B38, 0x01AB38
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    JMP SET_GFX/ANIM_HELPER ; Goto, abuse RTS.
OBJ_STATE_0x5F_HANDLER: ; 0D:0B43, 0x01AB43
    JSR XPOS_RTN_RET_?? ; Do.
    BCS DIE ; CS, init self.
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$18 ; If _ #$18
    BCS DIE ; >=, goto.
    LDY #$00 ; Index.
    CMP #$02 ; If _ #$02
    BCC INDEX_FOUND ; <, goto.
    INY ; Index++
    CMP #$05 ; If _ #$05
    BCC INDEX_FOUND ; <, goto.
    INY ; Index++
    CMP #$08 ; If _ #$08
    BCC INDEX_FOUND ; <, goto.
    INY ; Index++
    CMP #$0E ; If _ #$0E
    BCC INDEX_FOUND ; <, goto.
    INY ; Index++
    CMP #$14 ; If _ #$14
    BCC INDEX_FOUND ; <, goto.
    INY ; Index++
INDEX_FOUND: ; 0D:0B6D, 0x01AB6D
    LDA OBJ_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim from.
    TYA ; Index to A.
    LSR A ; >> 1, /2.
    BCC IS_EVEN ; Shifted 0x0, goto.
    LDA #$95
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr on odd.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr on odd.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
IS_EVEN: ; 0D:0B84, 0x01AB84
    RTS ; Leave.
DIE: ; 0D:0B85, 0x01AB85
    JMP INIT_OBJECT[X]_DATA_FULL ; Init self, destroy.
OBJ_DATA: ; 0D:0B88, 0x01AB88
    .db 6D ; Anim data.
    .db 6E
    .db 6F
    .db 70
    .db 71
    .db E8
OBJ_SPAWN_RTN: ; 0D:0B8E, 0x01AB8E
    STX TMP_00 ; Save Xobj. Mistake: Not to scratchpad. Bad!
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Get obj.
    BCC EXIT_X_RESTORE ; CC, failed, goto.
    LDA TMP_07
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set new obj attrs.
    LDA #$5F
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set state.
    LDY TMP_00 ; Handled obj.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load from handled.
    LDY #$00 ; Val?
    AND #$40 ; Keep direction?
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to new.
    BEQ DIR_BIT_0x0
    LDY #$02 ; Alt index for other direction.
DIR_BIT_0x0: ; 0D:0BAF, 0x01ABAF
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attrs from index.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X ; Set attr.
    LDA OBJ_DATA_C,Y ; Load
    LDY TMP_00 ; Load handled obj.
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],Y ; Add with handled.
    STA OBJ_POS_X?[18],X ; Store to new.
    LDA OBJ_POS_X??[18],Y ; Load handled.
    STA OBJ_POS_X??[18],X ; Store to new.
    LDA #$D9
    STA 4C6_OBJ_UNK[18],X ; Set new attr.
    CLC ; Prep add.
    ADC OBJ_POS_X??[18],X ; Add with other.
    STA OBJ_POS_Y??[18],X ; Store to new.Store to.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attrs in new.
    STA OBJ_ANIMATION_DISPLAY[18],X
EXIT_X_RESTORE: ; 0D:0BE1, 0x01ABE1
    LDX TMP_00 ; Restore handled.
    RTS ; Leave.
    LDA OBJ_ANIMATION_DISPLAY[18],X
    BNE L_0D:0BEC
    STA OBJECT_DATA_EXTRA_B?[18],X
L_0D:0BEC: ; 0D:0BEC, 0x01ABEC
    RTS
OBJ_DATA_C: ; 0D:0BED, 0x01ABED
    .db DC
    .db 00
    .db 24
    .db 00
OBJ_DATA_A: ; 0D:0BF1, 0x01ABF1
    .db 00
OBJ_DATA_B: ; 0D:0BF2, 0x01ABF2
    .db FC
    .db 00
    .db 04
ANIM/GFX_HELPER: ; 0D:0BF5, 0x01ABF5
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BPL POSITIVE
    LDA #$0C
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
POSITIVE: ; 0D:0C02, 0x01AC02
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    AND #$03 ; Range.
    TAY ; To Y index.
    LDA ANIM_DATA,Y ; Load value.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$A8
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$A9
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
ANIM_DATA: ; 0D:0C17, 0x01AC17
    .db 62
    .db 63
    .db 64
    .db 63
SET_GFX/ANIM_HELPER: ; 0D:0C1B, 0x01AC1B
    LDA #$A8
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$A9
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$62
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS
FOCUS_CHANGE: ; 0D:0C29, 0x01AC29
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ 1P_GAME ; 1P, goto.
    JSR RANDOMNESS ; Do.
    AND #$01 ; Test bit.
    BEQ BIT_UNSET ; Unset, goto.
1P_GAME: ; 0D:0C34, 0x01AC34
    JSR XOBJ_WRITE_PLAYER_FOCUS ; Focus.
BIT_UNSET: ; 0D:0C37, 0x01AC37
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    JMP DEATH_HELPER ; No health, goto.
VAL_NE_ZERO: ; 0D:0C3F, 0x01AC3F
    CMP #$18 ; If _ #$18
    BCS DO_UNK ; >=, goto.
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    BMI DO_UNK ; If negative, goto.
    ORA #$80 ; Set negative.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store back.
    BNE SKIP_RTN ; Always taken.
DO_UNK: ; 0D:0C4F, 0x01AC4F
    JSR ATTRS_SET_UNSURE ; Do.
SKIP_RTN: ; 0D:0C52, 0x01AC52
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA 707_SWITCHED_ON?? ; Load
    CMP #$03 ; If _ #$03
    BEQ RTS ; ==, leave.
    CMP #$02 ; If _ #$02
    BEQ RTS ; ==, leave.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$12
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    DEC 70D_UNK ; --
    BPL RTS ; If positive, leave.
    LDA RANDOM_VALS?[2] ; Load rand.
    AND #$03 ; Keep bits.
    ORA #$01 ; Set at least 0x01.
    STA 70D_UNK ; Store to.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attrs.
    STA 4D8_OBJ_UNK[18],X ; Clear.
RTS: ; 0D:0C87, 0x01AC87
    RTS ; Leave.
RTN_A: ; 0D:0C88, 0x01AC88
    LDA #$0A
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDA #$68
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    LDA #$A8
    STA ZP_R2-R5_BANK_VALUES+2 ; Setr GFX.
    LDA #$AB
    STA ZP_R2-R5_BANK_VALUES+3
    JMP 707_SWITCH_RTN ; Goto.
ATTR_HELPER+707_SWITCH: ; 0D:0C9D, 0x01AC9D
    LDA #$0A
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDA #$7C
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$AC
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$AF
    STA ZP_R2-R5_BANK_VALUES+3
707_SWITCH_RTN: ; 0D:0CAF, 0x01ACAF
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold again.
    LDA 707_SWITCHED_ON?? ; Load val.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch with.
    LOW(SET_SWITCHES_HELPER_707_A) ; A and B set the same switch values. C differs.
    HIGH(SET_SWITCHES_HELPER_707_A)
    LOW(SET_SWITCHES_HELPER_707_A)
    HIGH(SET_SWITCHES_HELPER_707_A)
    LOW(SET_SWITCHES_HELPER)
    HIGH(SET_SWITCHES_HELPER)
    LOW(SET_SWITCHES_HELPER_707_C_OTHER)
    HIGH(SET_SWITCHES_HELPER_707_C_OTHER)
    LOW(SET_SWITCHES_HELPER_707_A)
    HIGH(SET_SWITCHES_HELPER_707_A)
    LOW(SET_SWITCHES_HELPER_707_A)
    HIGH(SET_SWITCHES_HELPER_707_A)
    LOW(SET_SWITCHES_HELPER_707_A)
    HIGH(SET_SWITCHES_HELPER_707_A)
DEATH_HELPER: ; 0D:0CCD, 0x01ACCD
    LDA #$01
    STA 3DB_UNKNOWN ; Set.
    JSR SOUND_RESET/INIT_RTN? ; Stop.
    LDA 707_SWITCHED_ON?? ; Load
    CMP #$03 ; If _ #$03
    BEQ SKIP_SOUND ; ==, goto.
    LDA #$7E
    JSR SND_BANKED_DISPATCH ; Play sound.
SKIP_SOUND: ; 0D:0CE1, 0x01ACE1
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move attrs.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$04
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Set attr.
    LDA #$96
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear.
GFX_MOD_UNK: ; 0D:0D0A, 0x01AD0A
    LDA 707_SWITCHED_ON?? ; Load
    ASL A ; << 3, *8.
    ASL A
    ASL A
    LDY OBJECT_DATA_HEALTH?[18],X ; Load P1 attr.
    BNE P1_HAS_HEALTH
    ORA #$04 ; Set if P1 doesn't have health.
P1_HAS_HEALTH: ; 0D:0D17, 0x01AD17
    TAY ; To Y index.
    LDA DATA_UNK_A,Y ; Load data from index.
    JSR INIT_OBJS_PLAYER_ATTRS_UNK ; Do.
    LDA GFX_ANIM_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim disp.
    LDA GFX_DATA_A,Y
    STA ZP_R2-R5_BANK_VALUES+2 ; Set gfx.
    LDA GFX_DATA_B,Y
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
INIT_OBJS_PLAYER_ATTRS_UNK: ; 0D:0D2F, 0x01AD2F
    STA TMP_00 ; Val to TMP.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save obj to scratch.
    LDX #$07 ; Obj val.
LOOP: ; 0D:0D36, 0x01AD36
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load obj state.
    BEQ NEXT_ITER ; Not enabled, next.
    CMP TMP_00 ; If _ #$00
    BEQ NEXT_ITER ; State/enabled same, skip.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj.
NEXT_ITER: ; 0D:0D42, 0x01AD42
    INX ; Next obj.
    CPX #$12 ; If _ Obj #$18
    BCC LOOP ; <, goto.
    LDX #$00 ; Obj.
LOOP_PLAYERS: ; 0D:0D49, 0x01AD49
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load from player.
    AND #$04 ; Test bit.
    BEQ INC_PLAYER_INDEX ; Not set, next player.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    CMP #$02 ; If _ #$02
    BNE INC_PLAYER_INDEX ; !=, next player.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load from player.
    AND #$FB ; Keep 1111.0011
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    TXA ; Player to A.
    LSR A ; Shift, turn to 0-1 index instead of 0x00/0x02.
    TAX ; Back to index.
    LDA #$00
    STA 85_PLAYER_UNK?[2],X ; Clear player custom attr.
    TXA ; Back to A.
    ASL A ; Turn it back.
    TAX ; Back to index.
INC_PLAYER_INDEX: ; 0D:0D69, 0x01AD69
    INX ; += 2, next player obj data index.
    INX
    CPX #$04 ; If _ #$04
    BCC LOOP_PLAYERS ; <, loop, do P2.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load original object.
    RTS
DATA_UNK_A: ; 0D:0D73, 0x01AD73
    .db 5E
GFX_ANIM_DATA: ; 0D:0D74, 0x01AD74
    .db 68
GFX_DATA_A: ; 0D:0D75, 0x01AD75
    .db A8
GFX_DATA_B: ; 0D:0D76, 0x01AD76
    .db AB
    .db 5E
    .db 68
    .db A8
    .db AB
    .db 62
    .db 7C
    .db AC
    .db AF
    .db 62
    .db 7C
    .db AC
    .db AF
    .db 67
    .db 8D
    .db B0
    .db B1
    .db 67
    .db 8E
    .db B0
    .db B3
    .db 55
    .db 05
    .db 2C
    .db 2D
    .db 55
    .db 05
    .db 2C
    .db 2D
RTN_A: ; 0D:0D93, 0x01AD93
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA 707_SWITCHED_ON?? ; Load
    CMP #$03 ; If _ #$03
    BEQ EXTENDED ; ==, goto.
    CMP #$01 ; If _ #$01
    BNE HOLD_EXTEND ; !=, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from Xobj.
    BNE HOLD_EXTEND ; != 0, goto.
    LDA #$61
    JSR BACKGROUND_UPDATING_INTERFACE ; Do rtn.
    LDA 87_CB_INDEX? ; Load from 0x87.
    BNE HOLD_EXTEND ; != 0, goto.
    LDA #$01
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
HOLD_EXTEND: ; 0D:0DB6, 0x01ADB6
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
EXTENDED: ; 0D:0DBB, 0x01ADBB
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear attrs.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JSR GFX_MOD_UNK ; Do.
    LDA #$5B
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
    .db 8A
    .db 48
    .db 98
    .db 48
    .db A2
    .db 00
    .db A0
    .db 07
    .db B9
    .db 24
    .db 04
    .db C9
    .db 61
    .db D0
    .db 01
    .db E8
    .db C8
    .db C0
    .db 12
    .db 90
    .db F3
    .db E0
    .db 05
    .db 68
    .db A8
    .db 68
    .db AA
    .db 60
RTN_B: ; 0D:0DEA, 0x01ADEA
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
    BPL RTS ; If positive, leave.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Get attr.
    LDA DATA_A,Y ; Load data.
    CMP #$80 ; If _ #$80
    BNE VAL_NE_0x80 ; !=, goto.
    JMP 0D:0E85 ; Goto.
VAL_NE_0x80: ; 0D:0E01, 0x01AE01
    LDA OBJ_POS_X?[18],X ; Load
    STA TMP_00 ; Store to.
    LDA OBJ_POS_X??[18],X ; Load
    STA TMP_01 ; Store to.
    LDY 707_SWITCHED_ON?? ; Y from.
    LDA #$00 ; Load A.
    CPY #$03 ; If Y _ #$03
    BNE NOT_0x03 ; !=, goto.
    LDA 4C6_OBJ_UNK[18],X ; A from here if is.
NOT_0x03: ; 0D:0E17, 0x01AE17
    STA TMP_02 ; A to.
    JSR 0D:0DCE ; Do rtn.
    BCS EXIT_RESTORE/CLEAR ; Ret CS, goto.
    JSR FIND_ANY_PAIR_UNUSED_RET_CS_PASS_CC_FAIL ; Do.
    BCS XOBJ_NEW_RECEIVED ; Ret CS, goto.
EXIT_RESTORE/CLEAR: ; 0D:0E23, 0x01AE23
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore Xobj.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear.
RTS: ; 0D:0E2B, 0x01AE2B
    RTS ; Leave.
XOBJ_NEW_RECEIVED: ; 0D:0E2C, 0x01AE2C
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Original obj in Y.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],Y ; Focus from original.
    TAY ; Focus obj to Y.
    CLC ; Prep add.
    LDA DATA_A,Y ; Load from focus.
    ADC TMP_00 ; Add with.
    STA OBJ_POS_X?[18],X ; Store to new.
    ROR A ; >> 1, /2 + 0x00/0x80.
    EOR DATA_A,Y ; Eor with.
    BMI VAL_NEGATIVE ; Negative, goto.
    CLC ; Prep add.
    LDA DATA_B,Y ; Load
    ADC TMP_02 ; Add with.
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    INC TMP_01 ; ++
    LDA TMP_01 ; Load
    STA OBJ_POS_X??[18],X ; Store to new.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK[18],X ; Add with.
    STA OBJ_POS_Y??[18],X ; Store to new.
    ROR A ; >> 1, /2 + 0x00/0x80
    EOR DATA_B,Y ; Invert bits.
    BMI VAL_NEGATIVE ; If neg, goto.
    LDA #$61
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set state.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
VAL_NEGATIVE: ; 0D:0E76, 0x01AE76
    INY ; Next original.
    INY
    TYA ; To A.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore original Xobj.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store
    LDA #$05
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    RTS ; Leave.
    DEC OBJ_POS_X_SUBPIXEL?[18],X
    LDA OBJ_POS_X_SUBPIXEL?[18],X
    CMP #$02
    BCS 0D:0EF8
    LDY 707_SWITCHED_ON??
    CPY #$03
    BNE 0D:0EA2
    CMP #$01
    BNE 0D:0EF8
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    JMP 0D:0EF8
    CPY #$02
    BEQ 0D:0EC8
    EOR #$01
    CLC
    ADC #$69
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$AA
    STA ZP_R2-R5_BANK_VALUES+2
    LDA #$AB
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    ORA #$02
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    JMP 0D:0EF8
    TAY
    BNE 0D:0EF8
    LDA #$E0
    CLC
    ADC OBJ_POS_X??[18],X
    STA OBJ_POS_Y??[18],X
    LDA #$95
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$B3
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$6C
    STA OBJ_ENABLED_STATE+MORE?+1,X
    LDA OBJ_POS_X?[18],X
    STA OBJ_POS_X?+1,X
    LDA OBJ_POS_X??[18],X
    STA OBJ_POS_Y??+1,X
    LDA #$00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?+1,X
    LDA #$04
    STA OBJ_ANIMATION_DISPLAY+1,X
    LDA OBJ_POS_X_SUBPIXEL?[18],X
    BEQ 0D:0F08
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JMP RTN_B
    INC OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA 707_SWITCHED_ON??
    CMP #$03
    BEQ 0D:0F40
    CMP #$02
    BNE 0D:0F3F
    LDA #$FD
    STA OBJ_POS_X??[18],X
    LDA #$00
    STA 4B4_OBJ_SPEED?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA #$28
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA #$07
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$51
    JSR SND_BANKED_DISPATCH
    RTS
    LDA #$20
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
DATA_A: ; 0D:0F46, 0x01AF46
    .db 18
DATA_B: ; 0D:0F47, 0x01AF47
    .db E8
    .db 10
    .db E0
    .db 10
    .db C6
    .db FC
    .db BD
    .db F0
    .db D8
    .db 08
    .db F0
    .db 10
    .db C8
    .db E8
    .db E8
    .db 04
    .db C0
    .db F8
    .db F0
    .db 80
    .db 80
RTN_C: ; 0D:0F5C, 0x01AF5C
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load
    BEQ VAL_EQ_ZERO ; ==, goto.
    JMP ALT_RTN ; Goto otherwise.
VAL_EQ_ZERO: ; 0D:0F64, 0x01AF64
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    BMI VAL_NEGATIVE ; If negative, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; -- otherwise.
    BPL VAL_NEGATIVE ; If positive, skip below.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load anim.
    EOR #$01 ; Mod.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
VAL_NEGATIVE: ; 0D:0F7B, 0x01AF7B
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BEQ VAL_ZERO ; == 0, goto.
    JMP EXIT_STEP ; Goto otherwise.
VAL_ZERO: ; 0D:0F83, 0x01AF83
    LDA #$00
    STA TMP_07 ; Clear.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BPL ATTR_POSITIVE ; If positive, don't dec.
    DEC TMP_07 ; -- if val negative.
ATTR_POSITIVE: ; 0D:0F8E, 0x01AF8E
    CLC ; Prep add.
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store to.
    LDA TMP_07 ; Load
    ADC OBJ_POS_X??[18],X ; Add with, carry.
    STA OBJ_POS_X??[18],X ; Store to.
    CLC ; Prep add.
    ADC OBJ_POS_Y??[18],X ; Add val.
    STA OBJ_POS_Y??[18],X ; Store to.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BNE ATTR_NE_ZERO ; != 0, goto.
    LDA OBJ_POS_X??[18],X ; Load
    BNE ATTR_NE_ZERO ; != 0, goto.
    INC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; ++
    LDA #$98
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$FE
    STA OBJ_POS_X??[18],X ; Set attr.
    LDA #$00
    STA 4B4_OBJ_SPEED?[18],X ; Clear attrs.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold it.
    LDA #$52
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
ATTR_NE_ZERO: ; 0D:0FCD, 0x01AFCD
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BMI VAL_NEG ; If negative, goto.
    LDA OBJ_POS_X??[18],X ; Load
    BMI EXIT ; If negative, goto.
    CMP #$03 ; If _ #$03
    BCC EXIT ; <, goto.
    DEC OBJ_POS_Y??[18],X ; --
    DEC OBJ_POS_Y??[18],X ; --, -= 2 total.
    JMP INVERT_STEP ; Goto.
VAL_NEG: ; 0D:0FE4, 0x01AFE4
    LDA OBJ_POS_X??[18],X ; Load
    BPL EXIT ; If positive, leave.
    CMP #$FE ; If _ #$FE
    BCS EXIT ; >=, leave.
INVERT_STEP: ; 0D:0FED, 0x01AFED
    LDA #$00 ; Prep invert.
    SEC ; Prep sub.
    SBC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Invert val.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store back.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
    BMI RESULT_NEGATIVE ; Negative, goto.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$03 ; If _ #$03
    BNE EXIT ; !=, goto.
    JMP GFX+ALOT_MORE ; Do otherwise.
RESULT_NEGATIVE: ; 0D:1005, 0x01B005
    INC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; ++
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
EXIT: ; 0D:1016, 0x01B016
    RTS ; Leave.
EXIT_STEP: ; 0D:1017, 0x01B017
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step--
    RTS ; Leave.
GFX+ALOT_MORE: ; 0D:101B, 0x01B01B
    LDA #$59
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$29
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$96
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
    LDA #$C8
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set attr.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save obj.
    LDA OBJ_POS_X?[18],X ; Move attrs to TMP.
    STA TMP_00
    LDA OBJ_POS_Y??[18],X ; Load
    STA TMP_01
    JSR FIND_ANY_PAIR_UNUSED_RET_CS_PASS_CC_FAIL ; Pair.
    BCC EXIT_RESTORE_XOBJ ; Fail, goto.
    LDA #$6B
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set state.
    LDA #$00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Clear attr.
    LDA TMP_00 ; Load
    STA OBJ_POS_X?[18],X ; Move to new OBJ.
    LDA TMP_01 ; Load
    SEC ; Prep sub.
    SBC #$08 ; Sub.
    STA OBJ_POS_Y??[18],X ; Store to new obj.
    LDA #$C8
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$9A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
EXIT_RESTORE_XOBJ: ; 0D:1065, 0x01B065
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore Xobj.
    RTS ; Leave.
ALT_RTN: ; 0D:1069, 0x01B069
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_STILL_POSITIVE ; Positive, goto.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    EOR #$01 ; Invert.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
HOLD_STILL_POSITIVE: ; 0D:107B, 0x01B07B
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    CMP #$1A ; If _ #$1A
    BCC RTS ; <, leave.
    CLC ; Prep add.
    LDA #$A0 ; Load
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store to.
    BCS ADD_OVERFLOW ; Overflow, goto.
    DEC OBJ_POS_X??[18],X ; --
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$FD ; If _ #$FD
    BCS ADD_OVERFLOW ; >=, goto.
    LDA #$FD
    STA OBJ_POS_X??[18],X ; Set to.
ADD_OVERFLOW: ; 0D:109F, 0x01B09F
    CLC ; Prep add.
    LDA OBJ_POS_X??[18],X ; Load
    ADC OBJ_POS_Y??[18],X ; Add with.
    STA OBJ_POS_Y??[18],X ; Store to.
    CMP #$05 ; If _ #$05
    BCS RTS ; >=, leave.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert. Destroys object.
RTS: ; 0D:10B0, 0x01B0B0
    RTS ; Leave.
ATTRS_SET_UNSURE: ; 0D:10B1, 0x01B0B1
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    ORA #$01 ; Set bit.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store back.
    LDA #$1C
    STA 704_OBJ_USE_UNK ; Set unk.
MISC_OBJ_END: ; 0D:10BE, 0x01B0BE
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 704_OBJ_USE_UNK ; --
    BEQ VAL_EQ_ZERO_B ; Other zero.
WAS_SET: ; 0D:10C8, 0x01B0C8
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA TMP_00 ; Store to TMP.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    LSR A ; >> 2, /4.
    LSR A
    AND #$03 ; Keep bits 0000.0011
    TAY ; To Y.
    LDA OBJ_DATA,Y ; Load datya for bits.
    ORA TMP_00 ; Or with other portion.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
VAL_EQ_ZERO: ; 0D:10DE, 0x01B0DE
    RTS ; Leave.
VAL_EQ_ZERO_B: ; 0D:10DF, 0x01B0DF
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load val.
    AND #$80 ; Keep only 1000.0000
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store back.
    BMI WAS_SET ; Go into other portion.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
RTS: ; 0D:10F1, 0x01B0F1
    RTS ; Leave.
OBJ_DATA: ; 0D:10F2, 0x01B0F2
    .db 03
    .db 01
    .db 03
    .db 02
OBJ_STATE_0x61_HANDLER: ; 0D:10F6, 0x01B0F6
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    INC OBJ_ANIMATION_DISPLAY[18],X ; ++
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load.
    CMP #$03 ; If _ #$03
    BEQ VAL_EQ_0x03 ; ==, goto.
    BCC RTS ; <, goto.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init.
VAL_EQ_0x03: ; 0D:1117, 0x01B117
    DEC OBJ_ANIMATION_DISPLAY[18],X ; --
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
RTS: ; 0D:111F, 0x01B11F
    RTS ; Leave.
FIND_ANY_PAIR_UNUSED_RET_CS_PASS_CC_FAIL: ; 0D:1120, 0x01B120
    LDX #$07 ; Xobj start.
FIND_LOOP: ; 0D:1122, 0x01B122
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    ORA OBJ_ENABLED_STATE+MORE?+1,X ; Combine with pair.
    BEQ RET_CS ; Both unused, goto.
    INX ; Next obj.
    CPX #$11 ; If _ #$11
    BCC FIND_LOOP ; <, goto.
    CLC ; CC, failure.
    RTS ; Leave.
RET_CS: ; 0D:1131, 0x01B131
    SEC ; CS, pass.
    RTS ; Leave.
RTN_C: ; 0D:1133, 0x01B133
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; ++
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$01 ; If _ #$01
    BNE VAL_NE_0x01 ; !=, goto.
    LDY 707_SWITCHED_ON?? ; Load
    CPY #$01 ; If _ #$01
    BNE VAL_NE_0x01 ; != 0, goto.
    LDY #$00
    STY 636_UNK ; Clear.
    TXA ; Handled to A.
    PHA ; Save to stack.
    LDA #$18
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Do.
    PLA ; Pull handled.
    TAX ; Back to X.
VAL_NE_0x01: ; 0D:1157, 0x01B157
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load attr.
    LDY #$00 ; Index reset.
    CMP #$01 ; If _ #$01
    BEQ Y_DECIDED ; ==, goto.
    INY ; Index++
    CMP #$18 ; If _ #$18
    BEQ Y_DECIDED ; ==, goto.
    INY ; Y++
    CMP #$30 ; If _ #$30
    BEQ Y_DECIDED ; ==, goto.
    CMP #$60 ; If _ #$30
    BCC RTS ; <, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$64 ; Hold.
    LDY 707_SWITCHED_ON?? ; Load.
    BNE NONZERO
    LDA #$32 ; Half if zero.
NONZERO: ; 0D:117A, 0x01B17A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
RTS: ; 0D:117D, 0x01B17D
    RTS ; Leave.
Y_DECIDED: ; 0D:117E, 0x01B17E
    STY TMP_02 ; Y to.
    LDA OBJ_POS_X?[18],X ; Load
    STA TMP_00 ; Store.
    LDA OBJ_POS_X??[18],X ; Load
    STA TMP_01 ; Store.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Hey, they finally used the scratchpad, lol.
    JSR FIND_ANY_PAIR_UNUSED_RET_CS_PASS_CC_FAIL ; Get pair.
    BCC EXIT_INDEX ; Failed, goto.
    LDA #$60
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set state.
    LDA TMP_01 ; Move from.
    STA OBJ_POS_X??[18],X ; Set attr.
    DEC OBJ_POS_X??[18],X ; --
    LDA #$00
    STA OBJ_POS_Y??[18],X ; Clear attrs.
    STA 4B4_OBJ_SPEED?[18],X
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA #$02
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Set attr.
    LDA #$01
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    LDY TMP_02 ; Load index.
    LDA OBJ_DATA_A,Y ; Load.
    CLC
    ADC TMP_00 ; Add with TMP var.
    STA OBJ_POS_X?[18],X ; Store to.
    LDA OBJ_DATA_B,Y ; Load
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store attr.
    SEC ; Prep sub.
    LDA TMP_01 ; Load
    SBC #$08 ; -=
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store attr.
    JMP EXIT_X_RESTORE ; Goto, abuse RTS.
EXIT_INDEX: ; 0D:11D0, 0x01B1D0
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
EXIT_X_RESTORE: ; 0D:11D3, 0x01B1D3
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore X.
RTS: ; 0D:11D6, 0x01B1D6
    RTS ; Leave.
OBJ_DATA_A: ; 0D:11D7, 0x01B1D7
    .db 00
    .db F2
    .db 0E
OBJ_DATA_B: ; 0D:11DA, 0x01B1DA
    .db 6C
    .db 6B
    .db 6B
OBJ_STATE_0x60_HANDLER: ; 0D:11DD, 0x01B1DD
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$20 ; Val.
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add with.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store to.
    BCC NO_OVERFLOW
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; ++ if overflow.
NO_OVERFLOW: ; 0D:11F0, 0x01B1F0
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4B4_OBJ_SPEED?[18],X ; Add to.
    STA 4B4_OBJ_SPEED?[18],X ; Store back.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC OBJ_POS_Y??[18],X ; Carry add.
    STA OBJ_POS_Y??[18],X ; Store back.
    CMP STATUS_FLAGS_B/OBJ_FOCUS[18],X ; If _ Attr
    BCC RTS ; <, goto.
    LDA #$4C
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init self, die.
RTN_D: ; 0D:1210, 0x01B210
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; Nonzero, continue.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Self.
    CMP #$02 ; If A _ #$02. TODO: This code is fucked. Mistake. Will be 0x00.
    BCS RTS ; >=, leave.
    LDA #$FF
    STA 5F8_OBJ_SETS_UNK ; Set attr.
RTS: ; 0D:1228, 0x01B228
    RTS ; Leave.
OBJ_STATE_0x62_HANDLER: ; 0D:1229, 0x01B229
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BEQ VAL_ZERO ; == 0, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
VAL_ZERO: ; 0D:1231, 0x01B231
    LDA 4D8_OBJ_UNK[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 4D8_OBJ_UNK[18],X ; --
VAL_EQ_ZERO: ; 0D:1239, 0x01B239
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Y from.
    LDA BRANCH_DATA,Y ; Load.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
VAL_EQ_ZERO: ; 0D:1249, 0x01B249
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR RTN_MULTISWITCH ; Do.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ EXIT ; == 0, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$02 ; If _ #$02
    BCC EXIT ; <, goto.
    CMP #$04 ; If _ #$04
    BCS EXIT ; >=, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
VAL_EQ_ZERO: ; 0D:126F, 0x01B26F
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store return.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load health.
    CPY #$FF ; If Curr _ #$FF
    BNE USE_OLD_HEALTH ; != 0, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store old health.
USE_OLD_HEALTH: ; 0D:127F, 0x01B27F
    LSR TMP_00 ; >> 1, /2.
    BCC EXIT ; Shifted 0x0, leave.
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP FOCUS_CHANGE ; Goto.
EXIT: ; 0D:128B, 0x01B28B
    JMP MISC_OBJ_END ; Goto.
BRANCH_DATA: ; 0D:128E, 0x01B28E
    .db 00
    .db 00
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
RTN_MULTISWITCH: ; 0D:1295, 0x01B295
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ASL A
    TAY
    LDA FILES_PTR_L,Y
    STA TMP_00
    LDA FILES_PTR_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X
    ASL A
    TAY
    LDA [TMP_00],Y
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02]
FILES_PTR_L: ; 0D:12B5, 0x01B2B5
    LOW(FILE_A)
FILES_PTR_H: ; 0D:12B6, 0x01B2B6
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
FILE_A: ; 0D:12C1, 0x01B2C1
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
FILE_B: ; 0D:12C7, 0x01B2C7
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
FILE_C: ; 0D:12CF, 0x01B2CF
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_D: ; 0D:12D3, 0x01B2D3
    LOW(ATTR_HELPER+707_SWITCH) ; Other rtn.
    HIGH(ATTR_HELPER+707_SWITCH)
FILE_E: ; 0D:12D5, 0x01B2D5
    LOW(RTN_A) ; Other rtn code.
    HIGH(RTN_A)
    LOW(RTN_B) ; Other rtn code.
    HIGH(RTN_B)
    LOW(RTN_C) ; Other rtn code.
    HIGH(RTN_C)
    LOW(RTN_D) ; Other rtn code.
    HIGH(RTN_D)
RTN_A: ; 0D:12DD, 0x01B2DD
    LDY #$14
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Palette.
    LDA #$01
    STA 707_SWITCHED_ON?? ; Set.
    LDA #$03
    STA 70D_UNK ; Store.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attr.
    LDA #$CC
    STA OBJ_POS_X?[18],X ; Set attr.
    LDA #$BC
    STA OBJ_POS_X??[18],X ; Store attr.
    STA OBJ_POS_Y??[18],X
    LDA #$EF
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$F6
    STA OBJ_POS_X_DELTA?[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs. ARGH. Optim mistakes again.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$28
    STA TIMER_GAME_SCRIPT? ; Set attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
RTN_B: ; 0D:1318, 0x01B318
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA TIMER_GAME_SCRIPT? ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA #$40
    JSR BACKGROUND_UPDATING_INTERFACE ; Do.
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NONZERO
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
VAL_NONZERO: ; 0D:132E, 0x01B32E
    RTS ; Leave.
VAL_NE_ZERO: ; 0D:132F, 0x01B32F
    DEC TIMER_GAME_SCRIPT? ; --
    BNE RTS ; != 0, goto.
    LDA #$60
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$34
    JSR SND_BANKED_DISPATCH ; Double sound.
    LDA #$E6
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
RTS: ; 0D:1343, 0x01B343
    RTS ; Leave.
RTN_C: ; 0D:1344, 0x01B344
    LDA #$C4
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$E7
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Ret CC, goto.
    LDA #$96
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA 4D8_OBJ_UNK[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$09
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    LDA #$00 ; Wtf mang. Mistake.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear attr pair.
    STA 704_OBJ_USE_UNK ; Clear.
    LDA #$CC
    STA OBJ_POS_X?[18],X ; Set attr.
    LDA #$BC
    STA OBJ_POS_X??[18],X ; Set attr.
    STA OBJ_POS_Y??[18],X ; Set attr.
    JSR ANIM/GFX/ATTR_HELPER ; Do.
    JSR SET_STATE/HOLD/ATTRS/ANIM_HELPER ; Do.
    LDA #$02
    STA 636_UNK ; Set.
RET_CC: ; 0D:1391, 0x01B391
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
RTS: ; 0D:139E, 0x01B39E
    RTS ; Leave.
SET_STATE/HOLD/ATTRS/ANIM_HELPER: ; 0D:139F, 0x01B39F
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
SET_GFX/ANIM_HELPER: ; 0D:13AE, 0x01B3AE
    LDA #$AC
    STA ZP_R2-R5_BANK_VALUES+2 ; Set attrs.
    LDA #$AD
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$74
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim display.
RTS: ; 0D:13BB, 0x01B3BB
    RTS ; Leave.
RTN_A: ; 0D:13BC, 0x01B3BC
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
SWITCH/HOLD/GFX/ANIM/SND_HELPER: ; 0D:13C4, 0x01B3C4
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    JSR SET_GFX/ANIM_HELPER ; Do.
    LDA #$7A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$23
    JMP SND_BANKED_DISPATCH ; Play sound.
RTN_B: ; 0D:13E0, 0x01B3E0
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$20 ; If _ #$20
    BCS HOLD_GT_0x20 ; >=, goto.
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    TAY ; To Y index.
    LDA OBJ_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    RTS
HOLD_GT_0x20: ; 0D:13F5, 0x01B3F5
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP FOCUS_CLOSEST_PLAYER ; Goto, abuse RTS.
OBJ_DATA: ; 0D:1403, 0x01B403
    .db 7A
    .db 7B
    .db 7A
    .db 7B
RTN_C: ; 0D:1407, 0x01B407
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    JSR TMP_SEED_RTN_FROM_FOCUS_OBJ ; Do.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    STA TMP_00 ; Store result.
    ORA OBJ_POS_X_DELTA?[18],X ; Or more.
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    BEQ ALL_SETTLED ; == 0, goto.
    LDA TMP_10 ; Load
    CMP #$30 ; If _ #$30
    BCS VAL_GT_0x30 ; >=, goto.
    SEC ; Prep sub.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Focus.
    LDA OBJ_POS_X??[18],Y ; Load
    SBC OBJ_POS_X??[18],X ; Sub with.
    BPL RESULT_POSITIVE ; Positive, goto.
    EOR #$FF ; Invert result.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 0D:1434, 0x01B434
    CMP #$11 ; If _ #$11
    BCC ALL_SETTLED ; <, goto.
VAL_GT_0x30: ; 0D:1438, 0x01B438
    LDA TMP_00 ; Load
    BNE RTN_D ; != 0, goto.
    LDA TMP_10 ; Load.
    CMP #$30 ; If _ #$30
    BCS VAL_GT_0x30 ; >=, goto.
RTN_D: ; 0D:1442, 0x01B442
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    BNE SCRIPT_NONZERO ; != 0, goto.
    JMP SET_STATE/HOLD/ATTRS/ANIM_HELPER ; Goto, abuse RTS.
SCRIPT_NONZERO: ; 0D:1449, 0x01B449
    LDA #$60 ; Val.
    LDY OBJ_POS_X_DELTA?[18],X ; Y from.
    BEQ VAL_EQ_ZERO
    BPL VAL_POSITIVE
    LDA #$A0 ; Alt val.
VAL_POSITIVE: ; 0D:1454, 0x01B454
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store attr.
VAL_EQ_ZERO: ; 0D:1457, 0x01B457
    JSR RTN_UNK_A ; Do.
    JMP ANIM/GFX/ATTR_HELPER ; Goto. Abuse RTS.
ALL_SETTLED: ; 0D:145D, 0x01B45D
    LDA 4D8_OBJ_UNK[18],X ; Load
    BNE RTN_D ; != 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Keep 0000.0111
    BEQ RTN_D ; == 0, goto.
    JMP EXIT_SWITCH ; Goto.
VAL_GT_0x30: ; 0D:146B, 0x01B46B
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BNE RTN_D ; != 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Keep 0000.0111
    BEQ RTN_D ; == 0, goto.
    JMP SWITCH/HOLD/GFX/ANIM_HELPER
EXIT_SWITCH: ; 0D:1479, 0x01B479
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold.
    STA OBJECT_DATA_EXTRA_B?[18],X ; And attr.
    RTS ; Leave.
RTN_A: ; 0D:148C, 0x01B48C
    LDA #$02
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$1E ; If _ #$1E
    BCS VAL_GTE_0x1E ; >=, goto.
    LDY #$00 ; Index.
    CMP #$07 ; If _ #$07
    BCC LT_0x07 ; <, goto.
    INY ; Index++
    CMP #$0B ; If _ #$0B
    BCS GTE_0x0B ; >=, goto.
    LDA #$94
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JMP LT_0x07 ; Goto.
GTE_0x0B: ; 0D:14AE, 0x01B4AE
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Clear attr.
LT_0x07: ; 0D:14B3, 0x01B4B3
    TYA ; Index to A.
    ASL A ; << 2, *4.
    ASL A
    TAY ; Back to index.
    LDA OBJ_DATA_A,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attrs from index.
    LDA OBJ_DATA_B,Y
    STA ZP_R2-R5_BANK_VALUES+2
    LDA OBJ_DATA_C,Y
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
VAL_GTE_0x1E: ; 0D:14C8, 0x01B4C8
    LDA #$50
    STA 4D8_OBJ_UNK[18],X ; Set attr.
    LDA #$40
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attr.
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Keep 0000.0111
    BNE LIKELY
    JMP SWITCH/HOLD/GFX/ANIM/SND_HELPER ; Goto, 1 in 8.
LIKELY: ; 0D:14E5, 0x01B4E5
    DEC OBJ_SECONDARY_SWITCH?[18],X ; --
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set switch.
    JMP SET_GFX/ANIM_HELPER ; Goto, abuse RTS.
OBJ_DATA_A: ; 0D:14F0, 0x01B4F0
    .db 78
    .db 00 ; Unused.
OBJ_DATA_B: ; 0D:14F2, 0x01B4F2
    .db AC
OBJ_DATA_C: ; 0D:14F3, 0x01B4F3
    .db AE
    .db 79
    .db 00 ; Unused.
    .db AC
    .db AE
SWITCH/HOLD/GFX/ANIM_HELPER: ; 0D:14F8, 0x01B4F8
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$AC
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$AF
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$77
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS
RTN_B: ; 0D:1515, 0x01B515
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    BEQ VAL_EQ_ZERO
    CMP #$14 ; If _ #$14
    BCC 0D:1514 ; <, goto.
    LDA #$50
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$20
    STA 4D8_OBJ_UNK[18],X ; Set attr.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Keep 0000.0111
    BNE VAL_NE_ZERO ; != 0, goto.
    JMP SWITCH/HOLD/GFX/ANIM/SND_HELPER ; 1 in 8.
VAL_NE_ZERO: ; 0D:1534, 0x01B534
    DEC OBJ_SECONDARY_SWITCH?[18],X ; --
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    JMP SET_GFX/ANIM_HELPER ; Goto, abuse RTS.
OBJ_STATE_0x63_HANDLER: ; 0D:153F, 0x01B53F
    JSR XPOS_RTN_RET_?? ; Do.
    BCC CONTINUE
    JMP INIT_OBJECT[X]_DATA_FULL
CONTINUE: ; 0D:1547, 0x01B547
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$03 ; If _ #$03
    BCC LT_0x03 ; <, goto.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    EOR #$03 ; Invert bits.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
LT_0x03: ; 0D:155E, 0x01B55E
    LDA #$9E
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    AND #$03 ; Keep bits.
    BNE LIKELY ; != 0, goto.
    RTS ; Leave. 1 in 4 chance.
LIKELY: ; 0D:156B, 0x01B56B
    LDA #$65
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set switch.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$04
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    RTS ; Leave.
VAL_EQ_ZERO: ; 0D:1580, 0x01B580
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    STA TMP_00
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE
    BCC L_0D:160A
    LDA #$25
    JSR SND_BANKED_DISPATCH
    LDA #$63
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA TMP_00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDY #$00
    ASL A
    BPL L_0D:15A5
    LDY #$02
L_0D:15A5: ; 0D:15A5, 0x01B5A5
    LDA L_0D:161B,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA L_0D:161C,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA L_0D:1617,Y
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD
    CLC
    ADC OBJ_POS_X?[18],Y
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    LDA #$DD
    STA 4C6_OBJ_UNK[18],X
    CLC
    ADC OBJ_POS_X??[18],X
    STA OBJ_POS_Y??[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$81
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X
    STX TMP_00
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE
    BCC L_0D:160A
    LDA #$64
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDY TMP_00
    LDA OBJ_POS_X?[18],Y
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_Y??[18],Y
    STA OBJ_POS_Y??[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
L_0D:160A: ; 0D:160A, 0x01B60A
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    RTS
    LDA OBJ_ANIMATION_DISPLAY[18],X
    BNE L_0D:1616
    STA OBJECT_DATA_EXTRA_B?[18],X
L_0D:1616: ; 0D:1616, 0x01B616
    RTS
L_0D:1617: ; 0D:1617, 0x01B617
    .db DA
    .db 00
    .db 26
    .db 00
L_0D:161B: ; 0D:161B, 0x01B61B
    .db 00
L_0D:161C: ; 0D:161C, 0x01B61C
    .db FC
    .db 00
    .db 04
OBJ_STATE_0x64_HANDLER: ; 0D:161F, 0x01B61F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$0C ; If _ #$0C
    BCS DIE ; >=, goto.
    LSR A ; >> 2, /4.
    LSR A
    TAY ; To index.
    LDA OBJ_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
RTS: ; 0D:1637, 0x01B637
    RTS ; Leave.
DIE: ; 0D:1638, 0x01B638
    JMP INIT_OBJECT[X]_DATA_FULL ; Init.
OBJ_DATA: ; 0D:163B, 0x01B63B
    .db 83
    .db 84
    .db 83
OBJ_STATE_0x65_HANDLER: ; 0D:163E, 0x01B63E
    LDA #$00
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, continue.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    INC OBJ_ANIMATION_DISPLAY[18],X ; ++
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, goto.
    JMP INIT_OBJECT[X]_DATA_FULL ; Die. Abuse RTS.
ANIM/GFX/ATTR_HELPER: ; 0D:165A, 0x01B65A
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Or with attrs.
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BPL STILL_POSITIVE ; Positive, goto.
    LDA #$09
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
STILL_POSITIVE: ; 0D:1675, 0x01B675
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Range.
VAL_EQ_ZERO: ; 0D:167A, 0x01B67A
    TAY ; To Y index.
    LDA OBJ_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set from data.
    LDA #$AC
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$AD
    STA ZP_R2-R5_BANK_VALUES+3
    RTS ; Leave.
OBJ_DATA: ; 0D:168A, 0x01B68A
    .db 74
    .db 75
    .db 76
    .db 75
OBJ_STATE_0x6A_HANDLER: ; 0D:168E, 0x01B68E
    .db 60 ; Leave.
OBJ_STATE_0x6B_HANDLER: ; 0D:168F, 0x01B68F
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    JMP INIT_OBJECT[X]_DATA_FULL ; Die.
RTS: ; 0D:1697, 0x01B697
    RTS ; Leave.
OBJ_STATE_0x67_HANDLER: ; 0D:1698, 0x01B698
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BEQ VAL_ZERO ; == 0, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
VAL_ZERO: ; 0D:16A0, 0x01B6A0
    LDA 4D8_OBJ_UNK[18],X ; Load
    BEQ VAL_ZERO ; == 0, goto.
    DEC 4D8_OBJ_UNK[18],X ; --
VAL_ZERO: ; 0D:16A8, 0x01B6A8
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR RTN_MULTISWITCH ; Do switch.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ EXIT ; == 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; LOad
    PHA ; Save.
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load attr.
    LSR A ; >> 1, /2
    BCC SHIFTED_ZERO ; Shifted 0x0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
SHIFTED_ZERO: ; 0D:16C4, 0x01B6C4
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store ret to TMP.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load health.
    CPY #$FF ; If _ #$FF
    BNE NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store health.
NE_0xFF: ; 0D:16D4, 0x01B6D4
    LDA TMP_00 ; Load
    AND #$02 ; Test bit.
    BEQ BIT_NOT_SET ; Not set, goto.
    INC 706_UNK ; ++
    RTS ; Leave.
BIT_NOT_SET: ; 0D:16DE, 0x01B6DE
    LDA TMP_00 ; Load
    LSR A ; >> 1, /2.
    BCS JMP_EXIT_FOCUS_SOUND_ETC ; If set, goto.
EXIT: ; 0D:16E3, 0x01B6E3
    JMP MISC_OBJ_END ; Goto.
JMP_EXIT_FOCUS_SOUND_ETC: ; 0D:16E6, 0x01B6E6
    JMP EXIT_FOCUS_SOUND_ETC ; Goto.
RTN_MULTISWITCH: ; 0D:16E9, 0x01B6E9
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load.
    ASL A ; << 1, *2.
    TAY
    LDA FILE_PTRS_L,Y ; Move file ptr.
    STA TMP_00
    LDA FILE_PTRS_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load.
    ASL A ; << 1, *2.
    TAY
    LDA [TMP_00],Y ; Move function ptr.
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02] ; Run code.
FILE_PTRS_L: ; 0D:1709, 0x01B709
    LOW(FILE_A)
FILE_PTRS_H: ; 0D:170A, 0x01B70A
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
    LOW(FILE_F)
    HIGH(FILE_F)
FILE_A: ; 0D:1715, 0x01B715
    LOW(RTN_A) ; From other function.
    HIGH(RTN_A)
FILE_B: ; 0D:1717, 0x01B717
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
FILE_C: ; 0D:171D, 0x01B71D
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
FILE_D: ; 0D:1725, 0x01B725
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
FILE_E: ; 0D:172B, 0x01B72B
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_F: ; 0D:172D, 0x01B72D
    LOW(RTN_A) ; From other rtn.
    HIGH(RTN_A)
    LOW(RTN_B) ; From other rtn.
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
RTN_D: ; 0D:1735, 0x01B735
    JSR INIT_OBJECT[X]_DATA_FULL ; Die.
    INX
    JSR INIT_OBJECT[X]_DATA_FULL ; With pair, too.
    DEX
    RTS ; Leave.
RTN_A: ; 0D:173E, 0x01B73E
    LDY #$15
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Palette.
    LDA #$02
    STA 707_SWITCHED_ON?? ; Set.
    LDA #$00
    STA 70D_UNK ; Clear.
    LDA #$6A
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$8C
    STA OBJ_POS_X??[18],X
    STA OBJ_POS_Y??[18],X
    JSR SET_GFX/ANIM_HELPER ; Do.
    LDA #$DC
    STA OBJECT_DATA_HEALTH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    STA 4D8_OBJ_UNK[18],X
    LDA #$09
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1
    STA 704_OBJ_USE_UNK
    STA 706_UNK
    INC OBJ_SECONDARY_SWITCH?[18],X
    LDA #$48
    JSR SND_BANKED_DISPATCH
    RTS
RTN_A: ; 0D:1789, 0x01B789
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    TAY ; Y = 0.
    LDA #$01
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_DATA,Y ; Load.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set step from.
    RTS ; Leave.
RTN_B: ; 0D:17A7, 0x01B7A7
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR SET_GFX/ANIM_HELPER ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE ; If positive, goto.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Move to hold.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE HOLD_POSITIVE ; != 0, goto.
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Y from.
    LDA OBJ_DATA,Y ; Data from.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to step.
    INC 544_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    CMP #$06 ; If _ #%06
    BEQ EXIT_HOLD/TERT ; ==, goto.
HOLD_POSITIVE: ; 0D:17D5, 0x01B7D5
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    LSR A ; >> 1, /2.
    BCC RTS ; Shifted 0x0, leave.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear.
RTS: ; 0D:17E0, 0x01B7E0
    RTS ; Leave.
EXIT_HOLD/TERT: ; 0D:17E1, 0x01B7E1
    LDA #$20
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
HOLD_NONZERO: ; 0D:17E9, 0x01B7E9
    RTS ; Leave.
RTN_C: ; 0D:17EA, 0x01B7EA
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR SET_GFX/ANIM_HELPER ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE HOLD_NONZERO ; != 0, goto.
    LDA #$00
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Clear attrs.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    JMP SET_SWITCH/HOLD/GFX/ANIM_HELPER ; Goto.
OBJ_DATA: ; 0D:1808, 0x01B808
    .db 1E
    .db 0F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
SET_SWITCH/HOLD/GFX/ANIM_HELPER: ; 0D:180E, 0x01B80E
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X
SET_GFX/ANIM_HELPER: ; 0D:181D, 0x01B81D
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2
    LDA #$B1
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$85
    STA OBJ_ANIMATION_DISPLAY[18],X
RTS: ; 0D:182A, 0x01B82A
    RTS
RTN_A: ; 0D:182B, 0x01B82B
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
HELPER_SWITCH/HOLD/GFX/ATTR/ANIM/??: ; 0D:1833, 0x01B833
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$04
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B3
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$8C
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim display.
    LDA #$00
    STA 706_UNK ; Clear ??
    RTS ; Leave.
RTN_B: ; 0D:185A, 0x01B85A
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE ; Positive, goto.
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BEQ EXIT_CLEARS/TERT/FOCUS ; == 0, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    EOR #$05 ; Invert bits.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
    LDA ZP_R2-R5_BANK_VALUES+3 ; Load GFX.
    EOR #$02 ; Invert GFX.
    STA ZP_R2-R5_BANK_VALUES+3 ; Store back.
HOLD_POSITIVE: ; 0D:1877, 0x01B877
    RTS ; Leave.
EXIT_CLEARS/TERT/FOCUS: ; 0D:1878, 0x01B878
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    JMP FOCUS_CLOSEST_PLAYER ; Goto. Abuse RTS.
SET_SWITCHES_HELPER: ; 0D:1886, 0x01B886
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
RTN_C: ; 0D:1891, 0x01B891
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    BCC RET_CC_RTN ; Focused, goto.
    JMP SET_SWITCH/HOLD/GFX/ANIM_HELPER ; Goto if fail to focus.
RET_CC_RTN: ; 0D:1899, 0x01B899
    JSR TMP_SEED_RTN_FROM_FOCUS_OBJ ; Do.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Get focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from focus.
    AND #$04 ; Keep.
    BEQ BIT_UNSET
    JMP RTN_D ; Goto if set.
BIT_UNSET: ; 0D:18A9, 0x01B8A9
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    STA TMP_00 ; Store to.
    ORA OBJ_POS_X_DELTA?[18],X ; Or with others.
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    BEQ ALL_SETTLED ; All zero, goto.
    LDA TMP_10 ; Load
    CMP #$30 ; If _ #$30
    BCS GTE_0x30 ; >=, goto.
    SEC ; Prep sub.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_POS_X??[18],Y ; Load from focus.
    SBC OBJ_POS_X??[18],X ; Sub with handled.
    BPL SKIP_COMPLIMENT
    EOR #$FF ; 2's compliment.
    CLC
    ADC #$01
SKIP_COMPLIMENT: ; 0D:18D0, 0x01B8D0
    CMP #$11 ; If _ #$11
    BCC ALL_SETTLED ; <, goto. In range, goto.
GTE_0x30: ; 0D:18D4, 0x01B8D4
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    BNE RTN_D ; Nonzero, goto.
    LDA TMP_10 ; Load
    CMP #$30 ; If _ #$30
    BCS GTE_0x30 ; >=, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA 4C6_OBJ_UNK[18],X ; Load from us.
    BEQ ALL_SETTLED ; == 0, goto.
    CMP #$D8 ; If _ #$D8
    BCS ALL_SETTLED ; >=, goto.
GTE_0x30: ; 0D:18EE, 0x01B8EE
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    AND #$05 ; Keep 0000.1001
    CMP #$01 ; If _ #$01
    BNE VAL_NE_0x01 ; !=, goto.
    LDA TMP_10 ; Loaed
    CMP #$40 ; If _ #$40
    BCS VAL_NE_0x01 ; >=, goto.
    JMP FIND_OBJ_RTN ; Goto.
RTN_D: ; 0D:1903, 0x01B903
    LDA RANDOM_VALS?[2] ; Load
    BNE VERY_LIKELY ; != 0, goto.
    JMP SET_SWITCH/HOLD/GFX/ANIM_HELPER ; If 0, do... 1 in 256.
VERY_LIKELY: ; 0D:190A, 0x01B90A
    LDA #$60 ; Val?
    LDY OBJ_POS_X_DELTA?[18],X ; Y from.
    BEQ ATTR_EQ_ZERO ; == 0, goto.
    BPL STORE_ATTR ; If positive, goto.
    LDA #$A0 ; Alt val.
STORE_ATTR: ; 0D:1915, 0x01B915
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store attr.
ATTR_EQ_ZERO: ; 0D:1918, 0x01B918
    JSR RTN_UNK_A ; Do.
    JMP ANIM/GFX_HELPER/SETTLER ; Goto.
ALL_SETTLED: ; 0D:191E, 0x01B91E
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BNE GTE_0x30 ; != 0, goto.
    JSR FIND_OBJ_STATE_0x68_RET_CS_FOUND ; Do.
    BCS GTE_0x30 ; Found, goto.
    JSR RANDOMNESS ; Do.
    AND #$03 ; Keep bits.
    BEQ 1_IN_4_RTN ; 1 in 4, goto.
    LDA #$00
    STA 70D_UNK ; Clear attr.
    JMP SET_SWITCHES/HOLD/ATTR_FROM_OTHER/CLEAR_ATTRS ; Goto.
VAL_NE_0x01: ; 0D:1937, 0x01B937
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA 4D8_OBJ_UNK[18],X ; Load
    BEQ VAL_EQ_ZERO_B ; == 0, goto.
    BNE RTN_D ; != 0, goto.
VAL_EQ_ZERO: ; 0D:1943, 0x01B943
    LDA RANDOM_VALS?[2] ; Load rand.
    AND #$0F ; Keep bits.
    BNE RTN_D ; != 0, any set, goto. 1 in 16 to not take.
FIND_OBJ_RTN: ; 0D:1949, 0x01B949
    JSR FIND_OBJ_STATE_0x68_RET_CS_FOUND ; Do.
    BCS RTN_D ; Found one, goto.
1_IN_4_RTN: ; 0D:194E, 0x01B94E
    LDA #$00
    STA 70D_UNK ; Clear attr.
    JMP SET_SWITCHES/HOLD/GFX/DISP/MOVE_HELPER ; Goto.
VAL_EQ_ZERO_B: ; 0D:1956, 0x01B956
    LDA 4D8_OBJ_UNK[18],X ; Load
    BNE RTN_D ; != 0, goto.
    LDA RANDOM_VALS?[2] ; Load
    AND #$1F ; Keep bits.
    BNE RTN_D ; != 0, goto. Highly likely. 1 in 32 to not take.
    LDA TMP_10 ; Load
    CMP #$32 ; If _ #$32
    BCC RTN_D ; <, goto.
    LDA #$00
    STA 70D_UNK ; Clear var.
    JSR SET_SWITCH/HOLD/GFX/ANIM_HELPER ; Do.
    LDA #$25
    JMP SND_BANKED_DISPATCH ; Play sound.
FIND_OBJ_STATE_0x68_RET_CS_FOUND: ; 0D:1974, 0x01B974
    LDY #$07 ; Obj focus.
CONTINUE_LOOP: ; 0D:1976, 0x01B976
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state of obj.
    CMP #$68 ; If _ #$68
    BEQ RET_CS ; ==, goto. Found.
    INY ; Next obj.
    CPY #$12 ; Final?
    BCC CONTINUE_LOOP ; <, goto.
    CLC ; Clear carry. Not found.
    RTS ; Leave.
RET_CS: ; 0D:1984, 0x01B984
    SEC ; Set carry. Found obj.
    RTS
SET_SWITCHES/HOLD/GFX/DISP/MOVE_HELPER: ; 0D:1986, 0x01B986
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$F6
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B1
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$89
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim disp.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to.
RTS: ; 0D:19A8, 0x01B9A8
    RTS ; Leave.
RTN_C: ; 0D:19A9, 0x01B9A9
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    BMI INC_NEGATIVE ; If negative, goto.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY+1,X ; Clear pair attr.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BEQ NAMED_LINE ; == 0, goto.
    CMP #$08 ; If _ #$08
    BCS EXIT_HOLD ; >=, goto.
    LDY #$00 ; Index.
    CMP #$02 ; If _ #$02
    BEQ INDEX_FOUND ; ==, goto.
    CMP #$04 ; If _ #$04
    BEQ INDEX_FOUND ; ==, goto.
    INY ; Index++
    CMP #$06 ; If _ #$06
    BNE RTS ; !=, leave.
INDEX_FOUND: ; 0D:19CB, 0x01B9CB
    STY TMP_12 ; Store to.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    STA TMP_02 ; Store to.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    STA TMP_05 ; Store to. Mistake, not needed, rtn does.
    JSR TMP_SETUP_SELECTIVE_INVERT ; Do.
    JMP 0D:1D42 ; Goto.
NAMED_LINE: ; 0D:19DD, 0x01B9DD
    LDA #$00
    STA TMP_12
    JMP 0D:1D11
INC_NEGATIVE: ; 0D:19E4, 0x01B9E4
    LDA #$02
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?+1,X
    LDA #$8F
    STA OBJ_ANIMATION_DISPLAY+1,X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    ASL A
    ASL A
    LDY #$00
    BCC 0D:19F9
    LDY #$02
    LDA 0D:1A29,Y
    ADC OBJ_POS_X?[18],X
    STA OBJ_POS_X?+1,X
    LDA OBJ_POS_X??[18],X
    STA OBJ_POS_X??+1,X
    INC OBJ_POS_X??+1,X
    LDA 0D:1A2A,Y
    STA 4C6_OBJ_UNK+1,X
    CLC
    ADC OBJ_POS_X??+1,X
    STA OBJ_POS_Y??+1,X
    LDA OBJ_ANIM_HOLD_TIMER?[18],X
    CMP #$FF
    BNE 0D:1A24
    LDA #$14
    JSR SND_BANKED_DISPATCH
    RTS
EXIT_HOLD: ; 0D:1A25, 0x01BA25
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
EXIT: ; 0D:1A28, 0x01BA28
    RTS
    .db F9
    .db BE
    .db 06
    .db BF
SET_SWITCHES/HOLD/ATTR_FROM_OTHER/CLEAR_ATTRS: ; 0D:1A2D, 0x01BA2D
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$1A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA OBJECT_DATA_HEALTH?[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set from other.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr/var.
    STA 706_UNK
    RTS ; Leave.
RTN_A: ; 0D:1A4B, 0x01BA4B
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BEQ VAL_ZERO ; == 0, goto.
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B2
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$88
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$14 ; If _ #$14
    BCC RTS ; <, goto.
    LDA #$97
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
RTS: ; 0D:1A69, 0x01BA69
    RTS ; Leave.
VAL_ZERO: ; 0D:1A6A, 0x01BA6A
    LDA #$20
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    STA OBJECT_DATA_HEALTH?[18],X ; Store to.
    LDA 706_UNK ; Load
    BEQ 706_EQ_ZERO
    JMP HELPER_SWITCH/HOLD/GFX/ATTR/ANIM/?? ; Do if zero.
706_EQ_ZERO: ; 0D:1A85, 0x01BA85
    LDA RANDOM_VALS?[2] ; Load.
    AND #$07 ; Keep bits.
    BNE ANY_BITS_SET ; !=, 7 in 8 to take.
    JMP HELPER_SWITCH/HOLD/GFX/ATTR/ANIM/?? ; Do 1 in 8.
ANY_BITS_SET: ; 0D:1A8E, 0x01BA8E
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    JMP SET_GFX/ANIM_HELPER ; Goto.
SET_SWITCH/HOLD/GFX/ANIM_HELPER: ; 0D:1A99, 0x01BA99
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$B2
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B3
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$8A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
STILL_HOLDING: ; 0D:1AB5, 0x01BAB5
    RTS
RTN_B: ; 0D:1AB6, 0x01BAB6
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BMI HOLD_NEGATIVE ; Negative, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL STILL_HOLDING ; If positive, goto.
    LDA #$8B
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim. Hold == 0 here.
    JMP NEW_OBJ_CREATION ; Goto.
HOLD_NEGATIVE: ; 0D:1AC8, 0x01BAC8
    LDY #$07 ; Obj start.
LOOP_ALL_OBJS: ; 0D:1ACA, 0x01BACA
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state.
    CMP #$68 ; If _ #$688
    BEQ STATE_MATCH ; ==, goto.
    INY ; Next obj.
    CPY #$12 ; All?
    BCC LOOP_ALL_OBJS ; <, no, loop.
    LDA #$50
    STA 4D8_OBJ_UNK[18],X ; Set attr. ??
    JMP SET_SWITCHES_HELPER ; Goto.
STATE_MATCH: ; 0D:1ADE, 0x01BADE
    LDA #$F6
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set long hold.
    RTS ; Leave.
OBJ_STATE_0x68_HANDLER: ; 0D:1AE4, 0x01BAE4
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    BEQ SECONDARY_ZERO ; == 0, goto.
    JMP HOLD/ANIM/DIE ; Goto otherwise.
SECONDARY_ZERO: ; 0D:1AEC, 0x01BAEC
    JSR XPOS_RTN_RET_?? ; Do.
    BCS RTN_RET_CS ; Ret CS, goto.
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    CMP #$03 ; If _ #$03
    BCC LT_0x03 ; <, goto.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    EOR #$07 ; Invert bit.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store back.
LT_0x03: ; 0D:1B08, 0x01BB08
    LDA #$98
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 1
    BCS EXIT_SECONDARY/ANIM/HOLD/ATTR_HELPER ; CS, goto.
    LSR A ; >> 1
    BCS EXIT_SECONDARY/ANIM/HOLD/ATTR_HELPER ; CS, goto.
    RTS ; Leave.
RTN_RET_CS: ; 0D:1B17, 0x01BB17
    TXA
    PHA ; Save Xobj. Doesn't use Xobj scratch.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load focus.
    TAX ; To X.
    JSR SET_SWITCHES_HELPER ; Move state.
    LDA #$C8
    STA 4D8_OBJ_UNK[18],X ; Set focus attr.
    PLA
    TAX ; Restore Xobj.
    JMP INIT_OBJECT[X]_DATA_FULL ; Die.
EXIT_SECONDARY/ANIM/HOLD/ATTR_HELPER: ; 0D:1B2A, 0x01BB2A
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switch.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Anim.
    LDA #$04
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    RTS ; Leave.
NEW_OBJ_CREATION: ; 0D:1B3F, 0x01BB3F
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA TMP_00 ; Store to TMP.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Store handling to scratchpad.
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Do.
    BCC EXIT_RESTORE ; Failed to get obj, goto.
    LDA #$68
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set new obj state.
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Init.
    LDA TMP_00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Set attr from other.
    LDY #$00 ; Index.
    ASL A ; << 1, *2.
    BPL VAL_POSITIVE
    LDY #$02 ; Alt index, other direction.
VAL_POSITIVE: ; 0D:1B64, 0x01BB64
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attrs from data.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_C,Y
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Handling to Y.
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],Y ; Add with.
    STA OBJ_POS_X?[18],X ; Store to new.
    LDA OBJ_POS_X??[18],Y ; Load
    STA OBJ_POS_X??[18],X ; Store to new.
    LDA #$D8 ; Load
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    CLC ; Prep add.
    ADC OBJ_POS_X??[18],X ; Add with new.
    STA OBJ_POS_Y??[18],X ; Store to new.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attrs.
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$93
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load again. Mistake, not needed.
    TYA ; to A.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store to new obj. Focus handling obj.
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
EXIT_RESTORE: ; 0D:1BAB, 0x01BBAB
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load handling.
    RTS ; Leave.
    LDA OBJ_ANIMATION_DISPLAY[18],X
    BNE L_0D:1BB7
    STA OBJECT_DATA_EXTRA_B?[18],X
L_0D:1BB7: ; 0D:1BB7, 0x01BBB7
    RTS
OBJ_DATA_C: ; 0D:1BB8, 0x01BBB8
    .db DA
    .db 00
    .db 26
    .db 00
OBJ_DATA_A: ; 0D:1BBC, 0x01BBBC
    .db 00
OBJ_DATA_B: ; 0D:1BBD, 0x01BBBD
    .db FB
    .db 00
    .db 05
HOLD/ANIM/DIE: ; 0D:1BC0, 0x01BBC0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Move anim.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, goto. Leave.
    JMP INIT_OBJECT[X]_DATA_FULL ; >=, destroyed.
ANIM/GFX_HELPER/SETTLER: ; 0D:1BDC, 0x01BBDC
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Or with attrs.
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BEQ ATTRS_SETTLED ; All == 0, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BPL SKIP_ATTR_SET ; If positive, goto.
    LDA #$0D
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
SKIP_ATTR_SET: ; 0D:1BF7, 0x01BBF7
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Range with bits.
ATTRS_SETTLED: ; 0D:1BFC, 0x01BBFC
    TAY ; To index.
    LDA OBJ_DATA,Y ; Load anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store.
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B1
    STA ZP_R2-R5_BANK_VALUES+3
RTS: ; 0D:1C0B, 0x01BC0B
    RTS ; Leave.
OBJ_DATA: ; 0D:1C0C, 0x01BC0C
    .db 85
    .db 86
    .db 87
    .db 86
EXIT_FOCUS_SOUND_ETC: ; 0D:1C10, 0x01BC10
    INC 70D_UNK ; ++
    LDA #$02 ; Useless. Mistake.
    JSR FOCUS_CHANGE ; Do.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$05 ; If _ #$05
    BEQ EXIT_ATTR_SET ; ==, goto.
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$03 ; If _ #$03
    BNE NE_0x03 ; !=, goto.
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load
    CMP #$01 ; If _ #$01
    BEQ EXIT_ATTR_SET ; ==, goto.
    CMP #$02 ; If _ #$02
    BEQ EXIT_ATTR_SET ; ==, goto.
NE_0x03: ; 0D:1C36, 0x01BC36
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    CMP #$46 ; If _ #$46
    LDA #$10 ; Load
    BCS GTE_0x46
    LDA #$0C ; Alt val.
GTE_0x46: ; 0D:1C41, 0x01BC41
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$8D
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$B0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$B1
    STA ZP_R2-R5_BANK_VALUES+3
EXIT_ATTR_SET: ; 0D:1C5B, 0x01BC5B
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    RTS ; Leave.
RTN_A: ; 0D:1C61, 0x01BC61
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL EXIT_ATTR_SET ; If positive, goto.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA 70D_UNK ; Load
    CMP #$03 ; If _ #$03
    BCC LT_0x03 ; <, goto.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attrs if >= val.
    STA 4D8_OBJ_UNK[18],X
    JMP RET_CC_RTN ; Goto.
LT_0x03: ; 0D:1C80, 0x01BC80
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JMP SET_SWITCHES_HELPER ; Goto.
OBJ_STATE_0x69_HANDLER: ; 0D:1C88, 0x01BC88
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load
    BNE TERT_NONZERO ; Goto if set.
    JSR ADD_RTN_RET_CS_POSITIVE_CC_NEGATIVE ; Do.
    BCS RET_CS ; Goto.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS RET_CS_B ; Ret CS, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load
    ADC OBJ_POS_X??[18],X ; Add with.
    STA OBJ_POS_Y??[18],X ; Store to.
    LDA #$98
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 2
    LSR A
    BCC RTS ; Bit 0x02 wasn't set, leave.
    INC 706_UNK ; Inc if was.
RTS: ; 0D:1CB4, 0x01BCB4
    RTS ; Leave.
RET_CS: ; 0D:1CB5, 0x01BCB5
    INC OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set long ass hold.
    LDA #$91
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA OBJ_POS_X??[18],X ; Move attr.
    STA OBJ_POS_Y??[18],X
TERT_NONZERO: ; 0D:1CC8, 0x01BCC8
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$09 ; If _ #$09
    BCS RET_CS_B ; >=, goto.
    CMP #$05 ; If _ #$05
    BNE RTS ; !=, leave.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Mod animation.
RTS: ; 0D:1CD9, 0x01BCD9
    RTS ; Leave.
RET_CS_B: ; 0D:1CDA, 0x01BCDA
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ EXIT_DIE ; ==, goto.
    TXA
    PHA ; Save Xobj to stack.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    TAX ; To Xobj.
    JSR ATTR_HELPER ; Do.
    LDA 706_UNK ; Load
    BNE 706_NONZERO ; != 0, goto.
    JSR SET_SWITCHES_HELPER ; Do.
    JMP EXIT_DIE_PULL_OBJ_OFF_STACK ; Goto.
706_NONZERO: ; 0D:1CF3, 0x01BCF3
    JSR HELPER_SWITCH/HOLD/GFX/ATTR/ANIM/?? ; Do.
EXIT_DIE_PULL_OBJ_OFF_STACK: ; 0D:1CF6, 0x01BCF6
    PLA ; And then kill? lol.
    TAX ; Back to X index.
EXIT_DIE: ; 0D:1CF8, 0x01BCF8
    JMP INIT_OBJECT[X]_DATA_FULL ; Goto, abuse RTS.
ATTR_HELPER: ; 0D:1CFB, 0x01BCFB
    LDA #$50
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear attrs.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$06
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    RTS ; Leave.
    LDA #$00
    STA 706_UNK
    LDA OBJ_POS_X?[18],X
    STA TMP_08
    LDA OBJ_POS_X??[18],X
    STA TMP_06
    SEC
    SBC #$38
    STA TMP_09
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X?[18],Y
    STA TMP_0A
    LDA OBJ_POS_X??[18],Y
    STA TMP_0B
    JSR L_0D:1DF3
    LDA TMP_05
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA TMP_02
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JMP L_0D:1D4C
    LDA OBJ_POS_X?[18],X ; Set more TMP's from Obj.
    STA TMP_08
    LDA OBJ_POS_X??[18],X
    STA TMP_06
L_0D:1D4C: ; 0D:1D4C, 0x01BD4C
    LDA TMP_05 ; Load
    ASL A ; << 2, *4.
    ASL A
    STA TMP_00 ; Store to.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load step.
    AND #$FC ; Keep 1111.1100
    STA TMP_04 ; Store to.
    ASL A ; << 2, *4.
    ASL A
    LDA #$00 ; Val to set.
    BCC SHIFTED_0x1
    LDA #$02 ; Alt val.
SHIFTED_0x1: ; 0D:1D61, 0x01BD61
    ORA TMP_00 ; Set bits with val.
    TAY ; To Y.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Store handling to scratchpad.
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Get obj.
    BCC EXIT_RESTORE ; Failed, goto.
    CLC ; Prep add.
    LDA OBJ_DATA_A,Y ; Load
    ADC TMP_08 ; Add with.
    STA OBJ_POS_X?[18],X ; Store to new.
    CLC ; Prep add.
    LDA OBJ_DATA_B,Y ; Load.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    CLC ; Prep add.
    ADC TMP_06 ; Add with.
    STA OBJ_POS_Y??[18],X ; Store to.
    LDA TMP_06 ; Load
    STA OBJ_POS_X??[18],X ; Store to.
    LDA TMP_04 ; Load
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to.
    LDY TMP_05 ; Index from.
    LDA OBJ_DATA_C,Y ; Load.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attrs.
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA TMP_0C ; Move from tmp to new. 5x.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA TMP_0D
    STA OBJ_POS_X_DELTA?[18],X
    LDA TMP_0E
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_0F
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_12
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load original handling.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store as focus.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$FC
    ORA #$02
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA #$69 ; Nice state.
    STA OBJ_ENABLED_STATE+MORE?[18],X
EXIT_RESTORE: ; 0D:1DCA, 0x01BDCA
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    RTS
OBJ_DATA_A: ; 0D:1DCE, 0x01BDCE
    .db F3
OBJ_DATA_B: ; 0D:1DCF, 0x01BDCF
    .db C3
    .db 0D
    .db C3
    .db F4
    .db C6
    .db 0C
    .db C6
    .db F4
    .db C5
    .db 0C
    .db C5
ADD_RTN_RET_CS_POSITIVE_CC_NEGATIVE: ; 0D:1DDA, 0x01BDDA
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4D8_OBJ_UNK[18],X ; Add
    STA 4D8_OBJ_UNK[18],X ; Store to.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4C6_OBJ_UNK[18],X ; Carry add.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    BPL RET_CS ; Ret CS.
    CLC ; Ret CC.
    RTS ; Leave.
RET_CS: ; 0D:1DF1, 0x01BDF1
    SEC ; Ret CS.
    RTS ; Leave.
L_0D:1DF3: ; 0D:1DF3, 0x01BDF3
    SEC
    LDA TMP_08
    SBC TMP_0A
    STA TMP_04
    LDY #$00
    BCS 0D:1E05
    LDY #$02
    LDA #$00
    SEC
    SBC TMP_04
    STY TMP_02
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA TMP_04
    SEC
    LDA TMP_09
    SBC TMP_0B
    STA TMP_05
    LDA #$00
    BCS 0D:1E20
    SEC
    SBC TMP_05
    STA TMP_05
    LDA #$01
    ORA TMP_02
    STA TMP_02
    LDA TMP_05
    LSR A
    LSR A
    AND #$38
    ORA TMP_04
    LSR A
    TAY
    LDA 0D:1E7B,Y
    BCS 0D:1E37
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$07
TMP_SETUP_SELECTIVE_INVERT: ; 0D:1E39, 0x01BE39
    STA TMP_05 ; A to TMP.
    ASL A ; << 2, *4.
    ASL A
    TAY ; A to Y.
    LDA TMP_DATA_A,Y ; Move data to TMP.
    STA TMP_0C
    LDA TMP_DATA_B,Y
    STA TMP_0D
    LDA TMP_DATA_C,Y
    STA TMP_0E
    LDA TMP_DATA_D,Y
    STA TMP_0F
    LDA TMP_02 ; Load
    LSR A ; >> 1, /2.
    BCS SHIFTED_0x1 ; Shifted 0x1, goto.
    SEC ; Prep sub.
    LDA #$00 ; Prep invert.
    SBC TMP_0E ; Invert.
    STA TMP_0E ; Store to.
    LDA #$00 ; Prep invert.
    SBC TMP_0F ; Invert.
    STA TMP_0F ; Store back.
SHIFTED_0x1: ; 0D:1E64, 0x01BE64
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load.
    ASL A ; << 1, *2.
    BMI RTS ; Now negative, goto.
    SEC ; Prep sub.
    LDA #$00 ; Prep invert.
    SBC TMP_0C ; Invert.
    STA TMP_0C ; Store back.
    LDA #$00 ; Prep sub.
    SBC TMP_0D ; Invert.
    STA TMP_0D ; Store back.
RTS: ; 0D:1E77, 0x01BE77
    RTS ; Leave.
OBJ_DATA_C: ; 0D:1E78, 0x01BE78
    .db 9C
    .db 90
    .db 9B
    .db 22
    .db 00
    .db 00
    .db 00
    .db 21
    .db 00
    .db 00
    .db 00
    .db 21
    .db 00
    .db 00
    .db 00
    .db 21
    .db 10
    .db 00
    .db 00
    .db 22
    .db 11
    .db 00
    .db 00
    .db 22
    .db 21
    .db 10
    .db 00
    .db 22
    .db 22
    .db 11
    .db 00
TMP_DATA_A: ; 0D:1E97, 0x01BE97
    .db 31
TMP_DATA_B: ; 0D:1E98, 0x01BE98
    .db 07
TMP_DATA_C: ; 0D:1E99, 0x01BE99
    .db 83
TMP_DATA_D: ; 0D:1E9A, 0x01BE9A
    .db 03
    .db A9
    .db 05
    .db A9
    .db 05
    .db 61
    .db 03
    .db 40
    .db 07
SET_SWITCHES_HELPER_707_A: ; 0D:1EA3, 0x01BEA3
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS
TMP_SEED_RTN_FROM_FOCUS_OBJ: ; 0D:1EAE, 0x01BEAE
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Yobj.
    STY TMP_00 ; Store to.
    LDA #$00
    STA TMP_01 ; Clear.
    SEC ; Prep sub.
    LDA OBJ_POS_X?[18],X ; Load
    SBC OBJ_POS_X?[18],Y ; Sub with Yobj.
    STA TMP_10 ; Store result.
    CMP #$1E ; If _ #$1E
    BCC LT_0x1E ; <, goto.
    CMP #$E3 ; If _ #$E3
    BCS GT_0xE3 ; >=, goto.
    INC TMP_01 ; Inc.
    LDA OBJ_POS_X?[18],X ; Load
    CMP OBJ_POS_X?[18],Y ; If _ Yobj
    BCS LT_0x1E ; >=, goto.
    INC TMP_01 ; Inc again.
GT_0xE3: ; 0D:1ED4, 0x01BED4
    SEC ; Prep sub.
    LDA #$00 ; Prep invert.
    SBC TMP_10 ; Invert result.
    STA TMP_10 ; Store back.
    LDA #$40 ; Seed dir.
    BNE DIR_SEEDED ; Always taken.
LT_0x1E: ; 0D:1EDF, 0x01BEDF
    LDA #$00 ; Dir left.
DIR_SEEDED: ; 0D:1EE1, 0x01BEE1
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store dir.
    LDA TMP_01 ; Load
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attr from data.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDY TMP_00 ; Y from.
    SEC ; Prep sub.
    LDA OBJ_POS_X??[18],X ; Load
    SBC OBJ_POS_X??[18],Y ; Sub with Yobj.
    STA TMP_11 ; Store result.
    LDY #$00 ; Index.
    CMP #$03 ; If _ #$03
    BCC INDEX_CHOSEN ; <, goto.
    CMP #$FE ; If _ #$FE
    BCS INDEX_CHOSEN_WITH_INVERT ; >=, goto.
    LDY #$02 ; Index.
    ASL A ; << 1, *2.
    BCC INDEX_CHOSEN ; Shifted off 0x0, goto.
    LDY #$04 ; Index.
INDEX_CHOSEN_WITH_INVERT: ; 0D:1F10, 0x01BF10
    SEC ; Prep sub.
    LDA #$00 ; Prep invert.
    SBC TMP_11 ; Invert.
    STA TMP_11 ; Store back.
INDEX_CHOSEN: ; 0D:1F17, 0x01BF17
    LDA OBJ_DATA_C,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set attrs from index.
    LDA OBJ_DATA_D,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
OBJ_DATA_A: ; 0D:1F24, 0x01BF24
    .db 00
OBJ_DATA_B: ; 0D:1F25, 0x01BF25
    .db 00
    .db 50
    .db FF
    .db B0
    .db 00
OBJ_DATA_C: ; 0D:1F2A, 0x01BF2A
    .db 00
OBJ_DATA_D: ; 0D:1F2B, 0x01BF2B
    .db 00
    .db 90
    .db FF
    .db 70
    .db 00
RTN_UNK_A: ; 0D:1F30, 0x01BF30
    LDA #$01 ; TODO: This.
    BNE 0D:1F36
    LDA #$00
    STA TMP_07
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    CLC
    LDA 520_OBJ_POS_X_LARGE?[18],X
    ADC 4B4_OBJ_SPEED?[18],X
    STA TMP_02
    LDA 503_OBJ_POS_X_LARGEST?[18],X
    ADC OBJ_POS_X??[18],X
    STA TMP_03
    ROR A
    EOR 503_OBJ_POS_X_LARGEST?[18],X
    BPL 0D:1F57
    LDA OBJ_POS_X??[18],X
    STA TMP_03
    LDY #$00
    LDA OBJ_POS_X_DELTA?[18],X
    BMI 0D:1F5F
    INY
    CLC
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ADC OBJ_POS_X_SUBPIXEL?[18],X
    STA TMP_04
    LDA OBJ_POS_X_DELTA?[18],X
    ADC OBJ_POS_X?[18],X
    STA TMP_05
    ROR A
    EOR OBJ_POS_X_DELTA?[18],X
    BPL 0D:1F82
    LDA #$01
    LDY OBJ_POS_X_DELTA?[18],X
    BPL 0D:1F7F
    LDA #$02
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BNE 0D:1F94
    LDA TMP_07
    BEQ 0D:1F94
    CLC
    LDA TMP_05
    ADC 0D:1FBB,Y
    TAY
    LDA TMP_03
    LDA TMP_04
    STA OBJ_POS_X_SUBPIXEL?[18],X
    LDA TMP_05
    STA OBJ_POS_X?[18],X
    LDA TMP_02
    STA 4B4_OBJ_SPEED?[18],X
    LDA TMP_03
    STA OBJ_POS_X??[18],X
    CLC
    LDA OBJ_POS_X??[18],X
    ADC 4C6_OBJ_UNK[18],X
    STA OBJ_POS_Y??[18],X
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BNE 0D:1FB9
    CLC
    RTS
    SEC
    RTS
    .db EC
    .db 14
GFX/ANIM_HELPER: ; 0D:1FBD, 0x01BFBD
    LDA #$A8
    STA ZP_R2-R5_BANK_VALUES+2 ; Set gfx.
    LDA #$AB
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$62
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db 2D

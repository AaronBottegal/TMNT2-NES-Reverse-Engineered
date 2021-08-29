    .db 36
OBJ_STATE_0x6E_HANDLER: ; 16:0001, 0x02C001
    .db 60
    .db 60 ; Just make sure, lol.
OBJ_STATE_0x79_HANDLER: ; 16:0003, 0x02C003
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save obj.
    LDA #$00 ; Load
    CPX #$07 ; If obj _ #$07
    BEQ OBJ_IS_0x07 ; ==, goto.
    LDA #$01 ; Alt val.
OBJ_IS_0x07: ; 16:000E, 0x02C00E
    STA 710_BOSS_WHICH_HIT? ; Store selected.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
VAL_EQ_ZERO: ; 16:0019, 0x02C019
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; --
VAL_EQ_ZERO: ; 16:0021, 0x02C021
    LDA #$0D
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR RTN_MULTISWITCH ; Switch.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, leave.
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load pair.
    BNE HAS_VAL ; != 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Pair.
    BEQ PAIR_INDEX_ZERO ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
PAIR_INDEX_ZERO: ; 16:0041, 0x02C041
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load
    CPY #$FF ; If _ #$FF
    BNE VAL_NE_ZERO ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store saved.
VAL_NE_ZERO: ; 16:0051, 0x02C051
    LDA TMP_00 ; Load
    AND #$02 ; If _ #$02
    BEQ BIT_CLEAR ; If set, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$40 ; Set bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR RANDOMNESS ; Random.
    AND #$03 ; Keep bits.
    BNE RTS ; Any bits set, goto. 3 in 4, goto.
    JSR OBJ_EXIST_THINGY ; Do.
RTS: ; 16:0069, 0x02C069
    RTS ; Leave.
BIT_CLEAR: ; 16:006A, 0x02C06A
    LSR TMP_00 ; >>
    BCC RTS ; Shifted 0x0, leave.
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP L_16:09A9 ; Goto, abuse RTS.
HAS_VAL: ; 16:0076, 0x02C076
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Pair hold.
    BEQ RTS ; == 0, leave.
    CLC ; Prep add.
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; Pair--
    BMI RECSULT_NEGATIVE ; Negative, goto.
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load pair.
    LSR A ; >> 2, /4.
    LSR A
RECSULT_NEGATIVE: ; 16:0086, 0x02C086
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    BCC SHIFT_CLEAR ; CC, goto.
    ORA #$02 ; Set bit.
SHIFT_CLEAR: ; 16:008F, 0x02C08F
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store attr.
RTS: ; 16:0092, 0x02C092
    RTS ; Leave.
RTN_MULTISWITCH: ; 16:0093, 0x02C093
    LDA OBJ_SECONDARY_SWITCH?[18],X ; You've seen this a few times before, look those up. lol.
    ASL A
    TAY
    LDA FILE_PTR_L,Y
    STA TMP_00
    LDA FILE_PTR_H,Y
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
FILE_PTR_L: ; 16:00B3, 0x02C0B3
    LOW(FILE_A)
FILE_PTR_H: ; 16:00B4, 0x02C0B4
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
FILE_A: ; 16:00BF, 0x02C0BF
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_B: ; 16:00C1, 0x02C0C1
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
    LOW(RTN_E)
    HIGH(RTN_E)
FILE_C: ; 16:00C9, 0x02C0C9
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
    LOW(RTN_F)
    HIGH(RTN_F)
    LOW(RTN_G)
    HIGH(RTN_G)
FILE_D: ; 16:00D7, 0x02C0D7
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_E: ; 16:00DB, 0x02C0DB
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_F: ; 16:00DD, 0x02C0DD
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
    LOW(RTN_C)
    HIGH(RTN_C)
    LOW(RTN_D)
    HIGH(RTN_D)
RTN_A: ; 16:00E5, 0x02C0E5
    LDY #$22
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Color.
    LDA #$01
    STA 708_UNK ; Set.
    LDA #$00
    STA 709_UNK_CB_INDEX ; Set.
    LDA #$07
    STA 711_UNK ; Set.
    LDA #$6E
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A+1,X ; Clear pair attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?+1,X
    STA OBJ_ANIMATION_DISPLAY+1,X
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set attr.
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$80
    STA OBJ_POS_X?[18],X ; Set attr.
    LDA #$8C
    STA OBJ_POS_X??[18],X ; Set attrs.
    STA OBJ_POS_Y??[18],X
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA #$02
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set attr.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$80
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$B0
    STA OBJECT_DATA_HEALTH?[18],X ; Set attr.
    RTS ; Leave.
    TYA
    PHA
    LDA #$10
    LDY 711_UNK
    BNE 16:014E
    LDA #$20
    STA OBJECT_DATA_HEALTH?[18],X
    PLA
    TAY
    RTS
RTN_B: ; 16:0154, 0x02C154
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    TAY ; Y = 0
    LDA #$01
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_DATA,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$48
    JSR SND_BANKED_DISPATCH ; Play sounds.
    LDA #$61
    JSR SND_BANKED_DISPATCH
RTS: ; 16:0185, 0x02C185
    RTS ; Leave.
RTN_C: ; 16:0186, 0x02C186
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR SET_ANIM/DISP_GFX_BOSS_SEEDED ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RESULT_POSITIVE ; Positive, goto.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE RESULT_POSITIVE ; != 0, goto.
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Y from.
    LDA OBJ_DATA,Y ; Load data.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to step.
    INC 544_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    CMP #$06 ; If _ #$06
    BEQ VAL_EQ_0x06 ; ==, goto.
RESULT_POSITIVE: ; 16:01B4, 0x02C1B4
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    LSR A ; >> 1, /2.
    BCC RTS ; Shifted 0x0, goto.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; No disp.
RTS: ; 16:01BF, 0x02C1BF
    RTS ; Leave.
VAL_EQ_0x06: ; 16:01C0, 0x02C1C0
    LDA #$50
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    JSR SET_ATTRS_HELPER ; Do.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
OBJ_DATA: ; 16:01CC, 0x02C1CC
    .db 1E
    .db 0F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
RTN_D: ; 16:01D2, 0x02C1D2
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    CMP #$30 ; If _ #$30
    BCS OTHER_PART ; >=, goto.
    LDA 708_UNK
    BEQ OTHER_PART ; == 0, goto.
    LDA #$C1 ; Only > 0x80 one?
    JSR BACKGROUND_UPDATING_INTERFACE ; Cross bank.
    LDA 87_CB_INDEX? ; Load
    BNE OTHER_PART ; != 0, goto.
    LDA #$00
    STA 708_UNK ; Clear.
    LDA #$4B
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$00
    STA 3DB_UNKNOWN ; Clear attr.
OTHER_PART: ; 16:01FB, 0x02C1FB
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BEQ VAL_EQ_ZERO ; == 0, goto.
    JSR MOVE/RANGE ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    JMP HOLD_AND_ATTRS ; Goto.
VAL_EQ_ZERO: ; 16:0209, 0x02C209
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA #$0A ; Val?
    CPX #$07 ; If XObj _ #$07
    BEQ XOBJ_EQ_0x07 ; ==, goto.
    LDA #$07 ; Seed other val.
XOBJ_EQ_0x07: ; 16:0216, 0x02C216
    TAX ; Loaded to Xobj.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    BEQ LOADED_OBJ_IS_ZERO ; == 0, goto.
    JMP EXIT_RESTORE_XOBJ ; Goto.
LOADED_OBJ_IS_ZERO: ; 16:021F, 0x02C21F
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y from. TODO: Never stored?
    LDA #$6D
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set enabled.
    LDA #$6E
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair enabled.
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set attr.
    STA OBJ_SECONDARY_SWITCH?[18],Y ; Set Yobj attr.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set terts.
    STA OBJ_TERTIARY_SWITCH?[18],Y
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load Yobj
    AND #$BF ; Keep 1011.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store to Yobj.
    EOR #$01 ; Invert bottom.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store to Yobj.
    LDA #$20
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set holds.
    STA OBJ_ANIM_HOLD_TIMER?[18],Y
    LDA OBJ_POS_X?[18],Y ; Move from Yobj to Xobj.
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    LDA OBJ_POS_Y??[18],Y
    STA OBJ_POS_Y??[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to Xobj.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attrs.
    STA 4C6_OBJ_UNK[18],X
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    JSR 16:0143 ; Do.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load
    LSR A ; >> 1
    BCS BIT_SET ; Set, goto farther set.
    LDA ROM_ATTR_A
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move attr set.
    LDA ROM_ATTR_B
    STA OBJ_POS_X_DELTA?[18],X
    LDA ROM_ATTR_C
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y
    LDA ROM_ATTR_D
    STA OBJ_POS_X_DELTA?[18],Y
    JMP SYNC ; Go past other (same) set.
BIT_SET: ; 16:02A0, 0x02C2A0
    LDA ROM_ATTR_C
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move attr set.
    LDA ROM_ATTR_D
    STA OBJ_POS_X_DELTA?[18],X
    LDA ROM_ATTR_A
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y
    LDA ROM_ATTR_B
    STA OBJ_POS_X_DELTA?[18],Y
SYNC: ; 16:02B8, 0x02C2B8
    TYA ; Yobj to A.
    TAX ; To X.
    JSR SET_ANIM/DISP_GFX_BOSS_SEEDED ; Do.
    LDA #$49
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_RESTORE_XOBJ: ; 16:02C2, 0x02C2C2
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load Xobj from scratch.
    RTS ; Leave.
ROM_ATTR_C: ; 16:02C6, 0x02C2C6
    .db 00
ROM_ATTR_D: ; 16:02C7, 0x02C2C7
    .db FF
ROM_ATTR_A: ; 16:02C8, 0x02C2C8
    .db 00
ROM_ATTR_B: ; 16:02C9, 0x02C2C9
    .db 01
RTN_E: ; 16:02CA, 0x02C2CA
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR SET_ANIM/DISP_GFX_BOSS_SEEDED ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; -=-
    BEQ VAL_EQ_ZERO ; == 0, goto.
    JSR RANGER ; Do.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Invert with.
    LSR A ; >>
    BCS SHIFT_0x1 ; CS, goto.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; No disp.
SHIFT_0x1: ; 16:02E8, 0x02C2E8
    RTS ; Leave.
VAL_EQ_ZERO: ; 16:02E9, 0x02C2E9
    JSR FOCUS_FIND_CLOSEST_SEED_0x00 ; Do.
    JMP STATE_HELPER ; Goto.Goto.
OBJ_EXIST_THINGY: ; 16:02EF, 0x02C2EF
    TYA ; Y to A.
    PHA ; Save.
    LDY #$07 ; Obj val.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load
    BEQ OBJ_A_DOESNT_EXIST ; == 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load
    EOR #$01 ; Invert bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
OBJ_A_DOESNT_EXIST: ; 16:0300, 0x02C300
    LDY #$0A ; Obj val.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state.
    BEQ EXIT ; Obj B doesn't exist.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load
    EOR #$01 ; Invert bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
EXIT: ; 16:030F, 0x02C30F
    PLA ; Pull attr.
    TAY ; Back to Y.
    RTS ; Leave.
STATE/STEP/GFX_HELPER: ; 16:0312, 0x02C312
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switch.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X
    JMP SET_STEP/HOLD/GFX_HELPER ; Goto, abuse RTS.
RTN_D: ; 16:031F, 0x02C31F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary.
    AND #$04 ; Test bit.
    BEQ STATE_HELPER ; Not set, goto.
    RTS ; Leave if set.
STATE_HELPER: ; 16:032A, 0x02C32A
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
RTN_A: ; 16:0335, 0x02C335
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Focus.
    BCC GREAT_SUCCESS ; Goto.
    JMP HOLD_AND_ATTRS ; Hold if can't focus.
GREAT_SUCCESS: ; 16:033D, 0x02C33D
    LDA #$0A ; Alt obj.
    CPX #$07 ; If Xobj _ #$07
    BEQ ALT_OBJ_FOUND ; ==, goto.
    LDA #$07 ; Seed alt obj.
ALT_OBJ_FOUND: ; 16:0345, 0x02C345
    TAY ; Alt obj to Y.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load 
    BNE OTHER_RTN ; != 0, goto.
    LDA 711_UNK ; Load
    BEQ OTHER_RTN ; == 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$20 ; Test bit.
    BNE OTHER_RTN ; Set, goto.
    DEC 711_UNK ; --
    JMP VAL_EQ_ZERO ; Goto, abuse.
OTHER_RTN: ; 16:035D, 0x02C35D
    JSR IDK_TODO_DOES_A_LOT_ODD ; Do.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Get focus.
    SEC ; Prep sub.
    LDA OBJ_POS_X?[18],X ; Load
    SBC OBJ_POS_X?[18],Y ; Sub with focus.
    STA TMP_17 ; Store to.
    BPL VAL_POSITIVE
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
VAL_POSITIVE: ; 16:0373, 0x02C373
    STA TMP_16 ; Store diff.
    SEC ; Prep sub.
    LDA OBJ_POS_X??[18],X ; Load
    SBC OBJ_POS_X??[18],Y ; Sub with.
    BPL VAL_POSITIVE_B
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
VAL_POSITIVE_B: ; 16:0383, 0x02C383
    STA TMP_0E ; Store diff.
    LDA TMP_0E ; Load diff. Mistake, bad code ugh.
    CMP #$08 ; If _ #$08
    BCS GTE_0x8_DIFF ; >=, goto.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BNE SKIP_RTN ; != 0, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load
    AND #$03 ; Keep bits.
    CMP #$03 ; If _ #$03
    BNE SKIP_RTN ; !=, goto.
    LDA 4C6_OBJ_UNK[18],Y ; Load.
    CMP #$D0 ; If _ #$D0
    BCC SKIP_RTN ; <, goto.
    LDA TMP_16 ; Load diff.
    CMP #$28 ; If _ #$28
    BCS VAL_GT ; >=, goto.
    JMP SWITCH_STATE_RTN_A_PIGGYBACK ; Goto.
VAL_GT: ; 16:03A9, 0x02C3A9
    CMP #$40 ; If _ #$40
    BCC SKIP_RTN ; <, goto.
    CMP #$44 ; If _ #$44
    BCS SKIP_RTN ; >=, goto.
    JMP SWITCH_STATE_RTN_A_PIGGYBACK ; Goto.
SKIP_RTN: ; 16:03B4, 0x02C3B4
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA TMP_16 ; Load diff.
    CMP #$20 ; If _ #$20
    BCS VAL_NE_ZERO ; >=, goto.
    JMP SWITCH_STATE_RTN_A_PIGGYBACK ; Goto.
VAL_NE_ZERO: ; 16:03C2, 0x02C3C2
    JSR COUNTER_RANDOMNESS_BAD ; Load
    AND #$07 ; Keep bits.
    BNE GTE_0x8_DIFF ; Any set, goto. 7 in 8 to do.
    LDA TMP_10 ; 1 in 8. Load
    CMP #$20 ; If _ #$20
    BCC GTE_0x8_DIFF ; <, goto.
    CMP #$30 ; If _ #$30
    BCS GTE_0x8_DIFF ; <, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary of focus.
    AND #$03 ; Keep bits.
    CMP #$02 ; If _ #$02
    BNE GTE_0x8_DIFF ; !=, goto.
    JMP SET_SEC/TERT_SWITCHES_HOLD_EXTRA_HELPER ; Goto.
GTE_0x8_DIFF: ; 16:03E2, 0x02C3E2
    LDA 710_BOSS_WHICH_HIT? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair.
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA 711_UNK ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$3F ; Keep bits.
    BNE VAL_EQ_ZERO ; Any set, goto. 63 in 64 to take.
    INC OBJECT_DATA_EXTRA_B?+1,X ; ++
    LDA OBJECT_DATA_EXTRA_B?+1,X ; Load
    AND #$07 ; Keep bits.
    BNE VAL_EQ_ZERO ; != 0, goto. 7 in 8 to do.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_POS_X?[18],Y ; Load.
    ASL A ; << 1, *2.
    LDA #$01 ; Val A.
    BCC SHIFT_0x0
    LDA #$06 ; Val B.
SHIFT_0x0: ; 16:040E, 0x02C40E
    STA OBJ_TERTIARY_SWITCH?+1,X ; Store tert val.
    JMP VAL_EQ_ZERO ; Goto.
VAL_NE_ZERO: ; 16:0414, 0x02C414
    LDY OBJ_TERTIARY_SWITCH?+1,X ; Y from tert.
    LDA TERT_DATA_A,Y ; Load attr.
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Or with.
    ORA 503_OBJ_POS_X_LARGEST?[18],X ; Or with.
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Or with.
    BNE VALS_NONZERO ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?+1,X ; Move pair tert.
    LDA #$40
    STA OBJECT_DATA_HEALTH?+1,X ; Set tert health.
    JMP VALS_NONZERO ; Goto.
VAL_NE_ZERO: ; 16:0435, 0x02C435
    DEC OBJECT_DATA_HEALTH?+1,X ; Pair--
    BNE VALS_NONZERO ; != 0, goto.
    INC OBJ_TERTIARY_SWITCH?+1,X ; Move pair tert.
    LDY OBJ_TERTIARY_SWITCH?+1,X ; Y from pair tert.
    LDA TERT_DATA_B,Y ; Load from tert.
    BEQ VALS_NONZERO ; == 0, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?+1,X ; Clear pair tert.
    JMP VALS_NONZERO ; Goto.
TERT_DATA_A: ; 16:044D, 0x02C44D
    .db 00
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
TERT_DATA_B: ; 16:0458, 0x02C458
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
VAL_EQ_ZERO: ; 16:0463, 0x02C463
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$7F ; Keep bits.
    BNE EXIT_RANGING_AND_MORE ; != 0, goto.
VALS_NONZERO: ; 16:0469, 0x02C469
    LDY #$07 ; 1 in 128 to do. Obj.
    CPX #$0A ; If Xobj _ #$0A
    BNE XOBJ_NOT_0xA ; !=, goto.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load
    BEQ EXIT_RANGING_AND_MORE ; == 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load
    BMI EXIT_RANGING_AND_MORE ; If negative, goto.
XOBJ_NOT_0xA: ; 16:0479, 0x02C479
    LDY #$0A ; Alt obj.
    CPX #$07 ; If Xobj _ #$07
    BEQ XOBJ_EQ_0x7 ; ==, goto.
    LDY #$07 ; Alt obj.
XOBJ_EQ_0x7: ; 16:0481, 0x02C481
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from other obj.
    AND #$20 ; Keep bit.
    BNE EXIT_RANGING_AND_MORE ; Set, goto.
    LDA TWO_PLAYERS_FLAG ; Load
    BNE 2P_CODE ; Set, goto.
    LDA OBJ_SECONDARY_SWITCH?[18] ; Load secondary.
    AND #$04 ; Keep bit.
    BNE EXIT_RANGING_AND_MORE ; Set, goto.
2P_CODE: ; 16:0493, 0x02C493
    JSR 16:06E2 ; Do.
    BCS EXIT_RANGING_AND_MORE ; Ret CS, goto.
    STA 709_UNK_CB_INDEX ; Store result.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$20 ; Set bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Goto.
    JMP TODO ; Goto.
EXIT_RANGING_AND_MORE: ; 16:04A6, 0x02C4A6
    JSR RANGER ; Do all.
    JSR MOVE/RANGE
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
    JSR MOVE_Y_FINALIZE
    JMP HOLD_AND_ATTRS ; Goto, abuse RTS.
SET_STATE/DIR/ATTRS_HELPER: ; 16:04B5, 0x02C4B5
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Index from.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load direction.
    ASL A ; << 2
    ASL A
    LDY #$02 ; Index.
    BCS SHIFT_CS ; CS, goto.
    LDY #$04 ; Alt index.
SHIFT_CS: ; 16:04CD, 0x02C4CD
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Attrs from index.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    ASL OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; << 1
    ROL OBJ_POS_X_DELTA?[18],X ; << 1
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$90 ; If _ #$90
    LDY #$02 ; Index.
    BCC INDEX_FOUND ; <, goto.
    LDY #$04 ; Alt index.
INDEX_FOUND: ; 16:04EA, 0x02C4EA
    JSR ATTR_HELPER_INDEXED ; Attrs from.
    LDA #$28
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
    RTS ; Leave.
RTN_C: ; 16:04F3, 0x02C4F3
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BEQ VAL_ZERO ; == 0, goto.
    JSR RANGER ; Do.
    JSR MOVE/RANGE ; Do.
    JSR MOVE_Y_FINALIZE ; Do.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do.
    JMP HOLD_AND_ATTRS ; Goto.
VAL_ZERO: ; 16:0507, 0x02C507
    JSR FOCUS_FIND_CLOSEST_SEED_0x00 ; Find.
    LDA #$06
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$40
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Clear attr.
    RTS ; Leave.
RTN_G: ; 16:0515, 0x02C515
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BNE VAL_NONZERO ; != 0, goto.
    JSR STATE_HELPER ; To state.
VAL_NONZERO: ; 16:051D, 0x02C51D
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do.
    JMP HOLD_AND_ATTRS ; Goto, abuse RTS.
SWITCH_STATE_RTN_A_PIGGYBACK: ; 16:0523, 0x02C523
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Switch state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$16
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do sub.
RTN_A: ; 16:0535, 0x02C535
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Range with bits.
    BNE VAL_NONZERO ; != 0, goto.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; << 2
    ASL A
    LDA #$FF ; Val.
    BCC SHIFT_CC
    LDA #$00 ; Alt val.
SHIFT_CC: ; 16:0546, 0x02C546
    ADC OBJ_POS_X?[18],X ; Add with.
    STA OBJ_POS_X?[18],X ; Store to.
VAL_NONZERO: ; 16:054C, 0x02C54C
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BEQ HOLD_ZERO ; == 0, goto.
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Index from.
    CPY #$0E ; If _ #$0E
    BNE HOLD_NE_0xE ; != 0, goto.
    PHP ; Save status.
    LDA #$17
    JSR SND_BANKED_DISPATCH ; Play sound.
    PLP ; Pull status.
HOLD_NE_0xE: ; 16:055F, 0x02C55F
    LDA #$00 ; Load val.
    BCS A_SEEDED ; CS, goto.
    CPY #$0A ; If _ #$0A
    BCC A_SEED_0x1 ; <, goto.
    LDA #$A7
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
A_SEED_0x1: ; 16:056C, 0x02C56C
    LDA #$01 ; Load val.
A_SEEDED: ; 16:056E, 0x02C56E
    STA TMP_00 ; Store to.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    ASL A ; << 1
    ROL TMP_00 ; << 1
    LDY TMP_00 ; Index from.
    LDA OBJ_DATA_A,Y ; Load from data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to anim.
    LDA #$BD ; Load attr.
    LDY 710_BOSS_WHICH_HIT? ; Load which GFX.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Store GFX.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    ASL A ; << 1
    BPL RTS ; If positive, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
RTS: ; 16:0591, 0x02C591
    RTS ; Leave.
HOLD_ZERO: ; 16:0592, 0x02C592
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$1F ; Keep bits.
    ADC #$10 ; += 0x10
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store as attr.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 2
    ASL A
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$BF ; Keep bits.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    BCC SHIFT_CC ; <, goto.
    JSR COUNTER_RANDOMNESS_BAD ; Do.
    AND #$07 ; Keep bits.
    BNE SHIFT_CC ; != 0, goto. 7 in 8 to take.
    JSR SET_STATE/DIR/ATTRS_HELPER ; Do.
    JMP SET_STEP/HOLD/GFX_HELPER ; Goto.
SHIFT_CC: ; 16:05BD, 0x02C5BD
    DEC OBJ_SECONDARY_SWITCH?[18],X ; --
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    JMP SET_STEP/HOLD/GFX_HELPER ; Goto.
OBJ_DATA_A: ; 16:05C8, 0x02C5C8
    .db AD
    .db E5
    .db AE
    .db AF
SET_SEC/TERT_SWITCHES_HOLD_EXTRA_HELPER: ; 16:05CC, 0x02C5CC
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    RTS ; Leave.
RTN_B: ; 16:05E1, 0x02C5E1
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BEQ HOLD_ZERO ; == 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1
    LDA #$B0 ; Load
    ADC #$00 ; Add with 0 or 1, depends on shift.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    LDA #$BE ; Load
    LDY 710_BOSS_WHICH_HIT? ; Load index of GFX change.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Set GFX with. +2 or +3 probably.
    LDA #$0E
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    RTS
HOLD_ZERO: ; 16:05FF, 0x02C5FF
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JMP SWITCH_STATE_RTN_A_PIGGYBACK ; Goto.
HOLD_AND_ATTRS: ; 16:060A, 0x02C60A
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE ; If positive, goto.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set attr.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
HOLD_POSITIVE: ; 16:0617, 0x02C617
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Range with bits.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y
SET_ANIM_DISP/GFX_BOSS: ; 16:0620, 0x02C620
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Y from Xobj.
    BPL VAL_POSITIVE ; Positive, goto.
    CLC ; Prep add.
    ADC #$03 ; Add val.
VAL_POSITIVE: ; 16:0628, 0x02C628
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$BC ; GFX.
    LDY 710_BOSS_WHICH_HIT? ; Y from.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Store GFX.
    RTS ; Leave.
SET_STEP/HOLD/GFX_HELPER: ; 16:0634, 0x02C634
    LDA #$02
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set attr.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
SET_ANIM/DISP_GFX_BOSS_SEEDED: ; 16:063E, 0x02C63E
    LDA #$A5 ; Val.
    JMP SET_ANIM_DISP/GFX_BOSS
OBJ_DATA_A: ; 16:0643, 0x02C643
    .db A3
    .db A4
    .db A5
    .db A4
TODO: ; 16:0647, 0x02C647
    LDA 709_UNK_CB_INDEX ; Load
    ASL A ; << 1
    TAY ; To Y index.
    LDA 709_DATA_A,Y ; Set TMP from index.
    STA TMP_0C
    LDA 709_DATA_B,Y
    STA TMP_0E
    LDA OBJ_POS_X?[18],X
    STA TMP_08
    LDA OBJ_POS_X??[18],X
    STA TMP_0A
    JSR MATH_RTN_TODO ; Do.
    LDA #$04
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    RTS ; Leave.
RTN_E: ; 16:0669, 0x02C669
    JSR HOLD_AND_ATTRS ; Do.
    JSR PAIR_POS_THINGY ; Do.
    BCS NEXT_TERT_W/_HOLD_HELPER ; Ret CS, goto.
    JSR PAIR_POS_THINGY ; Do.
    BCC RTS ; Ret CC, just leave.
NEXT_TERT_W/_HOLD_HELPER: ; 16:0676, 0x02C676
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    LDA #$18
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
RTS: ; 16:067E, 0x02C67E
    RTS ; Leave.
RTN_F: ; 16:067F, 0x02C67F
    LDA #$BF ; GFX.
    LDY 710_BOSS_WHICH_HIT? ; Index.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Store val to index.
    LDA #$AA
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    LDA OBJ_POS_X?[18],X ; Load
    ASL A ; << 1
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$BF ; Keep bits. 1011.1111
    BCS SHIFT_CS ; CS, goto.
    ORA #$40 ; Set bit if shift CC.
SHIFT_CS: ; 16:0699, 0x02C699
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BEQ RTN_DONE ; == 0, goto.
    RTS ; Leave if nonzero.
RTN_DONE: ; 16:06A2, 0x02C6A2
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY+1,X ; Set pair attr.
    LDA #$44
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
RTN_B: ; 16:06B6, 0x02C6B6
    LDA #$BF ; Val.
    LDY 710_BOSS_WHICH_HIT? ; Index from.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Store GFX.
    LDA #$AA
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDY 709_UNK_CB_INDEX ; Index from.
    LDA CROSS_BANK_ARRAY,Y ; Load val from array.
    JSR BACKGROUND_UPDATING_INTERFACE ; Do.
    LDA 87_CB_INDEX? ; Load
    BNE RTS ; != 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$DF ; Keep 1101.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR STATE/STEP/GFX_HELPER ; Do.
RTS: ; 16:06DB, 0x02C6DB
    RTS ; Goto, abuse RTS.
CROSS_BANK_ARRAY: ; 16:06DC, 0x02C6DC
    .db C2 ; Entry 0x42 - 0x47. Bank B.
    .db C3
    .db C4
    .db C5
    .db C6
    .db C7
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    BMI 16:072D
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X?[18],X
    SEC
    SBC OBJ_POS_X?[18],Y
    BPL 16:06F8
    EOR #$FF
    CLC
    ADC #$01
    CMP #$40
    BCC 16:072D
    CLC
    LDA OBJ_POS_X??[18],X
    ADC #$10
    AND #$E0
    STA TMP_00
    CLC
    LDA OBJ_POS_X??[18],Y
    ADC #$10
    AND #$E0
    CMP TMP_00
    BNE 16:072D
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$03
    STA TMP_00
    DEC TMP_00
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    ASL A
    ASL A
    LDA #$00
    BCC 16:0728
    LDA #$03
    CLC
    ADC TMP_00
    CLC
    RTS
    SEC
    RTS
709_DATA_A: ; 16:072F, 0x02C72F
    .db E0
709_DATA_B: ; 16:0730, 0x02C730
    .db A0
    .db B0
    .db C0
    .db E0
    .db D7
    .db 20
    .db A0
    .db 50
    .db C0
    .db 20
    .db D7
MATH_RTN_TODO: ; 16:073B, 0x02C73B
    LDA #$00
    STA TMP_09 ; Clear attrs.
    STA TMP_0B
    STA TMP_0D
    STA TMP_0F
    STA OBJ_POS_X_SUBPIXEL?+1,X
    STA 4B4_OBJ_SPEED?+1,X
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X
    SEC
    LDA TMP_0C
    SBC TMP_08
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    LDA TMP_0D
    SBC TMP_09
    STA OBJ_POS_X_DELTA?+1,X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    BEQ 16:0782
    LDA #$01
    LDY OBJ_POS_X_DELTA?+1,X
    BPL 16:077F
    SEC
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    LDA #$00
    SBC OBJ_POS_X_DELTA?+1,X
    STA OBJ_POS_X_DELTA?+1,X
    LDA #$FF
    STA OBJ_POS_X_SUBPIXEL?+1,X
    SEC
    LDA TMP_0E
    SBC TMP_0A
    STA 520_OBJ_POS_X_LARGE?+1,X
    LDA TMP_0F
    SBC TMP_0B
    STA 503_OBJ_POS_X_LARGEST?+1,X
    ORA 520_OBJ_POS_X_LARGE?+1,X
    BEQ 16:07B3
    LDA #$01
    LDY 503_OBJ_POS_X_LARGEST?+1,X
    BPL 16:07B0
    SEC
    LDA #$00
    SBC 520_OBJ_POS_X_LARGE?+1,X
    STA 520_OBJ_POS_X_LARGE?+1,X
    LDA #$00
    SBC 503_OBJ_POS_X_LARGEST?+1,X
    STA 503_OBJ_POS_X_LARGEST?+1,X
    LDA #$FF
    STA 4B4_OBJ_SPEED?+1,X
    LDA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    CMP 520_OBJ_POS_X_LARGE?+1,X
    BCS 16:07DA
    INC STATUS_FLAGS_B/OBJ_FOCUS+1,X
    LDA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    PHA
    LDA OBJ_POS_X_DELTA?+1,X
    PHA
    LDA 520_OBJ_POS_X_LARGE?+1,X
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    LDA 503_OBJ_POS_X_LARGEST?+1,X
    STA OBJ_POS_X_DELTA?+1,X
    PLA
    STA 503_OBJ_POS_X_LARGEST?+1,X
    PLA
    STA 520_OBJ_POS_X_LARGE?+1,X
    LDA 520_OBJ_POS_X_LARGE?+1,X
    ASL A
    STA TMP_08
    LDA 503_OBJ_POS_X_LARGEST?+1,X
    ROL A
    STA TMP_09
    SEC
    LDA TMP_08
    SBC OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 544_OBJ_UNK_POS_DELTA?+1,X
    LDA TMP_09
    SBC OBJ_POS_X_DELTA?+1,X
    STA 532_OBJ_UNK_POS_DELTA?+1,X
    LDA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    RTS
PAIR_POS_THINGY: ; 16:07FE, 0x02C7FE
    LDA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Load
    BNE INIT_VARS ; != 0, goto.
    JMP RTS_CS ; Goto.
INIT_VARS: ; 16:0806, 0x02C806
    LDA OBJ_POS_X_SUBPIXEL_DELTA?+1,X ; Load
    ASL A ; << 1
    STA TMP_08 ; Store to.
    LDA OBJ_POS_X_DELTA?+1,X ; Load
    ROL A ; Bring in other bit.
    STA TMP_09 ; Store to.
    LDA 520_OBJ_POS_X_LARGE?+1,X ; Load
    ASL A ; << 1
    STA TMP_0A ; Store.
    LDA 503_OBJ_POS_X_LARGEST?+1,X ; Load
    ROL A ; << 1
    STA TMP_0B ; Store to.
ENTER_RTN: ; 16:081E, 0x02C81E
    LDA 532_OBJ_UNK_POS_DELTA?+1,X ; Load
    BMI NEGATIVE ; If negative, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load.
    BNE VAL_SET ; != 0, goto.
    CLC ; Prep add.
    LDA OBJ_POS_X??[18],X ; Load
    ADC 4B4_OBJ_SPEED?+1,X ; Add with.
    STA OBJ_POS_X??[18],X ; Store to.
    JMP SUB_THINGY ; Goto.
VAL_SET: ; 16:0835, 0x02C835
    CLC ; Prep add.
    LDA OBJ_POS_X?[18],X ; Load
    ADC OBJ_POS_X_SUBPIXEL?+1,X ; Add with.
    STA OBJ_POS_X?[18],X ; Store to.
SUB_THINGY: ; 16:083F, 0x02C83F
    SEC ; Prep sub.
    LDA 544_OBJ_UNK_POS_DELTA?+1,X ; Load
    SBC TMP_08 ; Sub with.
    STA 544_OBJ_UNK_POS_DELTA?+1,X ; Store to.
    LDA 532_OBJ_UNK_POS_DELTA?+1,X ; Load
    SBC TMP_09 ; Sub with.
    STA 532_OBJ_UNK_POS_DELTA?+1,X ; Store to.
    JMP ENTER_RTN ; Goto.
NEGATIVE: ; 16:0853, 0x02C853
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    CLC ; Prep add.
    LDA OBJ_POS_X?[18],X ; Load
    ADC OBJ_POS_X_SUBPIXEL?+1,X ; Add with.
    STA OBJ_POS_X?[18],X ; Store back.
    JMP THINGY_ADD ; Goto.
VAL_NE_ZERO: ; 16:0865, 0x02C865
    CLC ; Prep add.
    LDA OBJ_POS_X??[18],X ; Load
    ADC 4B4_OBJ_SPEED?+1,X ; Add with.
    STA OBJ_POS_X??[18],X ; Store to.
THINGY_ADD: ; 16:086F, 0x02C86F
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?+1,X ; Load.
    ADC TMP_0A ; Add with.
    STA 544_OBJ_UNK_POS_DELTA?+1,X ; Store to.
    LDA 532_OBJ_UNK_POS_DELTA?+1,X ; Load
    ADC TMP_0B ; Add with.
    STA 532_OBJ_UNK_POS_DELTA?+1,X ; Store to.
    CLC ; Prep add.
    LDA OBJ_POS_X??[18],X ; Load
    ADC 4C6_OBJ_UNK[18],X ; Add with.
    STA OBJ_POS_Y??[18],X ; Store to.
    DEC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; --
    BEQ RTS_CS ; == 0, goto.
    CLC ; Ret CC.
    JMP RTS ; Goto.
RTS_CS: ; 16:0893, 0x02C893
    SEC ; Set carry.
RTS: ; 16:0894, 0x02C894
    RTS ; Leave.
IDK_TODO_DOES_A_LOT_ODD: ; 16:0895, 0x02C895
    LDA 710_BOSS_WHICH_HIT? ; Load
    BEQ ALT_THINGY ; Goto.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair tert.
    BEQ ALT_THINGY ; == 0, goto.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load tert.
    ASL A ; << 1
    TAY ; to Y.
    LDA UNK_DATA_A,Y ; Move to TMP.
    STA TMP_14
    LDA UNK_DATA_B,Y
    STA TMP_15
    JMP HIT_DETECT/ATTRS/MORE_TODO ; Goto.
UNK_DATA_A: ; 16:08B1, 0x02C8B1
    .db 00
UNK_DATA_B: ; 16:08B2, 0x02C8B2
    .db 00
    .db D8
    .db 90
    .db D8
    .db 90
    .db D8
    .db D8
    .db D8
    .db D8
    .db 00
    .db 00
    .db 28
    .db D8
    .db 28
    .db D8
    .db 28
    .db 90
    .db 28
    .db 90
    .db 00
    .db 00
ALT_THINGY: ; 16:08C7, 0x02C8C7
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1
    LDA #$F0 ; Load
    LDY #$1E ; Load.
    BCC SHIFT_0x0 ; CC, goto.
    LDA #$10 ; Alt vals.
    LDY #$E2
SHIFT_0x0: ; 16:08D5, 0x02C8D5
    STA TMP_14 ; Store val.
    TYA ; Val to A.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],Y ; Add to val.
    PHA ; Save.
    ROL A ; << 1
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Eor with.
    LSR A ; >> 1
    PLA ; Pull saved.
    BCS SHIFED_0x1 ; CS, goto.
    STA TMP_14 ; Store moved pos.
SHIFED_0x1: ; 16:08EA, 0x02C8EA
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load focus.
    LDA OBJ_POS_X??[18],Y ; Load from focus.
    STA TMP_15 ; Store to.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; << 2
    ASL A
    ROL A ; << 1
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Eor with.
    LSR A ; >> 1
    BCC HIT_DETECT/ATTRS/MORE_TODO ; CC, goto.
    LDA OBJ_POS_X??[18],Y ; Load
    CMP #$B0 ; If _ #$B0
    LDA #$E1 ; Val.
    BCS VAL_GT_0xB0 ; CS, goto.
    LDA #$20 ; Load alt val.
VAL_GT_0xB0: ; 16:0909, 0x02C909
    ADC OBJ_POS_X??[18],Y ; Add with.
    STA TMP_15 ; Store to.
HIT_DETECT/ATTRS/MORE_TODO: ; 16:090E, 0x02C90E
    JSR HIT_DETECT_HELPER_UNK ; Detect.
    LDY #$00 ; Val A.
    LDA TMP_10 ; Load
    CMP #$02 ; If _ #$02
    BCC LT_0x02 ; <, goto.
    LDY #$02 ; Alt val B.
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_14 ; If _ TMP_14
    BCS LT_0x02 ; >=, goto.
    LDY #$04 ; Alt val C.
LT_0x02: ; 16:0924, 0x02C924
    LDA 710_BOSS_WHICH_HIT? ; A from.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CLC ; Prep add.
    TYA ; Val to A.
    ADC #$06 ; += 0x6
    TAY ; Back to Y.
VAL_EQ_ZERO: ; 16:092E, 0x02C92E
    LDA OBJ_DATA_A,Y ; Move data from index.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDY #$00 ; Val A.
    LDA TMP_11 ; Load
    CMP #$08 ; If _ #$08
    BCC ATTR_HELPER_INDEXED ; <, goto.
    LDY #$02 ; Alt val B.
    LDA TMP_13 ; Load
    BPL ATTR_HELPER_INDEXED ; If positive, goto.
SET_ATTRS_HELPER: ; 16:0948, 0x02C948
    LDY #$04 ; Alt val C.
ATTR_HELPER_INDEXED: ; 16:094A, 0x02C94A
    LDA 710_BOSS_WHICH_HIT? ; Load.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CLC ; Prep add.
    TYA ; Index to A.
    ADC #$06 ; Add.
    TAY ; Back to Y.
VAL_EQ_ZERO: ; 16:0954, 0x02C954
    LDA OBJ_DATA_A,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set attrs from.
    LDA OBJ_DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
OBJ_DATA_A: ; 16:0961, 0x02C961
    .db 00
OBJ_DATA_B: ; 16:0962, 0x02C962
    .db 00
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
    .db E0
    .db FE
    .db 20
    .db 01
OBJ_DATA_A: ; 16:096D, 0x02C96D
    .db 00
OBJ_DATA_B: ; 16:096E, 0x02C96E
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
    .db 00
    .db 00
    .db 20
    .db FF
    .db E0
    .db 00
RANGER: ; 16:0979, 0x02C979
    JSR XPOS_RTN_RET_?? ; Do.
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$10 ; If _ #$10
    BCC EXIT_MIN ; <, goto.
    CMP #$F0 ; If _ #$F0
    BCC EXIT_INRANGE ; <, goto.
    LDA #$F0 ; Seed highest.
    BNE EXIT_STORE ; != 0, goto.
EXIT_MIN: ; 16:098B, 0x02C98B
    LDA #$10 ; Seed pos.
EXIT_STORE: ; 16:098D, 0x02C98D
    STA OBJ_POS_X?[18],X ; Store.
EXIT_INRANGE: ; 16:0990, 0x02C990
    RTS ; Leave.
MOVE/RANGE: ; 16:0991, 0x02C991
    JSR MOVE_UNK_RET_?? ; Do.
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$78 ; If _ #$78
    BCC EXIT_MIN ; <, goto.
    CMP #$E4 ; If _ #$E4
    BCC RTS ; <, goto.
    LDA #$E4 ; Set attr.
    BNE EXIT_WRITE
EXIT_MIN: ; 16:09A3, 0x02C9A3
    LDA #$78 ; Seed min.
EXIT_WRITE: ; 16:09A5, 0x02C9A5
    STA OBJ_POS_X??[18],X ; Store val.
RTS: ; 16:09A8, 0x02C9A8
    RTS ; Leave.
L_16:09A9: ; 16:09A9, 0x02C9A9
    INC STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA OBJECT_DATA_HEALTH?[18],X
    BNE 16:09CD
    LDY #$0A
    CPX #$07
    BEQ 16:09B9
    LDY #$07
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    CMP #$05
    LDA #$06
    STA OBJECT_DATA_HEALTH?[18],X
    BCS 16:09CD
    LDA #$00
    STA OBJECT_DATA_HEALTH?[18],X
    JMP 16:0A77
    JSR XOBJ_WRITE_PLAYER_FOCUS
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    AND #$20
    BEQ 16:09EE
    LDA #$18
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA OBJECT_DATA_HEALTH?[18],X
    CMP #$06
    BCS 16:09ED
    LDA #$06
    STA OBJECT_DATA_HEALTH?[18],X
    RTS
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$18
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    BMI ATTR_HELPER_BLINK/WHICH
    LDY OBJECT_DATA_HEALTH?[18],X
    CPY #$06
    BCS ATTR_HELPER_BLINK/WHICH
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    ORA #$80
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    JSR 16:0BCF
    CPX #$07
    BNE ATTR_HELPER_BLINK/WHICH
    LDA #$00
    STA 711_UNK
    LDA #$14
    STA OBJECT_DATA_HEALTH?[18],X
ATTR_HELPER_BLINK/WHICH: ; 16:0A22, 0x02CA22
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1, *2.
    LDA #$B2 ; Load
    ADC #$00 ; Add if carry.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    LDA #$BF ; Attr.
    LDY 710_BOSS_WHICH_HIT? ; Load which.
    STA ZP_R2-R5_BANK_VALUES+2,Y ; Store GFX.
    RTS ; Leave.
RTN_A: ; 16:0A36, 0x02CA36
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BMI NEGATIVE ; If negative, goto.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    LSR A ; >> 2, /4.
    LSR A
    NOP ; Do nothing. Mistake but only because not removed.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep  1111.1100
    BCC SHIFT_CC ; CC, goto.
    ORA #$02 ; Set bit.
SHIFT_CC: ; 16:0A4F, 0x02CA4F
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store attr.
    RTS ; Leave.
NEGATIVE: ; 16:0A53, 0x02CA53
    LDA #$20
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Set pair attr.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    CMP #$10 ; If _ #$10
    BCC LT_0x10 ; <, goto.
    LDA #$10
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
LT_0x10: ; 16:0A64, 0x02CA64
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do.
    JSR COUNTER_RANDOMNESS_BAD ; Do.
    AND #$07 ; Keep bits.
    BNE LIKELY ; 7 in 8 to do.
    JMP SET_SEC/TERT_SWITCHES_HOLD_EXTRA_HELPER ; 1 in 8 to move.
LIKELY: ; 16:0A71, 0x02CA71
    JSR SET_STEP/HOLD/GFX_HELPER ; Do.
    JMP STATE_HELPER ; Goto, abuse RTS.
    CPX #$07
    BEQ 16:0ABC
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    JSR ATTR_HELPER_BLINK/WHICH
    LDA #$80
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
RTN_A: ; 16:0A98, 0x02CA98
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE HOLD_NONZERO ; != 0, goto.
    JMP KILL_THREE_OBJECTS_BASE_START ; Goto.
HOLD_NONZERO: ; 16:0AA5, 0x02CAA5
    JSR ATTR_HELPER_BLINK/WHICH ; Do.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    AND #$08 ; Test bit.
    BNE RTS ; != 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT?
    LSR A ; >> 1
    NOP ; Mistake because not gone. Seems to be to hold space for more if needed.
    NOP
    BCC RTS ; <, goto.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Don't display.
RTS: ; 16:0ABB, 0x02CABB
    RTS
    LDX #$0A
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    BEQ 16:0AE1
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$05
    BCS 16:0AE1
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    JSR ATTR_HELPER_BLINK/WHICH
    LDA #$80
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDX #$07
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y
    AND #$40
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDY #$00
    ASL A
    BMI 16:0B04
    LDY #$02
    LDA 16:0B34,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA 16:0B35,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA 16:0B38
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 16:0B39
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JSR 16:0002
    LDA #$B5
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$BF
    LDY 710_BOSS_WHICH_HIT?
    STA ZP_R2-R5_BANK_VALUES+2,Y
    LDA #$E0
    STA 4C6_OBJ_UNK[18],X
    JMP MOVE_Y_FINALIZE
    BRK
    INC SPRITE_PAGE[256],X
    BRK
    ???
RTN_B: ; 16:0B3A, 0x02CB3A
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR RANGER ; Do.
    LDA #$18 ; Val.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCC VAL_NEG ; Negative, goto.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move when positive.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear attr.
    LDA #$10
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
VAL_NEG: ; 16:0B56, 0x02CB56
    JMP MOVE_Y_FINALIZE ; Goto.
RTN_C: ; 16:0B59, 0x02CB59
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BNE VAL_NE_ZERO ; != 0, goto.
    JMP RANGER ; Goto, abuse RTS.
VAL_NE_ZERO: ; 16:0B66, 0x02CB66
    LDA #$01
    STA 3DB_UNKNOWN ; Set.
    JSR SOUND_RESET/INIT_RTN? ; Reset sound.
    LDA #$7E
    JSR SND_BANKED_DISPATCH ; Play sound.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$96
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attr.
RTS: ; 16:0B7B, 0x02CB7B
    RTS ; Leave.
RTN_D: ; 16:0B7C, 0x02CB7C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BNE RTS ; != 0, leave.
    LDA #$00
    STA 708_UNK ; Clear vals.
    STA 709_UNK_CB_INDEX ; No more CB updates.
    LDA #$FF
    STA 5F8_OBJ_SETS_UNK ; Set.
    JMP KILL_TWO_PAIRS_NOT_SELF ; Goto, abuse RTS.
KILL_THREE_OBJECTS_BASE_START: ; 16:0B96, 0x02CB96
    JSR INIT_OBJECT[X]_DATA_FULL
KILL_TWO_PAIRS_NOT_SELF: ; 16:0B99, 0x02CB99
    INX ; Pair
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    INX ; Next pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Back to original.
    DEX
    RTS ; Leave.
OBJ_STATE_0x6F_HANDLER: ; 16:0BA4, 0x02CBA4
    LDA #$B4
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_DIE
    LDA #$40 ; Val.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCC EXIT_MOVE? ; Ret CC, goto.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear attrs.
    STA 4D8_OBJ_UNK[18],X
    LDA ROM_VAL_A ; Move from ROM to attrs.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA ROM_VAL_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
EXIT_MOVE?: ; 16:0BC9, 0x02CBC9
    JMP MOVE_Y_FINALIZE ; Goto.
EXIT_DIE: ; 16:0BCC, 0x02CBCC
    JMP INIT_OBJECT[X]_DATA_FULL ; Dies.
    INX
    INX
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD
    LDA #$6F
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y
    AND #$FC
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    LDA OBJ_POS_X?[18],Y
    STA TMP_00
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$40
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    LDA L_16:0C37,Y
    CLC
    ADC TMP_00
    STA OBJ_POS_X?[18],X
    LDA L_16:0C38,Y
    CLC
    ADC 4C6_OBJ_UNK[18],X
    STA 4C6_OBJ_UNK[18],X
    LDA L_16:0C39,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA L_16:0C3A,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA L_16:0C33
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA L_16:0C34
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA OBJ_SECONDARY_SWITCH?[18],X
    JSR MOVE_Y_FINALIZE
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    RTS
L_16:0C33: ; 16:0C33, 0x02CC33
    .db 00
L_16:0C34: ; 16:0C34, 0x02CC34
    .db FC
ROM_VAL_A: ; 16:0C35, 0x02CC35
    .db 00
ROM_VAL_B: ; 16:0C36, 0x02CC36
    .db FD
L_16:0C37: ; 16:0C37, 0x02CC37
    .db 08
L_16:0C38: ; 16:0C38, 0x02CC38
    .db D0
L_16:0C39: ; 16:0C39, 0x02CC39
    .db 00
L_16:0C3A: ; 16:0C3A, 0x02CC3A
    .db 02
    .db F8
    .db D0
    .db 00
    .db FE
OBJ_STATE_0x4D_HANDLER: ; 16:0C3F, 0x02CC3F
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save to scratch.
    LDA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Load pair.
    BEQ PAIR_EQ_ZERO ; == 0, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; --
PAIR_EQ_ZERO: ; 16:0C4A, 0x02CC4A
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load
    BEQ PAIR_EQ_ZERO_B ; == 0, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; --
PAIR_EQ_ZERO_B: ; 16:0C52, 0x02CC52
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    BEQ PAIR_EQ_ZERO_C ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; --, goto.
PAIR_EQ_ZERO_C: ; 16:0C5A, 0x02CC5A
    LDA #$12
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR ODD_MULTISWITCH ; Switch.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    BEQ PAIR_VAL_ZERO ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
PAIR_VAL_ZERO: ; 16:0C75, 0x02CC75
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store result.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load new.
    CPY #$FF ; If _ #$FF
    BNE HEALTH_NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store prev.
HEALTH_NE_0xFF: ; 16:0C85, 0x02CC85
    LDA TMP_00 ; Load TMP.
    LSR A ; >> 1, /2.
    BCS DONT_LEAVE_YET ; Shifted off val, goto.
RTS: ; 16:0C8A, 0x02CC8A
    RTS ; Leave.
DONT_LEAVE_YET: ; 16:0C8B, 0x02CC8B
    JMP L_16:11FA ; Goto.
STATE/ANIM_HELPER: ; 16:0C8E, 0x02CC8E
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$40
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim stuff.
    LDA #$7A
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS ; Leave.
GRP_F_RTN_A: ; 16:0CA3, 0x02CCA3
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE RTS ; != 0, leave.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set disp.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
RTS: ; 16:0CBF, 0x02CCBF
    RTS ; Leave.
GRP_F_RTN_B: ; 16:0CC0, 0x02CCC0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCS GTE_0x04 ; >=, goto.
RTS: ; 16:0CD9, 0x02CCD9
    RTS ; Leave.
GTE_0x04: ; 16:0CDA, 0x02CCDA
    JSR INIT_OBJECT[X]_DATA_FULL ; Clear obj.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Clear.
    DEX ; Back to base obj.
EXIT: ; 16:0CE2, 0x02CCE2
    JMP OBJ_REMOVE_FROM_GROUP_ARRAY ; Goto.
ODD_MULTISWITCH: ; 16:0CE5, 0x02CCE5
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    ASL A ; << 1, *2.
    TAY ; To index.
    LDA PTR_GRP_L,Y ; Move ptr.
    STA TMP_00
    LDA PTR_GRP_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_02 ; Move to ZP.
    INY ; Stream++
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_03 ; Move to ZP.
    JMP [TMP_02] ; Goto rtn.
PTR_GRP_L: ; 16:0D05, 0x02CD05
    LOW(PTR_GRP_A) ; PTR table.
PTR_GRP_H: ; 16:0D06, 0x02CD06
    HIGH(PTR_GRP_A)
    LOW(PTR_GRP_B)
    HIGH(PTR_GRP_B)
    LOW(PTR_GRP_C)
    HIGH(PTR_GRP_C)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_E)
    HIGH(PTR_GRP_E)
    LOW(PTR_GRP_F)
    HIGH(PTR_GRP_F)
PTR_GRP_A: ; 16:0D11, 0x02CD11
    LOW(GRP_A_RTN_A)
    HIGH(GRP_A_RTN_A)
PTR_GRP_B: ; 16:0D13, 0x02CD13
    LOW(GRP_B_RTN_A)
    HIGH(GRP_B_RTN_A)
    LOW(GRP_B_RTN_B) ; Sus code, lol.
    HIGH(GRP_B_RTN_B)
    LOW(GRP_B_RTN_C)
    HIGH(GRP_B_RTN_C)
PTR_GRP_C: ; 16:0D19, 0x02CD19
    LOW(GRP_C_RTN_A)
    HIGH(GRP_C_RTN_A)
    LOW(GRP_C_RTN_B)
    HIGH(GRP_C_RTN_B)
    LOW(GRP_C_RTN_C)
    HIGH(GRP_C_RTN_C)
PTR_GRP_D: ; 16:0D1F, 0x02CD1F
    LOW(GRP_D_RTN_A)
    HIGH(GRP_D_RTN_A)
PTR_GRP_E: ; 16:0D21, 0x02CD21
    LOW(GRP_E_RTN_A)
    HIGH(GRP_E_RTN_A)
PTR_GRP_F: ; 16:0D23, 0x02CD23
    LOW(GRP_F_RTN_A)
    HIGH(GRP_F_RTN_A)
    LOW(GRP_F_RTN_B)
    HIGH(GRP_F_RTN_B)
GRP_A_RTN_A: ; 16:0D27, 0x02CD27
    LDA #$CE
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$CF
    STA ZP_R2-R5_BANK_VALUES+3
    LDY #$1D
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$4E
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$08
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim hold.
    JSR ANIM_SOLVER_HELPER ; Anim.
    JSR MOVE_Y_FINALIZE ; Goto Yobj.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    AND #$02 ; Keep bit.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Manip.
    INC 716_UNK ; ++
    LDA 716_UNK ; Load
    AND #$01 ; Keep bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr with.
    JSR ADD_OBJ_TO_717-719_ARRS ; Do.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If handling _ 719
    BNE NOT_SLOT_719 ; !=, goto.
    LDA #$02
    STA OBJECT_DATA_EXTRA_B?+1,X ; Set pair val.
NOT_SLOT_719: ; 16:0D6B, 0x02CD6B
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
GRP_B_RTN_A: ; 16:0D6F, 0x02CD6F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
GRP_B_RTN_B: ; 16:0D78, 0x02CD78
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$01
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set attr.
VAL_NONZERO: ; 16:0D87, 0x02CD87
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Move attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    .db FE ; INC XOBJ.tert. Not marked because of label in middle of inst.
    .db 8C
OBJ_DATA_A: ; 16:0D97, 0x02CD97
    .db 05
OBJ_DATA_B: ; 16:0D98, 0x02CD98
    .db 60 ; Leave.
    .db 00 ; Data used from data labels. Wtf is this lol.
    .db FF
    .db 00
    .db 01
GRP_B_RTN_C: ; 16:0D9D, 0x02CD9D
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR ANIM_SOLVER_HELPER ; Solve anim.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_CLEAR_FLAG ; CS, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE RTS ; != 0, leave.
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$28 ; If _ #$28
    BCC RTS ; <, leave.
    CMP #$D8 ; If _ #$28
    BCS RTS ; >=, leave.
    JSR STATE_MOVE_HELPER_S0x02_T0x01 ; Do.
EXIT_CLEAR_FLAG: ; 16:0DC0, 0x02CDC0
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear.
RTS: ; 16:0DC5, 0x02CDC5
    RTS ; Leave.
ANIM_SOLVER_HELPER: ; 16:0DC6, 0x02CDC6
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL HOLD_POSITIVE
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
HOLD_POSITIVE: ; 16:0DD3, 0x02CDD3
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Get step.
    AND #$01 ; Keep bit.
    TAY ; To Y index.
    LDA ANIM_DATA_ARR,Y ; Load anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set.
    RTS ; Leave.
ANIM_DATA_ARR: ; 16:0DE0, 0x02CDE0
    .db 72
    .db 73
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$20
    STA OBJECT_DATA_HEALTH?+1,X
RTS: ; 16:0DF1, 0x02CDF1
    RTS
GRP_C_RTN_A: ; 16:0DF2, 0x02CDF2
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJECT_DATA_HEALTH?+1,X ; Pair health?
    BNE RTS ; != 0, leave. Move state if so.
STATE_MOVE_HELPER_S0x02_T0x01: ; 16:0DFC, 0x02CDFC
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
GRP_C_RTN_B: ; 16:0E07, 0x02CE07
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    JSR XOBJ_TO_717_SLOTS_CC_FAIL_CS_OKAY ; To slot.
    JSR FIND_GROUP_SLOT_XOBJ_IN
    JSR SLOT_MATTERS_HIT_DETECT/ATTRS? ; Do.
    JSR RTN_BOX_DETECT? ; Do.
    LDA TMP_11 ; Load
    CMP #$08 ; If _ #$08
    BCC LT_0x08 ; <, goto.
    JMP 16:0E81 ; Goto.
LT_0x08: ; 16:0E1F, 0x02CE1F
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load pair.
    BNE PAIR_NONZERO ; != 0, goto.
    LDA TMP_10 ; Load
    CMP #$20 ; If _ #$20
    BCS PAIR_NONZERO ; >=, goto.
    JMP 16:0EB2 ; Goto.
PAIR_NONZERO: ; 16:0E2D, 0x02CE2D
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    ASL A ; << 1, *2.
    BNE VAL_NONZERO ; != 0, goto. Very rare to run this code.
    ROL A ; << 1.
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Eor val.
    LSR A ; >> 1.
    BCS VAL_NONZERO ; Carry set, still do nothing. Half odds of chance.
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$01 ; Keep bit.
    BNE VAL_NONZERO ; If set, still skip.
    LDA TMP_10 ; Load val.
    CMP #$30 ; If _ #$30
    BCS GTE_0x30 ; >=, goto.
    BCC LT_0x30 ; <, goto.
VAL_NONZERO: ; 16:0E48, 0x02CE48
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$DC ; If _ #$DC
    BCC LT_0xDC ; <, goto.
    JMP ENTRY_Y_0x02 ; Goto.
LT_0xDC: ; 16:0E52, 0x02CE52
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$24 ; If _ #$24
    BCS GTE_0x24 ; >=, goto.
    JMP ENTRY_Y_0x04 ; Goto.
GTE_0x24: ; 16:0E5C, 0x02CE5C
    JMP 16:0E81 ; Goto.
GTE_0x30: ; 16:0E5F, 0x02CE5F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Yobj from.
    LDA OBJ_POS_X?[18],X ; Load
    CMP OBJ_POS_X?[18],Y ; If _ other OBJ.
    BCC LT_OTHER_OBJECT ; <, goto.
    JMP ENTRY_Y_0x02 ; Entry.
LT_OTHER_OBJECT: ; 16:0E6D, 0x02CE6D
    JMP ENTRY_Y_0x04 ; Entry.
LT_0x30: ; 16:0E70, 0x02CE70
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from.
    LDA OBJ_POS_X?[18],X ; Load from.
    CMP OBJ_POS_X?[18],Y ; If _ Other obj.
    BCS ALT_ENTRY ; >=, goto.
    JMP ENTRY_Y_0x02 ; Goto.
ALT_ENTRY: ; 16:0E7E, 0x02CE7E
    JMP ENTRY_Y_0x04 ; Goto.
    CPX OBJ_INDEXES_GROUP_UNK+2
    BNE 16:0EA3
    LDA OBJ_POS_X_DELTA?[18],X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BNE 16:0EA3
    INC OBJECT_DATA_EXTRA_B?+1,X
    LDA OBJECT_DATA_EXTRA_B?+1,X
    CMP #$08
    BCC 16:0EA3
    LDA #$02
    STA OBJECT_DATA_EXTRA_B?+1,X
    JSR MOVE?_AND_RANGE_OBJ
    JSR RTN_MOVE/POS_UNK
    JSR ANIM_SOLVER_HELPER
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
    JMP MOVE_Y_FINALIZE
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_HEALTH?+1,X
    RTS
GRP_D_RTN_A: ; 16:0EC2, 0x02CEC2
    INC OBJECT_DATA_HEALTH?+1,X ; Pair++
    LDY OBJECT_DATA_HEALTH?+1,X ; Load from pair.
    CPY #$14 ; If _ #$14
    BCS GTE_0x14
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load val.
    AND #$07 ; Keep 0000.0111
    BNE SKIP_MOVE ; 1 in 8 chance to not take.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; << 2, 84.
    ASL A
    LDA #$FF ; Seed val.
    BCC USE_VAL
    LDA #$00 ; Seed other.
USE_VAL: ; 16:0EDD, 0x02CEDD
    ADC OBJ_POS_X?[18],X ; Add to.
    STA OBJ_POS_X?[18],X ; Store.
SKIP_MOVE: ; 16:0EE3, 0x02CEE3
    LDA #$77 ; Val.
    CPY #$09 ; If Y _ #$09
    BCC USE_AS_ANIM ; <, goto.
    LDA #$78 ; Val.
    CPY #$0E ; If _ #$0E
    BCS USE_AS_ANIM ; >=, goto.
    LDA #$B8
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$78 ; Val.
USE_AS_ANIM: ; 16:0EF6, 0x02CEF6
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
GTE_0x14: ; 16:0EFA, 0x02CEFA
    LDA #$28
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Set pair attr.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Move state.
ADD_OBJ_TO_717-719_ARRS: ; 16:0F02, 0x02CF02
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load
    BNE OCCUPADO_A ; Occupied.
    STX OBJ_INDEXES_GROUP_UNK[3] ; Save to slot.
    RTS ; Leave.
OCCUPADO_A: ; 16:0F0B, 0x02CF0B
    LDA OBJ_INDEXES_GROUP_UNK+1 ; Load
    BNE OCCUPADO_B ; Occupied.
    STX OBJ_INDEXES_GROUP_UNK+1 ; Save to slot.
    RTS ; Lave.
OCCUPADO_B: ; 16:0F14, 0x02CF14
    STX OBJ_INDEXES_GROUP_UNK+2 ; Save to.
    RTS ; Leave.
FIND_GROUP_SLOT_XOBJ_IN: ; 16:0F18, 0x02CF18
    LDY #$00 ; Obj start?
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If _ Slot[0]
    BEQ Y_TO_VAR ; ==, goto.
    INY ; Obj++
    CPX OBJ_INDEXES_GROUP_UNK+1 ; Compare to other slot.
    BEQ Y_TO_VAR ; ==, goto.
    INY ; Obj++
Y_TO_VAR: ; 16:0F26, 0x02CF26
    STY A/B_WHICH_RESULT ; Which slot matched to here.
    RTS ; Leave.
OBJ_REMOVE_FROM_GROUP_ARRAY: ; 16:0F2A, 0x02CF2A
    LDA #$00 ; Clear val.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Slot
    BNE CHECK_XOBJ_SLOT[1] ; !=, goto.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
    RTS ; Leave.
CHECK_XOBJ_SLOT[1]: ; 16:0F35, 0x02CF35
    CPX OBJ_INDEXES_GROUP_UNK+1 ; If Xobj _ Slot
    BNE CHECK_XOBJ_SLOT[0] ; !=, goto.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; Load other.
    BNE CLEAR_SLOT[2]_STORE_SLOT[1] ; != 0, goto. Move down.
    LDY OBJ_INDEXES_GROUP_UNK[3] ; Load from Slot[0]
    BEQ CLEAR_SLOT_0x01 ; == 0, goto.
    STY OBJ_INDEXES_GROUP_UNK+1 ; Store to slot[1]
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear slot[0]
    JMP RTS ; Leave. Bad code, just RTS here.
CLEAR_SLOT_0x01: ; 16:0F4D, 0x02CF4D
    STA OBJ_INDEXES_GROUP_UNK+1 ; Clear
    RTS
CLEAR_SLOT[2]_STORE_SLOT[1]: ; 16:0F51, 0x02CF51
    STY OBJ_INDEXES_GROUP_UNK+1 ; Store to slot[1]
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot[2]
    JMP RTS ; Leave. Bad code, just RTS here.
CHECK_XOBJ_SLOT[0]: ; 16:0F5A, 0x02CF5A
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If  Xobj _ Slot[0]
    BNE RTS ; !=, leave.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; Load from slot.
    BNE CLEAR_SLOT[2]_STORE_SLOT[0] ; Has val, goto. Move down.
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear slot no move.
    RTS
CLEAR_SLOT[2]_STORE_SLOT[0]: ; 16:0F68, 0x02CF68
    STY OBJ_INDEXES_GROUP_UNK[3] ; Obj move down.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
RTS: ; 16:0F6E, 0x02CF6E
    RTS ; Leave.
XOBJ_TO_717_SLOTS_CC_FAIL_CS_OKAY: ; 16:0F6F, 0x02CF6F
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Slot
    BNE RET _CC ; !=, goto.
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load slot.
    BEQ XOBJ_TO_717 ; == 0, goto.
    LDA OBJ_INDEXES_GROUP_UNK+1 ; Load slot.
    BNE RET _CC ; Slot nonzero, goto.
    STX OBJ_INDEXES_GROUP_UNK+1 ; Xobj to slot.
    JMP CLEAR_719_RTS_CS
XOBJ_TO_717: ; 16:0F84, 0x02CF84
    STX OBJ_INDEXES_GROUP_UNK[3] ; X to slot.
CLEAR_719_RTS_CS: ; 16:0F87, 0x02CF87
    LDA #$00
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
    SEC ; CS RTS.
    RTS
RET _CC: ; 16:0F8E, 0x02CF8E
    CLC ; CC RTS.
    RTS
OBJ_STATE_0x4E_HANDLER: ; 16:0F90, 0x02CF90
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; From Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; To handling.
    LDA OBJ_POS_Y??+17,X
    STA OBJ_POS_X?[18],X ; To handling.
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_X??[18],X ; To handling.
    STA OBJ_POS_Y??[18],X ; To this also.
    LDA #$00 ; Prep val.
    LDY 4B4_OBJ_SPEED?+17,X ; Load
    BPL ANIM_SEEDED ; If positive, skip reseed.
    LDA #$04 ; Reseed value.
ANIM_SEEDED: ; 16:0FAE, 0x02CFAE
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    RTS
OBJ_STATE_0x4F_HANDLER: ; 16:0FB2, 0x02CFB2
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG ; Do.
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$B9
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 2, /4.
    LSR A
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    RTS ; Leave.
EXIT_OBJ_DESTROY: ; 16:0FD1, 0x02CFD1
    JMP INIT_OBJECT[X]_DATA_FULL ; Init.
ENTRY_Y_0x00: ; 16:0FD4, 0x02CFD4
    LDY #$00
    JMP INDEX_SEEDED
ENTRY_Y_0x02: ; 16:0FD9, 0x02CFD9
    LDY #$02
    JMP INDEX_SEEDED
ENTRY_Y_0x04: ; 16:0FDE, 0x02CFDE
    LDY #$04
INDEX_SEEDED: ; 16:0FE0, 0x02CFE0
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attrs.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    CLC ; Prep add.
    LDA #$FB ; -= 5 signed.
    ADC 4C6_OBJ_UNK[18],X ; Add to.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Clear pair hold.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Clear pair step.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
OBJ_DATA_C: ; 16:1014, 0x02D014
    .db 00
OBJ_DATA_D: ; 16:1015, 0x02D015
    .db FC
OBJ_DATA_A: ; 16:1016, 0x02D016
    .db 00
OBJ_DATA_B: ; 16:1017, 0x02D017
    .db 00
    .db 00
    .db FE
    .db 00
    .db 02
GRP_C_RTN_C: ; 16:101C, 0x02D01C
    JSR MOVE?_AND_RANGE_OBJ
    LDA #$18
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Move.
    BCS RET_CS ; CS, goto.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    INC OBJ_ANIM_HOLD_TIMER?+1,X ; Hold pair.
    JSR PAIR_HOLD_TIMEOUT_RTN ; Do.
    LDA #$74 ; Anim val.
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Y from pair.
    BEQ PAIR_STEP_0x00 ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; --
    LDA #$75 ; Alt anim.
PAIR_STEP_0x00: ; 16:103B, 0x02D03B
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
RET_CS: ; 16:1041, 0x02D041
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear attr.
    JSR MOVE_Y_FINALIZE ; Do.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Move state.
PAIR_HOLD_TIMEOUT_RTN: ; 16:104C, 0x02D04C
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load hold.
    CMP #$23 ; If _ #$23
    BEQ PAIR_HOLD_TIMEOUT ; ==, goto.
    RTS ; Leave if not.
PAIR_HOLD_TIMEOUT: ; 16:1054, 0x02D054
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Do.
    BCS OBJ_RECEIVED ; Received, goto.
    JMP EXIT_XOBJ_RESTORE ; Leave, none available.
OBJ_RECEIVED: ; 16:105C, 0x02D05C
    LDA #$0D
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Obj from scratch. Bad code/mistake, not used and destroyed.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from new obj. TODO: Mistake?
    TAY ; To Yobj.
    LDA OBJ_POS_X?[18],Y ; Load from Yobj.
    STA TMP_0C ; Store to.
    LDA OBJ_POS_Y??[18],Y ; Load from Yobj.
    STA TMP_0D ; Store to.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y from.
    LDA #$07
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,Y ; Set pair step.
    LDA OBJ_POS_X?[18],Y ; Load from handling.
    STA TMP_00 ; Save.
    LDA OBJ_POS_X??[18],Y ; Move from handling to new.
    STA OBJ_POS_X??[18],X
    INC OBJ_POS_X??[18],X ; Inc new.
    LDA 4C6_OBJ_UNK[18],Y ; Load handling.
    STA TMP_02 ; Save.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load handling.
    ASL A ; << 2, *4.
    ASL A
    LDA #$00 ; Seed vals.
    LDY #$00
    BCC SHIFT_CC ; CC, goto.
    LDY #$02 ; Alt vals.
    ORA #$40
SHIFT_CC: ; 16:109C, 0x02D09C
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to new.
    CLC ; Prep add.
    LDA OBJ_MOD_A,Y ; Load val.
    ADC TMP_00 ; Add with saved.
    STA OBJ_POS_X?[18],X ; Store to new.
    CLC ; Prep add.
    LDA OBJ_MOD_B,Y ; Load val.
    ADC TMP_02 ; Add with saved.
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    JSR MOVE_Y_FINALIZE ; Move new.
    LDA OBJ_POS_X?[18],X ; Load new.
    STA TMP_0E ; Store to.
    LDA OBJ_POS_Y??[18],X ; Load new.
    STA TMP_0F ; Store to.
    LDY #$03 ; Val?
    JSR 16:129B ; Do ??
    CLC ; Prep add.
    ADC #$02 ; Add with.
    LSR A ; >> 2, /4.
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Load from index.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set new attrs.
    LDA TMP_08
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move from TMP to new.
    LDA TMP_09
    STA OBJ_POS_X_DELTA?[18],X
    LDA TMP_0A
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_0B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_09
    LSR A ; >> 1, /2.
    EOR OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Eor with.
    ASL A ; << 1, *2.
    BMI DONT_INVERT ; Negative, goto.
    SEC ; Prep sub.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Save.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_DELTA?[18],X ; Save.
DONT_INVERT: ; 16:10FF, 0x02D0FF
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load from new.
    BPL SKIP_INVERT ; If positive, goto.
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC 544_OBJ_UNK_POS_DELTA?[18],X ; Invert.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Save.
    LDA #$00 ; Seed invert.
    SBC 532_OBJ_UNK_POS_DELTA?[18],X ; Invert.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Save.
SKIP_INVERT: ; 16:1115, 0x02D115
    LDA #$4F
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Enable state.
EXIT_XOBJ_RESTORE: ; 16:111A, 0x02D11A
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore from scratch.
    RTS ; Leave.
OBJ_MOD_A: ; 16:111E, 0x02D11E
    .db EC
OBJ_MOD_B: ; 16:111F, 0x02D11F
    .db EA
    .db 14
    .db EA
OBJ_DATA_A: ; 16:1122, 0x02D122
    .db AB
    .db 76
    .db AA
    .db 76
SLOT_MATTERS_HIT_DETECT/ATTRS?: ; 16:1126, 0x02D126
    LDA A/B_WHICH_RESULT ; Get slot caring for.
    CMP #$02 ; If _ #$02
    BNE NE_TWO ; !=, goto.
    LDA OBJECT_DATA_EXTRA_B?+1,X ; Load pair data.
NE_TWO: ; 16:1130, 0x02D130
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA TMP_DATA_A,Y ; Set up TMP.
    STA TMP_14
    LDA TMP_DATA_B,Y
    STA TMP_15
    LDA UNK_DATA,Y ; Load val.
    BNE VAL_NONZERO ; != 0, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    CLC ; Pre padd.
    LDA OBJ_POS_X?[18],Y ; Load from Yobj.
    ADC TMP_14 ; Add with.
    PHA ; Save.
    ROR A ; >> val.
    EOR TMP_14 ; Eor with.
    ASL A ; << val.
    PLA ; Pull added val.
    BCC SHIFT_CC ; CC, goto.
    ASL TMP_14 ; << 1, *2.
    LDA #$10 ; Load val.
    BCS SHIFT_CC ; Use if CS.
    LDA #$F0 ; Otherwise, this.
SHIFT_CC: ; 16:115B, 0x02D15B
    STA TMP_14 ; Store to.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA OBJ_POS_X??[18],Y ; Load from Yobj.
    STA TMP_15 ; Store to.
VAL_NONZERO: ; 16:1165, 0x02D165
    JSR HIT_DETECT_HELPER_UNK ; Help.
    LDY #$00 ; Index.
    LDA TMP_10 ; Load
    CMP #$02 ; If _ #$02
    BCC INDEX_USE ; <, goto.
    LDY #$02 ; Index.
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_14 ; If _ TMP.
    BCS INDEX_USE ; >=, goto.
    LDY #$04 ; Last index.
INDEX_USE: ; 16:117B, 0x02D17B
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move attrs from index data.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDY #$00 ; Index.
    LDA TMP_11 ; Load.
    CMP #$06 ; If _ #$06
    BCC INDEX_USE_B
    LDY #$02 ; Index.
    LDA TMP_13 ; Load val.
    BPL INDEX_USE_B ; Positive, goto.
    LDY #$04 ; Index.
INDEX_USE_B: ; 16:1197, 0x02D197
    LDA OBJ_DATA_A,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Move attrs.
    LDA OBJ_DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
OBJ_DATA_A: ; 16:11A4, 0x02D1A4
    .db 00
OBJ_DATA_B: ; 16:11A5, 0x02D1A5
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
OBJ_DATA_A: ; 16:11AA, 0x02D1AA
    .db 00
OBJ_DATA_B: ; 16:11AB, 0x02D1AB
    .db 00
    .db 60
    .db FF
    .db A0
    .db 00
UNK_DATA: ; 16:11B0, 0x02D1B0
    .db 00
    .db 00
TMP_DATA_A: ; 16:11B2, 0x02D1B2
    .db E2
TMP_DATA_B: ; 16:11B3, 0x02D1B3
    .db 00
    .db 00
    .db 00
    .db 1E
    .db 00
    .db 01
    .db 00
    .db 16
    .db A0
    .db 01
    .db 00
    .db 60
    .db E0
    .db 01
    .db 00
    .db C0
    .db B0
    .db 01
    .db 00
    .db E8
    .db B0
    .db 01
    .db 00
    .db 16
    .db E0
    .db 01
    .db 00
    .db 80
    .db B0
MOVE?_AND_RANGE_OBJ: ; 16:11D0, 0x02D1D0
    JSR XPOS_RTN_RET_?? ; Do.
    LDA #$10 ; Load
    CMP OBJ_POS_X?[18],X ; If _ attr
    BCS VAL_SEEDED ; >=, goto.
    LDA #$F0 ; Load
    CMP OBJ_POS_X?[18],X ; If _ #$F0
    BCS RTS ; >=, goto.
VAL_SEEDED: ; 16:11E1, 0x02D1E1
    STA OBJ_POS_X?[18],X ; Range.
RTS: ; 16:11E4, 0x02D1E4
    RTS ; Leave.
RTN_MOVE/POS_UNK: ; 16:11E5, 0x02D1E5
    JSR MOVE_UNK_RET_?? ; dO.
    LDA #$78 ; Seed val.
    CMP OBJ_POS_X??[18],X ; If seed _ attr
    BCS WRITE_SEED ; >, write val.
    LDA #$E4 ; Alt seed.
    CMP OBJ_POS_X??[18],X ; If seed _ attr.
    BCS RTS ; >=, leave.
WRITE_SEED: ; 16:11F6, 0x02D1F6
    STA OBJ_POS_X??[18],X ; Store val.
RTS: ; 16:11F9, 0x02D1F9
    RTS ; Leave.
L_16:11FA: ; 16:11FA, 0x02D1FA
    JSR XOBJ_WRITE_PLAYER_FOCUS
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y
    ASL A
    ASL A
    LDY #$00
    BCS 16:1215
    LDY #$02
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$BF
    BCC 16:121E
    ORA #$40
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    CLC
    LDA 4C6_OBJ_UNK[18],X
    ADC #$FB
    CMP #$81
    BCS 16:1245
    LDA #$81
    STA 4C6_OBJ_UNK[18],X
    LDA #$79
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$2B
    JMP SND_BANKED_DISPATCH
OBJ_DATA_A: ; 16:1252, 0x02D252
    .db 00
OBJ_DATA_B: ; 16:1253, 0x02D253
    .db FE
    .db 00
    .db 02
OBJ_DATA_C: ; 16:1256, 0x02D256
    .db 00
OBJ_DATA_D: ; 16:1257, 0x02D257
    .db FD
GRP_E_RTN_A: ; 16:1258, 0x02D258
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR MOVE?_AND_RANGE_OBJ ; Range.
    LDA #$20
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCS CS_RET ; Ret CS, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load attr.
    CMP #$81 ; If _ #$81
    BCS GTE_0x81 ; >=, goto.
    LDA #$81 ; Load val. Minimum.
    STA 4C6_OBJ_UNK[18],X ; Set.
GTE_0x81: ; 16:1273, 0x02D273
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJ_POS_Y??[18],X ; Load
    CMP #$40 ; If _ #$40
    BCS RTS ; >=, goto.
    LDA #$40 ; Minimum.
    STA OBJ_POS_Y??[18],X ; Set.
RTS: ; 16:1282, 0x02D282
    RTS ; Leave.
CS_RET: ; 16:1283, 0x02D283
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; CAlear.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    BNE HEALTH_NONZERO ; != 0, goto.
    JMP STATE/ANIM_HELPER ; Goto.
HEALTH_NONZERO: ; 16:1293, 0x02D293
    LDA #$10
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Set pair.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Goto.
    TYA
    PHA
    JSR TONS_OF_MATH_AND_INVERTS_TODO
    PLA
    TAY
    LDA TMP_00
    PHA
    JSR MORE_TONS_OF_CRAP
    PLA
    RTS
TONS_OF_MATH_AND_INVERTS_TODO: ; 16:12AA, 0x02D2AA
    LDY #$00
    LDA TMP_0C
    SEC
    SBC TMP_0E
    BCS 16:12B8
    EOR #$FF
    ADC #$01
    INY
    STA TMP_00
    LDA TMP_0D
    SEC
    SBC TMP_0F
    BCS 16:12C7
    EOR #$FF
    ADC #$01
    INY
    INY
    STA TMP_01
    STY TMP_04
    LDY TMP_01
    LDA TMP_00
    CMP TMP_01
    BCS 16:12D4
    TYA
    CMP #$08
    BCC 16:12E0
    LSR A
    LSR TMP_00
    LSR TMP_01
    JMP 16:12D4
    LDA TMP_01
    ASL A
    ASL A
    ASL A
    ADC TMP_00
    TAY
    LDA 16:1309,Y
    STA TMP_00
    LDY TMP_04
    INC TMP_04
    LDA TMP_04
    AND #$02
    BEQ 16:12FE
    SEC
    LDA #$08
    SBC TMP_00
    STA TMP_00
    CLC
    LDA 16:1349,Y
    ADC TMP_00
    AND #$1F
    STA TMP_00
    RTS
    .db 04
    .db 02
    .db 01
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 06
    .db 04
    .db 03
    .db 02
    .db 02
    .db 01
    .db 01
    .db 01
    .db 07
    .db 05
    .db 04
    .db 03
    .db 03
    .db 02
    .db 02
    .db 02
    .db 07
    .db 06
    .db 05
    .db 04
    .db 03
    .db 03
    .db 03
    .db 02
    .db 07
    .db 06
    .db 05
    .db 05
    .db 04
    .db 03
    .db 03
    .db 03
    .db 08
    .db 07
    .db 06
    .db 05
    .db 05
    .db 04
    .db 04
    .db 03
    .db 08
    .db 07
    .db 06
    .db 05
    .db 05
    .db 06
    .db 04
    .db 04
    .db 08
    .db 07
    .db 06
    .db 06
    .db 05
    .db 05
    .db 04
    .db 04
    .db 00
    .db 08
    .db 18
    .db 10
MORE_TONS_OF_CRAP: ; 16:134D, 0x02D34D
    PHA
    STY TMP_07
    JSR 16:13BF
    LDA TMP_00
    STA TMP_08
    LDA TMP_01
    STA TMP_09
    LDY TMP_07
    PLA
    PHA
    JSR 16:136C
    LDA TMP_00
    STA TMP_0A
    LDA TMP_01
    STA TMP_0B
    PLA
    RTS
    STY TMP_03
    LDY #$00
    STY TMP_00
    STY TMP_01
    PHA
    AND #$0F
    CMP #$08
    BNE 16:1382
    LDY TMP_03
    STY TMP_01
    JMP 16:139C
    TAY
    LDA 16:13AF,Y
    LDY #$07
    ASL TMP_00
    ROL TMP_01
    ASL TMP_03
    BCC 16:1399
    CLC
    ADC TMP_00
    STA TMP_00
    BCC 16:1399
    INC TMP_01
    DEY
    BPL 16:1388
    PLA
    AND #$10
    BEQ 16:13AE
    SEC
    LDA #$00
    SBC TMP_00
    STA TMP_00
    LDA #$00
    SBC TMP_01
    STA TMP_01
    RTS
    .db 00
    .db 32
    .db 62
    .db 8E
    .db B5
    .db D5
    .db ED
    .db FB
    .db 00
    .db FB
    .db ED
    .db D5
    .db B5
    .db 8E
    .db 62
    .db 32
    CLC
    ADC #$08
    AND #$1F
    JMP 16:136C
OBJ_STATE_0x4A_HANDLER: ; 16:13C7, 0x02D3C7
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Move attrs from Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store as diff?
    LDA OBJ_POS_Y??+17,X
    STA OBJ_POS_X?[18],X ; Store to.
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_X??[18],X ; Store to.
    STA OBJ_POS_Y??[18],X ; Also store here.
    LDA #$00 ; Anim seed.
    LDY 4B4_OBJ_SPEED?+17,X ; Load from Obj[17]
    BPL ANIMATION_SEEDED_IN_A ; Positive, no change.
    CPY #$FB ; If _ #$FB
    BCS ANIMATION_SEEDED_IN_A ; >=, goto. No change.
    LDA #$04 ; Mod seed.
ANIMATION_SEEDED_IN_A: ; 16:13E9, 0x02D3E9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    RTS ; Leave.
OBJ_STATE_0x49_HANDLER: ; 16:13ED, 0x02D3ED
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save Xobj.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load attr.
    BEQ ATTR_EQ_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
ATTR_EQ_ZERO: ; 16:13F8, 0x02D3F8
    LDA #$C2 ; Attr seed.
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Val test.
    BPL USE_A_SEED ; Positive, goto.
    LDA #$16 ; Alt attr.
USE_A_SEED: ; 16:1401, 0x02D401
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR ODD_SECONDARY_TERT_RUNNER_MULTISWITCH ; Do.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE GOTO_ATTR_THING ; != 0, goto.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ GOTO_ATTR_THING ; == 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load Xobj.
    BEQ VAL_EQ_ZERO_B ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
VAL_EQ_ZERO_B: ; 16:141F, 0x02D41F
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store result.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load attr.
    CPY #$FF ; If val _ #$FF
    BNE VAL_NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store if not.
VAL_NE_0xFF: ; 16:142F, 0x02D42F
    LSR TMP_00 ; >> 1, /2.
    BCS SHIFTED_RESULT_CS ; CS, goto.
GOTO_ATTR_THING: ; 16:1433, 0x02D433
    JMP PAIR_ATTRS_AND_HANDLING_STUFF ; Do.
SHIFTED_RESULT_CS: ; 16:1436, 0x02D436
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1, *2.
    LDA #$2B ; Val.
    BCC USE_A_VAL_SOUND ; CC, goto.
    LDA #$2C ; Alt val.
USE_A_VAL_SOUND: ; 16:1440, 0x02D440
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP LINE_BELOW ; Make sure we get there, lol.
LINE_BELOW: ; 16:1446, 0x02D446
    JSR XOBJ_WRITE_PLAYER_FOCUS ; Do.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA ROM_VAL_A ; Move attrs from ROM.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA ROM_VAL_B
    STA OBJ_POS_X_DELTA?[18],X
    LDA ROM_VAL_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA ROM_VAL_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load from Yobj.
    AND #$40 ; Keep bit.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to handled object.
    ASL A ; << 1, *2.
    BPL VAL_POSITIVE ; Positive, goto.
    SEC ; Prep sub.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Subtract, inverting.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_DELTA?[18],X ; Subtract, inverting.
    STA OBJ_POS_X_DELTA?[18],X ; Store back.
VAL_POSITIVE: ; 16:148A, 0x02D48A
    CLC ; Prep add.
    LDA #$FB ; Seed Invert +5?
    ADC 4C6_OBJ_UNK[18],X ; Add with.
    STA 4C6_OBJ_UNK[18],X ; Store back.
    LDA #$1E
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JMP PAIR_MANIP_STUFF ; Goto.
ROM_VAL_A: ; 16:149B, 0x02D49B
    .db 00
ROM_VAL_B: ; 16:149C, 0x02D49C
    .db 01
ROM_VAL_C: ; 16:149D, 0x02D49D
    .db 00
ROM_VAL_D: ; 16:149E, 0x02D49E
    .db FF
GRP_D_RTN_A: ; 16:149F, 0x02D49F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Ret CC, goto.
    ASL OBJ_POS_X?[18],X ; << Val.
    LDA #$00 ; Val.
    BCS VAL_SEEDED ; CS shifted, goto.
    LDA #$FF ; Alt val.
VAL_SEEDED: ; 16:14B2, 0x02D4B2
    STA OBJ_POS_X?[18],X ; Store val.
RET_CC: ; 16:14B5, 0x02D4B5
    LDA #$10 ; Mod.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Mod.
    BCC SKIP_STATE_MOVE ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Pair attrs clear.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BNE HEALTH_NONZERO ; Has health, skip.
    JMP NO_HEALTH_STATE_MOVE ; State swap.
HEALTH_NONZERO: ; 16:14D7, 0x02D4D7
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BMI STATE_MOVE_PORTION ; Negative, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BEQ VAL_NOW_ZERO ; == 0, goto.
STATE_MOVE_PORTION: ; 16:14E1, 0x02D4E1
    JSR STATE_MOVE+ATTR_HELPER_B
SKIP_STATE_MOVE: ; 16:14E4, 0x02D4E4
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Y from Xobj.
    BPL EXIT_MOVE ; If positive, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    LDA #$8D ; Val A.
    BCC WRITE_ANIM_VAL ; CC, goto.
    LDA #$A6 ; Alt anim.
WRITE_ANIM_VAL: ; 16:14F3, 0x02D4F3
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim
EXIT_MOVE: ; 16:14F6, 0x02D4F6
    JSR MOVE_Y_FINALIZE ; Move. Funny, as is first time this is done without a JMP to the RTN.
    RTS ; Leave.
VAL_NOW_ZERO: ; 16:14FA, 0x02D4FA
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$1B
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$8C
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim disp.
    LDA #$32
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
GRP_D_RTN_B: ; 16:150C, 0x02D50C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDY #$00 ; Index val.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$12 ; If _ #$12
    BCS INDEX_SOLVED ; >=, goto.
    INY ; Index++
    CMP #$09 ; If _ #$09
    BCS INDEX_SOLVED ; >=, goto.
    INY ; Next index.
INDEX_SOLVED: ; 16:1520, 0x02D520
    LDA OBJ_ANIM_DATA,Y ; Get anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$80 ; Set bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR STATE_MOVE+ATTR_HELPER_B ; State move.
RTS: ; 16:1536, 0x02D536
    RTS ; Leave.
OBJ_ANIM_DATA: ; 16:1537, 0x02D537
    .db 8C
    .db A0
    .db A1
NO_HEALTH_STATE_MOVE: ; 16:153A, 0x02D53A
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$8E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$20
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Entry set.
    RTS
GRP_E_RTN_A: ; 16:154F, 0x02D54F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Get attr.
    ASL A
    ASL A ; << 2, *4.
    LDA #$ED ; Val A.
    BCS CS_SHIFT ; Shifted CS, goto.
    LDA #$12 ; Alt val.
CS_SHIFT: ; 16:156E, 0x02D56E
    STA TMP_00 ; Store to.
    ADC OBJ_POS_X?[18],X ; Add with. Carry sometimes fucked?? TODO: Wtf.
    PHA ; Save.
    ROR A ; >> 1, /2.
    EOR TMP_00 ; Eor with.
    ASL A ; << 1, *2.
    PLA ; Pull val.
    BCC CC_CLEAR ; CC, goto.
    LDA #$00 ; Load
    ASL TMP_00 ; << 1.
    BCS CC_CLEAR ; Carry set shift, goto.
    LDA #$FF ; Val.
CC_CLEAR: ; 16:1583, 0x02D583
    STA OBJ_POS_X?[18],X ; Store 0x00/0xFF.
    LDA #$F6
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold it.
RTS: ; 16:1598, 0x02D598
    RTS ; Leave.
VAL_EQ_ZERO: ; 16:1599, 0x02D599
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; Positive still, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, leave.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj.
    INX ; Pair obj.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init too.
    DEX ; Fix back to base.
RTS: ; 16:15BA, 0x02D5BA
    RTS
ODD_SECONDARY_TERT_RUNNER_MULTISWITCH: ; 16:15BB, 0x02D5BB
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA PTR_GROUPS_L,Y ; Move ptr to ZP.
    STA TMP_00
    LDA PTR_GROUPS_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_02 ; Store to.
    INY ; Stream++
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_03 ; Store to.
    JMP [TMP_02] ; Goto code.
PTR_GROUPS_L: ; 16:15DB, 0x02D5DB
    LOW(PTR_GRP_A) ; Secondary for this data selection.
PTR_GROUPS_H: ; 16:15DC, 0x02D5DC
    HIGH(PTR_GRP_A)
    LOW(PTR_GRP_B)
    HIGH(PTR_GRP_B)
    LOW(PTR_GRP_C)
    HIGH(PTR_GRP_C)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_E)
    HIGH(PTR_GRP_E)
PTR_GRP_A: ; 16:15E7, 0x02D5E7
    LOW(GRP_A_RTN_A) ; Tert for these data selection.
    HIGH(GRP_A_RTN_A)
PTR_GRP_B: ; 16:15E9, 0x02D5E9
    LOW(GRP_B_RTN_A)
    HIGH(GRP_B_RTN_A)
    LOW(GRP_B_RTN_B)
    HIGH(GRP_B_RTN_B)
PTR_GRP_C: ; 16:15ED, 0x02D5ED
    LOW(GRP_C_RTN_A)
    HIGH(GRP_C_RTN_A)
    LOW(GRP_C_RTN_B)
    HIGH(GRP_C_RTN_B)
    LOW(GRP_C_RTN_C)
    HIGH(GRP_C_RTN_C)
    LOW(GRP_C_RTN_D)
    HIGH(GRP_C_RTN_D)
PTR_GRP_D: ; 16:15F5, 0x02D5F5
    LOW(GRP_D_RTN_A)
    HIGH(GRP_D_RTN_A)
    LOW(GRP_D_RTN_B)
    HIGH(GRP_D_RTN_B)
PTR_GRP_E: ; 16:15F9, 0x02D5F9
    LOW(GRP_E_RTN_A)
    HIGH(GRP_E_RTN_A)
GRP_A_RTN_A: ; 16:15FB, 0x02D5FB
    LDA #$DA
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$DB
    STA ZP_R2-R5_BANK_VALUES+3
    LDY #$1F
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$4A
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair.
    LDA #$0A
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Get val.
    AND #$02 ; Keep bit.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to obj.
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Manip.
    LDA #$02
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
GRP_B_RTN_A: ; 16:1625, 0x02D625
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE VAL_NONZERO ; != 0, goto. Bad code, could have branched around store.
    LDA #$01 ; Set if zero.
VAL_NONZERO: ; 16:162F, 0x02D62F
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store val.
    LSR A ; >> 1, /2. Carry important.
    LDA #$20 ; Seed val.
    BCS SHIFTED_SET_OFF_A ; Carry was set, goto.
    LDA #$E0 ; Seed other val.
SHIFTED_SET_OFF_A: ; 16:1639, 0x02D639
    STA OBJ_POS_X?[18],X ; Store attr.
    LDA #$00 ; Other vals.
    BCS SHIFTED_SET_OFF_B ; Same shift check.
    LDA #$40 ; Alt val.
SHIFTED_SET_OFF_B: ; 16:1642, 0x02D642
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    EOR #$01 ; Invert bit.
    LSR A ; >> 1, /2. To carry.
    JSR ATTR_SET_CARRY_SELECTION ; Attr set based on carry.
    JMP ATTR_SET_HELPER ; Goto, abuse RTS.
GRP_B_RTN_B: ; 16:1651, 0x02D651
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Ret CC, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear flag if CS.
RET_CC: ; 16:165B, 0x02D65B
    LDA #$20 ; Mod val.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Mod.
    BCC RET_CC_B ; Ret CC, goto.
    JSR STATE_MOVE+ATTR_HELPER_A ; Set attrs.
RET_CC_B: ; 16:1665, 0x02D665
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_10 ; If attr _ TMP
    BCC CLEAR_ATTR ; <, goto.
    CMP #$E0 ; If attr _ #$E0
    BCC SKIP_CLEAR ; <, goto.
CLEAR_ATTR: ; 16:1670, 0x02D670
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
SKIP_CLEAR: ; 16:1675, 0x02D675
    JSR ANIM_DISP_SOLVER ; Solve anim.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
ANIM_DISP_SOLVER: ; 16:167B, 0x02D67B
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    AND #$01 ; Keep bit.
    ASL A ; << 2, *4.
    ASL A
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    BPL ATTR_POSITIVE ; Positive, goto.
    ORA #$02 ; Set bit.
ATTR_POSITIVE: ; 16:1689, 0x02D689
    LDY 4C6_OBJ_UNK[18],X ; Load attr.
    BPL OR_BIT ; Of positive, set bit and use.
    CPY #$FC ; If attr _ #$FC
    BCC ANIM_VAL_SOLVED ; <, goto.
OR_BIT: ; 16:1692, 0x02D692
    ORA #$01 ; Set bit.
ANIM_VAL_SOLVED: ; 16:1694, 0x02D694
    TAY ; A to index.
    LDA ANIM_DISP,Y ; Load data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
ANIM_DISP: ; 16:169C, 0x02D69C
    .db 84 ; Anims.
    .db 85
    .db 88
    .db 89
    .db 86
    .db 87
    .db 8A
    .db 8B
GRP_C_RTN_A: ; 16:16A4, 0x02D6A4
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BEQ HOLD_EQ_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE HOLD_NONZERO ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
HOLD_NONZERO: ; 16:16B3, 0x02D6B3
    JMP EXIT_ANIM ; Goto.
HOLD_EQ_ZERO: ; 16:16B6, 0x02D6B6
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Do.
    JSR RTN_MOVE/POS_UNK ; Do.
    JSR INVERT_RTN_UNK ; Do.
    LDA #$20
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCC EXIT_ANIM ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear.
    JSR FOCUS_FIND_SEED_0x80 ; Focus on something.
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Shift maybe.
    BCS EXIT_ANIM ; True, goto.
    JSR COUNTER_RANDOMNESS_BAD ; Do.
    AND #$03 ; Test bits. Random.
    BNE BITS_SET ; !=, either set, goto.
    JSR STATE_MOVE+ATTR_HELPER_B ; Do rtn.
    JMP EXIT_ANIM ; Exit.
BITS_SET: ; 16:16DE, 0x02D6DE
    JSR STATE_MOVE+ATTR_SET[/FROM_STATE] ; Do.
EXIT_ANIM: ; 16:16E1, 0x02D6E1
    JSR ANIM_DISP_SOLVER ; Solve anim disp.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
STATE_MOVE+ATTR_HELPER_B: ; 16:16EA, 0x02D6EA
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
ATTR_SET_HELPER: ; 16:16F9, 0x02D6F9
    LDA ATTR_ROM_A ; Load from ROM.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; To obj.
    LDA ATTR_ROM_B ; Load from ROM.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; To obj.
    RTS ; Leave.
ATTR_ROM_A: ; 16:1706, 0x02D706
    .db 00
ATTR_ROM_B: ; 16:1707, 0x02D707
    .db FB
CLEAR_ATTRS_HELPER_1708: ; 16:1708, 0x02D708
    LDA #$00
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    RTS
STATE_MOVE+ATTR_SET[/FROM_STATE]: ; 16:1711, 0x02D711
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; State move.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA ROM_VAL_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    LDA ROM_VAL_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JMP ATTR_FROM_STATE_HELPER ; Goto.
ROM_VAL_A: ; 16:172F, 0x02D72F
    .db 00
ROM_VAL_B: ; 16:1730, 0x02D730
    .db FC
GRP_C_RTN_B: ; 16:1731, 0x02D731
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load attr
    BEQ ATTR_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NONZERO: ; 16:1740, 0x02D740
    JMP JMP_EXIT_ANIM ; Goto.
ATTR_ZERO: ; 16:1743, 0x02D743
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Attr set.
    JSR RTN_MOVE/POS_UNK ; Do.
    JSR INVERT_RTN_UNK ; Do.
    LDA #$20
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCC JMP_EXIT_ANIM ; Ret CC, exit.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    JSR FOCUS_FIND_SEED_0x80 ; Focus
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Maybe switch.
    BCS JMP_EXIT_ANIM ; Switched, goto.
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$03 ; Keep bits.
    BEQ EXIT_STATE_MOVE ; == 0, neither set, goto.
    JSR STATE_MOVE+ATTR_SET[/FROM_STATE] ; Do sub.
    JMP JMP_EXIT_ANIM ; Goto.
EXIT_STATE_MOVE: ; 16:176B, 0x02D76B
    JSR STATE_MOVE+ATTR_HELPER_A ; Do.
JMP_EXIT_ANIM: ; 16:176E, 0x02D76E
    JMP EXIT_ANIM ; Goto.
STATE_MOVE+ATTR_HELPER_A: ; 16:1771, 0x02D771
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA ROM_DATA_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    LDA ROM_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold anim.
    RTS ; Leave.
ROM_DATA_A: ; 16:178D, 0x02D78D
    .db 00
ROM_DATA_B: ; 16:178E, 0x02D78E
    .db FB
GRP_C_RTN_C: ; 16:178F, 0x02D78F
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BEQ HOLD_EQ_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE ATTR_SET_UNK ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
ATTR_SET_UNK: ; 16:179E, 0x02D79E
    LDA #$FD
    STA 4C6_OBJ_UNK[18],X ; Set ??
    RTS ; Leave.
HOLD_EQ_ZERO: ; 16:17A4, 0x02D7A4
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Attr set.
    JSR RTN_MOVE/POS_UNK ; Do.
    LDA #$20 ; Load.
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Move with val.
    BCC EXIT_ANIM ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    JSR FOCUS_FIND_SEED_0x80 ; Focus.
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Shift maybe.
    BCS EXIT_ANIM ; Shifted, leave.
    JSR COUNTER_RANDOMNESS_BAD ; Randomness.
    AND #$01 ; On bit.
    BEQ BIT_UNSET
    JSR STATE_MOVE+ATTR_HELPER_A ; Move state.
    JMP EXIT_ANIM ; Exit.
BIT_UNSET: ; 16:17C9, 0x02D7C9
    JSR STATE_MOVE+ATTR_HELPER_B ; Move state.
EXIT_ANIM: ; 16:17CC, 0x02D7CC
    JMP EXIT_ANIM ; Goto.
GRP_C_RTN_D: ; 16:17CF, 0x02D7CF
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; Hold != 0, leave.
    JSR RTN_NEW_OBJ_AND_MANY_ATTRS ; New obj thingy.
    JSR STATE_MOVE+ATTR_HELPER_B ; Attr set.
RTS: ; 16:17DA, 0x02D7DA
    RTS ; Leave.
RTN_POSSIBLY_SHIFT_STATE_CS_TRUE: ; 16:17DB, 0x02D7DB
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    LSR A ; >> 1, /2.
    BCS SHIFTED_CS ; Carry set, goto.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$28
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    SEC ; Ret CS.
    RTS
SHIFTED_CS: ; 16:17F2, 0x02D7F2
    CLC ; Ret CC.
    RTS
INVERT_RTN_UNK: ; 16:17F4, 0x02D7F4
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RTS ; Ret CC, goto.
    LDA OBJ_POS_X?[18],X ; Load attr.
    CMP #$20 ; If _ #$20
    BCC INVERT_PORTION ; <, goto.
    CMP #$E0 ; If _ #$E0
    BCC RTS ; <, leave.
INVERT_PORTION: ; 16:1804, 0x02D804
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Subtract. INverting.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_DELTA?[18],X ; Subtract.
    STA OBJ_POS_X_DELTA?[18],X ; Store inverted.
    JSR XPOS_RTN_RET_?? ; Do.
RTS: ; 16:1818, 0x02D818
    RTS ; Leave.
ATTR_FROM_STATE_HELPER: ; 16:1819, 0x02D819
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod dir.
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    PHA ; Save. Tert is base val, shifted.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    PLA ; Pull other val.
    BCC VAL_TO_INDEX ; Shift above was CC, goto.
    ORA #$02 ; Add to index.
VAL_TO_INDEX: ; 16:182C, 0x02D82C
    TAY ; To index.
ATTR_FROM_YINDEX: ; 16:182D, 0x02D82D
    LDA OBJ_DATA_A,Y ; Move attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    RTS
ATTR_SET_CARRY_SELECTION: ; 16:183A, 0x02D83A
    LDY #$00 ; P1 index.
    BCC CARRY_CLEAR
    LDY #$02 ; P2 index.
CARRY_CLEAR: ; 16:1840, 0x02D840
    JMP ATTR_FROM_YINDEX
OBJ_DATA_A: ; 16:1843, 0x02D843
    .db 00
OBJ_DATA_B: ; 16:1844, 0x02D844
    .db FF
    .db 00
    .db 01
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
ATTR_HELPER_YOBJ_CONSIDERED: ; 16:184F, 0x02D84F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
L_16:1852: ; 16:1852, 0x02D852
    LDA OBJ_POS_X??[18],Y ; A from Yobj.
    LDY #$00 ; Index seed.
    CMP OBJ_POS_X??[18],X ; If Yobj pos _ Xobj pos
    BEQ POS_MATCH ; ==, goto.
    LDY #$02 ; Alt seed.
    BCC POS_MATCH ; <, goto.
    LDY #$04 ; Alt seed.
POS_MATCH: ; 16:1862, 0x02D862
    LDA DATA_A,Y ; Move attrs.
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
DATA_A: ; 16:186F, 0x02D86F
    .db 00
DATA_B: ; 16:1870, 0x02D870
    .db 00
    .db C0
    .db FF
    .db 40
    .db 00
PAIR_MANIP_STUFF: ; 16:1875, 0x02D875
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Pair load.
    ORA #$01 ; Set bit.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Store back.
    LDA #$40
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Set pair val.
PAIR_ATTRS_AND_HANDLING_STUFF: ; 16:1882, 0x02D882
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load from pair.
    BEQ RTS ; == 0, goto.
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; pair--
    BEQ PAIR_NOW_ZERO_EXTENSION ; == 0, goto.
NEGATIVE_SET: ; 16:188C, 0x02D88C
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA TMP_00 ; Store to.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    LSR A ; >> 2, /4.
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Get data.
    ORA TMP_00 ; Set bottom randomly.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store.
RTS: ; 16:18A2, 0x02D8A2
    RTS ; Leave.
PAIR_NOW_ZERO_EXTENSION: ; 16:18A3, 0x02D8A3
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    AND #$80 ; Keep 1000.0000
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Store back.
    BMI NEGATIVE_SET ; If negative, go back into.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    RTS ; Leave.
OBJ_DATA: ; 16:18B6, 0x02D8B6
    .db 03
    .db 01
    .db 03
    .db 02
OBJ_STATE_0x4C_HANDLER: ; 16:18BA, 0x02D8BA
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Move from Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA OBJ_POS_Y??+17,X
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_X??[18],X
    STA OBJ_POS_Y??[18],X
    LDA #$04
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
OBJ_STATE_0x4B_HANDLER: ; 16:18D5, 0x02D8D5
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Load
    BEQ DANGLED_RTS ; == 0, goto.
    DEY ; Mod Yobj.
    BEQ YOBJ_DEC_ZERO ; == 0 now, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim disp.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, leave.
    JSR FOCUS_OBJ_MANIP_STUFF ; Manip.
RTS: ; 16:18F4, 0x02D8F4
    RTS ; Leave.
NOT_ENABLED: ; 16:18F5, 0x02D8F5
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Anim disp.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    RTS ; Leave.
DANGLED_RTS: ; 16:190A, 0x02D90A
    RTS ; RTS again, just to be sure, lol.
YOBJ_DEC_ZERO: ; 16:190B, 0x02D90B
    LDA #$C1
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR L_16:1932 ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load from Xobj.
    BPL RTS ; If positive, leave.
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X
    JSR OBJ_RTN_UNK_RET_VAL_UNK
    AND #$03
    BEQ RTS
    LSR A
    LDA #$2A
    BCS L_16:192B
    LDA #$2A
L_16:192B: ; 16:192B, 0x02D92B
    JSR SND_BANKED_DISPATCH
    JSR NOT_ENABLED
RTS: ; 16:1931, 0x02D931
    RTS
L_16:1932: ; 16:1932, 0x02D932
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Yobj from Xobj.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Yobj.
    BNE YOBJ_ENABLED ; != 0, state enabled.
    JMP NOT_ENABLED ; Goto, not enabled.
YOBJ_ENABLED: ; 16:193D, 0x02D93D
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; --
    BMI TIMER_NEGATIVE ; If negative, goto.
    JMP TIMER_NOT_NEGATIVE ; Goto, not negative.
TIMER_NEGATIVE: ; 16:1945, 0x02D945
    LDA #$04 ; Obj to focus.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set timer.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Set on Yobj also.
    TAY ; Obj to index.
    LDA OBJ_POS_X?[18],Y ; Load from obj.
    STA TMP_0C ; Save.
    LDA OBJ_POS_X?[18],X ; Load from Xobj.
    STA TMP_0E ; Save.
    SEC ; Prep sub.
    LDA 4C6_OBJ_UNK[18],Y ; Load from obj.
    SBC #$18 ; Subtract.
    BMI VAL_NEGATIVE ; Result negative.
    LDA #$80 ; Seed val. Highest.
VAL_NEGATIVE: ; 16:1965, 0x02D965
    STA TMP_0D ; Store result.
    LDA 4C6_OBJ_UNK[18],X ; Load
    STA TMP_0F ; Store to.
    JSR TONS_OF_MATH_AND_INVERTS_TODO ; Do..
    SEC ; Prep sub.
    SBC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Subtract with.
    BPL VAL_POSITIVE ; If positive, goto.
    CLC ; Prep add.
    ADC #$20 ; Add with.
    AND #$1F ; Keep 0001.1111
VAL_POSITIVE: ; 16:197A, 0x02D97A
    TAY ; To Y index.
    BEQ VAL_ZERO ; == 0, goto.
    CMP #$10 ; If _ #$10
    LDA #$FE ; Val seed.
    BCS L_16:1985 ; >=, goto.
    LDA #$01 ; Alt seed.
L_16:1985: ; 16:1985, 0x02D985
    ADC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Add with Xobj.
    AND #$1F ; Keep 0001.1111
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store back.
VAL_ZERO: ; 16:198D, 0x02D98D
    LDY #$02 ; Seed val.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JSR MORE_TONS_OF_CRAP ; Do.
    LDA TMP_08 ; Load
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set.
    LDA TMP_09 ; Load
    STA OBJ_POS_X_DELTA?[18],X ; Set.
    LDA TMP_0A ; Load
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set.
    LDA TMP_0B ; Load
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set.
TIMER_NOT_NEGATIVE: ; 16:19A9, 0x02D9A9
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Returned CC, goto.
    JMP FOCUS_OBJ_MANIP_STUFF ; Do.
RET_CC: ; 16:19B1, 0x02D9B1
    JSR MOVE_UNK_RET_CS_POS_CS_NEG ; Do.
    LDY 4C6_OBJ_UNK[18],X ; Y from Xobj.
    LDA #$08 ; Val seed.
    CPY #$08 ; If Y _ #$08
    BCC RANGE_VAL ; <, goto.
    LDA #$F8 ; Other val.
    CPY #$F8 ; If Y _ #$F8
    BCC DONT_RANGE_VAL ; <, goto.
RANGE_VAL: ; 16:19C3, 0x02D9C3
    STA 4C6_OBJ_UNK[18],X
DONT_RANGE_VAL: ; 16:19C6, 0x02D9C6
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; A from Yobj.
    TAY ; Val to index.
    JSR L_16:1852 ; Todo.
    JSR MOVE_UNK_RET_??
    LDA 4C6_OBJ_UNK[18],X
    BMI L_16:19F8
    SEC
    LDA OBJ_POS_X??[18],X
    SBC #$80
    BCC L_16:1A15
    STA TMP_00
    SEC
    LDA #$80
    SBC 4C6_OBJ_UNK[18],X
    EOR #$FF
    CLC
    ADC #$01
    CLC
    ADC TMP_00
    BCC L_16:1A15
    STA OBJ_POS_Y??[18],X
    JMP L_16:1A01
L_16:19F8: ; 16:19F8, 0x02D9F8
    CLC
    ADC OBJ_POS_X??[18],X
    BCC L_16:1A15
    STA OBJ_POS_Y??[18],X
L_16:1A01: ; 16:1A01, 0x02DA01
    JSR L_16:1A1B
    LDA OBJ_POS_X_DELTA?[18],X
    ASL A
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    AND #$BF
    BCS L_16:1A11
    ORA #$40
L_16:1A11: ; 16:1A11, 0x02DA11
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    RTS
L_16:1A15: ; 16:1A15, 0x02DA15
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
L_16:1A1B: ; 16:1A1B, 0x02DA1B
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL L_16:1A28
    LDA #$04
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
L_16:1A28: ; 16:1A28, 0x02DA28
    CLC
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    ADC #$02
    LSR A
    LSR A
    AND #$07
    TAY
    LDA DATA_A,Y
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LSR A
    LDA DATA_B,Y
    ADC #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
DATA_B: ; 16:1A46, 0x02DA46
    .db 8F
    .db A2
    .db A4
    .db A2
    .db 8F
    .db A2
    .db A4
    .db A2
DATA_A: ; 16:1A4E, 0x02DA4E
    .db 40
    .db C0
    .db 80
    .db 80
    .db 00
    .db 00
    .db 00
    .db 40
FOCUS_OBJ_MANIP_STUFF: ; 16:1A56, 0x02DA56
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj. TODO: Solve more.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    AND #$FE ; Keep 1111.1110
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load
    EOR #$02 ; Invert 0000.0010
    AND #$02 ; Keep 0000.0010
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Store back.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Xobj to scratch.
    TYA ; Yobj to A...
    TAX ; ...A to Xobj. Y->X
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Manip.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Reload X.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Back to base obj.
    RTS ; Leave.
RTN_NEW_OBJ_AND_MANY_ATTRS: ; 16:1A7F, 0x02DA7F
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$01 ; Set.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Get obj pair.
    BCS EXIT_RESTORE_XOBJ_SCRATCHPAD ; Fail, goto.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Get focus obj in Y.
    TYA ; Yobj to A.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set focus of new obj to handled.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; A from handled.
    STA TMP_00 ; To TMP.
    LDA #$4B
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set new state.
    LDA #$4C
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set new health.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y ; Load handled attr.
    AND #$40 ; Keep bit.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to new.
    ASL A ; << 2, *4.
    ASL A
    LDA #$FA ; Load val.
    BCC SHITED_CLEAR
    LDA #$06 ; Alt val.
SHITED_CLEAR: ; 16:1AB7, 0x02DAB7
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],Y ; Add to handled.
    STA OBJ_POS_X?[18],X ; Store to new.
    LDA OBJ_POS_X??[18],Y ; Load handled.
    STA OBJ_POS_X??[18],X ; Store to new.
    CLC ; Prep add.
    LDA #$E4 ; Load
    LDY TMP_00 ; Load saved.
    BMI SAVED_NEGATIVE ; Negative, use val.
    LDA #$E5 ; Alt val.
SAVED_NEGATIVE: ; 16:1ACD, 0x02DACD
    ADC 4C6_OBJ_UNK[18],Y ; Add to handled.
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load from new.
    ASL A ; << 2, *4.
    ASL A
    LDA #$00 ; Val.
    BCS SHIFTED_CS
    LDA #$10 ; Alt val.
SHIFTED_CS: ; 16:1ADE, 0x02DADE
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDY #$00 ; Index.
    BCC SHIFTED_CC ; CC, goto.
    LDY #$02 ; Index alt.
SHIFTED_CC: ; 16:1AE7, 0x02DAE7
    LDA DATA_A,Y ; Move attrs from index data.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$04
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set attr.
    LDA #$14
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$25
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_RESTORE_XOBJ_SCRATCHPAD: ; 16:1B07, 0x02DB07
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Get obj from scratchpad.
    RTS ; Leave.
    .db FC
    .db 04
    .db FC
    .db 04
DATA_A: ; 16:1B0F, 0x02DB0F
    .db C0
DATA_B: ; 16:1B10, 0x02DB10
    .db FF
    .db 40
    .db 00
OBJ_STATE_0x70_HANDLER: ; 16:1B13, 0x02DB13
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save obj.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$05 ; If _ #$05
    BEQ SECONDARY_EQ_0x05 ; ==, goto.
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load pair secondary.
    BNE PAIR_SECONDARY_NONZERO ; != 0, goto.
    LDA #$32
    STA 59E_OBJ_UNK/EXTRA_TIMER+2,X ; Set attr for next group..hmm..
    JMP NEXT_GRP_EQ_ZERO ; Goto.
PAIR_SECONDARY_NONZERO: ; 16:1B2A, 0x02DB2A
    LDA 59E_OBJ_UNK/EXTRA_TIMER+2,X ; Load next group.
    BEQ NEXT_GRP_EQ_ZERO ; == 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$03 ; Keep bits.
    BNE NEXT_GRP_EQ_ZERO ; 3 in 4, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER+2,X ; --. 1 in 4.
NEXT_GRP_EQ_ZERO: ; 16:1B38, 0x02DB38
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BEQ ATTR_EQ_ZERO ; == 0, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; -- otherwise.
ATTR_EQ_ZERO: ; 16:1B40, 0x02DB40
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ SECONDARY_EQ_0x05 ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; -- otherwise.
SECONDARY_EQ_0x05: ; 16:1B48, 0x02DB48
    LDA #$13
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR RTN_MULTISWITCH ; Do switch.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ DATA_EQ_ZERO ; == 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load
    BEQ ATTR_EQ_ZERO_B ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
ATTR_EQ_ZERO_B: ; 16:1B63, 0x02DB63
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store result.
    PLA ; Pull health saved.
    LDY OBJECT_DATA_HEALTH?[18],X ; Pull new.
    CPY #$FF ; If _ #$FF
    BNE NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store saved if !=
NE_0xFF: ; 16:1B73, 0x02DB73
    LDA TMP_00 ; Load
    LSR A ; >> 1
    BCS BIT_WAS_SET ; If set, goto.
DATA_EQ_ZERO: ; 16:1B78, 0x02DB78
    JMP IDK_TODO_UGH_GET_ME_OUT_OF_THESE_OBJS_T.T ; Data depends on script runtime. Stuff.
BIT_WAS_SET: ; 16:1B7B, 0x02DB7B
    LDA #$2F
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP DIED? ; Goto.
RTN_MULTISWITCH: ; 16:1B83, 0x02DB83
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ASL A
    TAY
    LDA FILE_PTRS_L,Y ; Move file ptr to TMP.
    STA TMP_00
    LDA FILE_PTRS_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X
    ASL A
    TAY
    LDA [TMP_00],Y ; Load rtn ptr from file ptr.
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02] ; Run code ptr.
FILE_PTRS_L: ; 16:1BA3, 0x02DBA3
    LOW(FILE_A)
FILE_PTRS_H: ; 16:1BA4, 0x02DBA4
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
FILE_A: ; 16:1BAF, 0x02DBAF
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_B: ; 16:1BB1, 0x02DBB1
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_C: ; 16:1BB5, 0x02DBB5
    LOW(RTN_A)
    HIGH(RTN_A)
    LOW(RTN_B)
    HIGH(RTN_B)
FILE_D: ; 16:1BB9, 0x02DBB9
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_E: ; 16:1BBB, 0x02DBBB
    LOW(RTN_A)
    HIGH(RTN_A)
FILE_F: ; 16:1BBD, 0x02DBBD
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
    LOW(RTN_F)
    HIGH(RTN_F)
RTN_A: ; 16:1BC9, 0x02DBC9
    LDY #$1E ; Palette.
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear vars.
    STA 704_OBJ_USE_UNK
    STA 706_UNK
    LDA #$71
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$72
    STA OBJ_ENABLED_STATE+MORE?+2,X ; Set pair + 1 state.
    LDA #$50
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$02 ; Even/odd at random.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set as focus.
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; And then focus anyway? lol.
    LDA #$40
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    LDA #$B0
    STA OBJ_POS_X?[18],X
    LDA #$C1
    STA OBJ_POS_X??[18],X
    JSR MOVE_Y_FINALIZE ; Do.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Never stored. Mistake. lol.
    RTS ; Leave.
RTN_A: ; 16:1C0B, 0x02DC0B
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC 544_OBJ_UNK_POS_DELTA?[18],X ; --
    BNE RTS ; != 0, leave.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attrs.
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    TAY ; Y = 0x00.
    LDA #$01
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs to val.
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_DATA,Y ; Load.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$60
    JSR SND_BANKED_DISPATCH ; Play sound.
RTS: ; 16:1C37, 0x02DC37
    RTS ; Leave.
RTN_B: ; 16:1C38, 0x02DC38
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    JSR SET_GFX+ANIM_HELPER ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL VAL_POSITIVE ; If positive, goto.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE VAL_POSITIVE ; != 0, goto.
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Y from.
    LDA OBJ_DATA,Y ; Y from data.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to.
    INC 544_OBJ_UNK_POS_DELTA?[18],X ; ++
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    CMP #$06 ; If _ #$06
    BEQ VAL_EQ_0x06 ; ==, goto.
VAL_POSITIVE: ; 16:1C66, 0x02DC66
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    LSR A ; >> 1, /2.
    BCC RTS ; Even, leave.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear on odd. Flashing, probably.
RTS: ; 16:1C71, 0x02DC71
    RTS ; Leave.
VAL_EQ_0x06: ; 16:1C72, 0x02DC72
    LDA #$00
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Clear attrs.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JSR HELP_STATE_SEC/TERT_0x02/0x01 ; Do.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
OBJ_DATA: ; 16:1C89, 0x02DC89
    .db 1E
    .db 0F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
GFX/ANIM_HELPER: ; 16:1C8F, 0x02DC8F
    LDA #$D0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$D1
    STA ZP_R2-R5_BANK_VALUES+3
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1. Important later.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE ; Hold positive, goto.
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
HOLD_POSITIVE: ; 16:1CA8, 0x02DCA8
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    AND #$03 ; Keep bits.
    BCC SHIFTED_CLEAR ; Shift above 0x0, goto.
    ORA #$04 ; Set if was set.
SHIFTED_CLEAR: ; 16:1CB1, 0x02DCB1
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Load from data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to anim.
    RTS ; Leave.
SET_GFX+ANIM_HELPER: ; 16:1CB9, 0x02DCB9
    LDA #$D0
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$D1
    STA ZP_R2-R5_BANK_VALUES+3
    LDA #$C2
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
OBJ_DATA: ; 16:1CC7, 0x02DCC7
    .db C2
    .db C3
    .db C4
    .db C3
    .db C5
    .db C6
    .db C7
    .db C6
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$20
    STA OBJECT_DATA_HEALTH?+2,X
RTS: ; 16:1CDE, 0x02DCDE
    RTS
RTN_A: ; 16:1CDF, 0x02DCDF
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJECT_DATA_HEALTH?+2,X ; --
    BNE RTS ; != 0, goto.
HELP_STATE_SEC/TERT_0x02/0x01: ; 16:1CE9, 0x02DCE9
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set state.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
RTN_B: ; 16:1CF4, 0x02DCF4
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    LDA #$00
    STA A/B_WHICH_RESULT ; Clear.
    JSR SLOT_MATTERS_HIT_DETECT/ATTRS? ; Do.
    JSR RTN_BOX_DETECT? ; Do.
    LDA TMP_11 ; Load
    CMP #$10 ; If _ #$10
    BCC VAL_LT_0x10
    JMP EXIT ; Goto otherwise.
VAL_LT_0x10: ; 16:1D0B, 0x02DD0B
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BNE VAL_SET ; != 0, goto.
    LDA TMP_10 ; Load
    CMP #$40 ; If _ #$40
    BCS VAL_SET ; >=, goto.
    JMP SWITCH/DIRECTION/OTHER_HELPER ; Do.
VAL_SET: ; 16:1D19, 0x02DD19
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    BCS EXIT ; Shifted 0x1, goto. 50% chance to not catch.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    BNE EXIT ; != 0, goto. 255 in 256.
    JSR NEW_OBJ_THINGY ; 1 in 256 to do.
EXIT: ; 16:1D26, 0x02DD26
    JSR MOVE?_AND_RANGE_OBJ ; Do subs.
    JSR RTN_MOVE/POS_UNK
    JSR GFX/ANIM_HELPER
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
SWITCH/DIRECTION/OTHER_HELPER: ; 16:1D35, 0x02DD35
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_HEALTH?+2,X ; Set obj+2 health.
    JMP SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Goto, abuse RTS.
RTN_A: ; 16:1D47, 0x02DD47
    LDA #$D2
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$D1
    STA ZP_R2-R5_BANK_VALUES+3
    INC OBJECT_DATA_HEALTH?+2,X ; ++
    LDY OBJECT_DATA_HEALTH?+2,X ; Y from.
    CPY #$14 ; If _ #$14
    BCS SIMPLER_RTN
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$07 ; Keep 0000.0111
    BNE BITS_SET ; 15 in 16 to take.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    LDA #$FF ; Val.
    BCC SHIFTED_0x0
    LDA #$00 ; Alt val.
SHIFTED_0x0: ; 16:1D6A, 0x02DD6A
    ADC OBJ_POS_X?[18],X ; Add with.
    STA OBJ_POS_X?[18],X ; Store back.
BITS_SET: ; 16:1D70, 0x02DD70
    LDA #$00 ; Val A.
    CPY #$06 ; If _ #$06
    BCC VAL_FOUND ; <, goto.
    BNE VAL_NE ; != 0x06, goto.
    LDA #$17
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NE: ; 16:1D7D, 0x02DD7D
    LDA #$01 ; Val B.
    CPY #$09 ; If _ #$09
    BCC VAL_FOUND ; <, goto.
    CPY #$0E ; If _ #$0E
    BCS VAL_FOUND ; >=, goto.
    LDA #$BC
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$01 ; Val B.
VAL_FOUND: ; 16:1D8E, 0x02DD8E
    STA TMP_00 ; Store.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$01 ; Keep bit.
    ASL A ; << 1, *2.
    ORA TMP_00 ; Set other bit from decided above.
    TAY ; To index.
    LDA OBJ_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store from data.
    RTS ; Leave.
SIMPLER_RTN: ; 16:1DA0, 0x02DDA0
    LDA #$32
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    JSR FOCUS_FIND_SEED_0x80 ; Do.
    JMP HELP_STATE_SEC/TERT_0x02/0x01 ; Goto.
OBJ_DATA: ; 16:1DAB, 0x02DDAB
    .db CC
    .db CD
    .db CE
    .db CF
BLINK_EXTENDED?: ; 16:1DAF, 0x02DDAF
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    ORA #$01 ; Set attr.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store back.
    LDA #$1C
    STA 704_OBJ_USE_UNK ; Set. TODO: Meaning.
IDK_TODO_UGH_GET_ME_OUT_OF_THESE_OBJS_T.T: ; 16:1DBC, 0x02DDBC
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load. TODO: Blinky boss code? Idk.
    BEQ RTS ; == 0, leave.
    DEC 704_OBJ_USE_UNK ; --
    BEQ VAL_NOW_ZERO ; == 0, goto.
REENTER: ; 16:1DC6, 0x02DDC6
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA TMP_00 ; Store to.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load.
    LSR A ; >> 2
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Load data.
    ORA TMP_00 ; Set with cleared bits.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store to.
RTS: ; 16:1DDC, 0x02DDDC
    RTS ; Leave.
VAL_NOW_ZERO: ; 16:1DDD, 0x02DDDD
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    AND #$80 ; Keep only bit.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store back.
    BMI REENTER ; Goto if negative.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    RTS ; Leave.
OBJ_DATA: ; 16:1DF0, 0x02DDF0
    .db 03
    .db 01
    .db 03
    .db 02
DIED?: ; 16:1DF4, 0x02DDF4
    JSR XOBJ_WRITE_PLAYER_FOCUS ; Focus.
    LDA #$00
    STA OBJ_POS_X_DELTA?[18],X ; Clear attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA 503_OBJ_POS_X_LARGEST?[18],X
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BNE HEALTH_NONZERO ; != 0, goto.
    JMP 17:0276 ; Goto.
HEALTH_NONZERO: ; 16:1E0D, 0x02DE0D
    CMP #$18 ; If _ #$18
    BCS HEALTH_GTE_0x18 ; >=, goto.
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    BMI HEALTH_GTE_0x18 ; If negative, goto.
    ORA #$80 ; Set bit.
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Store to.
    BNE SKIP_SUB ; Always taken.
HEALTH_GTE_0x18: ; 16:1E1D, 0x02DE1D
    JSR BLINK_EXTENDED? ; Do.
SKIP_SUB: ; 16:1E20, 0x02DE20
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switch.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
SET_GFX/ANIM_HELPER: ; 16:1E2F, 0x02DE2F
    LDA #$D2
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$D1 ; GFX Bank.
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Load switch.
    CPY #$05 ; If _ #$05
    BNE BANK_KEEP
    LDA #$D3 ; Alt bank.
BANK_KEEP: ; 16:1E3E, 0x02DE3E
    STA ZP_R2-R5_BANK_VALUES+3 ; Set GFX.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1
    LDA #$D0 ; Anim val.
    BCC ANIM_KEEP
    LDA #$D1 ; Alt anim val.
ANIM_KEEP: ; 16:1E4A, 0x02DE4A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
RTN_A: ; 16:1E4E, 0x02DE4E
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, leave.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    LDA #$10
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    JSR HELP_STATE_SEC/TERT_0x02/0x01 ; Do.
RTS: ; 16:1E65, 0x02DE65
    RTS ; Leave.
OBJ_STATE_0x72_HANDLER: ; 16:1E66, 0x02DE66
    LDA OBJ_ANIMATION_DISPLAY+17,X
    BEQ ANIM_SEEDED ; Goto, abuse RTS.
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Load
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store to.
    LDA OBJ_POS_Y??+17,X ; Load
    STA OBJ_POS_X?[18],X ; Store to.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; Load
    STA OBJ_POS_X??[18],X ; Store to.
    DEC OBJ_POS_X??[18],X ; Load
    STA OBJ_POS_Y??[18],X ; Store to.
    LDA #$04 ; Seed alt.
ANIM_SEEDED: ; 16:1E85, 0x02DE85
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store.
    RTS ; Leave.
OBJ_STATE_0x71_HANDLER: ; 16:1E89, 0x02DE89
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    BEQ RTS ; == 0, leave.
    JSR RTN_SWITCH ; Do.
    LDA OBJ_ANIMATION_DISPLAY+17,X ; Load -1 secondary.
    CMP #$05 ; If _ #$05
    BNE -1PAIR_SECONDARY_NE_0x05 ; !=, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC ATTR_HELPERS ; <, goto.
-1PAIR_SECONDARY_NE_0x05: ; 16:1E9F, 0x02DE9F
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$03 ; If _ #$03
    BCS RTS ; >=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE RTS ; != 0, goto.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    BEQ RTS ; == 0, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BPL RTS ; If positive, goto.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, goto.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do sub only if the stars align.
RTS: ; 16:1EBD, 0x02DEBD
    RTS ; Leave.
RTN_SWITCH: ; 16:1EBE, 0x02DEBE
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(RTS) ; STATE_0x71_SUBSWITCH_A, an RTS.
    HIGH(RTS)
    LOW(STATE_0x71_SUBSWITCH_B)
    HIGH(STATE_0x71_SUBSWITCH_B)
    LOW(STATE_0x71_SUBSWITCH_B)
    HIGH(STATE_0x71_SUBSWITCH_B)
    LOW(STATE_0x71_SUBSWITCH_C)
    HIGH(STATE_0x71_SUBSWITCH_C)
    LOW(STATE_0x71_SUBSWITCH_D)
    HIGH(STATE_0x71_SUBSWITCH_D)
    LOW(STATE_0x71_SUBSWITCH_E)
    HIGH(STATE_0x71_SUBSWITCH_E)
ATTR_HELPERS: ; 16:1ED0, 0x02DED0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set attr.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00 ; I wanna smash my haid against the table with all these LDA #$00's!
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear attr.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    RTS ; Leave.
STATE_0x71_SUBSWITCH_D: ; 16:1EED, 0x02DEED
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC 4C6_OBJ_UNK[18],X ; ++
    BEQ EXIT_MOVE ; == 0, goto.
    JSR MOVE_Y_FINALIZE ; Do.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL HOLD_POSITIVE ; Positive, goto.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Move step.
HOLD_POSITIVE: ; 16:1F07, 0x02DF07
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    LSR A ; >> 1, /2.
    LDA #$D2 ; Val.
    BCC SHIFTED_0x0
    LDA #$D3 ; Alt val.
SHIFTED_0x0: ; 16:1F11, 0x02DF11
    STA OBJ_ANIMATION_DISPLAY[18],X ; Disp.
    RTS ; Leave.
EXIT_MOVE: ; 16:1F15, 0x02DF15
    JSR MOVE_Y_FINALIZE ; dO.
    LDA #$30
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set attr.
    LDA #$D4
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
STATE_0x71_SUBSWITCH_E: ; 16:1F26, 0x02DF26
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE RTS ; != 0, not done yet, goto.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JMP RTS ; Goto leave, lol. Ugh.
VAL_EQ_ZERO: ; 16:1F3D, 0x02DF3D
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, goto.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Reset hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Disp++
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, leave.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init, gone.
RTS: ; 16:1F54, 0x02DF54
    RTS ; Leave.
STATE_0x71_SUBSWITCH_B: ; 16:1F55, 0x02DF55
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$02 ; If _ #$02
    BEQ SECOND_SWITCH ; ==, goto. 2nd switch entry.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE SECOND_SWITCH ; != 0, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    BNE SECOND_SWITCH ; != 0, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    BEQ SET_SECONDARY
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BNE SECOND_SWITCH ; != 0, goto.
SET_SECONDARY: ; 16:1F6F, 0x02DF6F
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
SECOND_SWITCH: ; 16:1F74, 0x02DF74
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BEQ ATTR_EQ_ZERO ; == 0, goto.
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; ++
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    CMP #$FA ; If _ #$FA
    BCC LT_0xFA ; <, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear attr.
    LDA #$FA
    STA OBJ_POS_X?[18],X ; Set attr.
ATTR_EQ_ZERO: ; 16:1F8D, 0x02DF8D
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Clear attr.
LT_0xFA: ; 16:1F92, 0x02DF92
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; --
    BMI VAL_NEGATIVE ; Negative, goto.
    JMP Y_EQ_ZERO ; Goto otherwise.
VAL_NEGATIVE: ; 16:1F9A, 0x02DF9A
    LDA #$04
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set attr.
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Y from
    CPY #$02 ; If _ #$02
    BNE VAL_NE_0x02 ; !=, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE VAL_NE_0x02 ; != 0, goto.
    LDA OBJ_POS_Y??+17,X ; Load -1pair attr.
    STA TMP_0C ; Store to.
    LDA #$AB
    STA TMP_0D ; Seed attr.
    LDA OBJ_POS_X?[18],X ; Load
    STA TMP_0E ; Store to.
    LDA 4C6_OBJ_UNK[18],X ; Load
    STA TMP_0F ; Store to.
    JMP L_17:0012 ; Goto.
VAL_NE_0x02: ; 16:1FC1, 0x02DFC1
    LDY 5C2_OBJ_DATA_PTR/MISC_INDEX+17,X ; Y from. -1 pair OBJ_DATA_PTR/MISC_INDEX
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; A from.
    BEQ VAL_EQ_ZERO
    CMP #$01 ; If _ #$01
    BEQ VAL_EQ_0x01 ; ==, goto.
    BNE ALT ; Always taken.
VAL_EQ_ZERO: ; 16:1FCF, 0x02DFCF
    LDA OBJ_POS_X?[18],Y ; Load  Yobj.
    STA TMP_0C ; Store to.
    LDA OBJ_POS_X?[18],X ; Load
    STA TMP_0E ; Store to.
    JMP IDK_CODE ; Goto.
VAL_EQ_0x01: ; 16:1FDC, 0x02DFDC
    SEC ; Prep sub.
    LDA OBJ_POS_X?[18],X ; Load
    SBC OBJ_POS_X?[18],Y ; Sub from other obj.
    BCC NO_UNDERFLOW ; Underflow
    LDA #$F0 ; Seed val.
NO_UNDERFLOW: ; 16:1FE7, 0x02DFE7
    STA TMP_0E ; Store val.
    LDA #$00
    STA TMP_0C ; Clear val.
    JMP IDK_CODE ; Goto.
ALT: ; 16:1FF0, 0x02DFF0
    SEC ; Prep sub.
    LDA OBJ_POS_X?[18],Y ; Load
    SBC OBJ_POS_X?[18],X ; Sub with.
    BCC NO_UNDERFLOW
    LDA #$F0 ; Seed val.
NO_UNDERFLOW: ; 16:1FFB, 0x02DFFB
    STA TMP_0C ; Store val.
    LDA #$00
    STA TMP_0E ; Clear val.

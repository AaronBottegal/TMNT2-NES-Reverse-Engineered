    .db 2A
TERTIARY_RTN_A: ; 0A:0001, 0x014001
    JSR OBJ_UNK_RET_CC_SUCCESS? ; Compare OBJX
    BCC RTN_A_FINALIZE ; Ret CC, goto.
    LDA TMP_02 ; Load State != Timer?
    BNE RTN_A_FINALIZE ; If any, goto.
    LDA TWO_PLAYERS_FLAG ; Test 2P
    BEQ NOT_2P
    LDY LEVEL/SCREEN_ON ; Load level.
    LDA LEVEL_DATA_2P_UNK,Y ; Load
    CLC
    ADC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Add to OBJ.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Store back.
NOT_2P: ; 0A:001A, 0x01401A
    LDA 5FA_UNK ; Load
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to obj.
    LDA #$00
    STA 5FA_UNK ; Clear these.
    STA 95_UNK
    STA 96_UNK
    INC OBJ_TERTIARY_SWITCH?[18],X ; Obj next.
RTN_A_FINALIZE: ; 0A:002C, 0x01402C
    JMP OBJECT_X_MOVE? ; Do rtn.
LEVEL_DATA_2P_UNK: ; 0A:002F, 0x01402F
    .db 02
    .db 02
    .db 02
    .db 03
    .db 03
    .db 03
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
OBJ_STATE_0x23_HANDLER: ; 0A:003A, 0x01403A
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load from object.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on.
    LOW(SWITCH_RTN_A) ; Probs this one, lol.
    HIGH(SWITCH_RTN_A)
SWITCH_RTN_A: ; 0A:0042, 0x014042
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load other from obj.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on.
    LOW(TERTIARY_RTN_A) ; Setup+move?
    HIGH(TERTIARY_RTN_A)
    LOW(TERTIARY_RTN_B) ; Object forward.
    HIGH(TERTIARY_RTN_B)
    LOW(TERTIARY_RTN_C) ; Timer to go back to switch 2.
    HIGH(TERTIARY_RTN_C)
TERTIARY_RTN_B: ; 0A:004E, 0x01404E
    CLC ; Prep add.
    LDA 95_UNK ; Load
    ADC #$01 ; += 1
    STA 95_UNK ; Store back.
    LDA 96_UNK ; Load
    ADC #$00 ; Overflow to.
    STA 96_UNK ; Store back.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load from obj.
    BNE OBJ_UNK_NONZERO ; Nonzero, goto.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; If val
    BEQ OBJ_DATA_B_ZERO ; == 0, goto.
    JSR FIND_SINGLE_YOBJ_NOT_SAME_AS_NEXT_TO_RET_CC_SUCCESS ; Do sub.
    BCC RTS_MOVE ; Found, leave.
    LDA 5FA_UNK ; Load
    BNE OBJ_DATA_B_ZERO ; If set, don't clear 8B.
    LDA #$00
    STA BG_UPDATE_FLAG_UNK ; Clear.
OBJ_DATA_B_ZERO: ; 0A:0073, 0x014073
    INC 714_UNK ; ++ unk.
    JMP INIT_OBJECT[X]_DATA_FULL ; Abuse RTS. Clear object?
OBJ_UNK_NONZERO: ; 0A:0079, 0x014079
    JSR GET_OBJS_COUNT_MATCH_FOCUS_AS_STATE_IN_TMP_00 ; Get val in TMP.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from X.
    CMP #$30 ; If _ #$30
    BCS VAL_GTE ; >=, goto.
    LDA LEVEL/SCREEN_ON ; Load screen.
    ASL A ; << 1, *2
    TAY ; To Y index.
    LDA SCREEN_DATA_PTR_L,Y ; Set up ptr.
    STA TMP_08
    LDA SCREEN_DATA_PTR_H,Y
    STA TMP_09
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Get index from OBJ.
    LDA [TMP_08],Y ; Load from file.
    CMP TMP_00 ; If _ count?
    BEQ RTS_MOVE ; ==, goto.
    BCC RTS_MOVE ; <, goto.
L_0A:009C: ; 0A:009C, 0x01409C
    JSR RTN_GET_OBJ_PAIR_IN_Y_RET_CC_SUCCESS
    BCS RTS_MOVE ; Didn't get Yobj. Leave.
    LDA #$30
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set timer.
    JSR SETUP_OBJ_X? ; Do...
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next switch.
RTS_MOVE: ; 0A:00AC, 0x0140AC
    JMP OBJECT_X_MOVE? ; Abuse RTS. Move.
VAL_GTE: ; 0A:00AF, 0x0140AF
    LDA TMP_00
    CMP #$02
    BCS RTS_MOVE
    BCC L_0A:009C
SCREEN_DATA_PTR_L: ; 0A:00B7, 0x0140B7
    .db CD
SCREEN_DATA_PTR_H: ; 0A:00B8, 0x0140B8
    .db 80
    .db CD
    .db 80
    .db E0
    .db 80
    .db F3
    .db 80
    .db 06
    .db 81
    .db 06
    .db 81
    .db 06
    .db 81
    .db 19
    .db 81
    .db 06
    .db 81
    .db 06
    .db 81
    .db 06
    .db 81
    .db 00
    .db 00
    .db 03
    .db 02
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 01
    .db 00
    .db 03
    .db 00
    .db 00
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 01
    .db 00
    .db 03
    .db 00
    .db 00
    .db 02
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 01
    .db 00
    .db 03
    .db 00
    .db 00
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 03
    .db 03
    .db 03
    .db 02
    .db 03
    .db 01
    .db 00
    .db 03
    .db 00
    .db 00
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 01
    .db 00
    .db 02
SETUP_OBJ_X?: ; 0A:012C, 0x01412C
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from Xobj.
    STA OBJ_ENABLED_STATE+MORE?[18],Y ; Store to Yobj.
    CMP #$30 ; If _ #$30
    BCS OVER_0x30 ; >=, goto.
    LDA #$01
    STA OBJ_ENABLED_STATE+MORE?+1,Y ; Set
OVER_0x30: ; 0A:013B, 0x01413B
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Copy from X to Y.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],Y
    STX TMP_10 ; Save Xobj working on.
    LDX ZP_13_INDEX_VAL_UNK ; Load
    DEX ; --
    BEQ ZP_13--_EQ_ZERO ; == 0, goto.
    DEX ; -- again.
    TXA ; To A.
    ASL A ; << 1, *2
    JMP A_FROM_X ; Goto.
ZP_13--_EQ_ZERO: ; 0A:014F, 0x01414F
    LDA RANDOM_VALS?[2] ; Load
    AND #$02 ; Keep 0000.0010
A_FROM_X: ; 0A:0153, 0x014153
    TAX ; A to X.
    LDA DATA_UPDATE_FLAGS?,X ; Get data.
    STA 556_OBJ_STATUS_FLAGS_A[18],Y ; Store to obj.
    LDA DATA_POS_X,X
    STA OBJ_POS_X_CONFIRMED[18],Y
    LDA LEVEL/SCREEN_ON ; Get level.
    ASL A ; << 1, *2
    TAX ; To X index.
    LDA DATA_TMP11_UNK,X ; Load.
    STA TMP_11 ; To TMP.
    LDA LEVEL/SCREEN_ON ; Get screen.
    CMP #$08 ; If _ #$08
    BNE SCREEN_NOT_8 ; !=, goto.
    LDA SCRIPT_LEVEL_SCREEN[2] ; Load
    BEQ SCREEN_NOT_8 ; If 0, skip.
    CMP #$03 ; If _ #$03
    BCS SCREEN_NOT_8 ; >=, goto.
    LDA #$BC
    STA TMP_11 ; Set to.
SCREEN_NOT_8: ; 0A:017B, 0x01417B
    LDA DATA_TMP12_UNK,X ; Get from level.
    STA TMP_12 ; Store to TMP.
    LDA RANDOM_VALS?[2] ; Load random.
    CMP TMP_11 ; If _ TMP_11
    BCC WRITE_TMP11_TO_POS ; <, goto.
    CMP TMP_12 ; If _ TMP_12
    BCC WRITE_A_TO_POS ; <, goto.
    LDA TMP_12 ; Load
    BNE WRITE_A_TO_POS ; If nonzero, write.
WRITE_TMP11_TO_POS: ; 0A:018E, 0x01418E
    LDA TMP_11 ; Load from.
WRITE_A_TO_POS: ; 0A:0190, 0x014190
    STA OBJ_POS_X??[18],Y ; Set from A.
    LDX TMP_10 ; Recover object working on.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    JMP OBJECT_X_MOVE? ; Move it.
    .db 4C
    .db F1
    .db F3
DATA_UPDATE_FLAGS?: ; 0A:019E, 0x01419E
    .db 01
DATA_POS_X: ; 0A:019F, 0x01419F
    .db 10
    .db 02
    .db F0
DATA_TMP11_UNK: ; 0A:01A2, 0x0141A2
    .db 90
DATA_TMP12_UNK: ; 0A:01A3, 0x0141A3
    .db D0
    .db A0
    .db D0
    .db B8
    .db D8
    .db A0
    .db B8
    .db B0
    .db D8
    .db A0
    .db D8
    .db 80
    .db D8
    .db 90
    .db D8
    .db A0
    .db D8
    .db A0
    .db D8
    .db A0
    .db D8
TERTIARY_RTN_C: ; 0A:01B8, 0x0141B8
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE RTS ; != 0, leave.
    DEC OBJ_TERTIARY_SWITCH?[18],X ; Back to switch 2.
RTS: ; 0A:01C0, 0x0141C0
    RTS
GET_OBJS_COUNT_MATCH_FOCUS_AS_STATE_IN_TMP_00: ; 0A:01C1, 0x0141C1
    LDA #$00
    STA TMP_00 ; Clear match count.
    LDY #$07 ; Obj start.
LOOP_OBJS: ; 0A:01C7, 0x0141C7
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Get state.
    CMP 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; If X.var _ Y.State
    BNE STATE_NE_TIMER? ; !=, goto.
    INC TMP_00 ; Matches++
STATE_NE_TIMER?: ; 0A:01D1, 0x0141D1
    INY ; Obj pair ++
    INY
    CPY #$11 ; If _ Obj[18]
    BCC LOOP_OBJS ; <, loop.
    RTS
PALETTE_UPDATE_CHANGE_TEST: ; 0A:01D8, 0x0141D8
    LDA DE_FLAG_PALETTE_UNK ; Load
    BNE PALETTE_UPDATE_CHANGE_FROM_OBJ ; != 0, goto.
    LDA 712_FLAG_PALETTE_UNK ; Load
    BNE RTS ; != 0, leave.
PALETTE_UPDATE_CHANGE_FROM_OBJ: ; 0A:01E1, 0x0141E1
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Get from Xobj
    DEY ; -= 2
    DEY
    BMI RTS ; Went negative, leave.
    LDA STATE_PALETTE_CHANGE,Y ; Get to change.
    TAY
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Change palette.
    LDA #$00
    STA DE_FLAG_PALETTE_UNK ; Clear flag.
RTS: ; 0A:01F3, 0x0141F3
    RTS
STATE_PALETTE_CHANGE: ; 0A:01F4, 0x0141F4
    .db 00
    .db 16
    .db 02
    .db 00
    .db 01
    .db 03
    .db 04
    .db 00
    .db 07
    .db 00
    .db 00
    .db 04
    .db 02
    .db 03
    .db 05
    .db 00
    .db 20
OBJ_UNK_RET_CC_SUCCESS?: ; 0A:0205, 0x014205
    LDY #$07 ; Obj
    STX TMP_00 ; Object handling.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load
    STA TMP_01 ; Store to.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    STA TMP_03 ; Store to. Xobj state.
    LDA #$00 ; Init val?
    STA TMP_02 ; Clear.
LOOP_OBJ_PAIRS: ; 0A:0217, 0x014217
    CPY TMP_00 ; If YOBJ _ Handling
    BEQ NEXT_YOBJ ; ==, goto.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Y object.
    BNE OBJY_ENABLED_NONZERO ; If nonzero, goto.
NEXT_YOBJ: ; 0A:0220, 0x014220
    INY ; Y += 2
    INY
    CPY #$11 ; If _ OBJ[17]
    BCC LOOP_OBJ_PAIRS ; <, loop.
    RTS ; Leave, none found. Carry set.
OBJY_ENABLED_NONZERO: ; 0A:0227, 0x014227
    BPL STATE_POSITIVE ; If positive, goto.
    CMP #$B0 ; If _ #$B0
    BCC NEXT_YOBJ ; <, next object.
STATE_POSITIVE: ; 0A:022D, 0x01422D
    CMP TMP_01 ; If Y.State _ Timer
    BEQ NEXT_YOBJ ; ==, skip.
    INC TMP_02 ; var++, unk.
    CMP TMP_03 ; If Y.State _ X.State
    BEQ NEXT_YOBJ ; ==, skip.
    CLC ; Set return. Success?
    RTS ; Leave.
FIND_SINGLE_YOBJ_NOT_SAME_AS_NEXT_TO_RET_CC_SUCCESS: ; 0A:0239, 0x014239
    LDY #$07 ; Yobj
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    STA TMP_00 ; Store to TMP.
LOOP_ALL_YOBJS: ; 0A:0240, 0x014240
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Yobj.
    BNE YOBJ_NONZERO ; If nonzero, goto.
NEXT_YOBJ: ; 0A:0245, 0x014245
    INY ; Obj++
    CPY #$11 ; If Yobj _ OBJ[18]
    BCC LOOP_ALL_YOBJS ; <, goto.
    RTS
YOBJ_NONZERO: ; 0A:024B, 0x01424B
    BMI NEXT_YOBJ ; If negative, skip.
    CMP TMP_00 ; If Yobj.State _ Xobj.State
    BEQ NEXT_YOBJ ; ==, goto. Can't match.
    CLC ; Clear carry, success.
    RTS
    LDA #$01
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    STA 556_OBJ_STATUS_FLAGS_A[18],Y
    LDA #$18
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA #$20
    BNE L_0A:0273
    LDA #$02
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    STA 556_OBJ_STATUS_FLAGS_A[18],Y
    LDA #$E8
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA #$E0
L_0A:0273: ; 0A:0273, 0x014273
    STA OBJ_POS_X_CONFIRMED[18],Y
    LDA LEVEL/SCREEN_ON
    CMP #$02
    BCS L_0A:028D
    LDA #$98
    STA OBJ_POS_Y_CONFIRMED[18],X
    STA OBJ_POS_X??[18],X
    LDA #$C0
    STA OBJ_POS_Y_CONFIRMED[18],Y
    STA OBJ_POS_X??[18],Y
    RTS
L_0A:028D: ; 0A:028D, 0x01428D
    LDA #$B0
    STA OBJ_POS_Y_CONFIRMED[18],X
    STA OBJ_POS_X??[18],X
    LDA #$E0
    STA OBJ_POS_Y_CONFIRMED[18],Y
    STA OBJ_POS_X??[18],Y
    RTS
    TXA
    SEC
    SBC #$07
    LSR A
    STA TMP_08
    ASL A
    CLC
    ADC TMP_08
    TAY
    LDA L_0A:02BA,Y
    STA TMP_08
    LDA L_0A:02BB,Y
    STA TMP_09
    LDA L_0A:02BC,Y
    STA TMP_0A
    RTS
L_0A:02BA: ; 0A:02BA, 0x0142BA
    .db 09
L_0A:02BB: ; 0A:02BB, 0x0142BB
    .db 0B
L_0A:02BC: ; 0A:02BC, 0x0142BC
    .db 0D
    .db 07
    .db 0B
    .db 0D
    .db 07
    .db 09
    .db 0D
    .db 07
    .db 09
    .db 0B
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db D6
    .db 82
    .db E0
    .db 82
    .db E0
    .db 82
    .db E0
    .db 82
    .db E0
    .db 82
    .db E0
    .db 82
    .db 02
    .db 06
    .db 02
    .db 02
    .db 06
    .db 02
    .db 02
    .db 06
    .db 02
    .db 02
    .db 06
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
OBJ_STATE_0x24_HANDLER: ; 0A:02F2, 0x0142F2
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch
    LOW(STATE_0x24_SWITCH_A) ; Sets val.
    HIGH(STATE_0x24_SWITCH_A)
    LOW(STATE_0x24_SWITCH_B) ; Pair create rtn.
    HIGH(STATE_0x24_SWITCH_B)
STATE_0x24_SWITCH_A: ; 0A:02FC, 0x0142FC
    LDA #$10
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set. Val?
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
EXIT_X_MOVE?: ; 0A:0304, 0x014304
    JMP OBJECT_X_MOVE? ; Finalize.
STATE_0x24_SWITCH_B: ; 0A:0307, 0x014307
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Val--
    BNE EXIT_X_MOVE? ; != 0, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    PHA ; Save
    JSR INIT_OBJECT[X]_DATA_FULL ; Re-init.
    PLA ; Pull.
    JMP PAIR_OBJS_CREATE_UNK ; Goto.
OBJ_STATE_0x25_HANDLER: ; 0A:0317, 0x014317
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(S25_EXTRA_RTN_A) ; Setup palette.
    HIGH(S25_EXTRA_RTN_A)
    LOW(S25_EXTRA_RTN_B) ; Makes objs.
    HIGH(S25_EXTRA_RTN_B)
S25_EXTRA_RTN_A: ; 0A:0321, 0x014321
    LDY #$00 ; Palette
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Update.
    LDA #$10 ; Val?
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move to other.
EXIT(_X_MOVE?): ; 0A:032E, 0x01432E
    JMP OBJECT_X_MOVE? ; Exit, abuse RTS.
S25_EXTRA_RTN_B: ; 0A:0331, 0x014331
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT(_X_MOVE?) ; != 0, leave.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    PHA ; Save.
    JSR INIT_OBJECT[X]_DATA_FULL ; Re-init.
    PLA ; Restore Xpos.
    JMP RTN_MAKE_OTHER_OBJS_LOOP ; Make objs.
OBJ_STATE_0x26_HANDLER: ; 0A:0341, 0x014341
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x26_SWITCH_A) ; Obj count matched matters.
    HIGH(STATE_0x26_SWITCH_A)
    LOW(STATE_0x26_SWITCH_B) ; IRQ/Script runs accounted for in rtn.
    HIGH(STATE_0x26_SWITCH_B)
    LOW(STATE_0x26_SWITCH_C) ; Moves back to B.
    HIGH(STATE_0x26_SWITCH_C)
STATE_0x26_SWITCH_A: ; 0A:034D, 0x01434D
    LDA #$10
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move switch.
    JMP OBJECT_X_MOVE? ; Exit/finalize.
STATE_0x26_SWITCH_B: ; 0A:0358, 0x014358
    JSR GET_OBJS_COUNT_MATCH_FOCUS_AS_STATE_IN_TMP_00 ; Get count.
    LDA TMP_00 ; Count
    CMP #$02 ; If _ #$02
    BCS EXIT_MOVE/UPDATE_FLAG ; >=, goto.
    JSR RTN_GET_OBJ_PAIR_IN_Y_RET_CC_SUCCESS
    BCS EXIT_MOVE/UPDATE_FLAG ; Fail, exit.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load
    STA OBJ_ENABLED_STATE+MORE?[18],Y ; Store to Yobj.
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    AND #$01 ; Keep 0000.0001
    CLC ; Prep add
    ADC #$01 ; Add
    STA 556_OBJ_STATUS_FLAGS_A[18],Y ; Store to update.
    CMP #$01 ; If _ #$01
    BEQ UPDATE_EQ_0x01 ; ==, goto. Was 0x00.
    LDA #$D0
    STA OBJ_POS_X_CONFIRMED[18],Y ; Set Xpos.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load ran count.
    AND #$0F ; Keep 0000.1111
    CLC
    ADC #$88 ; Add with
    BNE A_SEEDED ; Always taken.
UPDATE_EQ_0x01: ; 0A:0389, 0x014389
    LDA #$30 ; Val.
    STA OBJ_POS_X_CONFIRMED[18],Y ; Set.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$0F ; Keep 0000.1111
    CLC ; Prep add.
    ADC #$A8 ; Add with.
A_SEEDED: ; 0A:0395, 0x014395
    STA OBJ_POS_X??[18],Y ; Store to.
    INC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; ++
    JSR GET_OBJS_COUNT_MATCH_FOCUS_AS_STATE_IN_TMP_00 ; Do.
    LDA TMP_00 ; Count of objs.
    CMP #$02 ; If _ #$02
    BCC EXIT_MOVE/UPDATE_FLAG ; <, exit.
    LDA #$80
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set
    INC OBJ_SECONDARY_SWITCH?[18],X ; Secondary++
EXIT_MOVE/UPDATE_FLAG: ; 0A:03AC, 0x0143AC
    JSR OBJECT_X_MOVE? ; Exit.
    JMP TEST_OBJ_UPDATE_FLAG_INIT
STATE_0x26_SWITCH_C: ; 0A:03B2, 0x0143B2
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_MOVE/UPDATE_FLAG ; != 0, exit.
    DEC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary back.
    JMP EXIT_MOVE/UPDATE_FLAG ; Exit.
OBJ_STATE_0x01_HANDLER: ; 0A:03BD, 0x0143BD
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; OBJ_UPDATE_FLAGS-1.
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Copy to our flags.
    LDA OBJ_POS_Y_CONFIRMED+17,X ; OBJ_POS_X-1
    STA OBJ_POS_X_CONFIRMED[18],X ; Copy to ours.
    LDY OBJ_ANIMATION_DISPLAY+17,X ; OBJ_SECONDARY_SWITCH-1
    CPY #$04 ; If _ #$04
    BNE SSWITCH_NE_FOUR ; !=, goto.
    STA TMP_00 ; X Pos.
    LDY #$00 ; Index
    LDA 4D8_OBJ_UNK+17,X ; 4EA, UNK.
    BMI USE_NEGATIVE_INDEX
    INY ; Use other index, positive.
USE_NEGATIVE_INDEX: ; 0A:03DA, 0x0143DA
    LDA DATA_UNK,Y ; Load
    ADC TMP_00 ; Add with X.
    PHA ; Save
    ROR A ; >> 1
    EOR DATA_UNK,Y ; EOR with data.
    ASL A ; << 1
    PLA ; Save
    BCS SSWITCH_NE_FOUR ; If CS, don't store back.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to Xpos.
SSWITCH_NE_FOUR: ; 0A:03EB, 0x0143EB
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; 04A2, YPOS?
    ADC 4C6_OBJ_UNK[18],X ; Add with offset?
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to YPOS.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    LSR A ; >> 1, /2
    BCC IS_EVEN ; If clear, goto.
    LSR A ; >> 1, /2
    BCS IS_ODD_WITH_VALUE ; If odd with set, goto.
    LSR A ; >> 1, /2
    LDA #$04 ; Seed, unk.
    BCC ANIMATION_COMMIT_A ; <8 total, goto.
    DEC OBJECT_DATA_EXTRA_B?[18],X ; --
    BNE EXTRA_TIMER_NOT_FINISHED
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$02 ; Keep only 0000.0010.
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store secondary.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    LDA #$04 ; Seed unk.
    BNE ANIMATION_COMMIT_A ; Always taken.
IS_ODD_WITH_VALUE: ; 0A:0419, 0x014419
    LDA RANDOM_VALS?[2] ; Get rand.
    LSR A ; >> 2, /2.
    LSR A
    AND #$03 ; Keep 0000.0011
    TAY ; To Y index.
    LDA HANDLER_1_RDATA_UNK,Y ; Get random.
ANIMATION_COMMIT_A: ; 0A:0423, 0x014423
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display animation.
    RTS ; Leave.
IS_EVEN: ; 0A:0427, 0x014427
    LDA #$00 ; Anim
    BEQ ANIMATION_COMMIT_A
EXTRA_TIMER_NOT_FINISHED: ; 0A:042B, 0x01442B
    LDA #$AA ; Anim
    BNE ANIMATION_COMMIT_A
DATA_UNK: ; 0A:042F, 0x01442F
    .db F8
    .db 08
SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER: ; 0A:0431, 0x014431
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$03 ; If _ #$03
    BNE SCREEN_NOT_THREE ; !=, alternate.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BEQ ALT_OBJ_ZERO ; If == 0, goto.
SCREEN_NOT_THREE: ; 0A:043C, 0x01443C
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load pair secondary.
    ORA #$01 ; Set
    STA OBJ_SECONDARY_SWITCH?+1,X ; Store back to secondary.
    RTS ; Leave.
OBJ_PAIR_SWITCH_MOD: ; 0A:0445, 0x014445
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load pair switch.
    AND #$02 ; Keep 0000.0010
    BNE RTS ; If set, leave.
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load secondary of pair.
    AND #$FE ; Keep 1111.1110
    STA OBJ_SECONDARY_SWITCH?+1,X ; Store back.
RTS: ; 0A:0454, 0x014454
    RTS
ALT_OBJ_ZERO: ; 0A:0455, 0x014455
    PHA ; Save from obj.
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?+1,X ; Set pair secondary.
    LDA #$10
    STA OBJECT_DATA_EXTRA_B?+1,X ; Set pair extra.
    LDA #$1E
    JSR SND_BANKED_DISPATCH ; Play sound.
    PLA ; Restore
    RTS ; Leave.
HANDLER_1_RDATA_UNK: ; 0A:0467, 0x014467
    .db 58
    .db 59
    .db 58
    .db 59
OBJ_STATE_0x02_HANDLER: ; 0A:046B, 0x01446B
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save to scratch.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Get secondary.
    BNE SECONDARY_NONZERO
    JMP SECONDARY_ZERO ; Goto..
SECONDARY_NONZERO: ; 0A:0476, 0x014476
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ SINGLE_PLAYER/SKIP ; == 0, 1P, goto.
    LDA NUM_PLAYER_LIVES[2] ; Load P1 Lives.
    ORA NUM_PLAYER_LIVES+1 ; |= P2 lives.
    BMI SINGLE_PLAYER/SKIP ; Either player game over, goto.
    LDY OBJ_INDEXES_GROUP_UNK+1
    BEQ SINGLE_PLAYER/SKIP ; == 0, goto.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load timer from first Yobj.
    LDY OBJ_INDEXES_GROUP_UNK[3] ; Other object index.
    BEQ SINGLE_PLAYER/SKIP ; == 0, goto.
    CMP 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; If A_timer _ B_timer
    BNE SINGLE_PLAYER/SKIP ; !=, goto.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load current.
    EOR #$02 ; Invert 0000.0010
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Store back.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load OBJ
    AND #$8F ; Keep 1000.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
SINGLE_PLAYER/SKIP: ; 0A:04A2, 0x0144A2
    JSR TEST_XOBJ_EQ_717/718_INDEX_MATCH ; Test..?
    LDY OBJ_TERTIARY_SWITCH?+1,X ; Get from Xobj next to..
    LDA DATA_TERTIARY_NEXT_UNK,Y ; Load from
    STA 4C6_OBJ_UNK+1,X ; Store to obj.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    LDA OBJ_DATA_EXTRA_FLAGS,Y
    BEQ EXTRA_B_VAL_0x01 ; == 0, goto. No extra.
    LDA LEVEL/SCREEN_ON ; Load screen
    CMP #$03 ; If _ #$03
    BEQ EXTRA_B_VAL_0x01 ; ==, goto.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Var
    BEQ EXTRA_B_VAL_0x01 ; ==, skip.
    LDA 704_OBJ_USE_UNK ; Load
    BEQ DECIDE_EXTRA_B_VAL ; == 0, goto.
    LDA RANDOM_VALS?[2] ; Load rand.
    AND #$03 ; Keep 0000.0011
    BNE EXTRA_B_VAL_0x01 ; Any set, skip.
    DEC 704_OBJ_USE_UNK ; -- val.
EXTRA_B_VAL_0x01: ; 0A:04CF, 0x0144CF
    LDA #$01 ; Extra val.
    BNE SYNC_UNK ; Always taken.
DECIDE_EXTRA_B_VAL: ; 0A:04D3, 0x0144D3
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load next to tertiary
    BNE EXTRA_B_VAL_0x01 ; != 0, goto.
    LDA 712_FLAG_PALETTE_UNK ; Load flag
    BNE EXTRA_B_VAL_0x01 ; != 0, goto.
    LDA #$84 ; Extra val.
SYNC_UNK: ; 0A:04DF, 0x0144DF
    STA OBJECT_DATA_EXTRA_B?[18],X ; Store to extra.
    JSR SECONDARY_AND_TERTIARY_SWITCH_RTN ; Do one of a billion things??? Ugh, lots to do here.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Get extra
    BEQ RTS ; No extra, leave.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load update flags.
    BNE RTS ; If any set, leave.
    TXA ; Object to A.
    LSR A ; Shift.
    EOR RANDOM_VALS?[2] ; Invert bits in this.
    LSR A ; Shift again.
    BCC RTS ; If shifted off 0, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health
    PHA ; Save
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load timer.
    AND #$08 ; Test 0000.1000
    BEQ TIMER?_BIT_0x08_NOT_SET
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health
    DEC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; -- from pair.
    BNE TIMER?_BIT_0x08_NOT_SET ; If not set, skip ??
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$F7 ; Keep 1111.0111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Clear pair.
TIMER?_BIT_0x08_NOT_SET: ; 0A:0518, 0x014518
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do..
    STA TMP_00 ; Store ret.
    PLA ; Restore.
    LDY OBJECT_DATA_HEALTH?[18],X ; Get health.
    CPY #$FF ; If _ #$FF
    BNE HEALTH_NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store A to health.
HEALTH_NE_0xFF: ; 0A:0528, 0x014528
    LDA TMP_00 ; Load TMP.
    CMP #$FF ; If _ #$FF
    BNE RET_NE_0xFF ; !=, goto.
    JMP RTN_RET_0xFF ; Goto if 0xFF.
RET_NE_0xFF: ; 0A:0531, 0x014531
    LSR A ; >> 1, /2.
    BCS RET_0x01_SET ; If set, goto.
    LSR A ; >> 1, /2.
    BCC RTS ; Return 0x02 clear, leave.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Var
    BNE RTS ; !=, leave.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from OBJ.
    AND #$EF ; Keep 1110.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Clear pair var.
RTS: ; 0A:0549, 0x014549
    RTS ; Leave.
RET_0x01_SET: ; 0A:054A, 0x01454A
    LDA A/B_WHICH_RESULT ; Get which.
    CMP #$02 ; If _ #$02
    BCS GTEQ_0x02 ; >=, skip sub.
    JSR OBJ_CLEAR_AND_SET_PAIR_UNK ; Do
GTEQ_0x02: ; 0A:0554, 0x014554
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    CMP #$10 ; If _ 0x10
    BNE VAL_NE_0x10 ; !=, goto.
    JMP SET_XOBJ_SWITCHES_AND_ANIMATION ; Goto.
VAL_NE_0x10: ; 0A:055E, 0x01455E
    CMP #$0D ; If _ #$0D
    BNE STATE_NE_0x0D ; !=, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BPL STATE_NE_0x0D ; If positive, skip.
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT?
    LDA #$01
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y ; Set of Yobj.
STATE_NE_0x0D: ; 0A:056F, 0x01456F
    LDA OBJECT_DATA_HEALTH?[18],X ; If _ #$00
    BEQ HEALTH_EQ_0x00 ; ==, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Get secondary from obj.
    LSR A ; >> 1, /2.
    BCS HEALTH_EQ_0x00 ; If bit is 0x01, goto.
    JMP HEALTH_NONZERO ; Do.
HEALTH_EQ_0x00: ; 0A:0580, 0x014580
    JMP HEALTH_ZERO ; Do.
SECONDARY_AND_TERTIARY_SWITCH_RTN: ; 0A:0583, 0x014583
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary
    ASL A ; << 1, *2. Word size.
    TAY ; To index.
    LDA SECONDARY_RTNS_L,Y
    STA TMP_00
    LDA SECONDARY_RTNS_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tertiary for secondary.
    ASL A ; << 1, *2. Word size.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load from first ptr.
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02] ; Run code secondary multiswitch.
SECONDARY_RTNS_L: ; 0A:05A3, 0x0145A3
    LOW(HANDLER_0x01_MULTISWITCH_A) ; Note: All contain own pointer tables inside on tertiary switch.
SECONDARY_RTNS_H: ; 0A:05A4, 0x0145A4
    HIGH(HANDLER_0x01_MULTISWITCH_A) ; Jesus there's a lot of crap here.
    LOW(HANDLER_0x01_MULTISWITCH_B) ; State, animation, track to player, more.
    HIGH(HANDLER_0x01_MULTISWITCH_B)
    LOW(HANDLER_0x01_MULTISWITCH_C) ; Misc.
    HIGH(HANDLER_0x01_MULTISWITCH_C)
    LOW(HANDLER_0x01_MULTISWITCH_D) ; Tons
    HIGH(HANDLER_0x01_MULTISWITCH_D)
    LOW(HANDLER_0x01_MULTISWITCH_E) ; Smol
    HIGH(HANDLER_0x01_MULTISWITCH_E)
    LOW(HANDLER_0x01_MULTISWITCH_F) ; Smoler
    HIGH(HANDLER_0x01_MULTISWITCH_F)
    LOW(HANDLER_0x01_MULTISWITCH_G) ; Smolest
    HIGH(HANDLER_0x01_MULTISWITCH_G)
HANDLER_0x01_MULTISWITCH_G: ; 0A:05B1, 0x0145B1
    LOW(HANDLER_0x01_MULTISWITCH_G_RTN_A) ; Focus on closest, animation, move.
    HIGH(HANDLER_0x01_MULTISWITCH_G_RTN_A)
    LOW(HANDLER_0x01_MULTISWITCH_G_RTN_B) ; State, animation.
    HIGH(HANDLER_0x01_MULTISWITCH_G_RTN_B)
RTN_RET_0xFF: ; 0A:05B5, 0x0145B5
    LDA #$06
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    AND #$EF
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    JMP L_0A:14FD
HANDLER_0x01_MULTISWITCH_G_RTN_A: ; 0A:05CD, 0x0145CD
    LDA #$8B
    STA OBJ_ANIMATION_DISPLAY[18],X ; Animation.
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X ; Store extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Move.
    JMP FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find and leave.
HANDLER_0x01_MULTISWITCH_G_RTN_B: ; 0A:05DD, 0x0145DD
    LDA #$64
    STA 704_OBJ_USE_UNK ; Set to, unk why.
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move to state.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JMP STATE_SOLVING_AND_ANIMATION_FOR_STATE ; Update animation.
SUB_GFX_BANKS_FROM_STATE: ; 0A:05EB, 0x0145EB
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    CMP #$02 ; If _ #$02
    BNE STATE_NE_0x02 ; !=, goto.
    LDY 712_FLAG_PALETTE_UNK ; Y from.
    BNE SET_SGFX_BANK_3_ONLY ; != 0, goto.
STATE_NE_0x02: ; 0A:05F7, 0x0145F7
    ASL A ; << 1, *2. Word size.
    TAY ; To Y index.
    LDA SPRITE_GFX_BANK_2_VALS,Y ; Move banks.
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4
    LDA SPRITE_GFX_BANK_3_VALS,Y
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    JMP L_0A:060D ; Goto.
SET_SGFX_BANK_3_ONLY: ; 0A:0606, 0x014606
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA SPRITE_GFX_BANK_3_VALS,Y ; Move bank 3 only.
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
L_0A:060D: ; 0A:060D, 0x01460D
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$03 ; If _ #$03
    BNE SPRITE_GFX_BANK_3_VALS ; !=, goto. RTS.
    LDA #$37
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5 ; Set bank on screen 3.
SPRITE_GFX_BANK_3_VALS: ; 0A:0617, 0x014617
    RTS ; Leave.
    .db 28
    .db 29
    .db 28
    .db 29
    .db 2B
    .db 29
    .db 48
    .db 29
    .db 49
    .db 29
    .db 4A
    .db 29
    .db 4B
    .db 29
    .db 50
    .db 29
    .db 53
    .db 29
    .db 32
    .db 33
    .db 52
    .db 29
    .db 51
    .db 29
    .db 35
    .db 29
    .db 48
    .db 54
    .db 4B
    .db 54
    .db 5A
    .db 5B
    .db 36
    .db 29
    .db D8
    .db 29
    .db 2B
    .db 29
    .db 2B
    .db 29
SCREEN_DATA_B: ; 0A:0640, 0x014640
    .db 04 ; Health values?
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
    .db 04
HANDLER_0x01_MULTISWITCH_A: ; 0A:064D, 0x01464D
    LOW(SECONDARY_ZERO)
    HIGH(SECONDARY_ZERO)
SECONDARY_ZERO: ; 0A:064F, 0x01464F
    JSR PALETTE_UPDATE_CHANGE_TEST ; Test change.
    LDA #$01
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Enable other.
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear timer.
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    LDA #$03 ; Secondary value for pair.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Get state.
    CPY #$0E ; If _ #$0E
    BEQ A_TO_SECONDARY_FOR_PAIRED ; ==, goto.
    CPY #$0F ; If _ #$0F
    BEQ A_TO_SECONDARY_FOR_PAIRED ; ==, goto.
    LDA #$00 ; Clear
A_TO_SECONDARY_FOR_PAIRED: ; 0A:066E, 0x01466E
    STA OBJ_SECONDARY_SWITCH?+1,X ; Store pair secondary.
    INC 716_UNK ; ++
    LDA 716_UNK ; Load
    AND #$03 ; Keep 0000.0011
    ORA #$80 ; Set 1000.0000
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store to.
    AND #$01 ; Keep 0000.0001
    ASL A ; << 1, *2.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do.
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY ; Do.
    LDY LEVEL/SCREEN_ON ; Load screen to index.
    LDA SCREEN_DATA_A,Y ; Load flag for screen.
    STA 4D8_OBJ_UNK+1,X ; Store to Xobj pair.
    LDY LEVEL/SCREEN_ON ; Load screen to index again.
    LDA SCREEN_DATA_B,Y
    STA OBJECT_DATA_HEALTH?[18],X ; Health for objects?
    JSR OBJ_STORAGE_UNK ; Store Xobj, idk.
    JSR SUB_GFX_BANKS_FROM_STATE ; GFX change.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load
    LDA NEXT_OBJ_INDEX_PER_STATE,Y
    BEQ SWITCH_BASED_ON_MISC_INDEX ; == 0, goto.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store value to obj.
SWITCH_BASED_ON_MISC_INDEX: ; 0A:06AB, 0x0146AB
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Switch based on this.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_0x02_RTN_A) ; Direction, tertiary, more.
    HIGH(SWITCH_0x02_RTN_A)
    LOW(SWITCH_0x02_RTN_B) ; Level to obj data, also A RTN.
    HIGH(SWITCH_0x02_RTN_B)
    LOW(SWITCH_0x02_RTN_C) ; Screen 3 only, otherwise does RTN A
    HIGH(SWITCH_0x02_RTN_C)
    LOW(SWITCH_0x02_RTN_D) ; Sec, tert update. Screen 3 mods, too.
    HIGH(SWITCH_0x02_RTN_D)
    LOW(SWITCH_0x02_RTN_E) ; Sec 0x01 Tert 0x0A
    HIGH(SWITCH_0x02_RTN_E)
    LOW(SWITCH_0x02_RTN_F) ; Sec 0x01 Tert 0x0B
    HIGH(SWITCH_0x02_RTN_F)
    LOW(SWITCH_0x02_RTN_G) ; Switches, randomness, BG detection?
    HIGH(SWITCH_0x02_RTN_G)
    LOW(SWITCH_0x02_RTN_H) ; Sec 0x01, Tert 0x00, clear stuff, dir+pos.
    HIGH(SWITCH_0x02_RTN_H)
    LOW(SWITCH_0x02_RTN_I) ; Sec 0x01, Tert 0x00, clear stuff.
    HIGH(SWITCH_0x02_RTN_I)
    LOW(SWITCH_0x02_RTN_J) ; Sec 0x03, Tert 0x15, direction, sound.
    HIGH(SWITCH_0x02_RTN_J)
    LOW(SWITCH_0x02_RTN_K) ; Sec 0x01, Tert 0x0D, more.
    HIGH(SWITCH_0x02_RTN_K)
    LOW(SWITCH_0x02_RTN_L) ; Sec 0x01, Tert 0x0E, smol clear.
    HIGH(SWITCH_0x02_RTN_L)
SWITCH_0x02_RTN_A: ; 0A:06C9, 0x0146C9
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load flags.
    BNE FLAGS_SET ; != 0, goto.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Set this.
FLAGS_SET: ; 0A:06D1, 0x0146D1
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Set.
SWITCH_0x02_RTN_B: ; 0A:06D4, 0x0146D4
    LDY LEVEL/SCREEN_ON ; Load screen.
    LDA SCREEN_DATA_UNK_A,Y ; Move screen data to obj.
    STA OBJ_POS_X??[18],X
    LDA SCREEN_DATA_UNK_B,Y
    STA 4C6_OBJ_UNK[18],X
    LDA SCREEN_DATA_UNK_C,Y
    STA OBJ_TERTIARY_SWITCH?+1,X ; Tertiary of pair.
    JMP SWITCH_0x02_RTN_A ; Also do RTN A.
SWITCH_0x02_RTN_C: ; 0A:06EB, 0x0146EB
    LDY LEVEL/SCREEN_ON ; Load screen.
    CPY #$03 ; If _ #$03
    BNE SWITCH_0x02_RTN_A ; !=, do RTN A
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear
    STA OBJ_TERTIARY_SWITCH?+1,X ; Clear.
    JMP SET_OBJ_SECONDARY_0x01_TERTIARY_0x08_DIRECTION_POS_MORE ; Do.
RTN_MAKE_OTHER_OBJS_LOOP: ; 0A:06FC, 0x0146FC
    STA TMP_16 ; Save Xobj Xpos.
    LDA #$02 ; Loop count.
    STA TMP_17 ; Store to TMP.
LOOP_MAKE_OBJS: ; 0A:0702, 0x014702
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Get Xobj.
    BCS RTS ; Ret CS, failed.
    LDA #$02
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set xobj state.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear.
    CLC ; Prep add.
    LDY TMP_17 ; Load loop.
    LDA TMP_16 ; Load Xpos.
    ADC XPOS_ADD,Y ; Mod Xpos.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to this Xpos.
    LDA #$97
    STA OBJ_POS_X??[18],X ; Set
    LDA #$E9
    STA 4C6_OBJ_UNK[18],X ; Set
    LDA #$00
    STA 4D8_OBJ_UNK[18],X ; Clear.
    STA OBJ_TERTIARY_SWITCH?+1,X ; Clear pair tert.
    LDA #$03
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set.
    DEC TMP_17 ; Loop--
    BPL LOOP_MAKE_OBJS ; Make more if positive.
RTS: ; 0A:0737, 0x014737
    RTS ; Leave.
XPOS_ADD: ; 0A:0738, 0x014738
    .db 00
    .db F0
    .db 10
SWITCH_0x02_RTN_D: ; 0A:073B, 0x01473B
    JMP SET_OBJ_SECONDARY_TERTIARY_UPDATE
SWITCH_0x02_RTN_E: ; 0A:073E, 0x01473E
    JMP SET_SECONDARY_0x01_TERTIARY_0x0A
SWITCH_0x02_RTN_F: ; 0A:0741, 0x014741
    JMP SET_SECONDARY_0x01_TERTIARY_0x0B
SWITCH_0x02_RTN_K: ; 0A:0744, 0x014744
    JMP SET_SECONDARY_TERTIARY_DISPLAY_MORE
SWITCH_0x02_RTN_L: ; 0A:0747, 0x014747
    JMP SET_SECONDARY_0x01_TERTIARY_0x0E_MORE
PAIR_OBJS_CREATE_UNK: ; 0A:074A, 0x01474A
    STA TMP_16 ; Store obj Xpos to.
    LDA #$02 ; Loops - 1
    STA TMP_17 ; Store.
LOOP_RTN: ; 0A:0750, 0x014750
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Find pair.
    BCS RTS ; Failed to get pair, leave.
    LDA #$04
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set obj state.
    LDA TMP_16
    STA OBJ_POS_X_CONFIRMED[18],X ; Set from other obj.
    LDA #$70 ; Val?
    STA OBJ_POS_X??[18],X ; Set
    LDA #$04 ; Val?
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set.
    LDA TMP_17 ; Load loop count.
    ASL A ; >> 1, /2
    TAY ; To index.
    LDA OBJ_DATA_A,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Set pair.
    LDA OBJ_DATA_B_PAIR_HOLD,Y
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Set pair.
    LDA OBJ_DATA_C
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set
    LDA OBJ_DATA_D
    STA OBJ_POS_X_DELTA?[18],X ; Set.
    LDA OBJ_DATA_E
    STA 520_OBJ_POS_X_LARGE?[18],X ; Set
    LDA OBJ_DATA_F
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Set.
    DEC TMP_17 ; --
    BPL LOOP_RTN ; Positive, loop.
RTS: ; 0A:0795, 0x014795
    RTS
OBJ_DATA_C: ; 0A:0796, 0x014796
    .db 80
OBJ_DATA_D: ; 0A:0797, 0x014797
    .db 01
OBJ_DATA_E: ; 0A:0798, 0x014798
    .db 9A
OBJ_DATA_F: ; 0A:0799, 0x014799
    .db 02
OBJ_DATA_A: ; 0A:079A, 0x01479A
    .db 14
OBJ_DATA_B_PAIR_HOLD: ; 0A:079B, 0x01479B
    .db 0F ; TODO: Mistake because not 2 entries for data A/B?
    .db 0A
    .db 19
    .db 01
    .db 23
    STA TMP_16 ; TODO: This another version of above?
    LDA #$02
    STA TMP_17
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL
    BCS 0A:07DF
    LDA #$02
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA TMP_16
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA #$88
    STA OBJ_POS_X??[18],X
    LDA #$05
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA TMP_17
    ASL A
    TAY
    LDA 0A:07E2,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA 0A:07E3,Y
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA 0A:07E0
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA 0A:07E1
    STA 503_OBJ_POS_X_LARGEST?[18],X
    DEC TMP_17
    BPL 0A:07A6
    RTS
    .db 80
    .db 00
    .db 59
    .db 30
    .db 39
    .db 30
    .db 19
    .db 30
SWITCH_0x02_RTN_G: ; 0A:07E8, 0x0147E8
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear
    JSR XPOS_RANDOMNESS ; Xpos from randomness.
    JSR RANDOMNESS ; More
    AND #$07 ; Keep bottom bits.
    TAY ; To Y index.
    LDA ALT_RTN+DATA,Y ; NOTE: Table in this routine, didn't need specific data?
    STA OBJ_POS_X??[18],X ; To.
4A2_ADD_LT_0xE0: ; 0A:0806, 0x014806
    LDY OBJ_POS_X_CONFIRMED[18],X ; Load to Y.
    LDA OBJ_POS_X??[18],X ; Load
    JSR RTN_BACKGROUND_TILE_RELATED? ; Get tile?
    CMP #$03 ; If _ #$03
    BEQ SET_UNK_AND_DO_SWITCHES+MORE ; ==, goto.
    CLC ; Prep add
    LDA OBJ_POS_X??[18],X ; Load
    ADC #$10 ; += 0x10
    STA OBJ_POS_X??[18],X ; Store back.
    CMP #$E0 ; If _ #$E0
    BCC 4A2_ADD_LT_0xE0 ; Loop if LT.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init?
ALT_RTN+DATA: ; 0A:0823, 0x014823
    LDY #$A8
    BCS 0A:07DF
    CPY #$C8
    BNE 0A:0803
SET_UNK_AND_DO_SWITCHES+MORE: ; 0A:082B, 0x01482B
    LDA #$20
    STA 4C6_OBJ_UNK[18],X ; Set val.
    JMP SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do.
XPOS_RANDOMNESS: ; 0A:0833, 0x014833
    JSR RANDOMNESS ; Randomness?
    ADC RANDOM_VALS?[2] ; More random.
    LSR A ; >> 1, /2.
    AND #$0F ; Keep bottom bits.
    CMP #$0C ; If _ #$0C
    BCC LESS_THAN_0x0C ; <, goto.
    JSR RANDOMNESS ; More randomness?
    ADC RANDOM_VALS?[2] ; Add val.
    LSR A ; >> 1, /2.
    AND #$0F ; Keep bottom bits.
    CMP #$0C ; If _ #$0C
    BCC LESS_THAN_0x0C ; <, goto.
    SBC #$05 ; -= 0x05, range 0x00 - 0x08
LESS_THAN_0x0C: ; 0A:084D, 0x01484D
    ASL A ; << 4, *16.
    ASL A
    ASL A
    ASL A
    ADC #$20 ; += 0x20
    STA OBJ_POS_X_CONFIRMED[18],X ; Store X pos.
    RTS
SWITCH_0x02_RTN_H: ; 0A:0857, 0x014857
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Extra clear
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No hold.
    JMP SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Dir and pos.
SWITCH_0x02_RTN_I: ; 0A:086F, 0x01486F
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$0C
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No hold timer.
    RTS
SCREEN_DATA_UNK_A: ; 0A:0885, 0x014885
    .db E0
    .db E0
    .db CA
    .db AD
    .db E0
    .db E0
    .db E0
    .db E0
    .db A2
    .db E0
    .db E0
    .db E0
    .db E0
    .db E0
    .db E0
    .db E0
SCREEN_DATA_UNK_B: ; 0A:0895, 0x014895
    .db 00
    .db 00
    .db AC
    .db F0
    .db 00
    .db 00
    .db 00
    .db 00
    .db DC
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
SCREEN_DATA_UNK_C: ; 0A:08A5, 0x0148A5
    .db 00
    .db 00
    .db 01
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 02
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
SWITCH_0x02_RTN_J: ; 0A:08B5, 0x0148B5
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$15
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$01
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    JSR RANDOMNESS ; Do randomness.
    AND #$3F ; Keep bottom.
    ADC #$20 ; Add
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set as hold.
    LDA #$7A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    LSR A ; >> 1
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$BF ; Keep 0x10111111
    BCS SKIP_SET_FLAG_A ; Update bit 0x01 was set, goto.
    ORA #$40 ; Set bit.
SKIP_SET_FLAG_A: ; 0A:08E0, 0x0148E0
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store direction.
    LDY #$00 ; Seed val.
    BCS SKIP_SET_FLAG_B
    LDY #$02 ; If set, use val instead.
SKIP_SET_FLAG_B: ; 0A:08E9, 0x0148E9
    LDA DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move dir-specific data.
    LDA DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$26
    JMP SND_BANKED_DISPATCH ; Play sound.
DATA_A: ; 0A:08FA, 0x0148FA
    .db 80
DATA_B: ; 0A:08FB, 0x0148FB
    .db FD
    .db 80
    .db 02
HANDLER_0x01_MULTISWITCH_B: ; 0A:08FE, 0x0148FE
    LOW(S01_MSB_RTN_A) ; Setup, animation.
    HIGH(S01_MSB_RTN_A)
    LOW(S01_MSB_RTN_B) ; Finds closest, move, sound, animation.
    HIGH(S01_MSB_RTN_B)
    LOW(S01_MSB_RTN_C) ; Pos, animation.
    HIGH(S01_MSB_RTN_C)
    LOW(S01_MSB_RTN_D) ; Pos, animation.
    HIGH(S01_MSB_RTN_D)
    LOW(S01_MSB_RTN_D)
    HIGH(S01_MSB_RTN_D)
    LOW(S01_MSB_RTN_D)
    HIGH(S01_MSB_RTN_D)
    LOW(S01_MSB_RTN_E) ; New state at end of hold.
    HIGH(S01_MSB_RTN_E)
    LOW(S01_MSB_RTN_F) ; Move, to other state.
    HIGH(S01_MSB_RTN_F)
    LOW(S01_MSB_RTN_G) ; WARNING: More switches ahead. 0.o
    HIGH(S01_MSB_RTN_G)
    LOW(S01_MSB_RTN_H) ; Move, anim, pair.
    HIGH(S01_MSB_RTN_H)
    LOW(S01_MSB_RTN_I) ; Move, anim, pair based?
    HIGH(S01_MSB_RTN_I)
    LOW(S01_MSB_RTN_J) ; Pair, solving, state move.
    HIGH(S01_MSB_RTN_J)
    LOW(S01_MSB_RTN_K) ; Hold timer, animation, state move.
    HIGH(S01_MSB_RTN_K)
    LOW(S01_MSB_RTN_L) ; Move, animation, data, state move.
    HIGH(S01_MSB_RTN_L)
    LOW(S01_MSB_RTN_M) ; Range, animation, move, state.
    HIGH(S01_MSB_RTN_M)
S01_MSC_RTN_B: ; 0A:091C, 0x01491C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR SUB_HOLD/STEP_STUFF ; Do.
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do.
    BCC CC_RET ; Ret CC, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear
    JSR RANDOMNESS ; Do.
    AND #$0F ; Keep 0000.1111
    ORA #$10 ; Set 0001.0000
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Store to hold.
CC_RET: ; 0A:0938, 0x014938
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE ANY_FLAGS_SET ; If value, goto.
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; -- for pair.
    BMI PAIR_HOLD_NEGATIVE ; If now negative, goto.
    LDY OBJ_POS_X_CONFIRMED[18],X ; Xpos to Y.
    LDA OBJ_POS_X??[18],X ; Load
    CLC
    ADC 4C6_OBJ_UNK+1,X ; Add with pair.
    JSR UNK_SUB_B ; Do sub.
    BEQ FIND_FOCUS_AND_STATE_MOVE ; Ret eq zero, goto.
ANY_FLAGS_SET: ; 0A:0951, 0x014951
    JMP MOVE_Y_FINALIZE ; Goto.
PAIR_HOLD_NEGATIVE: ; 0A:0954, 0x014954
    JSR FOCUS_FIND_CLOSEST_SEED_0x00 ; Focus
    LDA 712_FLAG_PALETTE_UNK ; Load
    BNE PALETTE_FLAG_SET ; If set, goto.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    LDA OBJ_DATA_INDEX_UNK,Y ; Load from obj index.
    BEQ PALETTE_FLAG_SET ; If 0, goto.
    JMP RTN_UNK ; Goto.
PALETTE_FLAG_SET: ; 0A:0967, 0x014967
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Goto state.
FIND_FOCUS_AND_STATE_MOVE: ; 0A:096A, 0x01496A
    JSR FOCUS_FIND_CLOSEST_SEED_0x00 ; Find.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Goto state.
SET_SECONDARY/TERTIARY_DIRECTION_MORE: ; 0A:0970, 0x014970
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tertiary.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load flags.
    BNE FLAGS_NE_ZERO ; != 0, goto.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; No hold timer for secondary.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load obj?
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load Xpos for X.
    CMP OBJ_POS_X_CONFIRMED[18],Y ; If X.Xpos _ Y.Xpos
    LDA #$00 ; Prep vals. Direction related.
    LDY #$02 ; Index.
    BCS X_LARGER ; >=, goto.
    LDA #$40 ; Prep alternates.
    LDY #$04
X_LARGER: ; 0A:0997, 0x014997
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; A to direction.
    JMP OBJ_SET_UNK_FROM_Y ; Set from Y.
FLAGS_NE_ZERO: ; 0A:099D, 0x01499D
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    CMP #$02 ; If _ #$02
    LDA #$00 ; Prep vals. Direction related.
    LDY #$02 ; Index.
    BCC 0A:09AC ; <, goto.
    LDA #$40 ; Prep alt.
    LDY #$04
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store direction.
OBJ_SET_UNK_FROM_Y: ; 0A:09AF, 0x0149AF
    LDA DATA_UNK_A,Y ; Move from arrs to obj.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA DATA_UNK_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    RTS
DATA_UNK_A: ; 0A:09BC, 0x0149BC
    .db 00
DATA_UNK_B: ; 0A:09BD, 0x0149BD
    .db 00
    .db 00
    .db FE
    .db 00
    .db 02
S01_MSB_RTN_G: ; 0A:09C2, 0x0149C2
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load pair data.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on pair.
    LOW(PAIR_RTN_A) ; Animation, move, randomness.
    HIGH(PAIR_RTN_A)
    LOW(PAIR_RTN_B) ; Move, maintain hold, pair, sound.
    HIGH(PAIR_RTN_B)
    LOW(PAIR_RTN_C) ; Move, switch state shift.
    HIGH(PAIR_RTN_C)
PAIR_RTN_A: ; 0A:09D3, 0x0149D3
    LDA #$04
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do
    BCC RET_CC ; If carry not set, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; No update.
    JSR RANDOMNESS ; Get random.
    AND #$3F ; Range 0x00 - 0x3F, 0 to 64 frames.
    ADC #$20 ; += 0x20, 32 frames.
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Set hold for pair.
RET_CC: ; 0A:09EF, 0x0149EF
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load update
    BNE RTS ; If any set, leave.
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; Pair hold--
    BPL RTS ; Pair hold still positive, leave.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Move pair data.
    LDA #$FF ; Hold seed.
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Store.
RTS: ; 0A:0A01, 0x014A01
    RTS ; Leave.
PAIR_RTN_B: ; 0A:0A02, 0x014A02
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Move
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Next
    LDA #$FF
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Still holding.
    LDA #$09
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Set pair.
    LDA #$43
    JMP SND_BANKED_DISPATCH ; Play sound.
PAIR_RTN_C: ; 0A:0A1A, 0x014A1A
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Move.
    INC OBJ_ANIM_HOLD_TIMER?+1,X ; Hold++
    BNE HOLD_NONZERO ; If has val.
    LDA RTN_C_DATA ; Data, 0x80
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store to.
    LDA RTN_C_DATA ; Data, 0xFA
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store to.
HOLD_NONZERO: ; 0A:0A2E, 0x014A2E
    LDA #$30
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Move
    BCC OBJ_FINALIZE ; If CC, finalize.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 4D8_OBJ_UNK[18],X
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move state.
    JSR OBJ_PAIR_SWITCH_MOD ; Mod pair.
OBJ_FINALIZE: ; 0A:0A43, 0x014A43
    JMP MOVE_Y_FINALIZE ; Abuse RTS.
RTN_C_DATA: ; 0A:0A46, 0x014A46
    .db 80
RTN_C_DATA: ; 0A:0A47, 0x014A47
    .db FA
SET_OBJ_SECONDARY_0x01_TERTIARY_0x08_DIRECTION_POS_MORE: ; 0A:0A48, 0x014A48
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$08
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tertiary.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load update
    BNE UPDATE_NONZERO ; != 0, goto.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Set
UPDATE_NONZERO: ; 0A:0A5A, 0x014A5A
    LSR A ; >> 1
    LDA #$00 ; Prep vals. Val
    LDY #$00 ; Index
    BCS SHIFTED_ONE ; Bit was set, goto.
    LDA #$40 ; Alt vals.
    LDY #$02
SHIFTED_ONE: ; 0A:0A65, 0x014A65
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Set
    LDA OBJ_DATA_A,Y ; Move.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Clear on pair.
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA OBJ_POS_X??[18],X ; Load
    STA OBJ_POS_Y_CONFIRMED[18],X ; To Y.
    RTS ; Leave.
OBJ_DATA_A: ; 0A:0A83, 0x014A83
    .db 80
OBJ_DATA_B: ; 0A:0A84, 0x014A84
    .db FE
    .db 80
    .db 01
S01_MSB_RTN_H: ; 0A:0A87, 0x014A87
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    JSR MOVE_UNK_RET_?? ; Move
    LDA #$40
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Move
    BCC MOVE_CC ; If CC, goto.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 4D8_OBJ_UNK[18],X
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; State to.
    JSR OBJ_PAIR_SWITCH_MOD ; Pair mod.
MOVE_CC: ; 0A:0AA4, 0x014AA4
    LDA #$09
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display animation.
    JMP MOVE_Y_FINALIZE ; Finalize.
SET_OBJ_SECONDARY_TERTIARY_UPDATE: ; 0A:0AAC, 0x014AAC
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set
    LDA #$09
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set
    LDA #$00
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Clear
    LDA OBJ_DATA_UNK[4] ; Move from ROM.
    STA 520_OBJ_POS_X_LARGE?[18],X ; To object.
    LDA OBJ_DATA_UNK+1
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA OBJ_DATA_UNK+2
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_UNK+3
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JMP SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do.
OBJ_DATA_UNK: ; [4], 0A:0AD6, 0x014AD6
    .db 40
    .db 00
    .db 00
    .db FD
S01_MSB_RTN_I: ; 0A:0ADA, 0x014ADA
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load pair.
    BEQ PAIR_DATA_EQ_ZERO ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Pair--
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear for main.
RTS: ; 0A:0AEC, 0x014AEC
    RTS ; Leave.
PAIR_DATA_EQ_ZERO: ; 0A:0AED, 0x014AED
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do..
    JSR MOVE_UNK_RET_?? ; Do..
    JSR MOVE_Y_FINALIZE ; Do..
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE ; Do..
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; -- pair.
    BNE RTS ; If not zero, leave.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Move main to state if hold is done.
SET_SECONDARY_0x01_TERTIARY_0x0A: ; 0A:0B01, 0x014B01
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$0A
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tertiary.
    RTS
S01_MSB_RTN_L: ; 0A:0B0C, 0x014B0C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load pair data.
    BMI PAIR_VAL_NEG ; If negative, goto.
    CMP #$12 ; If _ #$12
    BCS GTE_TWELVE ; >=, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Inc pair data.
    LDY #$00 ; Index
    CMP #$06 ; If data _ #$06
    BCC INDEX_DECIDED ; <, goto.
    INY ; Index++
    CMP #$0C ; If data _ #$0C
    BCC INDEX_DECIDED ; <, goto.
    INY ; Index++
INDEX_DECIDED: ; 0A:0B2C, 0x014B2C
    LDA DISPLAY_DATA,Y ; Load data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display.
    LDA #$D4
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Swap GFX banks.
    LDA #$29
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
    JMP JMP_TO_Y_FINALIZE ; Finalize
GTE_TWELVE: ; 0A:0B3D, 0x014B3D
    LDA #$F6
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Store to pair data.
    LDA OBJ_DATA_A ; Move data to objects.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA OBJ_DATA_D
    STA 503_OBJ_POS_X_LARGEST?[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Set pair.
JMP_TO_Y_FINALIZE: ; 0A:0B5D, 0x014B5D
    JMP MOVE_Y_FINALIZE ; FInalize.
PAIR_VAL_NEG: ; 0A:0B60, 0x014B60
    JSR MOVE_UNK_RET_?? ; Do..
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$E2 ; If _ #$E2
    BCC UNDER_MAX
    LDA #$E1
    STA OBJ_POS_X??[18],X ; Set max.
UNDER_MAX: ; 0A:0B6F, 0x014B6F
    LDA #$40
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Move
    BCC JMP_TO_Y_FINALIZE ; Ret CC, finalize.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear
    STA 4D8_OBJ_UNK[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA OBJ_POS_X??[18],X ; Load
    STA OBJ_POS_Y_CONFIRMED[18],X ; To Y.
    JSR OBJ_PAIR_SWITCH_MOD ; Pair mod.
    JSR SUB_GFX_BANKS_FROM_STATE ; Set GFX.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Set state.
SET_SECONDARY_TERTIARY_DISPLAY_MORE: ; 0A:0B90, 0x014B90
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches
    LDA #$0D
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display change.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; To pair, unk.
    JMP SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
OBJ_DATA_A: ; 0A:0BA5, 0x014BA5
    .db 00
OBJ_DATA_B: ; 0A:0BA6, 0x014BA6
    .db FA
OBJ_DATA_C: ; 0A:0BA7, 0x014BA7
    .db 80
OBJ_DATA_D: ; 0A:0BA8, 0x014BA8
    .db 00
DISPLAY_DATA: ; 0A:0BA9, 0x014BA9
    .db A2
    .db A3
    .db A4
S01_MSB_RTN_M: ; 0A:0BAC, 0x014BAC
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Move.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Data from pair.
    CMP #$E0 ; If _ #$E0
    BCS GT_#$E0 ; >=, goto.
    CMP #$88 ; If _ #$88
    BCS GT_#$88 ; >=, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load from pair.
    CMP #$40 ; If _ #$40
    BCC LT_#$40 ; <, goto.
    LDY #$00 ; Index
    CMP #$50 ; If _ #$50
    BCC INDEX_DECIDED ; LT_#$50
    INY ; Index++
    CMP #$68 ; If _ #$68
    BCC INDEX_DECIDED ; <, goto.
    INY ; Index++
INDEX_DECIDED: ; 0A:0BD2, 0x014BD2
    LDA OBJ_DATA_ANIM_DISPLAY,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation to display.
    LDA #$D5
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; Set GFX for animation.
    LDA #$29
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5
JMP_TO_FINALIZE: ; 0A:0BE0, 0x014BE0
    JMP MOVE_Y_FINALIZE ; Goto.
LT_#$40: ; 0A:0BE3, 0x014BE3
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; No change in display?
    JMP JMP_TO_FINALIZE ; Goto.
GT_#$88: ; 0A:0BEB, 0x014BEB
    LDA #$F0
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Store extra.
    LDA OBJ_DATA_A
    STA 520_OBJ_POS_X_LARGE?[18],X ; Move data to OBJ.
    LDA OBJ_DATA_B
    STA 503_OBJ_POS_X_LARGEST?[18],X
    JSR SUB_GFX_BANKS_FROM_STATE ; Set GFX.
STATE/ANIMATION/DIR_MOD/FINALIZE_RE-ENTER: ; 0A:0BFF, 0x014BFF
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE ; State and animation.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
GT_#$E0: ; 0A:0C08, 0x014C08
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JSR MOVE_UNK_RET_?? ; Move.
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$E2 ; If _ #$E2
    BCC LT_#$E2
    LDA #$E1 ; Max
    STA OBJ_POS_X??[18],X ; Store.
LT_#$E2: ; 0A:0C1A, 0x014C1A
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; pair++
    BNE STATE/ANIMATION/DIR_MOD/FINALIZE_RE-ENTER
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 4D8_OBJ_UNK[18],X
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Goto state.
SET_SECONDARY_0x01_TERTIARY_0x0E_MORE: ; 0A:0C2A, 0x014C2A
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set switches.
    LDA #$0E
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Clear disp.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Clear pair data.
    RTS ; Leave.
OBJ_DATA_A: ; 0A:0C3D, 0x014C3D
    .db 00
OBJ_DATA_B: ; 0A:0C3E, 0x014C3E
    .db 01
OBJ_DATA_ANIM_DISPLAY: ; 0A:0C3F, 0x014C3F
    .db A5
    .db A6
    .db A7
S01_MSB_RTN_J: ; 0A:0C42, 0x014C42
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load pair.
    BEQ PAIR_DATA_ZERO ; If 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; --
PAIR_HOLD_NONZERO: ; 0A:0C4F, 0x014C4F
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do..
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE ; Do..
    JMP MOVE_Y_FINALIZE ; Move finalize, abuse RTS.
PAIR_DATA_ZERO: ; 0A:0C58, 0x014C58
    JSR MOVE_UNK_RET_?? ; dO..
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; Dec hold from pair.
    BNE PAIR_HOLD_NONZERO ; If not zero, do.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Goto if zero.
SET_SECONDARY_0x01_TERTIARY_0x0B: ; 0A:0C63, 0x014C63
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0B
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS
S01_MSB_RTN_A: ; 0A:0C6E, 0x014C6E
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do...
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BNE Y_HAS_VAL ; If has value, do instead.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LSR A ; >> 1, /2 prev. Once every 2 frames, update.
    TAY ; To Y index.
    LDA ANIMATIONS_TO_DISPLAY,Y ; Load for hold.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display.
    CPY #$03 ; If index _ #$03
    BNE FINALIZE_OBJECT ; !=, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
    LDA OBJ_DATA_A ; Store data.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA OBJ_DATA_D
    STA 503_OBJ_POS_X_LARGEST?[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
FINALIZE_OBJECT: ; 0A:0CAB, 0x014CAB
    JMP MOVE_Y_FINALIZE ; Move object.
Y_HAS_VAL: ; 0A:0CAE, 0x014CAE
    JSR MOVE_UNK_RET_?? ; Do.
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$E8 ; If _ #$E8
    BCC DONT_CAP ; <, goto.
    LDA #$E7 ; Cap val.
    STA OBJ_POS_X??[18],X ; Store max.
DONT_CAP: ; 0A:0CBD, 0x014CBD
    LDA #$40 ; Val?
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    BCC FINALIZE_OBJECT ; If carry clear, finalize.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 4D8_OBJ_UNK[18],X
    LDA OBJ_POS_X??[18],X ; Load
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to.
    JSR OBJ_PAIR_SWITCH_MOD ; Set pair.
    JMP MOVE_OBJECT_STATE_S3_T13_0HOLD ; Do.
OBJ_DATA_A: ; 0A:0CD8, 0x014CD8
    .db 00
OBJ_DATA_B: ; 0A:0CD9, 0x014CD9
    .db FA
OBJ_DATA_C: ; 0A:0CDA, 0x014CDA
    .db 80
OBJ_DATA_D: ; 0A:0CDB, 0x014CDB
    .db 00
ANIMATIONS_TO_DISPLAY: ; 0A:0CDC, 0x014CDC
    .db 38
    .db 33
    .db 34
    .db 35
S01_MSB_RTN_K: ; 0A:0CE0, 0x014CE0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BNE OBJ_DATA_NONZERO ; Has value, goto.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LSR A ; Shift
    TAY ; To Y inex.
    LDA OBJ_ANIMATION_DISPLAY_DATA,Y ; Load frame to show.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to.
    CPY #$03 ; If OBJ data _ #$03
    BNE NE_THREE ; !=, goto.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
    LDA OBJ_DATA_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set obj data.
    LDA OBJ_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_C
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_D
    STA OBJ_POS_X_DELTA?[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do..
NE_THREE: ; 0A:0D1D, 0x014D1D
    JMP MOVE_Y_FINALIZE ; Finalize.
OBJ_DATA_NONZERO: ; 0A:0D20, 0x014D20
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do..
    LDA #$40
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do..
    BCS CARRY_SET ; If carry set, goto.
    LDA #$85 ; Animation A.
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Y from.
    BMI WRITE_ANIMATION_FROM_A ; If negative, goto.
    LDA #$84 ; Animation B.
WRITE_ANIMATION_FROM_A: ; 0A:0D33, 0x014D33
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation
    JMP NE_THREE ; Finalize. Bad code/mistake, just JMP to it smh.
CARRY_SET: ; 0A:0D39, 0x014D39
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear vals.
    STA 4D8_OBJ_UNK[18],X
    LDA OBJ_POS_X??[18],X ; Load
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to.
    JSR OBJ_PAIR_SWITCH_MOD ; Pair mod.
    JMP OBJ_STATE_SET_S03_T17 ; Move state.
OBJ_DATA_A: ; 0A:0D4D, 0x014D4D
    .db 00
OBJ_DATA_B: ; 0A:0D4E, 0x014D4E
    .db FA
OBJ_DATA_C: ; 0A:0D4F, 0x014D4F
    .db 40
OBJ_DATA_D: ; 0A:0D50, 0x014D50
    .db FF
OBJ_ANIMATION_DISPLAY_DATA: ; 0A:0D51, 0x014D51
    .db 88
    .db 86
    .db 85
    .db 85
S01_MSB_RTN_B: ; 0A:0D55, 0x014D55
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do...
    LDA 4C6_OBJ_UNK[18],X ; Load pre-routine.
    PHA ; Save
    LDA #$20
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do...
    PLA ; Restore.
    BPL 4C6_ORIGINAL_POSITIVE ; If was positive, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load now.
    BPL 4C6_IS_NOW_POSITIVE ; If went negative to positive.
4C6_ORIGINAL_POSITIVE: ; 0A:0D71, 0x014D71
    LDA #$46
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    LDA 4C6_OBJ_UNK[18],X ; Load
    BMI LEAVE_FINALIZE_Y ; If negative, skip rest.
    EOR #$FF ; Compliment
    CLC
    ADC #$01
    STA TMP_00 ; Store to
    SEC ; Prep sub.
    LDA OBJ_POS_X??[18],X ; Load
    SBC TMP_00 ; Sub from compliment.
    BCS NO_UNDERFLOW ; If no underflow, skip display change.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Don't change animation.
    LDA #$01 ; Seed pos?
NO_UNDERFLOW: ; 0A:0D91, 0x014D91
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store POS.
    RTS ; Leave.
LEAVE_FINALIZE_Y: ; 0A:0D95, 0x014D95
    JMP MOVE_Y_FINALIZE
4C6_IS_NOW_POSITIVE: ; 0A:0D98, 0x014D98
    LDA #$00 ; Clear a bnunch.
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    INC OBJ_TERTIARY_SWITCH?[18],X ; Inc tert switch.
    JSR OBJ_PAIR_SWITCH_MOD ; Pair mod.
    LDA #$33 ; Play sound.
    JMP SND_BANKED_DISPATCH
S01_MSB_RTN_C: ; 0A:0DB1, 0x014DB1
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Inc hold.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$08 ; If _ #$08
    BCC HOLD_TIMER_FINISHED ; <, don't set to O.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear timer.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
HOLD_TIMER_FINISHED: ; 0A:0DCE, 0x014DCE
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    CMP #$09 ; If _ #$09
    BCS ALT_ANIMATION_NEXT_TERT ; >=, goto.
    LSR A ; >> 1, /2.
    LDA #$47 ; Load
    BCC SHIFT_SEED_LOWER
    LDA #$48 ; Seed higher, shift was 1 carry.
SHIFT_SEED_LOWER: ; 0A:0DDC, 0x014DDC
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display.
    RTS ; Leave.
ALT_ANIMATION_NEXT_TERT: ; 0A:0DE0, 0x014DE0
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store hold
    LDA #$49
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next multiswitch.
    RTS
S01_MSB_RTN_D: ; 0A:0DEE, 0x014DEE
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE RTS ; If not zero, leave.
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store new hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load displaying.
    CMP #$4C ; If _ #$4C
    BCS RTS ; >=, leave.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Less, add one.
RTS: ; 0A:0E10, 0x014E10
    RTS ; Leave.
S01_MSB_RTN_E: ; 0A:0E11, 0x014E11
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE RTS ; Hold non-zero, leave.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear hold
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; And data.
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move to state.
RTS: ; 0A:0E27, 0x014E27
    RTS ; Leave.
S01_MSB_RTN_F: ; 0A:0E28, 0x014E28
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do..
    BCS UNDERFLOW ; If underflow, goto.
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Load
    ADC OBJ_POS_X_SUBPIXEL?[18],X ; Add to subpixel.
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store to subpixel.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add to.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to.
    ROR A ; Shift
    EOR OBJ_POS_X_DELTA?[18],X ; Invert with delta.
    BPL RTS ; If positive, goto.
UNDERFLOW: ; 0A:0E49, 0x014E49
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    CMP #$10 ; If _ #$10
    BEQ MOVE_TO_S03_T15 ; If enabled == #$10, set to other state.
    LDA #$02 ; Switch to S02, T00.
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
RTS: ; 0A:0E62, 0x014E62
    RTS ; Leave.
MOVE_TO_S03_T15: ; 0A:0E63, 0x014E63
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$15
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
HANDLER_0x01_MULTISWITCH_C: ; 0A:0E6E, 0x014E6E
    LOW(S01_MSC_RTN_A) ; Does a ton.
    HIGH(S01_MSC_RTN_A)
    LOW(S01_MSC_RTN_B) ; Focus, randomness, ??
    HIGH(S01_MSC_RTN_B)
    LOW(S01_MSC_RTN_C) ; Pair hold, per level tert for pair, animation.
    HIGH(S01_MSC_RTN_C)
    LOW(S01_MSC_RTN_D) ; Pair hold, animation.
    HIGH(S01_MSC_RTN_D)
S01_MSC_RTN_D: ; 0A:0E76, 0x014E76
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load pair hold.
    BNE PAIR_HELD ; Held, goto.
    LDA #$09 ; Animation.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Y from
    CPY #$0A ; If _ #$0A
    BNE ANIMATION_ASIS ; !=, goto.
    LDA #$57 ; Alt animation.
ANIMATION_ASIS: ; 0A:0E8E, 0x014E8E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do
    JSR MOVE_UNK_RET_?? ; Do.
    LDA OBJ_POS_X??[18],X ; Load
    CMP #$E0 ; If _ #$E0
    BCC LT_0xE0
    LDA #$E0
    STA OBJ_POS_X??[18],X ; Set 0xE0
LT_0xE0: ; 0A:0EA3, 0x014EA3
    LDA #$40
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do
    BCC RET_CC ; CC, goto.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?+1,X ; Clear pair.
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move state.
    JSR OBJ_PAIR_SWITCH_MOD ; Mod.
RET_CC: ; 0A:0EBB, 0x014EBB
    JMP MOVE_Y_FINALIZE ; Finalize.
PAIR_HELD: ; 0A:0EBE, 0x014EBE
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; --
    RTS ; Leave.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$56
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$0A
    BEQ 0A:0EE5
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE
    LDA #$08
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?+1,X
    LDY LEVEL/SCREEN_ON
    LDA PER_SCREEN_INDEX_VALUES,Y
    ASL A
    ASL A
    TAY
    LDA 0A:0F20,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:0F21,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:0F22,Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA 0A:0F23,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    RTS
PER_SCREEN_INDEX_VALUES: ; 0A:0F10, 0x014F10
    .db 00
    .db 00
    .db 01
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 02
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
    .db FD
    .db 80
    .db 00
    .db 00
    .db FD
    .db D0
    .db 00
    .db 00
    .db FD
    .db D0
    .db 00
    .db 00
    .db FD
    .db 80
    .db 00
    .db 00
    .db FD
    .db 80
    .db 00
S01_MSC_RTN_C: ; 0A:0F38, 0x014F38
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Move?
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load pair
    BNE PAIR_HELD ; If set, goto.
    LDA #$09 ; Animation.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Y from OBJ.
    CPY #$0A ; If _ #$0A
    BNE SKIP_OTHER_ANIMATION ; !=, goto.
    LDA #$57 ; Animation.
SKIP_OTHER_ANIMATION: ; 0A:0F50, 0x014F50
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Do.
    JSR MOVE_UNK_RET_?? ; Do.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Load pair.
    CMP OBJ_POS_X??[18],X ; If _ var
    BCC SKIP_UNK ; <, goto.
    STA OBJ_POS_X??[18],X ; Store from pair to.
    INC OBJ_POS_X??[18],X ; ++
SKIP_UNK: ; 0A:0F67, 0x014F67
    LDA #$40
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI SKIP_UNK ; Negative, goto.
    LDA 4D8_OBJ_UNK+1,X ; Load from pair.
    CMP 4C6_OBJ_UNK[18],X ; If _ Xobj
    BCS SKIP_UNK ; >=, goto.
    STA 4C6_OBJ_UNK[18],X ; Store
    LDY LEVEL/SCREEN_ON ; Load screen
    LDA SCREEN_TERTS_PER_LEVEL,Y ; Load for screen.
    STA OBJ_TERTIARY_SWITCH?+1,X ; Set pair tert.
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Do.
    JSR OBJ_PAIR_SWITCH_MOD ; Do.
SKIP_UNK: ; 0A:0F8A, 0x014F8A
    JMP MOVE_Y_FINALIZE ; Goto.
PAIR_HELD: ; 0A:0F8D, 0x014F8D
    DEC OBJ_ANIM_HOLD_TIMER?+1,X ; --
    RTS ; Leave.
RTN_UNK: ; 0A:0F91, 0x014F91
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA #$56
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    CPY #$0A ; If _ #$0A
    BEQ FOCUS_OBJ_0x0A ; ==, goto.
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Set.
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE ; Finalize.
FOCUS_OBJ_0x0A: ; 0A:0FB2, 0x014FB2
    LDY LEVEL/SCREEN_ON ; Load screen.
    LDA PER_SCREEN_INDEX_VALUES,Y ; Load per screen.
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA SCREEN_DATA_UNK_A,Y ; Move to Xobj.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA SCREEN_DATA_UNK_B,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA SCREEN_DATA_UNK_C,Y ; Move to pair.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Pair hold.
    LDA OTHER_DATA_0x40 ; Move to Xobj.
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA OTHER_DATA_0xFF
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
DATA_TERTIARY_NEXT_UNK: ; 0A:0FDE, 0x014FDE
    .db 00
    .db AC
    .db DC
    .db F0
    .db A9
    .db A9
    .db A9
SCREEN_DATA_A: ; 0A:0FE5, 0x014FE5
    .db 00
    .db 00
    .db AC
    .db F0
    .db 00
    .db 00
    .db 00
    .db 00
    .db DC
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
SCREEN_TERTS_PER_LEVEL: ; 0A:0FF5, 0x014FF5
    .db 00
    .db 00
    .db 01
    .db 03
    .db 00
    .db 00
    .db 00
    .db 00
    .db 02
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
OTHER_DATA_0x40: ; 0A:1005, 0x015005
    .db 40
OTHER_DATA_0xFF: ; 0A:1006, 0x015006
    .db FF
SCREEN_DATA_UNK_A: ; 0A:1007, 0x015007
    .db 80
SCREEN_DATA_UNK_B: ; 0A:1008, 0x015008
    .db F8
SCREEN_DATA_UNK_C: ; 0A:1009, 0x015009
    .db 80
    .db 00
    .db 80
    .db F8
    .db C2
    .db 00
    .db 00
    .db FA
    .db 9A
    .db 00
    .db 00
    .db FB
    .db 9A
    .db 00
OBJ_STATE_MOVE_TO_S02_T00: ; 0A:1017, 0x015017
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tertiary.
    RTS
S01_MSC_RTN_A: ; 0A:1022, 0x015022
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BEQ ALT_RTN
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Do if none.
ALT_RTN: ; 0A:102A, 0x01502A
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1, *2.
    BMI SKIP_RTN ; If negative, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load from pair.
    BEQ SKIP_RTN ; Zero, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; pair--
    BNE SKIP_RTN ; Still not zero, goto.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ var
    BNE SKIP_RTN ; !=, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$EF ; Keep 1110.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
SKIP_RTN: ; 0A:1047, 0x015047
    JSR XOBJ_CMP_STUFF_RET_CS_CLEARED_CC_NO_MOD ; Do sub.
    BCC RET_CLEARED ; If cleared, goto.
    RTS ; Leave if obj gone.
RET_CLEARED: ; 0A:104D, 0x01504D
    JSR RTN_BOX_DETECT? ; Do..
    LDA TMP_10 ; Load
    STA TMP_16 ; Store to.
    LDA TMP_11 ; Load
    STA TMP_17 ; Store to.
    JSR HIT_DETECT?_UNK ; Do..
    JSR RTN_UNK_BITS_SET_IDK ; Do..
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; >> 1, *2.
    BPL SHIFT_POSITIVE ; If positive, goto.
    JMP RTN_UNK ; Goto.
SHIFT_POSITIVE: ; 0A:1067, 0x015067
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load other object.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load secondary of Yobj.
    AND #$04 ; Test 0000.0100
    BEQ TEST_CLEARED ; If not set, goto.
    JMP RTN_UNK_OTHER ; Do if set.
TEST_CLEARED: ; 0A:1074, 0x015074
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    CMP #$0B ; If _ #$0B
    BNE NOT_0x0B ; !=, goto.
    LDA RANDOM_VALS?[2] ; Load
    AND #$3F ; Keep 0011.1111
    BEQ RANDOM_ZERO ; If zero, goto.
    JMP RTN_UNK_OTHER ; Goto.
RANDOM_ZERO: ; 0A:1084, 0x015084
    LDA TMP_16 ; Load
    CMP #$60 ; If _ #$60
    BCC UNDER_0x60 ; <, goto.
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Abuse RTS.
UNDER_0x60: ; 0A:108D, 0x01508D
    JMP RTN_UNK_XSWITCH ; Do switch sub.
NOT_0x0B: ; 0A:1090, 0x015090
    LDA TMP_17 ; Load
    CMP #$07 ; If _ #$07
    BCC UNDER_0x17 ; <, goto.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Clear in OBJ.
    JMP RTN_UNK_OTHER ; Goto.
UNDER_0x17: ; 0A:109E, 0x01509E
    INC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; ++
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Load
    CMP #$01 ; If _ #$01
    BEQ 5B0_VAL_EQ_0x01 ; ==, goto.
    LDY LEVEL/SCREEN_ON ; Load screen.
    CMP COMPARE_PER_SCREEN_UNK,Y ; Compare value for screen.
    BCC RTN_UNK_OTHER ; <, goto.
5B0_VAL_EQ_0x01: ; 0A:10AF, 0x0150AF
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load from obj.
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Combine with.
    BNE SKIP_UNK ; If either set, skip.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair.
    BNE SKIP_UNK ; If set, skip.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load other object.
    LDA 4C6_OBJ_UNK[18],Y ; Load from other.
    BEQ SKIP_UNK ; If not set, skip.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from Yobj.
    AND #$0F ; Keep 0000.1111
    BNE SKIP_UNK ; If any set, skip.
    JSR SUB_UNK ; Do sub.
    BCC SKIP_UNK ; If CC ret, skip.
    JMP RTN_UNK ; CS ret, do.
SKIP_UNK: ; 0A:10D3, 0x0150D3
    LDA TMP_16 ; Load
    CMP #$80 ; If _ #$80
    BCC RTN_UNK_XSWITCH ; <, goto. Coulda just BPL'd, hmm.
    JSR SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Do.
    JMP FINALIZATION ; Do.
RTN_UNK_XSWITCH: ; 0A:10DF, 0x0150DF
    JSR SUB_SWITCH_XOBJ_UNK ; Do sub.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    CMP #$03 ; If _ #$03
    BNE RTN_UNK_OTHER ; !=, goto.
    JSR MOVE_Y_FINALIZE ; Move.
    JMP SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do, abuse RTS.
RTN_UNK_OTHER: ; 0A:10EF, 0x0150EF
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ var
    BNE XOBJ_NOT_719_VAR ; !=, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    AND #$10 ; Keep 0001.0000
    BEQ BIT_0x10_UNSET ; Not set, goto.
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load pair.
    AND #$02 ; Test 0000.0010
    BNE BIT_0x02_SET ; If set, goto.
    ASL OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Shift.
    ROL OBJ_POS_X_DELTA?[18],X ; Roll to.
    ASL 520_OBJ_POS_X_LARGE?[18],X ; Shift
    ROL 503_OBJ_POS_X_LARGEST?[18],X ; Roll to.
BIT_0x02_SET: ; 0A:110E, 0x01510E
    JMP RTN_UNK ; Goto.
BIT_0x10_UNSET: ; 0A:1111, 0x015111
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Combine with these.
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BNE RTN_UNK ; If any set, goto.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Losd pair.
    EOR #$01 ; Set 0000.0001
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Store back.
    INC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; ++
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Load
    CMP #$04 ; If _ #$04
    BCC RTN_UNK ; <, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from Xobj.
    ORA #$10 ; Set 0001.0000
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$00
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Clear pair.
    LDA #$C8
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Store to pair.
    RTS ; Leave.
XOBJ_NOT_719_VAR: ; 0A:1144, 0x015144
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load from pair.
    AND #$02 ; Test 0000.0010
    BNE RTN_UNK ; If set, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load obj from Xobj.
    LDA 4C6_OBJ_UNK[18],Y ; Load from Yobj.
    BNE RTN_UNK ; If set, skip.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load from Yobj.
    AND #$04 ; Test 0000.0100
    BNE RTN_UNK ; If set, goto.
    LDY OBJ_INDEXES_GROUP_UNK[3] ; Y from var.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    ASL A ; << 1
    BMI RTN_UNK ; If 0x40 was set, goto.
    LDY OBJ_INDEXES_GROUP_UNK+1 ; Y from
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    ASL A ; << 1, *2.
    BMI RTN_UNK ; If bit 0x40 was set, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load from Xobj pair.
    BNE RTN_UNK ; If set, goto.
    LDA LEVEL/SCREEN_ON ; Load screen
    CMP #$02 ; If _ #$02
    BEQ RTN_UNK ; ==, goto.
    CMP #$03 ; If _ #$03
    BEQ RTN_UNK ; ==, goto.
    CMP #$08 ; If _ #$08
    BEQ RTN_UNK ; ==, goto.
    JSR SUB_UNK ; Not screen 2, 3, or 8. Do routine.
RTN_UNK: ; 0A:1182, 0x015182
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1.
    BPL SHIFT_POSITIVE ; Positive, goto.
    JSR SUB_UNK
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; --
    BEQ OBJ_CLEAR_AND_SET_PAIR_UNK ; If zero, goto.
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load from pair.
    BNE PAIR_NOT_ZERO ; != 0, goto.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ORA 520_OBJ_POS_X_LARGE?[18],X ; Combine with.
    BEQ OBJ_CLEAR_AND_SET_PAIR_UNK ; If neither set, goto.
    JMP FINALIZATION ; Goto.
OBJ_CLEAR_AND_SET_PAIR_UNK: ; 0A:11A0, 0x0151A0
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from obj.
    AND #$9F ; Keep 0x1001.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$64 ; Set pair to val.
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X
    RTS ; Leave.
PAIR_NOT_ZERO: ; 0A:11AE, 0x0151AE
    DEC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; pair--
    JMP FINALIZATION ; Goto.
SHIFT_POSITIVE: ; 0A:11B4, 0x0151B4
    JSR FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS ; Do..
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    JSR UNK_SUB_A
    LDY OBJ_POS_X_CONFIRMED[18],X
    LDA OBJ_POS_X??[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE 0A:1202
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BEQ 0A:11E6
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BNE 0A:11E6
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BNE 0A:11E6
    JMP 0A:0EC2
    JSR SUB_UNK
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:1202
    LDA RANDOM_VALS?[2]
    LSR A
    BCC 0A:1202
    INC OBJ_POS_X??[18],X
    LDA OBJ_POS_X??[18],X
    CMP #$E1
    BCC 0A:1202
    LDA #$E0
    STA OBJ_POS_X??[18],X
    CPX OBJ_INDEXES_GROUP_UNK+2
    BEQ 0A:121D
    LDA OBJ_POS_X_DELTA?[18],X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    BEQ 0A:121D
    LDA OBJ_POS_X_DELTA?[18],X
    ASL A
    ROL A
    EOR A/B_WHICH_RESULT
    LSR A
    BCS 0A:121D
    JMP FINALIZATION
    JSR 0A:12C4
    LDA OBJ_POS_X??[18],X
    CMP #$38
    BCS 0A:122A
    JMP SUB_UNK_SLOTS_AND_INIT
    CMP #$E1
    BCC 0A:1233
    LDA #$E0
    STA OBJ_POS_X??[18],X
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:123B
    JMP 0A:125F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BNE 0A:125F
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BNE 0A:125F
    SEC
    LDA OBJ_POS_X??[18],X
    SBC OBJ_POS_X??[18],Y
    BPL 0A:1258
    EOR #$FF
    CLC
    ADC #$01
    CMP #$03
    BCS 0A:125F
    JMP 0A:0EC2
    LDY OBJ_POS_X_CONFIRMED[18],X
    LDA OBJ_POS_X??[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE FINALIZATION
    LDA 503_OBJ_POS_X_LARGEST?[18],X
    BPL 0A:128F
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:12A6
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BEQ 0A:12A6
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$0F
    BNE 0A:12A6
    JSR SUB_UNK
    BCC 0A:12A6
    JMP RTN_UNK
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BEQ 0A:12A6
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BNE 0A:12A6
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BNE 0A:12A6
    JMP 0A:0EC2
    JSR 0A:1310
FINALIZATION: ; 0A:12A9, 0x0152A9
    JSR MOVE_Y_FINALIZE
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
    JMP STATE_SOLVING_AND_ANIMATION_FOR_STATE
UNK_SUB_A: ; 0A:12B2, 0x0152B2
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND
    BCC 0A:12C3
    ASL OBJ_POS_X_CONFIRMED[18],X
    LDA #$01
    BCS 0A:12C0
    LDA #$FE
    STA OBJ_POS_X_CONFIRMED[18],X
    RTS
    JSR MOVE_UNK_RET_??
    BCC 0A:12D5
    ASL OBJ_POS_X??[18],X
    LDA #$00
    BCS 0A:12D2
    LDA #$FF
    STA OBJ_POS_X??[18],X
    RTS
SUB_UNK: ; 0A:12D6, 0x0152D6
    CLC ; Prep add.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from obj.
    ADC SCRIPT_SCREEN_X_SCROLL[2] ; Add with scroll.
    AND #$0F ; Keep 0000.1111
    STA TMP_00 ; Store to TMP.
    LDA OBJ_POS_X_DELTA?[18],X ; Load 
    BMI LOAD_NEGATIVE ; Negative, goto.
    INC TMP_00 ; ++, 0x01-0x10 now.
    SEC ; Prep sub.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SBC TMP_00 ; Sub with.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store back.
    JMP RTS ; Leave. Why not just RTS here? Bad code. Mistake?
LOAD_NEGATIVE: ; 0A:12F3, 0x0152F3
    CLC ; Prep add.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    LDY TMP_00 ; Load to Y.
    ADC DATA_ADD_SEED,Y ; Add with table.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to Xobj.
RTS: ; 0A:12FF, 0x0152FF
    RTS ; Leave.
DATA_ADD_SEED: ; 0A:1300, 0x015300
    .db 10 ; Add opposite table for rtn above.
    .db 0F
    .db 0E
    .db 0D
    .db 0C
    .db 0B
    .db 0A
    .db 09
    .db 08
    .db 07
    .db 06
    .db 05
    .db 04
    .db 03
    .db 02
    .db 01
    CLC
    LDA OBJ_POS_X??[18],X
    ADC 4C6_OBJ_UNK[18],X
    CLC
    ADC 81_UNK
    AND #$0F
    STA TMP_00
    LDA 503_OBJ_POS_X_LARGEST?[18],X
    BMI 0A:133B
    INC TMP_00
    CLC
    LDA OBJ_POS_X??[18],X
    ADC 4C6_OBJ_UNK[18],X
    SEC
    SBC TMP_00
    LDY LEVEL/SCREEN_ON
    CPY #$02
    BNE 0A:1338
    CLC
    ADC #$04
    JMP 0A:1351
    CLC
    LDA OBJ_POS_X??[18],X
    ADC 4C6_OBJ_UNK[18],X
    LDY TMP_00
    CLC
    ADC DATA_ADD_SEED,Y
    LDY LEVEL/SCREEN_ON
    CPY #$02
    BNE 0A:1351
    CLC
    ADC #$F4
    SEC
    SBC 4C6_OBJ_UNK+1,X
    STA OBJ_POS_X??[18],X
    RTS
HIT_DETECT?_UNK: ; 0A:1359, 0x015359
    LDY A/B_WHICH_RESULT ; Y from.
    LDA DATA_A,Y ; Load data
    STA TMP_14 ; Store to.
    CPY #$02 ; If _ #$02
    BNE OBJ_IS_P2 ; P2, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from Xobj.
    AND #$10 ; Keep 0001.0000
    BNE BIT_SET ; If set, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA OBJ_POS_X??[18],Y ; Load from Yobj.
    CMP #$A8 ; Seed carry, 0x00 - 0xA7 CC.
    ROL A ; Rotate to bottom.
    ASL A ; Bring in zero.
    ORA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Set from pair.
    AND #$03 ; Keep 0000.0011
    TAY ; To Y index.
    LDA DATA_B,Y ; Move data to TMP for Y index.
    STA TMP_01
    LDA DATA_C,Y
    STA TMP_00
    JMP RTN_CONTINUE
BIT_SET: ; 0A:1389, 0x015389
    LDA #$00
    STA TMP_01 ; Clear TMP.
    STA TMP_00
    JMP RTN_CONTINUE ; Goto.
OBJ_IS_P2: ; 0A:1392, 0x015392
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from Xobj.
    CMP #$0B ; If _ #$0B
    BNE STATE_NE_0x0B ; !=, goto.
    TYA ; Y to A
    CLC
    ADC #$03 ; += 0x03
    TAY ; Back to Y.
STATE_NE_0x0B: ; 0A:139E, 0x01539E
    LDA DATA_P2_A,Y ; Seed P2 data.
    STA TMP_01
    LDA DATA_P2_B,Y ; A data is used for add.
    STA TMP_00
RTN_CONTINUE: ; 0A:13A8, 0x0153A8
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    CLC ; Prep add.
    ADC OBJ_POS_X_CONFIRMED[18],Y ; Add with.
    PHA ; Save
    ROR A ; >> 1
    EOR TMP_00 ; Eor with.
    ASL A ; << 1
    PLA ; Restore
    BCS ADD_OVERFLOWED ; If add overflowed
    STA TMP_14 ; Store if no overflow.
ADD_OVERFLOWED: ; 0A:13B9, 0x0153B9
    LDA OBJ_POS_X??[18],Y ; Load
    CLC ; Prep add.
    ADC TMP_01 ; Add with.
    STA TMP_15 ; Store result.
    JMP HIT_DETECT_HELPER_UNK ; Goto.
DATA_A: ; 0A:13C4, 0x0153C4
    .db FA
    .db 05
    .db FA
DATA_P2_B: ; 0A:13C7, 0x0153C7
    .db 1E
    .db E2
    .db C4
    .db 32
    .db CE
DATA_P2_A: ; 0A:13CC, 0x0153CC
    .db 00
    .db 00
    .db 28
    .db 28
    .db 00
DATA_C: ; 0A:13D1, 0x0153D1
    .db 3C
    .db C4
    .db 3C
    .db C4
DATA_B: ; 0A:13D5, 0x0153D5
    .db 28
    .db 28
    .db D8
    .db D8
RTN_UNK_BITS_SET_IDK: ; 0A:13D9, 0x0153D9
    LDY #$00 ; Y from
    LDA TMP_10 ; Load from.
    CMP #$02 ; If _ #$02
    BCC Y_CORRECT ; <, goto.
    LDY #$02 ; Reassign.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from.
    CMP TMP_14 ; If _ #$14
    BCS Y_CORRECT ; >=, goto.
    LDY #$04 ; Reassign again.
Y_CORRECT: ; 0A:13EC, 0x0153EC
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load from Xobj pair.
    AND #$02 ; Keep 0000.0010
    BEQ BIT_0x02_NOT_SET_A ; Not set, goto.
    TYA ; Y to A.
    ORA #$10 ; Set 0001.0000
    TAY ; Back to Y.
    JMP SCREEN_LT_0x05
BIT_0x02_NOT_SET_A: ; 0A:13FA, 0x0153FA
    LDA LEVEL/SCREEN_ON ; Load
    CMP #$05 ; If _ #$05
    BCC SCREEN_LT_0x05 ; <, goto.
    TYA ; Y to A.
    ORA #$08 ; Set 0000.1000
    TAY ; Back to Y.
SCREEN_LT_0x05: ; 0A:1404, 0x015404
    LDA OBJ_DATA_A,Y ; Move from data to object.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDY #$00 ; Assign.
    LDA TMP_11 ; Load
    CMP #$01 ; If _ #$01
    BCC UNDER_ONE ; <, goto.
    LDY #$02 ; Reassign.
    LDA TMP_13 ; Load
    BPL UNDER_ONE ; If positive, goto.
    LDY #$04 ; Reassign.
UNDER_ONE: ; 0A:1420, 0x015420
    LDA OBJ_SECONDARY_SWITCH?+1,X ; Load secondary of pair.
    AND #$02 ; Keep 0000.0010
    BEQ BIT_0x02_NOT_SET_B ; Not set, goto.
    TYA ; Val to A
    ORA #$10 ; Set 0001.0000
    TAY ; Back to Y.
    JMP DATA_MOVE_Y_INDEX ; Goto.
BIT_0x02_NOT_SET_B: ; 0A:142E, 0x01542E
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$05 ; If _ #$05
    BCC DATA_MOVE_Y_INDEX ; <, goto.
    TYA ; Y to A.
    ORA #$08 ; Set 0000.1000
    TAY ; Back to Y.
DATA_MOVE_Y_INDEX: ; 0A:1438, 0x015438
    LDA OBJ_DATA_C,Y ; Move data to OBJ.
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA OBJ_DATA_D,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
OBJ_DATA_A: ; 0A:1445, 0x015445
    .db 00
OBJ_DATA_B: ; 0A:1446, 0x015446
    .db 00
    .db 20
    .db FF
    .db E0
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
    .db 00
    .db 00
    .db A0
    .db FE
    .db 60
    .db 01
    .db 00
    .db 00
OBJ_DATA_C: ; 0A:145D, 0x01545D
    .db 00
OBJ_DATA_D: ; 0A:145E, 0x01545E
    .db 00
    .db 60
    .db FF
    .db A0
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
    .db 00
    .db 00
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
STATE_SOLVING_AND_ANIMATION_FOR_STATE: ; 0A:1475, 0x015475
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL STATE_COMP_STUFF ; If positive, goto.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Re-set hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Inc extra.
STATE_COMP_STUFF: ; 0A:1482, 0x015482
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load enabled.
    CMP #$0D ; If state _ #$0D
    BNE STATE_NE_0x0D ; Not eq.
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BMI A_AS_WORD_INDEX ; If negative, goto.
    LDA #$02 ; Load
    BNE A_AS_WORD_INDEX ; Always taken.
STATE_NE_0x0D: ; 0A:1492, 0x015492
    LDY LEVEL/SCREEN_ON ; Load screen.
    CPY #$03 ; If _ #$03
    BNE A_AS_WORD_INDEX ; Not 3, goto.
    LDY 4C6_OBJ_UNK[18],X ; Load 
    BNE A_AS_WORD_INDEX ; If has value, goto.
    STA TMP_00 ; Store state.
    TAY ; To Y
    LDA STATE_DATA_LOAD,Y
    BNE A_AS_WORD_INDEX ; If load has value, goto.
    LDA TMP_00 ; Re-use our state instead.
A_AS_WORD_INDEX: ; 0A:14A7, 0x0154A7
    ASL A ; << 2, *4.
    ASL A
    STA TMP_00 ; To temp.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load from OBJ.
    AND #$03 ; Keep 0000.0011
    ORA TMP_00 ; Combine with what we had.
    TAY ; To Y index.
    LDA COMPLETE_STATE_DATA,Y ; Load animation for state.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display animation.
    RTS ; Leave.
SUB_HOLD/STEP_STUFF: ; 0A:14BA, 0x0154BA
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL STATE_COMP_STUFF ; If not finished, goto.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold again.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; ++
    JMP STATE_COMP_STUFF ; Goto.
SET_OBJ_ANIM_HOLD/CLEAR_ENTRY: ; 0A:14CA, 0x0154CA
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear.
    RTS
OBJ_STORAGE_UNK: ; 0A:14D5, 0x0154D5
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load
    BNE VAL_NONZERO_A ; != 0, goto.
    STX OBJ_INDEXES_GROUP_UNK[3] ; X to here if zero.
    RTS
VAL_NONZERO_A: ; 0A:14DE, 0x0154DE
    LDA OBJ_INDEXES_GROUP_UNK+2 ; Load
    BNE VAL_NONZERO_B ; != 0, goto.
    STX OBJ_INDEXES_GROUP_UNK+2 ; X to here if zero.
    RTS
VAL_NONZERO_B: ; 0A:14E7, 0x0154E7
    STX OBJ_INDEXES_GROUP_UNK+1 ; X to here if both nonzero.
    RTS
TEST_XOBJ_EQ_717/718_INDEX_MATCH: ; 0A:14EB, 0x0154EB
    LDY #$00 ; Unk val.
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If Xobj _ Var
    BEQ XOBJ_EQ_INDEXES ; ==, goto.
    INY ; Y++
    CPX OBJ_INDEXES_GROUP_UNK+1 ; If Xobj _ Var
    BEQ XOBJ_EQ_INDEXES ; ==, goto.
    INY ; Y++
XOBJ_EQ_INDEXES: ; 0A:14F9, 0x0154F9
    STY A/B_WHICH_RESULT ; 0/1 match, 2 no match.
    RTS
L_0A:14FD: ; 0A:14FD, 0x0154FD
    CPX OBJ_INDEXES_GROUP_UNK+2
    BEQ 0A:1553
    CPX OBJ_INDEXES_GROUP_UNK[3]
    BNE 0A:1516
    LDA OBJ_INDEXES_GROUP_UNK+2
    BEQ 0A:1553
    STX OBJ_INDEXES_GROUP_UNK+2
    STA OBJ_INDEXES_GROUP_UNK[3]
    TAY
    JMP 0A:1527
    CPX OBJ_INDEXES_GROUP_UNK+1
    BNE 0A:1553
    LDA OBJ_INDEXES_GROUP_UNK+2
    BEQ 0A:1553
    STX OBJ_INDEXES_GROUP_UNK+2
    STA OBJ_INDEXES_GROUP_UNK+1
    TAY
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y
    AND #$8F
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
    LDY OBJ_INDEXES_GROUP_UNK+2
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y
    AND #$8F
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
    JSR TEST_XOBJ_EQ_717/718_INDEX_MATCH
    RTS
SUB_OBJ_SLOTS_UNK: ; 0A:1554, 0x015554
    LDA #$00 ; Load
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ This obj.
    BNE DIDNT_MATCH_719 ; !=, goto.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear.
    RTS ; Leave.
DIDNT_MATCH_719: ; 0A:155F, 0x01555F
    CPX OBJ_INDEXES_GROUP_UNK+1 ; If Xobj _ This obj
    BNE DIDNT_MATCH_718 ; !=, goto.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; Load obj.
    BNE MOVE_719_SLOT_DOWN ; != 0, goto.
    LDY OBJ_INDEXES_GROUP_UNK[3] ; Load obj.
    BEQ 717_NO_OBJ ; ==, goto.
    STY OBJ_INDEXES_GROUP_UNK+1 ; Move 717 up to here.
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear 717.
    JMP REENTER ; rE-ENTER.
717_NO_OBJ: ; 0A:1577, 0x015577
    STA OBJ_INDEXES_GROUP_UNK+1 ; Clear
    RTS ; Leave.
MOVE_719_SLOT_DOWN: ; 0A:157B, 0x01557B
    STY OBJ_INDEXES_GROUP_UNK+1 ; Store Y to here now.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear.
    JMP REENTER ; Goto.
DIDNT_MATCH_718: ; 0A:1584, 0x015584
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If Xobj _ This obj.
    BNE RTS ; !=, leave.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; If 719...
    BNE 719_VAL_717_CLEAR ; != 0, goto.
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear.
    RTS
719_VAL_717_CLEAR: ; 0A:1592, 0x015592
    STY OBJ_INDEXES_GROUP_UNK[3] ; Move down
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear upper.
REENTER: ; 0A:1598, 0x015598
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    AND #$8F ; Keep 1000.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,Y ; Clear these for pair.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
RTS: ; 0A:15AB, 0x0155AB
    RTS ; Leave.
XOBJ_CMP_STUFF_RET_CS_CLEARED_CC_NO_MOD: ; 0A:15AC, 0x0155AC
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ var
    BNE RTS_CC ; !=, goto.
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load
    BEQ 717_EQ_ZERO
    LDA OBJ_INDEXES_GROUP_UNK+1 ; Load
    BNE RTS_CC ; If set, RTS CC.
    STX OBJ_INDEXES_GROUP_UNK+1 ; X to.
    JMP CLEAR_OBJ_ATTRS ; Goto.
717_EQ_ZERO: ; 0A:15C1, 0x0155C1
    STX OBJ_INDEXES_GROUP_UNK[3] ; X to.
CLEAR_OBJ_ATTRS: ; 0A:15C4, 0x0155C4
    LDA #$00
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from obj.
    AND #$8F ; Keep 1000.1111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$00
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Clear these.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
RTS_CS: ; 0A:15DC, 0x0155DC
    SEC ; RTS CS. Obj cleared.
    RTS
RTS_CC: ; 0A:15DE, 0x0155DE
    CLC ; RTS CC. Obj not changed?
    RTS
SUB_UNK: ; 0A:15E0, 0x0155E0
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BEQ 0A:15EB
    JMP OBJ_CLEAR_AND_SET_PAIR_UNK
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BEQ 0A:15F5
    JMP OBJ_CLEAR_AND_SET_PAIR_UNK
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    JSR 0A:1767
    LDA OBJ_POS_X_CONFIRMED[18],X
    STA TMP_06
    LDA OBJ_POS_X??[18],X
    STA TMP_07
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    CLC
    LDA OBJ_POS_X_CONFIRMED[18],Y
    ADC TMP_08
    CMP #$29
    BCS 0A:1614
    LDA #$29
    CMP #$D7
    BCC 0A:161A
    LDA #$D7
    STA OBJ_POS_X_CONFIRMED[18],X
    CLC
    LDA OBJ_POS_X??[18],Y
    ADC TMP_09
    CMP #$E1
    BCC 0A:1629
    LDA #$E0
    STA OBJ_POS_X??[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    LDY OBJ_POS_X_CONFIRMED[18],X
    JSR UNK_SUB_B
    BNE 0A:1645
    LDA TMP_06
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA TMP_07
    STA OBJ_POS_X??[18],X
    JMP OBJ_CLEAR_AND_SET_PAIR_UNK
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LSR A
    LSR A
    BMI 0A:165E
    INC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    CMP #$F0
    BCC 0A:166D
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    JMP 0A:166D
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    CMP #$F0
    BCC 0A:166D
    LDA #$EF
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    RTS
SUB_UNK: ; 0A:166E, 0x01566E
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LSR A
    TAY
    LDA NUM_PLAYER_LIVES[2],Y
    BMI 0A:16E9
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X_CONFIRMED[18],Y
    CMP #$50
    BCC 0A:16E9
    CMP #$B0
    BCS 0A:16E9
    LDA OBJ_POS_X??[18],X
    CMP OBJ_POS_X??[18],Y
    BNE 0A:16EB
    SEC
    LDA OBJ_POS_X_CONFIRMED[18],X
    SBC OBJ_POS_X_CONFIRMED[18],Y
    STA TMP_0A
    BCS 0A:169E
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_08
    CMP #$27
    BNE 0A:16E9
    LDA OBJ_POS_X??[18],X
    CMP #$A8
    ROL A
    AND #$01
    LDY TMP_0A
    BMI 0A:16B2
    ORA #$02
    ASL A
    ASL A
    TAY
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    AND #$9F
    ORA 0A:1747,Y
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA 0A:1748,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X_CONFIRMED[18],Y
    STA OBJ_POS_X_DELTA?+1,X
    LDA OBJ_POS_X??[18],Y
    STA 503_OBJ_POS_X_LARGEST?+1,X
    LDA #$80
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 520_OBJ_POS_X_LARGE?+1,X
    LDA #$B4
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA #$1E
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X
    SEC
    RTS
    CLC
    RTS
    JMP 0A:16E9
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X_CONFIRMED[18],X
    CMP OBJ_POS_X_CONFIRMED[18],Y
    BNE 0A:16E9
    SEC
    LDA OBJ_POS_X??[18],X
    SBC OBJ_POS_X??[18],Y
    STA TMP_0B
    BPL 0A:1709
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_09
    CMP #$24
    BNE 0A:16E9
    LDA RANDOM_VALS?[2]
    AND #$02
    LDY TMP_0B
    BMI 0A:1719
    ORA #$01
    ASL A
    ASL A
    TAY
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    AND #$9F
    ORA 0A:1757,Y
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA 0A:1758,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X_CONFIRMED[18],Y
    STA OBJ_POS_X_DELTA?+1,X
    LDA OBJ_POS_X??[18],Y
    STA 503_OBJ_POS_X_LARGEST?+1,X
    LDA #$80
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 520_OBJ_POS_X_LARGE?+1,X
    JMP 0A:16DD
    .db 40
    .db 78
    .db 27
    .db 00
    .db 60
    .db 78
    .db 27
    .db 00
    .db 60
    .db 00
    .db D9
    .db 00
    .db 40
    .db 00
    .db D9
    .db 00
    .db 60
    .db B4
    .db 24
    .db 00
    .db 40
    .db 3C
    .db DC
    .db 00
    .db 40
    .db B4
    .db 24
    .db 00
    .db 60
    .db 3C
    .db DC
    .db 00
    .db 85
    .db 00
    .db A0
    .db 00
    .db 84
    .db 01
    .db C9
    .db 79
    .db 90
    .db 0A
    .db A9
    .db F0
    .db E5
    .db 00
    .db 85
    .db 00
    .db A0
    .db 02
    .db 84
    .db 01
    .db C9
    .db 3D
    .db 90
    .db 0C
    .db A9
    .db 78
    .db E5
    .db 00
    .db 85
    .db 00
    .db A5
    .db 01
    .db 09
    .db 01
    .db 85
    .db 01
    .db A5
    .db 00
    .db 0A
    .db A8
    .db B9
    .db AE
    .db 97
    .db 85
    .db 08
    .db B9
    .db AF
    .db 97
    .db 85
    .db 09
    .db 46
    .db 01
    .db 90
    .db 06
    .db A9
    .db 00
    .db E5
    .db 08
    .db 85
    .db 08
    .db 46
    .db 01
    .db 90
    .db 06
    .db A9
    .db 00
    .db E5
    .db 09
    .db 85
    .db 09
    .db 60
    .db 27
    .db 00
    .db 27
    .db 00
    .db 27
    .db 01
    .db 27
    .db 02
    .db 27
    .db 03
    .db 27
    .db 04
    .db 27
    .db 05
    .db 27
    .db 06
    .db 27
    .db 07
    .db 26
    .db 08
    .db 26
    .db 09
    .db 26
    .db 0A
    .db 26
    .db 0B
    .db 25
    .db 0C
    .db 25
    .db 0C
    .db 24
    .db 0D
    .db 24
    .db 0E
    .db 24
    .db 0F
    .db 23
    .db 10
    .db 23
    .db 11
    .db 22
    .db 11
    .db 22
    .db 12
    .db 21
    .db 13
    .db 20
    .db 14
    .db 20
    .db 15
    .db 1F
    .db 15
    .db 1F
    .db 16
    .db 1E
    .db 17
    .db 1D
    .db 18
    .db 1D
    .db 18
    .db 1C
    .db 19
    .db 1B
    .db 1A
    .db 1A
    .db 1A
    .db 19
    .db 1B
    .db 19
    .db 1B
    .db 18
    .db 1C
    .db 17
    .db 1D
    .db 16
    .db 1D
    .db 15
    .db 1E
    .db 14
    .db 1E
    .db 14
    .db 1F
    .db 13
    .db 1F
    .db 12
    .db 20
    .db 11
    .db 20
    .db 10
    .db 20
    .db 0F
    .db 21
    .db 0E
    .db 21
    .db 0D
    .db 21
    .db 0C
    .db 22
    .db 0B
    .db 22
    .db 0A
    .db 22
    .db 09
    .db 23
    .db 08
    .db 23
    .db 07
    .db 23
    .db 06
    .db 23
    .db 05
    .db 23
    .db 04
    .db 23
    .db 03
    .db 23
    .db 02
    .db 23
    .db 01
    .db 23
    .db 00
    .db 24
HANDLER_0x01_MULTISWITCH_D: ; 0A:1828, 0x015828
    LOW(S01_MSD_RTN_A) ; Pair, obj from Xobj, animation, move.
    HIGH(S01_MSD_RTN_A)
    LOW(S01_MSD_RTN_B) ; Similar to above but not exact.
    HIGH(S01_MSD_RTN_B)
    LOW(S01_MSD_RTN_C) ; Sewer level diff, set anim, hold obj, retarget.
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_D) ; Hold, Pfocus, display, sewer swap.
    HIGH(S01_MSD_RTN_D)
    LOW(S01_MSD_RTN_E) ; Sound, sewer mod, display, hold.
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_F) ; Hold, animate, pair write, focus on player.
    HIGH(S01_MSD_RTN_F)
    LOW(S01_MSD_RTN_G) ; Focus player, random animate, 1 in 8 to ??
    HIGH(S01_MSD_RTN_G)
    LOW(S01_MSD_RTN_C) ; Dup
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_E) ; Dup
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_H) ; Sewer mod, pfocus, animate.
    HIGH(S01_MSD_RTN_H)
    LOW(S01_MSD_RTN_I) ; State mod, pair things, animation/extra, misc.
    HIGH(S01_MSD_RTN_I)
    LOW(S01_MSD_RTN_C) ; Dup.
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_J) ; Hit detect? Animate, hold, chance retarget rtn, misc.
    HIGH(S01_MSD_RTN_J)
    LOW(S01_MSD_RTN_K) ; Spawn thing, difference between objs. A bit different.
    HIGH(S01_MSD_RTN_K)
    LOW(S01_MSD_RTN_L) ; Animation, sound, cut down data inside during dev?
    HIGH(S01_MSD_RTN_L)
    LOW(S01_MSD_RTN_D) ; Dup
    HIGH(S01_MSD_RTN_D)
    LOW(S01_MSD_RTN_E) ; Dup
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_M) ; Hold, checks all enemies, animate, more.
    HIGH(S01_MSD_RTN_M)
    LOW(S01_MSD_RTN_N) ; Hold, animate, hit detect?
    HIGH(S01_MSD_RTN_N)
    LOW(S01_MSD_RTN_O) ; Animation, sound, hold.
    HIGH(S01_MSD_RTN_O)
    LOW(S01_MSD_RTN_P) ; Focus, state switches, retarget, misc.
    HIGH(S01_MSD_RTN_P)
    LOW(S01_MSD_RTN_Q) ; Same as R, but with alternate extra data.
    HIGH(S01_MSD_RTN_Q)
    LOW(S01_MSD_RTN_R) ; Same as R, but with even another alt extra data.
    HIGH(S01_MSD_RTN_R)
    LOW(S01_MSD_RTN_S) ; Anim, hit detect, sound, extra.
    HIGH(S01_MSD_RTN_S)
    LOW(S01_MSD_RTN_E) ; Dup
    HIGH(S01_MSD_RTN_E)
RTN_UNK: ; 0A:185A, 0x01585A
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    BEQ 0A:186A
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$02
    STA TMP_00
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$01
    STA ARR_SPRITE_OBJ_TIMER?+1
    LDY TMP_00
    LDA 0A:18AA,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA 0A:18AB,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    ASL A
    BMI 0A:189B
    SEC
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    LDA 0A:18B0,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:18B1,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JMP SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
    .db 80
    .db 02
    .db 00
    .db 01
ROM_VAL_0x80: ; 0A:18AE, 0x0158AE
    .db 80
ROM_VAL_0x02: ; 0A:18AF, 0x0158AF
    .db 02
    .db 00
    .db FC
    .db 40
    .db FC
S01_MSD_RTN_A: ; 0A:18B4, 0x0158B4
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA #$40
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Get obj from Xobj.
    BMI YOBJ_NEGATIVE ; If negative, skip alt val.
    LDA #$20 ; Alt val.
YOBJ_NEGATIVE: ; 0A:18C0, 0x0158C0
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair tert.
    BNE PAIR_TERT_HAS_VAL ; If tert val, skip branches.
    BCS RTN_UPDATE_PAIR_MOD_ANIM/STATE/RETARGET/MORE ; Branch on RTN ret.
    BCC OBJ_THINGS_IDK ; Nope, goto.
PAIR_TERT_HAS_VAL: ; 0A:18CC, 0x0158CC
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load from obj.
    BMI OBJ_THINGS_IDK ; If negative, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load from obj.
    CMP 4D8_OBJ_UNK+1,X ; Cmp to ?? on pair.
    BCS RTN_UPDATE_PAIR_MOD_ANIM/STATE/RETARGET/MORE ; Loaded >= CMP, goto.
OBJ_THINGS_IDK: ; 0A:18D9, 0x0158D9
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj
    STA TMP_06 ; Store to TMP.
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do pos rtn.
    BCC XPOS_RTN_RET_CC ; If ret CC, goto.
    LDA #$01 ; Val?
    LDY OBJ_POS_X_DELTA?[18],X ; Load from Xobj.
    BPL LOADED_POSITIVE ; If positive, goto.
    LDA #$02 ; Alt val.
LOADED_POSITIVE: ; 0A:18EC, 0x0158EC
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set flag.
XPOS_RTN_RET_CC: ; 0A:18EF, 0x0158EF
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load flags.
    BNE OBJ_UPDATING_ALREADY ; If has value, goto.
    LDY OBJ_POS_X_CONFIRMED[18],X ; Y from
    LDA OBJ_POS_X??[18],X ; A from.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK+1,X ; Ad to pair unk.
    JSR UNK_SUB_B ; Do?
    BNE OBJ_UPDATING_ALREADY ; Ret nonzero, goto.
    LDA TMP_06 ; Load held value.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store back to obj.
OBJ_UPDATING_ALREADY: ; 0A:1908, 0x015908
    JSR MOVE_Y_FINALIZE ; Do
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load from Xobj.
    ASL A ; << 1, *2
    LDA #$01 ; Unk.
    LDY #$09 ; Animation
    BCS SHIFTED_OFF_ONE ; If shifted one, use vals.
    LDA #$82 ; Alt vals.
    LDY #$0D ; Animation
SHIFTED_OFF_ONE: ; 0A:1919, 0x015919
    STA OBJECT_DATA_EXTRA_B?[18],X ; Store
    TYA ; Y to A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation to use.
    BCS RTS ; If shifted one, don't do below.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from Xobj.
    ORA #$08 ; Set 0000.1000
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$14 ; Val?
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Set pair.
RTS: ; 0A:192F, 0x01592F
    RTS ; Leave.
RTN_UPDATE_PAIR_MOD_ANIM/STATE/RETARGET/MORE: ; 0A:1930, 0x015930
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load from OBJ.A
    BNE OBJ_UPDATE_SET ; If set, goto.
    LDY OBJ_POS_X_CONFIRMED[18],X ; Y from obj.
    LDA OBJ_POS_X??[18],X ; Load from obj.
    CLC
    ADC 4C6_OBJ_UNK+1,X ; Add with pair unk.
    JSR UNK_SUB_B ; Do?
    BNE OBJ_UPDATE_SET ; If ret nonzero, goto.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR SUB_UNK ; Do?
OBJ_UPDATE_SET: ; 0A:194C, 0x01594C
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from Obj.
    AND #$F7 ; Keep 1111.01111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Clear.
    LDA 4C6_OBJ_UNK+1,X ; Load from pair.
    STA 4C6_OBJ_UNK[18],X ; Store to Xobj.
    LDA #$00
    STA 4D8_OBJ_UNK[18],X ; Clear
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear pair. Mistake? Not indexed?! TODO: Is mistake?
    JSR OBJ_PAIR_SWITCH_MOD ; Do.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do, abuse RTS.
S01_MSD_RTN_B: ; 0A:196D, 0x01596D
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    LDA #$40 ; Val?
    LDY 532_OBJ_UNK_POS_DELTA?[18],X ; Y from obj.
    BMI LOADED_NEGATIVE ; Negative, use val.
    LDA #$20 ; Alt val.
LOADED_NEGATIVE: ; 0A:1979, 0x015979
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do.
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load pair tert.
    BNE PAIR_TERT_NONZERO ; Nonezero, skip branches.
    BCS RTN_UPDATE_PAIR_MOD_ANIM/STATE/RETARGET/MORE ; Do.
    BCC RTN_CONTINUE ; If not CS, goto.
PAIR_TERT_NONZERO: ; 0A:1985, 0x015985
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load 
    BMI RTN_CONTINUE ; If negative, skip.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP 4D8_OBJ_UNK+1,X ; Compare to pair.
    BCS RTN_UPDATE_PAIR_MOD_ANIM/STATE/RETARGET/MORE ; Load >= pair, goto.
RTN_CONTINUE: ; 0A:1992, 0x015992
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI SKIP_ASSIGNS ; If negative, goto.
    LDA OBJ_POS_X_DELTA?[18],X ; Load from Xobj.
    ASL A ; << 1
    LDA ROM_VAL_0x80 ; Load
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store
    LDA ROM_VAL_0x02 ; Load
    STA OBJ_POS_X_DELTA?[18],X ; Store
    BCC SKIP_ASSIGNS ; If shifted zero off, goto.
    SEC ; Prep sub.
    LDA #$00 ; Zero.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invery, basically.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Zero.
    SBC OBJ_POS_X_DELTA?[18],X ; Sub. Note: Carry clear here.
    STA OBJ_POS_X_DELTA?[18],X ; Store to obj.
SKIP_ASSIGNS: ; 0A:19BA, 0x0159BA
    JMP OBJ_THINGS_IDK ; Goto, abuse RTS. Or mistake? TODO: I think is mistake, oops.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; This was probably the wanted exit, lol.
    INC OBJ_SECONDARY_SWITCH?[18],X
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_C: ; 0A:19CE, 0x0159CE
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find player.
    LDA #$00 ; Val.
    LDY LEVEL/SCREEN_ON ; Load screen.
    CPY #$03 ; If _ #$03
    BNE NOT_SCREEN_0x03 ; Not sewer.
    LDY 4C6_OBJ_UNK[18],X ; Load Y from Xobj.
    BNE NOT_SCREEN_0x03 ; Has value, skip.
    LDA #$02 ; Alt for sewer.
NOT_SCREEN_0x03: ; 0A:19E3, 0x0159E3
    STA TMP_07 ; Store to TMP.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++ hold.
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$13 ; If _ #$13
    BCS RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; >=, goto.
    LDA #$00 ; Vals
    CPY #$0A
    BCC USE_VALS ; Always taken because of CS above I believe.
    CPY #$0F ; If Y _ #$0F
    BCS GTE_0x0F ; >=, goto.
    LDA #$81
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load and set 0000.1000
    ORA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$14 ; Val?
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Set pair.
GTE_0x0F: ; 0A:1A0B, 0x015A0B
    LDA #$01 ; Index val.
USE_VALS: ; 0A:1A0D, 0x015A0D
    ORA TMP_07 ; Set with TMP.
    TAY ; To Y index.
    LDA ANIMATION_DISPLAY_VALS,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    RTS ; Leave.
ANIMATION_DISPLAY_VALS: ; 0A:1A17, 0x015A17
    .db 0B
    .db 0C
    .db 8F ; Sewer alt.
    .db 90
RTN_ANIM/STATE_RETARGET_CHANCE_MORE: ; 0A:1A1B, 0x015A1B
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load from Xobj.
    AND #$F7 ; Keep 1111.0111
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    LDA #$01
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set to 0x01
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY ; Do.
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Do.
    LDA #$00
    STA OBJ_POS_X_DELTA?[18],X ; Clear.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    JSR RANDOMNESS ; Get random.
    AND #$1F ; Keep 0001.1111.
    BNE HAS_VAL ; If val after, do.
    JMP FOCUS_FIND_SEED_0x80 ; Do. 1 in 0x20 chance to re-target closest?
HAS_VAL: ; 0A:1A40, 0x015A40
    RTS ; Leave if has value.
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0F
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_D: ; 0A:1A61, 0x015A61
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find focus.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$13 ; If _ #$13
    BCS RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; >=, goto.
    LDA #$00 ; Even val.
    CPY #$0A ; Hold _ #$0A
    BCC HOLD_UNDER_0x0A ; <, goto.
    CPY #$0F ; Hold _ #$0F
    BCS 0A:1A88 ; >=, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$08 ; Set
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$14
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Set pair. Val?
    LDA #$01 ; Use odd.
HOLD_UNDER_0x0A: ; 0A:1A8A, 0x015A8A
    STA TMP_00 ; To TMP.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from Obj.
    CMP #$03 ; If _ #$03
    BNE WRITE_OBJ_DATA ; !=, goto.
    LDY LEVEL/SCREEN_ON ; Load screen.
    CPY #$03 ; If _ #$03
    BNE WRITE_OBJ_DATA ; !=, goto. Not sewer.
    LDY 4C6_OBJ_UNK[18],X ; Y from Obj.
    BNE WRITE_OBJ_DATA ; If has val, skip.
    JSR RTN_AS_SUB ; Do RTN below as sub.
    LDY TMP_00 ; Y from TMP.
    LDA ANIM_DISPLAY_SWAP,Y ; Load swap.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Re-set.
    RTS ; Leave.
RTN_AS_SUB: ; 0A:1AAA, 0x015AAA
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
WRITE_OBJ_DATA: ; 0A:1AAD, 0x015AAD
    ASL A ; << 1, *2.
    ORA TMP_00 ; Or with val decided earlier.
    TAY ; To Y index.
    LDA ANIMATIONS_TO_DISPLAY,Y ; Load
    STA OBJ_ANIMATION_DISPLAY[18],X ; To OBJ.
    LDA DATA_TO_OBJ,Y ; Load
    STA OBJECT_DATA_EXTRA_B?[18],X ; To OBJ.
    RTS ; Leave.
ANIM_DISPLAY_SWAP: ; 0A:1ABE, 0x015ABE
    .db 8E
    .db 91
ANIMATIONS_TO_DISPLAY: ; 0A:1AC0, 0x015AC0
    .db 00
    .db 00
    .db 00
    .db 00
    .db 0B
    .db 0C
    .db 08
    .db 0F
    .db 00
    .db 00
    .db 00
    .db 00
    .db 22
    .db 23
    .db 00
    .db 00
    .db 00
    .db 00
    .db 41
    .db 43
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
DATA_TO_OBJ: ; 0A:1AE2, 0x015AE2
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 81
    .db 01
    .db 81
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 81
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 81
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
ANIM_DATA: ; 0A:1B04, 0x015B04
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 10
    .db 11
    .db 00
    .db 00
    .db 1A
    .db 1B
    .db 00
    .db 00
    .db 1A
    .db 1B
    .db 00
    .db 00
    .db 44
    .db 11
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
    .db 1A
    .db 1B
    .db 00
    .db 00
    .db 00
    .db 00
    .db 1A
    .db 1B
    .db 00
    .db 00
    .db 00
    .db 00
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 04
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 08
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 18
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 10
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
S01_MSD_RTN_E: ; 0A:1B6E, 0x015B6E
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++ hold.
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$1C ; If _ #$1C
    BCC HOLD_UNDER_0x1C
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if expired.
HOLD_UNDER_0x1C: ; 0A:1B7E, 0x015B7E
    LDA #$00 ; Val
    CPY #$14 ; If hold _ #$14
    BCC SEED_EVEN_DATA_FOR_STATES ; <, goto. Even data, seed 0x00.
    BNE SEED_ODD_DATA_FOR_STATES ; !=, goto. Odd data, seed 0x01.
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; If 14, does this.
    LDA #$0D ; Val
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Load from Obj.
    CPY #$09 ; If _ #$09
    BNE EN/ST_NE_0x09 ; !=, goto.
    LDA #$0F ; Sound val.
EN/ST_NE_0x09: ; 0A:1B94, 0x015B94
    JSR SND_BANKED_DISPATCH ; Play sound.
SEED_ODD_DATA_FOR_STATES: ; 0A:1B97, 0x015B97
    LDA #$01 ; Seed carry set if not sewers.
SEED_EVEN_DATA_FOR_STATES: ; 0A:1B99, 0x015B99
    LDY LEVEL/SCREEN_ON ; Load screen.
    CPY #$03 ; If _ #$03
    BNE SKIP_NOT_SEWERS ; Not sewers, goto.
    LDY OBJ_ENABLED_STATE+MORE?[18],X ; Y from obj.
    CPY #$03 ; If _ #$03
    BNE SKIP_NOT_SEWERS ; !=, goto.
    LDY 4C6_OBJ_UNK[18],X ; Y from obj.
    BNE SKIP_NOT_SEWERS ; !=, goto.
    TAY ; To Y index.
    LDA SEWER_ANIMS,Y ; Load
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store to animation.
    RTS ; Leave.
SKIP_NOT_SEWERS: ; 0A:1BB3, 0x015BB3
    LSR A ; >> 1. Seeded to be 0x01, so carry set here.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load enabled.
    ROL A ; Turn to word offset by 0x01.
    TAY ; To Y index.
    LDA ANIM_DATA,Y ; Load display.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display.
    RTS ; Leave.
SEWER_ANIMS: ; 0A:1BC0, 0x015BC0
    .db 92 ; Sewer anims.
    .db 93
SUB_SEC0x03_TERT0x05_HOLD0x00: ; 0A:1BC2, 0x015BC2
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
SUB_TERT_0x05_HOLD_0x00: ; 0A:1BC7, 0x015BC7
    LDA #$05
    STA OBJ_TERTIARY_SWITCH?[18],X
SUUB_HOLD_0x00: ; 0A:1BCC, 0x015BCC
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_F: ; 0A:1BD2, 0x015BD2
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do sub.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Focus.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++ Hold
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$14 ; If _ #$14
    BCC HOLD_NOT_EXPIRED ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if expired.
HOLD_NOT_EXPIRED: ; 0A:1BE5, 0x015BE5
    LDA #$00
    CPY #$06 ; Hold _ #$06
    BCC HOLD_LT_0x06 ; Always taken.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set 0000.1000
    ORA #$08
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$14 ; Set pair.
    STA 59E_OBJ_UNK/EXTRA_TIMER+1,X
    LDA #$01 ; Index.
    CPY #$0C ; Hold _ #$0C
    BCC HOLD_LT_0x06 ; <, goto.
    LDA #$02 ; Index.
HOLD_LT_0x06: ; 0A:1C00, 0x015C00
    TAY ; A to index reg.
    LDA ANIM_DISP_DATA,Y ; Set disp from.
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA OBJ_EXTRA_DATA,Y ; Set extra from.
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS ; lEAVE.
ANIM_DISP_DATA: ; 0A:1C0E, 0x015C0E
    .db 17
    .db 18
    .db 19
OBJ_EXTRA_DATA: ; 0A:1C11, 0x015C11
    .db 01
    .db 81
    .db 81
    .db A9
    .db 03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$06
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_G: ; 0A:1C24, 0x015C24
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Find player.
    LDY #$00 ; Index.
    LDA RANDOM_VALS?[2] ; Load random.
    AND #$08 ; Do based on bit.
    BEQ BIT_UNSET
    LDY #$01 ; Other index.
BIT_UNSET: ; 0A:1C34, 0x015C34
    LDA RANDOM_ANIM_DISP_VALS,Y ; Load from random.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set randomly.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$30 ; If _ #$30
    BCC UNDER_HOLD_0x30
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if over.
UNDER_HOLD_0x30: ; 0A:1C47, 0x015C47
    AND #$07 ; Keep 0000.0111 from hold timer.
    BNE RTS ; 0x01 in 0x08 chance to not skip.
    JMP SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Do instead.
RTS: ; 0A:1C4E, 0x015C4E
    RTS ; Leave.
RANDOM_ANIM_DISP_VALS: ; 0A:1C4F, 0x015C4F
    .db 15 ; Animation vals.
    .db 16
SUB_CLEAR_UNK_SEC0x03_TERT0x09: ; 0A:1C51, 0x015C51
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
SUB_SEC0x03_TERT0x09: ; 0A:1C56, 0x015C56
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
SUB_TERT0x09: ; 0A:1C5B, 0x015C5B
    LDA #$09
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS
S01_MSD_RTN_H: ; 0A:1C61, 0x015C61
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Focus.
    LDA #$00 ; Val
    LDY LEVEL/SCREEN_ON ; Load
    CPY #$03 ; If _ #$03
    BNE SCREEN_NOT_SEWERS ; !=, goto.
    LDY 4C6_OBJ_UNK[18],X ; Load from Xobj.
    BNE SCREEN_NOT_SEWERS ; Has value.
    LDA #$02 ; Change index bit.
SCREEN_NOT_SEWERS: ; 0A:1C76, 0x015C76
    STA TMP_07 ; Store.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$19 ; If _ #$19
    BCC HOLD_UNDER_0x19
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if over.
HOLD_UNDER_0x19: ; 0A:1C85, 0x015C85
    LDA #$00 ; Val
    CPY #$0F ; Hold _ #$0F
    BCC HOLD_LT_0x0F ; <, goto.
    LDA #$01 ; Alt animation.
HOLD_LT_0x0F: ; 0A:1C8D, 0x015C8D
    ORA TMP_07 ; Or with other decided.
    TAY ; To Y index.
    LDA ANIM_DISPLAY_DATA,Y ; Display
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA ANIM_EXTRA_DATA,Y ; Extra.
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
ANIM_DISPLAY_DATA: ; 0A:1C9D, 0x015C9D
    .db 22
    .db 23
    .db 9D
    .db 9E
ANIM_EXTRA_DATA: ; 0A:1CA1, 0x015CA1
    .db 01
    .db 81
    .db 01
    .db 81
    LDA #$00
    LDY #$00
    BEQ 0A:1CB5
    LDA #$00
    LDY #$02
    BNE 0A:1CB5
    LDA #$02
    LDY #$00
    STA TMP_00
    LDA 0A:1CFA,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:1CFB,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDY TMP_00
    LDA 0A:1CFE,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA 0A:1CFF,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    ASL A
    BMI 0A:1CE8
    SEC
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0A
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$09
    STA OBJ_ANIMATION_DISPLAY[18],X
    JMP SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
    .db 00
    .db FC
    .db 00
    .db FC
    .db 80
    .db 01
    .db 20
    .db 00
S01_MSD_RTN_I: ; 0A:1D02, 0x015D02
    LDA #$20
    JSR MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Do..
    LDA OBJ_TERTIARY_SWITCH?+1,X ; Load from pair.
    BNE PAIR_TERT_VALUE ; Has val, skip branches.
    BCS SUB_PAIR_MOD_MISC_CHANGES_SEC0x03_TERT0x0C_HOLD0x00 ; Branch on sub ret.
    BCC CONTINUE_RTN ; CC, continue.
PAIR_TERT_VALUE: ; 0A:1D10, 0x015D10
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    BMI CONTINUE_RTN ; If negative, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load
    CMP 4D8_OBJ_UNK+1,X ; If _ Pair
    BCS SUB_PAIR_MOD_MISC_CHANGES_SEC0x03_TERT0x0C_HOLD0x00 ; >=, goto.
CONTINUE_RTN: ; 0A:1D1D, 0x015D1D
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    STA TMP_06 ; Save
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do rtn.
    BCC SKIP_POS_THINGY ; ret CC, goto.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ASL A ; << 1, *2.
    LDA #$00 ; Val
    BCS SHIFTED_ONE
    LDA #$FF ; Alt
SHIFTED_ONE: ; 0A:1D34, 0x015D34
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to OBJ.
SKIP_POS_THINGY: ; 0A:1D37, 0x015D37
    LDY OBJ_POS_X_CONFIRMED[18],X ; Y from OBJ.
    LDA OBJ_POS_X??[18],X ; Load from OBJ.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK+1,X ; Add with pair.
    JSR UNK_SUB_B ; Do sub.
    BNE SUB_RET_VAL ; If val ret, goto.
    LDA TMP_06 ; Restore saved.
    STA OBJ_POS_X_CONFIRMED[18],X
SUB_RET_VAL: ; 0A:1D4B, 0x015D4B
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load val.
    BMI RTS ; Negative, skip setting.
    LDA #$AE ; Set extra.
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$24 ; Animation.
    STA OBJ_ANIMATION_DISPLAY[18],X
RTS: ; 0A:1D5A, 0x015D5A
    RTS ; Leave.
SUB_PAIR_MOD_MISC_CHANGES_SEC0x03_TERT0x0C_HOLD0x00: ; 0A:1D5B, 0x015D5B
    JSR OBJ_PAIR_SWITCH_MOD ; Mod.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do.
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move obj state.
    LDA #$0C
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_J: ; 0A:1D71, 0x015D71
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do..
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CPY #$1C ; Hold _ #$1C
    BCC HOLD_LT_0x1C ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if not.
HOLD_LT_0x1C: ; 0A:1D81, 0x015D81
    LDA #$00 ; Val
    CPY #$14 ; Hold _ #$14
    BCC SEED_SHIFT_CC ; <, goto.
    BNE SEED_SHIFT_CS ; !=, goto.
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Do sub.
    BCC SEED_SHIFT_CS ; Ret CC, goto.
    TYA ; Y to A. TODO: Y change in subs?
    STA OBJ_POS_X??+1,X ; To pair.
    LDA #$01
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Set in Yobj.
    LDA #$0D
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set in Xobj.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$0E
    JSR SND_BANKED_DISPATCH ; Play sound.
SEED_SHIFT_CS: ; 0A:1DA6, 0x015DA6
    LDA #$01 ; Seed shift carry.
SEED_SHIFT_CC: ; 0A:1DA8, 0x015DA8
    LSR A ; >> 1, put A bit 0 to carry.
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load Xobj.
    ROL A ; Rotate with carry into.
    TAY ; To Y index.
    LDA ANIM_DATA,Y ; Load anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Display.
    RTS ; Leave.
S01_MSD_RTN_K: ; 0A:1DB5, 0x015DB5
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY ; Do..
    LDY OBJ_POS_X??+1,X ; Y from pair.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Xobj.
    BEQ YOBJ_ZERO_STATE/ENABLED ; No val, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    BNE RTS ; If nonzero, goto.
    SEC ; Prep sub.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load X
    SBC OBJ_POS_X_CONFIRMED[18],Y ; Sub from Y.
    BPL RESULT_POSITIVE ; Positive result.
    EOR #$FF ; 2 Compliment.
    CLC
    ADC #$01
RESULT_POSITIVE: ; 0A:1DD3, 0x015DD3
    CMP #$08 ; Diff _ #$08
    BCS RTS ; >=, goto. Skip below.
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move obj to.
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY ; Set from sub.
    LDA OBJ_POS_X??+1,X ; Load from pair.
    TAX ; To X.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Load
    LDA #$00
    STA OBJ_POS_X??+1,X ; Clear pair.
    JMP RTS ; Goto.
YOBJ_ZERO_STATE/ENABLED: ; 0A:1DEF, 0x015DEF
    JSR OBJ_STATE_MOVE_TO_S02_T00 ; Move to state.
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY ; Do.
RTS: ; 0A:1DF5, 0x015DF5
    RTS ; Leave.
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0E
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_L: ; 0A:1E06, 0x015E06
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Focus.
    LDA #$00 ; Val
    LDY LEVEL/SCREEN_ON ; Screen
    CPY #$03 ; If _ #$03, sewer.
    BNE NOT_SEWER ; !=, goto.
    LDY 4C6_OBJ_UNK[18],X ; Y from Xobj.
    BNE NOT_SEWER ; Xobj has value.
    LDA #$04 ; Alt val.
NOT_SEWER: ; 0A:1E1B, 0x015E1B
    STA TMP_07 ; Save val decided.
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++ hold.
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CPY #$32 ; If _ #$32
    BCC HOLD_LT_0x32
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do if expired.
HOLD_LT_0x32: ; 0A:1E2F, 0x015E2F
    LDA #$00 ; Val
    CPY #$06 ; Hold _ #$06
    BCC A_DECIDED ; <, goto.
    LDA #$01 ; Val
    CPY #$0C ; Hold _ #$0C
    BCC A_DECIDED ; <, goto.
    BEQ HOLD_EQ_0x0C ; ==, goto.
    CPY #$10 ; Hold _ #$10
    BCS HOLD_GT_0x10
    BCC HOLD_LT_0x10
HOLD_EQ_0x0C: ; 0A:1E43, 0x015E43
    LDA #$10 ; Play sound at hold value.
    JSR SND_BANKED_DISPATCH
HOLD_LT_0x10: ; 0A:1E48, 0x015E48
    LDA #$AD
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
HOLD_GT_0x10: ; 0A:1E4D, 0x015E4D
    JSR MOVE_Y_FINALIZE ; Do.
    LDA RANDOM_VALS?[2] ; Load random.
    AND #$0F ; Keep 0000.1111
    TAY ; To index.
    CLC ; Prep add.
    LDA VAL_RANDOMLY_DECIDED,Y ; Get val.
    ADC OBJ_POS_Y_CONFIRMED[18],X ; Add with
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store back.
    LDA #$02 ; Alt value for A.
A_DECIDED: ; 0A:1E61, 0x015E61
    ORA TMP_07 ; Or with previously decided.
    TAY ; To Y index.
    LDA ANIMATIONS_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    RTS
VAL_RANDOMLY_DECIDED: ; 0A:1E6B, 0x015E6B
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
ANIMATIONS_DATA: ; 0A:1E7B, 0x015E7B
    .db 30
    .db 31
    .db 32
    .db 00
    .db 97
    .db 98
    .db 99
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 11
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
S01_MSD_RTN_M: ; 0A:1E92, 0x015E92
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do.
    LDY #$00 ; Index.
    LDA RANDOM_VALS?[2] ; Load random.
    AND #$08 ; Test bit.
    BEQ BIT_NOT_SET
    LDY #$01 ; Alt index.
BIT_NOT_SET: ; 0A:1EA2, 0x015EA2
    LDA ANIM_DATA,Y
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold
    CMP #$2A ; Hold _ #$2A
    BCC HOLD_UNDER_0x2A ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do otherwise.
HOLD_UNDER_0x2A: ; 0A:1EB5, 0x015EB5
    CMP #$01 ; Hold == #$01..
    BEQ DO_RTN
    CMP #$15 ; Or 0x15
    BEQ DO_RTN
    CMP #$29 ; Or 0x29
    BEQ DO_RTN ; Do rtn.
    RTS ; Leave.
DO_RTN: ; 0A:1EC2, 0x015EC2
    LDA #$00
    STA TMP_00 ; Clear.
    LDY #$07 ; Obj 7
LOOP_ALL_OBJECTS: ; 0A:1EC8, 0x015EC8
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load state.
    CMP #$1A ; If _ #$1A
    BNE NE_1A ; !=, goto.
    INC TMP_00 ; ++, 0x01.
NE_1A: ; 0A:1ED1, 0x015ED1
    INY ; Y++
    CPY #$12 ; Obj _ #$12?
    BCC LOOP_ALL_OBJECTS ; <, goto.
    LDA TMP_00 ; Load count.
    CMP #$04 ; If _ #$04
    BCS RTS ; >=, goto. More than 3 objects matched, leave.
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Do sub.
    BCC RTS ; Ret CC, leave.
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],Y ; Set Yobj hold value.
RTS: ; 0A:1EE6, 0x015EE6
    RTS ; Leave.
ANIM_DATA: ; 0A:1EE7, 0x015EE7
    .db 4D
    .db 51
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$12
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_N: ; 0A:1EF9, 0x015EF9
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CPY #$1C ; If _ #$1C
    BCC HOLD_LT_0x1C ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do otherwise.
HOLD_LT_0x1C: ; 0A:1F09, 0x015F09
    LDA #$1A ; Anim
    CPY #$14 ; Hold _ #$14
    BCC HOLD_LT_0x14 ; <, goto.
    BEQ HOLD_EQ_0x14
    LDA #$1B ; Alt, > 0x14.
HOLD_LT_0x14: ; 0A:1F13, 0x015F13
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    RTS ; Leave.
HOLD_EQ_0x14: ; 0A:1F17, 0x015F17
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Do sub.
    BCC X_FROM_HANDLER_SCRATCHPAD ; Ret CC.
    LDA #$08
    JSR SND_BANKED_DISPATCH ; Play sound.
    TXA ; Xobj to A.
    STA OBJ_POS_X_DELTA?[18],Y ; Store to Yobj.
X_FROM_HANDLER_SCRATCHPAD: ; 0A:1F28, 0x015F28
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Reload Xobj.
    RTS ; Leave.
MOVE_OBJECT_STATE_S3_T13_0HOLD: ; 0A:1F2C, 0x015F2C
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$13
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_O: ; 0A:1F3C, 0x015F3C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do sub.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CPY #$32 ; If _ #$32
    BCC HOLD_LT_0x32 ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do otherwise.
HOLD_LT_0x32: ; 0A:1F51, 0x015F51
    LDA #$36 ; Anim
    CPY #$14 ; Hold _ 0x14
    BEQ HOLD_EQ_0x14
    BCC A_AS_ANIMATION
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    LDA #$37 ; Animation.
A_AS_ANIMATION: ; 0A:1F60, 0x015F60
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store.
    RTS ; Leave.
HOLD_EQ_0x14: ; 0A:1F64, 0x015F64
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Do sub.
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$0F
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
OBJ_STATE_SET_S03_T17: ; 0A:1F71, 0x015F71
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Sec val.
    LDA #$17
    STA OBJ_TERTIARY_SWITCH?[18],X ; Tert val.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No hold.
    RTS ; Leave.
S01_MSD_RTN_S: ; 0A:1F81, 0x015F81
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CPY #$32 ; Hold _ #$32
    BCC HOLD_LT_0x32 ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Goto.
HOLD_LT_0x32: ; 0A:1F96, 0x015F96
    LDA #$87 ; Anim val.
    CPY #$14 ; Hold _ #$14
    BEQ HOLD_EQ_0x14 ; ==, goto.
    BCC HOLD_LT_0x14 ; <, goto. 0x15+ below.
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set
    LDA #$37 ; Anim
HOLD_LT_0x14: ; 0A:1FA5, 0x015FA5
    STA OBJ_ANIMATION_DISPLAY[18],X ; Anim store.
    RTS ; Leave.
HOLD_EQ_0x14: ; 0A:1FA9, 0x015FA9
    JSR SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Hit detect.
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store anim.
    LDA #$0F
    JMP SND_BANKED_DISPATCH ; Play sound.
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$14
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS ; Leave.
S01_MSD_RTN_P: ; 0A:1FC6, 0x015FC6
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Focus player.
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold++
    LDY OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    CPY #$32 ; If _ #$32
    BCC HOLD_LT_0x32 ; <, goto.
    JMP RTN_ANIM/STATE_RETARGET_CHANCE_MORE ; Do otherwise.
HOLD_LT_0x32: ; 0A:1FD9, 0x015FD9
    LDA #$3E ; Anim.
    CPY #$0F ; Hold _ #$0F
    BCC COMMIT_ANIM_A ; <, goto.
    BEQ HOLD_EQ_0x0F
    LDA #$AB ; Anim alt.
COMMIT_ANIM_A: ; 0A:1FE3, 0x015FE3
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation.
    RTS ; Leave.
HOLD_EQ_0x0F: ; 0A:1FE7, 0x015FE7
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    JMP SUB_UNK_CC_FAIL_CS_PASS_HIT_DETECT? ; Hit detect.
S01_MSD_RTN_Q: ; 0A:1FED, 0x015FED
    LDA #$8E ; Load val.
    BNE ALT_A_SEED ; Always taken.
S01_MSD_RTN_R: ; 0A:1FF1, 0x015FF1
    LDA #$8F ; Alt val.
ALT_A_SEED: ; 0A:1FF3, 0x015FF3
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set extra.
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do.
    JSR XPOS_MOD_DELTA_RET_CS_WRAPAROUND ; Do.
    BCC RET_CC ; Ret CC, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load

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
    ADC 5B0_OBJ_UNK[18],X ; Add to OBJ.
    STA 5B0_OBJ_UNK[18],X ; Store back.
NOT_2P: ; 0A:001A, 0x01401A
    LDA 5FA_UNK ; Load
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Store to obj.
    LDA #$00
    STA 5FA_UNK ; Clear
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
    LDA 5B0_OBJ_UNK[18],X ; Load from obj.
    BNE OBJ_UNK_NONZERO ; Nonzero, goto.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; If val
    BEQ OBJ_DATA_B_ZERO ; == 0, goto.
    JSR FIND_SINGLE_YOBJ_NOT_SAME_AS_NEXT_TO_RET_CC_SUCCESS ; Do sub.
    BCC RTS_MOVE ; Found, leave.
    LDA 5FA_UNK ; Load
    BNE OBJ_DATA_B_ZERO ; If set, don't clear 8B.
    LDA #$00
    STA 8B_UNK ; Clear.
OBJ_DATA_B_ZERO: ; 0A:0073, 0x014073
    INC 714_UNK ; ++ unk.
    JMP INIT_OBJECT[X]_DATA_FULL ; Abuse RTS. Clear object?
OBJ_UNK_NONZERO: ; 0A:0079, 0x014079
    JSR GET_OBJS_MATCH_X? ; Get val in TMP.
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
    JSR RTN_GET_OBJ_PAIR_IN_T_RET_CC_SUCCESS
    BCS RTS_MOVE ; Didn't get Yobj. Leave.
    LDA #$30
    STA 59E_OBJ_UNK[18],X ; Set timer.
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
    STA 556_OBJ_UPDATE_FLAGS?[18],Y ; Store to obj.
    LDA DATA_POS_X,X
    STA OBJ_POS_X[18],Y
    LDA LEVEL/SCREEN_ON ; Get level.
    ASL A ; << 1, *2
    TAX ; To X index.
    LDA DATA_TMP11_UNK,X ; Load.
    STA TMP_11 ; To TMP.
    LDA LEVEL/SCREEN_ON ; Get screen.
    CMP #$08 ; If _ #$08
    BNE SCREEN_NOT_8 ; !=, goto.
    LDA NAMETABLE_FOCUS_VAL?[2] ; Load
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
    STA 4A2_OBJ_UNK_POS?[18],Y ; Set from A.
    LDX TMP_10 ; Recover object working on.
    DEC 5B0_OBJ_UNK[18],X ; --
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
    DEC 59E_OBJ_UNK[18],X ; --
    BNE RTS ; != 0, leave.
    DEC OBJ_TERTIARY_SWITCH?[18],X ; Back to switch 2.
RTS: ; 0A:01C0, 0x0141C0
    RTS
GET_OBJS_MATCH_X?: ; 0A:01C1, 0x0141C1
    LDA #$00
    STA TMP_00 ; Clear.
    LDY #$07 ; Obj start.
LOOP_OBJS: ; 0A:01C7, 0x0141C7
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Get state.
    CMP 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; If X.var _ Y.State
    BNE STATE_NE_TIMER? ; !=, goto.
    INC TMP_00 ; ++
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
    JSR UPDATE_PALETTE[0x1C]_WITH_A_SAVING_XOBJ ; Change palette.
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
    STA 556_OBJ_UPDATE_FLAGS?[18],X
    STA 556_OBJ_UPDATE_FLAGS?[18],Y
    LDA #$18
    STA OBJ_POS_X[18],X
    LDA #$20
    BNE L_0A:0273
    LDA #$02
    STA 556_OBJ_UPDATE_FLAGS?[18],X
    STA 556_OBJ_UPDATE_FLAGS?[18],Y
    LDA #$E8
    STA OBJ_POS_X[18],X
    LDA #$E0
L_0A:0273: ; 0A:0273, 0x014273
    STA OBJ_POS_X[18],Y
    LDA LEVEL/SCREEN_ON
    CMP #$02
    BCS L_0A:028D
    LDA #$98
    STA OBJ_POS_Y[18],X
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$C0
    STA OBJ_POS_Y[18],Y
    STA 4A2_OBJ_UNK_POS?[18],Y
    RTS
L_0A:028D: ; 0A:028D, 0x01428D
    LDA #$B0
    STA OBJ_POS_Y[18],X
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$E0
    STA OBJ_POS_Y[18],Y
    STA 4A2_OBJ_UNK_POS?[18],Y
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
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x24_SWITCH_A)
    HIGH(STATE_0x24_SWITCH_A)
    LOW(STATE_0x24_SWITCH_B)
    HIGH(STATE_0x24_SWITCH_B)
STATE_0x24_SWITCH_A: ; 0A:02FC, 0x0142FC
    LDA #$10
    STA 59E_OBJ_UNK[18],X
    INC OBJ_SECONDARY_SWITCH?[18],X
L_0A:0304: ; 0A:0304, 0x014304
    JMP OBJECT_X_MOVE?
STATE_0x24_SWITCH_B: ; 0A:0307, 0x014307
    DEC 59E_OBJ_UNK[18],X
    BNE L_0A:0304
    LDA OBJ_POS_X[18],X
    PHA
    JSR INIT_OBJECT[X]_DATA_FULL
    PLA
    JMP L_0A:074A
OBJ_STATE_0x25_HANDLER: ; 0A:0317, 0x014317
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(S25_EXTRA_RTN_A)
    HIGH(S25_EXTRA_RTN_A)
    LOW(S25_EXTRA_RTN_B)
    HIGH(S25_EXTRA_RTN_B)
S25_EXTRA_RTN_A: ; 0A:0321, 0x014321
    LDY #$00
    JSR UPDATE_PALETTE[0x1C]_WITH_A_SAVING_XOBJ
    LDA #$10
    STA 59E_OBJ_UNK[18],X
    INC OBJ_SECONDARY_SWITCH?[18],X
L_0A:032E: ; 0A:032E, 0x01432E
    JMP OBJECT_X_MOVE?
S25_EXTRA_RTN_B: ; 0A:0331, 0x014331
    DEC 59E_OBJ_UNK[18],X
    BNE L_0A:032E
    LDA OBJ_POS_X[18],X
    PHA
    JSR INIT_OBJECT[X]_DATA_FULL
    PLA
    JMP L_0A:06FC
OBJ_STATE_0x26_HANDLER: ; 0A:0341, 0x014341
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x26_SWITCH_A)
    HIGH(STATE_0x26_SWITCH_A)
    LOW(STATE_0x26_SWITCH_B)
    HIGH(STATE_0x26_SWITCH_B)
    LOW(STATE_0x26_SWITCH_C)
    HIGH(STATE_0x26_SWITCH_C)
STATE_0x26_SWITCH_A: ; 0A:034D, 0x01434D
    LDA #$10
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    INC OBJ_SECONDARY_SWITCH?[18],X
    JMP OBJECT_X_MOVE?
STATE_0x26_SWITCH_B: ; 0A:0358, 0x014358
    JSR GET_OBJS_MATCH_X?
    LDA TMP_00
    CMP #$02
    BCS L_0A:03AC
    JSR RTN_GET_OBJ_PAIR_IN_T_RET_CC_SUCCESS
    BCS L_0A:03AC
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    STA OBJ_ENABLED_STATE+MORE?[18],Y
    LDA 5B0_OBJ_UNK[18],X
    AND #$01
    CLC
    ADC #$01
    STA 556_OBJ_UPDATE_FLAGS?[18],Y
    CMP #$01
    BEQ L_0A:0389
    LDA #$D0
    STA OBJ_POS_X[18],Y
    LDA IRQ/SCRIPT_RUN_COUNT?
    AND #$0F
    CLC
    ADC #$88
    BNE L_0A:0395
L_0A:0389: ; 0A:0389, 0x014389
    LDA #$30
    STA OBJ_POS_X[18],Y
    LDA IRQ/SCRIPT_RUN_COUNT?
    AND #$0F
    CLC
    ADC #$A8
L_0A:0395: ; 0A:0395, 0x014395
    STA 4A2_OBJ_UNK_POS?[18],Y
    INC 5B0_OBJ_UNK[18],X
    JSR GET_OBJS_MATCH_X?
    LDA TMP_00
    CMP #$02
    BCC L_0A:03AC
    LDA #$80
    STA 59E_OBJ_UNK[18],X
    INC OBJ_SECONDARY_SWITCH?[18],X
L_0A:03AC: ; 0A:03AC, 0x0143AC
    JSR OBJECT_X_MOVE?
    JMP TEST_OBJ_UPDATE_FLAG_INIT
STATE_0x26_SWITCH_C: ; 0A:03B2, 0x0143B2
    DEC 59E_OBJ_UNK[18],X
    BNE L_0A:03AC
    DEC OBJ_SECONDARY_SWITCH?[18],X
    JMP L_0A:03AC
OBJ_STATE_0x01_HANDLER: ; 0A:03BD, 0x0143BD
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; OBJ_UPDATE_FLAGS-1.
    STA 556_OBJ_UPDATE_FLAGS?[18],X ; Copy to our flags.
    LDA OBJ_POS_Y+17,X ; OBJ_POS_X-1
    STA OBJ_POS_X[18],X ; Copy to ours.
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
    STA OBJ_POS_X[18],X ; Store to Xpos.
SSWITCH_NE_FOUR: ; 0A:03EB, 0x0143EB
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL?+17,X ; 04A2, YPOS?
    ADC 4C6_OBJ_UNK[18],X ; Add with offset?
    STA OBJ_POS_Y[18],X ; Store to YPOS.
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
    LDY 718_OBJ_INDEX_B_UNK
    BEQ SINGLE_PLAYER/SKIP ; == 0, goto.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load timer from first Yobj.
    LDY 717_OBJ_INDEX_A_UNK ; Other object index.
    BEQ SINGLE_PLAYER/SKIP ; == 0, goto.
    CMP 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; If A_timer _ B_timer
    BNE SINGLE_PLAYER/SKIP ; !=, goto.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load current.
    EOR #$02 ; Invert 0000.0010
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Store back.
    LDA 59E_OBJ_UNK[18],Y ; Load OBJ
    AND #$8F ; Keep 1000.1111
    STA 59E_OBJ_UNK[18],Y ; Store back.
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
    CPX 719_OBJ_CMP_UNK ; If Xobj _ Var
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
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load update flags.
    BNE RTS ; If any set, leave.
    TXA ; Object to A.
    LSR A ; Shift.
    EOR RANDOM_VALS?[2] ; Invert bits in this.
    LSR A ; Shift again.
    BCC RTS ; If shifted off 0, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health
    PHA ; Save
    LDA 59E_OBJ_UNK[18],X ; Load timer.
    AND #$08 ; Test 0000.1000
    BEQ TIMER?_BIT_0x08_NOT_SET
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health
    DEC 59E_OBJ_UNK+1,X ; -- from pair.
    BNE TIMER?_BIT_0x08_NOT_SET ; If not set, skip ??
    LDA 59E_OBJ_UNK[18],X ; Load
    AND #$F7 ; Keep 1111.0111
    STA 59E_OBJ_UNK[18],X ; Store back
    LDA #$00
    STA 59E_OBJ_UNK+1,X ; Clear pair.
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
    CPX 719_OBJ_CMP_UNK ; If Xobj _ Var
    BNE RTS ; !=, leave.
    LDA 59E_OBJ_UNK[18],X ; Load from OBJ.
    AND #$EF ; Keep 1110.1111
    STA 59E_OBJ_UNK[18],X ; Store back.
    LDA #$00
    STA 5B0_OBJ_UNK+1,X ; Clear pair var.
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
    LDA 59E_OBJ_UNK[18],X ; Load
    BPL STATE_NE_0x0D ; If positive, skip.
    JSR SUB_UNK_CC_FAIL_CS_PASS
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
    LOW(HANDLER_0x01_MULTISWITCH_C)
    HIGH(HANDLER_0x01_MULTISWITCH_C)
    LOW(HANDLER_0x01_MULTISWITCH_D)
    HIGH(HANDLER_0x01_MULTISWITCH_D)
    LOW(HANDLER_0x01_MULTISWITCH_E)
    HIGH(HANDLER_0x01_MULTISWITCH_E)
    LOW(HANDLER_0x01_MULTISWITCH_F)
    HIGH(HANDLER_0x01_MULTISWITCH_F)
    LOW(HANDLER_0x01_MULTISWITCH_G) ; Pretty simple.
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
    LDA 59E_OBJ_UNK[18],X
    AND #$EF
    STA 59E_OBJ_UNK[18],X
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
    JSR OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
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
    STA ZP_R2-R5_BANK_VALUES+2
    LDA SPRITE_GFX_BANK_3_VALS,Y
    STA ZP_R2-R5_BANK_VALUES+3
    JMP L_0A:060D ; Goto.
SET_SGFX_BANK_3_ONLY: ; 0A:0606, 0x014606
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA SPRITE_GFX_BANK_3_VALS,Y ; Move bank 3 only.
    STA ZP_R2-R5_BANK_VALUES+3
L_0A:060D: ; 0A:060D, 0x01460D
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$03 ; If _ #$03
    BNE SPRITE_GFX_BANK_3_VALS ; !=, goto. RTS.
    LDA #$37
    STA ZP_R2-R5_BANK_VALUES+3 ; Set bank on screen 3.
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
    STA 59E_OBJ_UNK[18],X ; Store to.
    AND #$01 ; Keep 0000.0001
    ASL A ; << 1, *2.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    JSR OBJ_MANIP_BASED_ON_LIVES_UNK ; Do.
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
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load flags.
    BNE FLAGS_SET ; != 0, goto.
    JMP OBJ_STATE_MOVE_TO_S02_T00 ; Set this.
FLAGS_SET: ; 0A:06D1, 0x0146D1
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Set.
SWITCH_0x02_RTN_B: ; 0A:06D4, 0x0146D4
    LDY LEVEL/SCREEN_ON ; Load screen.
    LDA SCREEN_DATA_UNK_A,Y ; Move screen data to obj.
    STA 4A2_OBJ_UNK_POS?[18],X
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
L_0A:06FC: ; 0A:06FC, 0x0146FC
    STA TMP_16
    LDA #$02
    STA TMP_17
L_0A:0702: ; 0A:0702, 0x014702
    JSR L_1F:1317
    BCS L_0A:0737
    LDA #$02
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA #$00
    STA 556_OBJ_UPDATE_FLAGS?[18],X
    CLC
    LDY TMP_17
    LDA TMP_16
    ADC L_0A:0738,Y
    STA OBJ_POS_X[18],X
    LDA #$97
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$E9
    STA 4C6_OBJ_UNK[18],X
    LDA #$00
    STA 4D8_OBJ_UNK[18],X
    STA OBJ_TERTIARY_SWITCH?+1,X
    LDA #$03
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    DEC TMP_17
    BPL L_0A:0702
L_0A:0737: ; 0A:0737, 0x014737
    RTS
L_0A:0738: ; 0A:0738, 0x014738
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
L_0A:074A: ; 0A:074A, 0x01474A
    STA TMP_16
    LDA #$02
    STA TMP_17
L_0A:0750: ; 0A:0750, 0x014750
    JSR L_1F:1317
    BCS L_0A:0795
    LDA #$04
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA TMP_16
    STA OBJ_POS_X[18],X
    LDA #$70
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$04
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA TMP_17
    ASL A
    TAY
    LDA L_0A:079A,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA L_0A:079B,Y
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA L_0A:0796
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA L_0A:0797
    STA OBJ_POS_X_DELTA?[18],X
    LDA L_0A:0798
    STA 520_ARR_UNK[18],X
    LDA L_0A:0799
    STA 50E_ARR_UNK[18],X
    DEC TMP_17
    BPL L_0A:0750
L_0A:0795: ; 0A:0795, 0x014795
    RTS
L_0A:0796: ; 0A:0796, 0x014796
    .db 80
L_0A:0797: ; 0A:0797, 0x014797
    .db 01
L_0A:0798: ; 0A:0798, 0x014798
    .db 9A
L_0A:0799: ; 0A:0799, 0x014799
    .db 02
L_0A:079A: ; 0A:079A, 0x01479A
    .db 14
L_0A:079B: ; 0A:079B, 0x01479B
    .db 0F
    .db 0A
    .db 19
    .db 01
    .db 23
    .db 85
    .db 16
    .db A9
    .db 02
    .db 85
    .db 17
    .db 20
    .db 17
    .db F3
    .db B0
    .db 34
    .db A9
    .db 02
    .db 9D
    .db 24
    .db 04
    .db A5
    .db 16
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db 88
    .db 9D
    .db A2
    .db 04
    .db A9
    .db 05
    .db 9D
    .db C2
    .db 05
    .db A5
    .db 17
    .db 0A
    .db A8
    .db B9
    .db E2
    .db 87
    .db 9D
    .db 5B
    .db 04
    .db B9
    .db E3
    .db 87
    .db 9D
    .db 49
    .db 04
    .db AD
    .db E0
    .db 87
    .db 9D
    .db 20
    .db 05
    .db AD
    .db E1
    .db 87
    .db 9D
    .db 0E
    .db 05
    .db C6
    .db 17
    .db 10
    .db C7
    .db 60
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
    STA 556_OBJ_UPDATE_FLAGS?[18],X ; Clear
    JSR XPOS_RANDOMNESS ; Xpos from randomness.
    JSR RANDOMNESS? ; More
    AND #$07 ; Keep bottom bits.
    TAY ; To Y index.
    LDA ALT_RTN+DATA,Y ; NOTE: Table in this routine, didn't need specific data?
    STA 4A2_OBJ_UNK_POS?[18],X ; To.
4A2_ADD_LT_0xE0: ; 0A:0806, 0x014806
    LDY OBJ_POS_X[18],X ; Load to Y.
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    JSR RTN_BACKGROUND_TILE_RELATED? ; Get tile?
    CMP #$03 ; If _ #$03
    BEQ SET_UNK_AND_DO_SWITCHES+MORE ; ==, goto.
    CLC ; Prep add
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    ADC #$10 ; += 0x10
    STA 4A2_OBJ_UNK_POS?[18],X ; Store back.
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
    JSR RANDOMNESS? ; Randomness?
    ADC RANDOM_VALS?[2] ; More random.
    LSR A ; >> 1, /2.
    AND #$0F ; Keep bottom bits.
    CMP #$0C ; If _ #$0C
    BCC LESS_THAN_0x0C ; <, goto.
    JSR RANDOMNESS? ; More randomness?
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
    STA OBJ_POS_X[18],X ; Store X pos.
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
    JMP OBJ_DIR_MOD_FROM_POS_AND_UNK ; Dir and pos.
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
    JSR RANDOMNESS? ; Do randomness.
    AND #$3F ; Keep bottom.
    ADC #$20 ; Add
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set as hold.
    LDA #$7A
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load
    LSR A ; >> 1
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load
    AND #$BF ; Keep 0x10111111
    BCS SKIP_SET_FLAG_A ; Update bit 0x01 was set, goto.
    ORA #$40 ; Set bit.
SKIP_SET_FLAG_A: ; 0A:08E0, 0x0148E0
    STA OBJ_DIRECTION_RELATED?[18],X ; Store direction.
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
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR 0A:14BA
    JSR XPOS_RTN_RET_??
    BCC 0A:0938
    LDA #$00
    STA 556_OBJ_UPDATE_FLAGS?[18],X
    JSR RANDOMNESS?
    AND #$0F
    ORA #$10
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA 556_OBJ_UPDATE_FLAGS?[18],X
    BNE 0A:0951
    DEC OBJ_ANIM_HOLD_TIMER?+1,X
    BMI 0A:0954
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BEQ 0A:096A
    JMP MOVE_Y_FINALIZE
    JSR 1F:16FA
    LDA 712_FLAG_PALETTE_UNK
    BNE 0A:0967
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    LDA 0B:0B90,Y
    BEQ 0A:0967
    JMP 0A:185A
    JMP OBJ_STATE_MOVE_TO_S02_T00
    JSR 1F:16FA
    JMP OBJ_STATE_MOVE_TO_S02_T00
SET_SECONDARY/TERTIARY_DIRECTION_MORE: ; 0A:0970, 0x014970
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tertiary.
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load flags.
    BNE FLAGS_NE_ZERO ; != 0, goto.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; No hold timer for secondary.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load obj?
    LDA OBJ_POS_X[18],X ; Load Xpos for X.
    CMP OBJ_POS_X[18],Y ; If X.Xpos _ Y.Xpos
    LDA #$00 ; Prep vals. Direction related.
    LDY #$02 ; Index.
    BCS X_LARGER ; >=, goto.
    LDA #$40 ; Prep alternates.
    LDY #$04
X_LARGER: ; 0A:0997, 0x014997
    STA OBJ_DIRECTION_RELATED?[18],X ; A to direction.
    JMP OBJ_SET_UNK_FROM_Y ; Set from Y.
FLAGS_NE_ZERO: ; 0A:099D, 0x01499D
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load
    CMP #$02 ; If _ #$02
    LDA #$00 ; Prep vals. Direction related.
    LDY #$02 ; Index.
    BCC 0A:09AC ; <, goto.
    LDA #$40 ; Prep alt.
    LDY #$04
    STA OBJ_DIRECTION_RELATED?[18],X ; Store direction.
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
    JSR XPOS_RTN_RET_?? ; Do
    BCC RET_CC ; If carry not set, goto.
    LDA #$00
    STA 556_OBJ_UPDATE_FLAGS?[18],X ; No update.
    JSR RANDOMNESS? ; Get random.
    AND #$3F ; Range 0x00 - 0x3F, 0 to 64 frames.
    ADC #$20 ; += 0x20, 32 frames.
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Set hold for pair.
RET_CC: ; 0A:09EF, 0x0149EF
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load update
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
    JSR MOVE_UNK_RET_?? ; Move
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
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load update
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
    STA OBJ_DIRECTION_RELATED?[18],X ; Set
    LDA OBJ_DATA_A,Y ; Move.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Clear on pair.
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    STA OBJ_POS_Y[18],X ; To Y.
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
    JSR MOVE_UNK_RET_?? ; Move
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
    STA OBJ_DIRECTION_RELATED?[18],X ; Clear
    LDA OBJ_DATA_UNK[4] ; Move from ROM.
    STA 520_ARR_UNK[18],X ; To object.
    LDA OBJ_DATA_UNK+1
    STA 50E_ARR_UNK[18],X
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
    JSR XPOS_RTN_RET_?? ; Do..
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
    STA ZP_R2-R5_BANK_VALUES+2 ; Swap GFX banks.
    LDA #$29
    STA ZP_R2-R5_BANK_VALUES+3
    JMP JMP_TO_Y_FINALIZE ; Finalize
GTE_TWELVE: ; 0A:0B3D, 0x014B3D
    LDA #$F6
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Store to pair data.
    LDA OBJ_DATA_A ; Move data to objects.
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 520_ARR_UNK[18],X
    LDA OBJ_DATA_D
    STA 50E_ARR_UNK[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER ; Set pair.
JMP_TO_Y_FINALIZE: ; 0A:0B5D, 0x014B5D
    JMP MOVE_Y_FINALIZE ; FInalize.
PAIR_VAL_NEG: ; 0A:0B60, 0x014B60
    JSR MOVE_UNK_RET_?? ; Do..
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    CMP #$E2 ; If _ #$E2
    BCC UNDER_MAX
    LDA #$E1
    STA 4A2_OBJ_UNK_POS?[18],X ; Set max.
UNDER_MAX: ; 0A:0B6F, 0x014B6F
    LDA #$40
    JSR MOVE_UNK_RET_?? ; Move
    BCC JMP_TO_Y_FINALIZE ; Ret CC, finalize.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear
    STA 4D8_OBJ_UNK[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    STA OBJ_POS_Y[18],X ; To Y.
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
    JMP OBJ_DIR_MOD_FROM_POS_AND_UNK
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
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX for animation.
    LDA #$29
    STA ZP_R2-R5_BANK_VALUES+3
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
    STA 520_ARR_UNK[18],X ; Move data to OBJ.
    LDA OBJ_DATA_B
    STA 50E_ARR_UNK[18],X
    JSR SUB_GFX_BANKS_FROM_STATE ; Set GFX.
STATE/ANIMATION/DIR_MOD/FINALIZE_RE-ENTER: ; 0A:0BFF, 0x014BFF
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE ; State and animation.
    JSR OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
GT_#$E0: ; 0A:0C08, 0x014C08
    JSR OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JSR MOVE_UNK_RET_?? ; Move.
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    CMP #$E2 ; If _ #$E2
    BCC LT_#$E2
    LDA #$E1 ; Max
    STA 4A2_OBJ_UNK_POS?[18],X ; Store.
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
    JSR OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do..
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
    STA 520_ARR_UNK[18],X
    LDA OBJ_DATA_D
    STA 50E_ARR_UNK[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
FINALIZE_OBJECT: ; 0A:0CAB, 0x014CAB
    JMP MOVE_Y_FINALIZE ; Move object.
Y_HAS_VAL: ; 0A:0CAE, 0x014CAE
    JSR MOVE_UNK_RET_?? ; Do.
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    CMP #$E8 ; If _ #$E8
    BCC DONT_CAP ; <, goto.
    LDA #$E7 ; Cap val.
    STA 4A2_OBJ_UNK_POS?[18],X ; Store max.
DONT_CAP: ; 0A:0CBD, 0x014CBD
    LDA #$40 ; Val?
    JSR MOVE_UNK_RET_?? ; Do.
    BCC FINALIZE_OBJECT ; If carry clear, finalize.
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear these.
    STA 4D8_OBJ_UNK[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    STA OBJ_POS_Y[18],X ; Store to.
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
    JSR XPOS_RTN_RET_?? ; Do..
    LDA #$40
    JSR MOVE_UNK_RET_?? ; Do..
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
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    STA OBJ_POS_Y[18],X ; Store to.
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
    JSR MOVE_UNK_RET_?? ; Do...
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
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    SBC TMP_00 ; Sub from compliment.
    BCS NO_UNDERFLOW ; If no underflow, skip display change.
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X ; Don't change animation.
    LDA #$01 ; Seed pos?
NO_UNDERFLOW: ; 0A:0D91, 0x014D91
    STA OBJ_POS_Y[18],X ; Store POS.
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
    ADC OBJ_POS_X[18],X ; Add to.
    STA OBJ_POS_X[18],X ; Store to.
    ROR A ; Shift
    EOR OBJ_POS_X_DELTA?[18],X ; Invert with delta.
    BPL RTS ; If positive, goto.
UNDERFLOW: ; 0A:0E49, 0x014E49
    LDA #$00
    STA 556_OBJ_UPDATE_FLAGS?[18],X ; Clear
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
    LOW(S01_MSC_RTN_A)
    HIGH(S01_MSC_RTN_A)
    LOW(S01_MSC_RTN_B)
    HIGH(S01_MSC_RTN_B)
    LOW(S01_MSC_RTN_C)
    HIGH(S01_MSC_RTN_C)
    LOW(S01_MSC_RTN_D)
    HIGH(S01_MSC_RTN_D)
S01_MSC_RTN_D: ; 0A:0E76, 0x014E76
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?+1,X
    BNE 0A:0EBE
    LDA #$09
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$0A
    BNE 0A:0E8E
    LDA #$57
    STA OBJ_ANIMATION_DISPLAY[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
    JSR MOVE_UNK_RET_??
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$E0
    BCC 0A:0EA3
    LDA #$E0
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$40
    JSR MOVE_UNK_RET_??
    BCC 0A:0EBB
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?+1,X
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    JSR OBJ_STATE_MOVE_TO_S02_T00
    JSR OBJ_PAIR_SWITCH_MOD
    JMP MOVE_Y_FINALIZE
    DEC OBJ_ANIM_HOLD_TIMER?+1,X
    RTS
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
    LDA 0A:0F10,Y
    ASL A
    ASL A
    TAY
    LDA 0A:0F20,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:0F21,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:0F22,Y
    STA 520_ARR_UNK[18],X
    LDA 0A:0F23,Y
    STA 50E_ARR_UNK[18],X
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    RTS
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
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?+1,X
    BNE 0A:0F8D
    LDA #$09
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$0A
    BNE 0A:0F50
    LDA #$57
    STA OBJ_ANIMATION_DISPLAY[18],X
    JSR SET_PAIR_SECONDARY|0x01_SCREEN_3_DIFFER
    JSR MOVE_UNK_RET_??
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    CMP 4A2_OBJ_UNK_POS?[18],X
    BCC 0A:0F67
    STA 4A2_OBJ_UNK_POS?[18],X
    INC 4A2_OBJ_UNK_POS?[18],X
    LDA #$40
    JSR MOVE_UNK_RET_??
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:0F8A
    LDA 4D8_OBJ_UNK+1,X
    CMP 4C6_OBJ_UNK[18],X
    BCS 0A:0F8A
    STA 4C6_OBJ_UNK[18],X
    LDY LEVEL/SCREEN_ON
    LDA 0A:0FF5,Y
    STA OBJ_TERTIARY_SWITCH?+1,X
    JSR OBJ_STATE_MOVE_TO_S02_T00
    JSR OBJ_PAIR_SWITCH_MOD
    JMP MOVE_Y_FINALIZE
    DEC OBJ_ANIM_HOLD_TIMER?+1,X
    RTS
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$56
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$0A
    BEQ 0A:0FB2
    LDA #$02
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    JSR STATE_SOLVING_AND_ANIMATION_FOR_STATE
    LDY LEVEL/SCREEN_ON
    LDA 0A:0F10,Y
    ASL A
    ASL A
    TAY
    LDA 0A:1007,Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:1008,Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA 0A:1009,Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X
    LDA #$0F
    STA OBJ_ANIM_HOLD_TIMER?+1,X
    LDA 0A:1005
    STA 520_ARR_UNK[18],X
    LDA 0A:1006
    STA 50E_ARR_UNK[18],X
    RTS
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
    .db 40
    .db FF
    .db 80
    .db F8
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
    LDA 556_OBJ_UPDATE_FLAGS?[18],X ; Load
    BEQ ALT_RTN
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE ; Do if none.
ALT_RTN: ; 0A:102A, 0x01502A
    LDA 59E_OBJ_UNK[18],X ; Load
    ASL A ; << 1, *2.
    BMI SKIP_RTN ; If negative, goto.
    LDA 5B0_OBJ_UNK+1,X ; Load from pair.
    BEQ SKIP_RTN ; Zero, goto.
    DEC 5B0_OBJ_UNK+1,X ; pair--
    BNE SKIP_RTN ; Still not zero, goto.
    CPX 719_OBJ_CMP_UNK ; If Xobj _ var
    BNE SKIP_RTN ; !=, goto.
    LDA 59E_OBJ_UNK[18],X ; Load
    AND #$EF ; Keep 1110.1111
    STA 59E_OBJ_UNK[18],X ; Store back.
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
    LDA 59E_OBJ_UNK[18],X ; Load
    ASL A ; >> 1, *2.
    BPL SHIFT_POSITIVE ; If positive, goto.
    JMP RTN_UNK
SHIFT_POSITIVE: ; 0A:1067, 0x015067
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BEQ 0A:1074
    JMP 0A:10EF
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    CMP #$0B
    BNE 0A:1090
    LDA RANDOM_VALS?[2]
    AND #$3F
    BEQ 0A:1084
    JMP 0A:10EF
    LDA TMP_16
    CMP #$60
    BCC 0A:108D
    JMP SET_SECONDARY/TERTIARY_DIRECTION_MORE
    JMP 0A:10DF
    LDA TMP_17
    CMP #$07
    BCC 0A:109E
    LDA #$00
    STA 5B0_OBJ_UNK[18],X
    JMP 0A:10EF
    INC 5B0_OBJ_UNK[18],X
    LDA 5B0_OBJ_UNK[18],X
    CMP #$01
    BEQ 0A:10AF
    LDY LEVEL/SCREEN_ON
    CMP 0B:0BBB,Y
    BCC 0A:10EF
    LDA 50E_ARR_UNK[18],X
    ORA 520_ARR_UNK[18],X
    BNE 0A:10D3
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:10D3
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BEQ 0A:10D3
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$0F
    BNE 0A:10D3
    JSR 0B:0B0B
    BCC 0A:10D3
    JMP 0A:0F91
    LDA TMP_16
    CMP #$80
    BCC 0A:10DF
    JSR SET_SECONDARY/TERTIARY_DIRECTION_MORE
    JMP FINALIZATION
    JSR 0B:0069
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$03
    BNE 0A:10EF
    JSR MOVE_Y_FINALIZE
    JMP OBJ_DIR_MOD_FROM_POS_AND_UNK
    CPX 719_OBJ_CMP_UNK
    BNE 0A:1144
    LDA 59E_OBJ_UNK[18],X
    AND #$10
    BEQ 0A:1111
    LDA OBJ_SECONDARY_SWITCH?+1,X
    AND #$02
    BNE 0A:110E
    ASL OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ROL OBJ_POS_X_DELTA?[18],X
    ASL 520_ARR_UNK[18],X
    ROL 50E_ARR_UNK[18],X
    JMP RTN_UNK
    LDA OBJ_POS_X_DELTA?[18],X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ORA 50E_ARR_UNK[18],X
    ORA 520_ARR_UNK[18],X
    BNE RTN_UNK
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    EOR #$01
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    INC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    CMP #$04
    BCC RTN_UNK
    LDA 59E_OBJ_UNK[18],X
    ORA #$10
    STA 59E_OBJ_UNK[18],X
    LDA #$00
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA #$C8
    STA 5B0_OBJ_UNK+1,X
    RTS
    LDA OBJ_SECONDARY_SWITCH?+1,X
    AND #$02
    BNE RTN_UNK
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BNE RTN_UNK
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$04
    BNE RTN_UNK
    LDY 717_OBJ_INDEX_A_UNK
    LDA 59E_OBJ_UNK[18],Y
    ASL A
    BMI RTN_UNK
    LDY 718_OBJ_INDEX_B_UNK
    LDA 59E_OBJ_UNK[18],Y
    ASL A
    BMI RTN_UNK
    LDA 5B0_OBJ_UNK+1,X
    BNE RTN_UNK
    LDA LEVEL/SCREEN_ON
    CMP #$02
    BEQ RTN_UNK
    CMP #$03
    BEQ RTN_UNK
    CMP #$08
    BEQ RTN_UNK
    JSR 0A:166E
RTN_UNK: ; 0A:1182, 0x015182
    LDA 59E_OBJ_UNK[18],X ; Load
    ASL A ; << 1.
    BPL SHIFT_POSITIVE ; Positive, goto.
    JSR SUB_UNK
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; --
    BEQ OBJ_CLEAR_AND_SET_PAIR_UNK ; If zero, goto.
    LDA 5B0_OBJ_UNK+1,X ; Load from pair.
    BNE PAIR_NOT_ZERO ; != 0, goto.
    LDA 50E_ARR_UNK[18],X ; Load
    ORA 520_ARR_UNK[18],X ; Combine with.
    BEQ OBJ_CLEAR_AND_SET_PAIR_UNK ; If neither set, goto.
    JMP FINALIZATION ; Goto.
OBJ_CLEAR_AND_SET_PAIR_UNK: ; 0A:11A0, 0x0151A0
    LDA 59E_OBJ_UNK[18],X ; Load from obj.
    AND #$9F ; Keep 0x1001.1111
    STA 59E_OBJ_UNK[18],X ; Store back.
    LDA #$64 ; Set pair to val.
    STA 5B0_OBJ_UNK+1,X
    RTS ; Leave.
PAIR_NOT_ZERO: ; 0A:11AE, 0x0151AE
    DEC 5B0_OBJ_UNK+1,X ; pair--
    JMP FINALIZATION ; Goto.
SHIFT_POSITIVE: ; 0A:11B4, 0x0151B4
    JSR OBJ_MANIP_BASED_ON_LIVES_UNK ; Do..
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF ; Do..
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ ; Do..
    JSR UNK_SUB_A
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
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
    JSR 0A:12D6
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:1202
    LDA RANDOM_VALS?[2]
    LSR A
    BCC 0A:1202
    INC 4A2_OBJ_UNK_POS?[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$E1
    BCC 0A:1202
    LDA #$E0
    STA 4A2_OBJ_UNK_POS?[18],X
    CPX 719_OBJ_CMP_UNK
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
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$38
    BCS 0A:122A
    JMP 0B:05B9
    CMP #$E1
    BCC 0A:1233
    LDA #$E0
    STA 4A2_OBJ_UNK_POS?[18],X
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
    LDA 4A2_OBJ_UNK_POS?[18],X
    SBC 4A2_OBJ_UNK_POS?[18],Y
    BPL 0A:1258
    EOR #$FF
    CLC
    ADC #$01
    CMP #$03
    BCS 0A:125F
    JMP 0A:0EC2
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE FINALIZATION
    LDA 50E_ARR_UNK[18],X
    BPL 0A:128F
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:12A6
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA 4C6_OBJ_UNK[18],Y
    BEQ 0A:12A6
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    AND #$0F
    BNE 0A:12A6
    JSR 0B:0B0B
    BCC 0A:12A6
    JMP 0A:0F91
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
    JSR OBJ_DIR_MOD_FROM_POS_AND_UNK
    JMP STATE_SOLVING_AND_ANIMATION_FOR_STATE
UNK_SUB_A: ; 0A:12B2, 0x0152B2
    JSR XPOS_RTN_RET_??
    BCC 0A:12C3
    ASL OBJ_POS_X[18],X
    LDA #$01
    BCS 0A:12C0
    LDA #$FE
    STA OBJ_POS_X[18],X
    RTS
    JSR MOVE_UNK_RET_??
    BCC 0A:12D5
    ASL 4A2_OBJ_UNK_POS?[18],X
    LDA #$00
    BCS 0A:12D2
    LDA #$FF
    STA 4A2_OBJ_UNK_POS?[18],X
    RTS
    CLC
    LDA OBJ_POS_X[18],X
    ADC B1_SCROLL_X_COPY_IRQ_ZP[2]
    AND #$0F
    STA TMP_00
    LDA OBJ_POS_X_DELTA?[18],X
    BMI 0A:12F3
    INC TMP_00
    SEC
    LDA OBJ_POS_X[18],X
    SBC TMP_00
    STA OBJ_POS_X[18],X
    JMP 0A:12FF
    CLC
    LDA OBJ_POS_X[18],X
    LDY TMP_00
    ADC 0A:1300,Y
    STA OBJ_POS_X[18],X
    RTS
    .db 10
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
    LDA 4A2_OBJ_UNK_POS?[18],X
    ADC 4C6_OBJ_UNK[18],X
    CLC
    ADC 81_UNK
    AND #$0F
    STA TMP_00
    LDA 50E_ARR_UNK[18],X
    BMI 0A:133B
    INC TMP_00
    CLC
    LDA 4A2_OBJ_UNK_POS?[18],X
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
    LDA 4A2_OBJ_UNK_POS?[18],X
    ADC 4C6_OBJ_UNK[18],X
    LDY TMP_00
    CLC
    ADC 0A:1300,Y
    LDY LEVEL/SCREEN_ON
    CPY #$02
    BNE 0A:1351
    CLC
    ADC #$F4
    SEC
    SBC 4C6_OBJ_UNK+1,X
    STA 4A2_OBJ_UNK_POS?[18],X
    RTS
HIT_DETECT?_UNK: ; 0A:1359, 0x015359
    LDY A/B_WHICH_RESULT ; Y from.
    LDA DATA_A,Y ; Load data
    STA TMP_14 ; Store to.
    CPY #$02 ; If _ #$02
    BNE OBJ_IS_P2 ; P2, goto.
    LDA 59E_OBJ_UNK[18],X ; Load from Xobj.
    AND #$10 ; Keep 0001.0000
    BNE BIT_SET ; If set, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA 4A2_OBJ_UNK_POS?[18],Y ; Load from Yobj.
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
    ADC OBJ_POS_X[18],Y ; Add with.
    PHA ; Save
    ROR A ; >> 1
    EOR TMP_00 ; Eor with.
    ASL A ; << 1
    PLA ; Restore
    BCS ADD_OVERFLOWED ; If add overflowed
    STA TMP_14 ; Store if no overflow.
ADD_OVERFLOWED: ; 0A:13B9, 0x0153B9
    LDA 4A2_OBJ_UNK_POS?[18],Y ; Load
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
    LDA OBJ_POS_X[18],X ; Load from.
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
    STA 520_ARR_UNK[18],X
    LDA OBJ_DATA_D,Y
    STA 50E_ARR_UNK[18],X
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
    BPL STATE_COMP ; If positive, goto.
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Re-set hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Inc extra.
STATE_COMP: ; 0A:1482, 0x015482
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load enabled.
    CMP #$0D ; If state _ #$0D
    BNE STATE_NE_0x0D ; Not eq.
    LDY 59E_OBJ_UNK[18],X ; Load
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
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL STATE_COMP
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    JMP STATE_COMP
SET_OBJ_ANIM_HOLD/CLEAR_ENTRY: ; 0A:14CA, 0x0154CA
    LDA #$0A
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Clear.
    RTS
OBJ_STORAGE_UNK: ; 0A:14D5, 0x0154D5
    LDA 717_OBJ_INDEX_A_UNK ; Load
    BNE VAL_NONZERO_A ; != 0, goto.
    STX 717_OBJ_INDEX_A_UNK ; X to here if zero.
    RTS
VAL_NONZERO_A: ; 0A:14DE, 0x0154DE
    LDA 719_OBJ_CMP_UNK ; Load
    BNE VAL_NONZERO_B ; != 0, goto.
    STX 719_OBJ_CMP_UNK ; X to here if zero.
    RTS
VAL_NONZERO_B: ; 0A:14E7, 0x0154E7
    STX 718_OBJ_INDEX_B_UNK ; X to here if both nonzero.
    RTS
TEST_XOBJ_EQ_717/718_INDEX_MATCH: ; 0A:14EB, 0x0154EB
    LDY #$00 ; Unk val.
    CPX 717_OBJ_INDEX_A_UNK ; If Xobj _ Var
    BEQ XOBJ_EQ_INDEXES ; ==, goto.
    INY ; Y++
    CPX 718_OBJ_INDEX_B_UNK ; If Xobj _ Var
    BEQ XOBJ_EQ_INDEXES ; ==, goto.
    INY ; Y++
XOBJ_EQ_INDEXES: ; 0A:14F9, 0x0154F9
    STY A/B_WHICH_RESULT ; 0/1 match, 2 no match.
    RTS
L_0A:14FD: ; 0A:14FD, 0x0154FD
    CPX 719_OBJ_CMP_UNK
    BEQ 0A:1553
    CPX 717_OBJ_INDEX_A_UNK
    BNE 0A:1516
    LDA 719_OBJ_CMP_UNK
    BEQ 0A:1553
    STX 719_OBJ_CMP_UNK
    STA 717_OBJ_INDEX_A_UNK
    TAY
    JMP 0A:1527
    CPX 718_OBJ_INDEX_B_UNK
    BNE 0A:1553
    LDA 719_OBJ_CMP_UNK
    BEQ 0A:1553
    STX 719_OBJ_CMP_UNK
    STA 718_OBJ_INDEX_B_UNK
    TAY
    LDA 59E_OBJ_UNK[18],Y
    AND #$8F
    STA 59E_OBJ_UNK[18],Y
    LDA #$00
    STA 5B0_OBJ_UNK+1,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
    LDY 719_OBJ_CMP_UNK
    LDA 59E_OBJ_UNK[18],Y
    AND #$8F
    STA 59E_OBJ_UNK[18],Y
    LDA #$00
    STA 5B0_OBJ_UNK+1,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
    JSR TEST_XOBJ_EQ_717/718_INDEX_MATCH
    RTS
    LDA #$00
    CPX 719_OBJ_CMP_UNK
    BNE 0A:155F
    STA 719_OBJ_CMP_UNK
    RTS
    CPX 718_OBJ_INDEX_B_UNK
    BNE 0A:1584
    LDY 719_OBJ_CMP_UNK
    BNE 0A:157B
    LDY 717_OBJ_INDEX_A_UNK
    BEQ 0A:1577
    STY 718_OBJ_INDEX_B_UNK
    STA 717_OBJ_INDEX_A_UNK
    JMP 0A:1598
    STA 718_OBJ_INDEX_B_UNK
    RTS
    STY 718_OBJ_INDEX_B_UNK
    STA 719_OBJ_CMP_UNK
    JMP 0A:1598
    CPX 717_OBJ_INDEX_A_UNK
    BNE 0A:15AB
    LDY 719_OBJ_CMP_UNK
    BNE 0A:1592
    STA 717_OBJ_INDEX_A_UNK
    RTS
    STY 717_OBJ_INDEX_A_UNK
    STA 719_OBJ_CMP_UNK
    LDA 59E_OBJ_UNK[18],Y
    AND #$8F
    STA 59E_OBJ_UNK[18],Y
    LDA #$00
    STA 5B0_OBJ_UNK+1,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,Y
    RTS
XOBJ_CMP_STUFF_RET_CS_CLEARED_CC_NO_MOD: ; 0A:15AC, 0x0155AC
    CPX 719_OBJ_CMP_UNK ; If Xobj _ var
    BNE RTS_CC ; !=, goto.
    LDA 717_OBJ_INDEX_A_UNK ; Load
    BEQ 717_EQ_ZERO
    LDA 718_OBJ_INDEX_B_UNK ; Load
    BNE RTS_CC ; If set, RTS CC.
    STX 718_OBJ_INDEX_B_UNK ; X to.
    JMP CLEAR_OBJ_ATTRS ; Goto.
717_EQ_ZERO: ; 0A:15C1, 0x0155C1
    STX 717_OBJ_INDEX_A_UNK ; X to.
CLEAR_OBJ_ATTRS: ; 0A:15C4, 0x0155C4
    LDA #$00
    STA 719_OBJ_CMP_UNK ; Clear
    LDA 59E_OBJ_UNK[18],X ; Load from obj.
    AND #$8F ; Keep 1000.1111
    STA 59E_OBJ_UNK[18],X ; Store back.
    LDA #$00
    STA 5B0_OBJ_UNK+1,X ; Clear these.
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
    LDA OBJ_POS_X[18],X
    STA TMP_06
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA TMP_07
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    CLC
    LDA OBJ_POS_X[18],Y
    ADC TMP_08
    CMP #$29
    BCS 0A:1614
    LDA #$29
    CMP #$D7
    BCC 0A:161A
    LDA #$D7
    STA OBJ_POS_X[18],X
    CLC
    LDA 4A2_OBJ_UNK_POS?[18],Y
    ADC TMP_09
    CMP #$E1
    BCC 0A:1629
    LDA #$E0
    STA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    LDY OBJ_POS_X[18],X
    JSR UNK_SUB_B
    BNE 0A:1645
    LDA TMP_06
    STA OBJ_POS_X[18],X
    LDA TMP_07
    STA 4A2_OBJ_UNK_POS?[18],X
    JMP OBJ_CLEAR_AND_SET_PAIR_UNK
    LDA 59E_OBJ_UNK[18],X
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
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LSR A
    TAY
    LDA NUM_PLAYER_LIVES[2],Y
    BMI 0A:16E9
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X[18],Y
    CMP #$50
    BCC 0A:16E9
    CMP #$B0
    BCS 0A:16E9
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP 4A2_OBJ_UNK_POS?[18],Y
    BNE 0A:16EB
    SEC
    LDA OBJ_POS_X[18],X
    SBC OBJ_POS_X[18],Y
    STA TMP_0A
    BCS 0A:169E
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_08
    CMP #$27
    BNE 0A:16E9
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$A8
    ROL A
    AND #$01
    LDY TMP_0A
    BMI 0A:16B2
    ORA #$02
    ASL A
    ASL A
    TAY
    LDA 59E_OBJ_UNK[18],X
    AND #$9F
    ORA 0A:1747,Y
    STA 59E_OBJ_UNK[18],X
    LDA 0A:1748,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X[18],Y
    STA OBJ_POS_X_DELTA?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],Y
    STA 50E_ARR_UNK+1,X
    LDA #$80
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 520_ARR_UNK+1,X
    LDA #$B4
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA #$1E
    STA 5B0_OBJ_UNK+1,X
    SEC
    RTS
    CLC
    RTS
    JMP 0A:16E9
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X[18],X
    CMP OBJ_POS_X[18],Y
    BNE 0A:16E9
    SEC
    LDA 4A2_OBJ_UNK_POS?[18],X
    SBC 4A2_OBJ_UNK_POS?[18],Y
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
    LDA 59E_OBJ_UNK[18],X
    AND #$9F
    ORA 0A:1757,Y
    STA 59E_OBJ_UNK[18],X
    LDA 0A:1758,Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_POS_X[18],Y
    STA OBJ_POS_X_DELTA?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],Y
    STA 50E_ARR_UNK+1,X
    LDA #$80
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X
    STA 520_ARR_UNK+1,X
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
    LOW(S01_MSD_RTN_A)
    HIGH(S01_MSD_RTN_A)
    LOW(S01_MSD_RTN_B)
    HIGH(S01_MSD_RTN_B)
    LOW(S01_MSD_RTN_C)
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_D)
    HIGH(S01_MSD_RTN_D)
    LOW(S01_MSD_RTN_E)
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_F)
    HIGH(S01_MSD_RTN_F)
    LOW(S01_MSD_RTN_G)
    HIGH(S01_MSD_RTN_G)
    LOW(S01_MSD_RTN_C)
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_E)
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_H)
    HIGH(S01_MSD_RTN_H)
    LOW(S01_MSD_RTN_I)
    HIGH(S01_MSD_RTN_I)
    LOW(S01_MSD_RTN_C)
    HIGH(S01_MSD_RTN_C)
    LOW(S01_MSD_RTN_J)
    HIGH(S01_MSD_RTN_J)
    LOW(S01_MSD_RTN_K)
    HIGH(S01_MSD_RTN_K)
    LOW(S01_MSD_RTN_L)
    HIGH(S01_MSD_RTN_L)
    LOW(S01_MSD_RTN_D)
    HIGH(S01_MSD_RTN_D)
    LOW(S01_MSD_RTN_E)
    HIGH(S01_MSD_RTN_E)
    LOW(S01_MSD_RTN_M)
    HIGH(S01_MSD_RTN_M)
    LOW(S01_MSD_RTN_N)
    HIGH(S01_MSD_RTN_N)
    LOW(S01_MSD_RTN_O)
    HIGH(S01_MSD_RTN_O)
    LOW(S01_MSD_RTN_P)
    HIGH(S01_MSD_RTN_P)
    LOW(S01_MSD_RTN_Q) ; Alt A val.
    HIGH(S01_MSD_RTN_Q)
    LOW(S01_MSD_RTN_R) ; Same as Q, except alt A.
    HIGH(S01_MSD_RTN_R)
    LOW(S01_MSD_RTN_S)
    HIGH(S01_MSD_RTN_S)
    LOW(S01_MSD_RTN_E)
    HIGH(S01_MSD_RTN_E)
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
    LDA OBJ_DIRECTION_RELATED?[18],X
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
    .db 80
    .db 02
    .db 00
    .db FC
    .db 40
    .db FC
S01_MSD_RTN_A: ; 0A:18B4, 0x0158B4
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    LDA #$40
    LDY 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:18C0
    LDA #$20
    JSR MOVE_UNK_RET_??
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:18CC
    BCS 0A:1930
    BCC 0A:18D9
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:18D9
    LDA 4C6_OBJ_UNK[18],X
    CMP 4D8_OBJ_UNK+1,X
    BCS 0A:1930
    LDA OBJ_POS_X[18],X
    STA TMP_06
    JSR XPOS_RTN_RET_??
    BCC 0A:18EF
    LDA #$01
    LDY OBJ_POS_X_DELTA?[18],X
    BPL 0A:18EC
    LDA #$02
    STA 556_OBJ_UPDATE_FLAGS?[18],X
    LDA 556_OBJ_UPDATE_FLAGS?[18],X
    BNE 0A:1908
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE 0A:1908
    LDA TMP_06
    STA OBJ_POS_X[18],X
    JSR MOVE_Y_FINALIZE
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    ASL A
    LDA #$01
    LDY #$09
    BCS 0A:1919
    LDA #$82
    LDY #$0D
    STA OBJECT_DATA_EXTRA_B?[18],X
    TYA
    STA OBJ_ANIMATION_DISPLAY[18],X
    BCS 0A:192F
    LDA 59E_OBJ_UNK[18],X
    ORA #$08
    STA 59E_OBJ_UNK[18],X
    LDA #$14
    STA 59E_OBJ_UNK+1,X
    RTS
    LDA 556_OBJ_UPDATE_FLAGS?[18],X
    BNE 0A:194C
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE 0A:194C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR 0A:12D6
    LDA 59E_OBJ_UNK[18],X
    AND #$F7
    STA 59E_OBJ_UNK[18],X
    LDA #$00
    STA 59E_OBJ_UNK+1,X
    LDA 4C6_OBJ_UNK+1,X
    STA 4C6_OBJ_UNK[18],X
    LDA #$00
    STA 4D8_OBJ_UNK[18],X
    STA ARR_SPRITE_OBJ_TIMER?+1
    JSR OBJ_PAIR_SWITCH_MOD
    JMP 0A:1A1B
S01_MSD_RTN_B: ; 0A:196D, 0x01596D
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    LDA #$40
    LDY 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:1979
    LDA #$20
    JSR MOVE_UNK_RET_??
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:1985
    BCS 0A:1930
    BCC 0A:1992
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:1992
    LDA 4C6_OBJ_UNK[18],X
    CMP 4D8_OBJ_UNK+1,X
    BCS 0A:1930
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:19BA
    LDA OBJ_POS_X_DELTA?[18],X
    ASL A
    LDA 0A:18AE
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA 0A:18AF
    STA OBJ_POS_X_DELTA?[18],X
    BCC 0A:19BA
    SEC
    LDA #$00
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    JMP 0A:18D9
    JMP OBJ_STATE_MOVE_TO_S02_T00
    INC OBJ_SECONDARY_SWITCH?[18],X
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_C: ; 0A:19CE, 0x0159CE
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    LDA #$00
    LDY LEVEL/SCREEN_ON
    CPY #$03
    BNE 0A:19E3
    LDY 4C6_OBJ_UNK[18],X
    BNE 0A:19E3
    LDA #$02
    STA TMP_07
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$13
    BCS 0A:1A1B
    LDA #$00
    CPY #$0A
    BCC 0A:1A0D
    CPY #$0F
    BCS 0A:1A0B
    LDA #$81
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA 59E_OBJ_UNK[18],X
    ORA #$08
    STA 59E_OBJ_UNK[18],X
    LDA #$14
    STA 59E_OBJ_UNK+1,X
    LDA #$01
    ORA TMP_07
    TAY
    LDA 0A:1A17,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    .db 0B
    .db 0C
    .db 8F
    .db 90
    .db BD
    .db 9E
    .db 05
    .db 29
    .db F7
    .db 9D
    .db 9E
    .db 05
    LDA #$01
    STA 5B0_OBJ_UNK[18],X
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY
    JSR OBJ_STATE_MOVE_TO_S02_T00
    LDA #$00
    STA OBJ_POS_X_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    JSR RANDOMNESS?
    AND #$1F
    BNE 0A:1A40
    JMP 1F:16FE
    RTS
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
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$13
    BCS 0A:1A1B
    LDA #$00
    CPY #$0A
    BCC 0A:1A8A
    CPY #$0F
    BCS 0A:1A88
    LDA 59E_OBJ_UNK[18],X
    ORA #$08
    STA 59E_OBJ_UNK[18],X
    LDA #$14
    STA 59E_OBJ_UNK+1,X
    LDA #$01
    STA TMP_00
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    CMP #$03
    BNE 0A:1AAD
    LDY LEVEL/SCREEN_ON
    CPY #$03
    BNE 0A:1AAD
    LDY 4C6_OBJ_UNK[18],X
    BNE 0A:1AAD
    JSR 0A:1AAA
    LDY TMP_00
    LDA 0A:1ABE,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    ASL A
    ORA TMP_00
    TAY
    LDA 0A:1AC0,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA 0A:1AE2,Y
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
    .db 8E
    .db 91
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
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$1C
    BCC 0A:1B7E
    JMP 0A:1A1B
    LDA #$00
    CPY #$14
    BCC 0A:1B99
    BNE 0A:1B97
    JSR SUB_UNK_CC_FAIL_CS_PASS
    LDA #$0D
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$09
    BNE 0A:1B94
    LDA #$0F
    JSR SND_BANKED_DISPATCH
    LDA #$01
    LDY LEVEL/SCREEN_ON
    CPY #$03
    BNE 0A:1BB3
    LDY OBJ_ENABLED_STATE+MORE?[18],X
    CPY #$03
    BNE 0A:1BB3
    LDY 4C6_OBJ_UNK[18],X
    BNE 0A:1BB3
    TAY
    LDA 0A:1BC0,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    LSR A
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    ROL A
    TAY
    LDA 0A:1B04,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    .db 92
    .db 93
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$05
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_F: ; 0A:1BD2, 0x015BD2
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$14
    BCC 0A:1BE5
    JMP 0A:1A1B
    LDA #$00
    CPY #$06
    BCC 0A:1C00
    LDA 59E_OBJ_UNK[18],X
    ORA #$08
    STA 59E_OBJ_UNK[18],X
    LDA #$14
    STA 59E_OBJ_UNK+1,X
    LDA #$01
    CPY #$0C
    BCC 0A:1C00
    LDA #$02
    TAY
    LDA 0A:1C0E,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA 0A:1C11,Y
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
    ???
    CLC
    ORA 0A:0101,Y
    STA [FILE_PLAYER_OBJ_USE_B+1,X]
    ???
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$06
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_G: ; 0A:1C24, 0x015C24
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    LDY #$00
    LDA RANDOM_VALS?[2]
    AND #$08
    BEQ 0A:1C34
    LDY #$01
    LDA 0A:1C4F,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?[18],X
    CMP #$30
    BCC 0A:1C47
    JMP 0A:1A1B
    AND #$07
    BNE 0A:1C4E
    JMP SUB_UNK_CC_FAIL_CS_PASS
    RTS
    ORA TMP_16,X
    LDA #$00
    STA 59E_OBJ_UNK[18],X
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$09
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS
S01_MSD_RTN_H: ; 0A:1C61, 0x015C61
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    LDA #$00
    LDY LEVEL/SCREEN_ON
    CPY #$03
    BNE 0A:1C76
    LDY 4C6_OBJ_UNK[18],X
    BNE 0A:1C76
    LDA #$02
    STA TMP_07
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$19
    BCC 0A:1C85
    JMP 0A:1A1B
    LDA #$00
    CPY #$0F
    BCC 0A:1C8D
    LDA #$01
    ORA TMP_07
    TAY
    LDA 0A:1C9D,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA 0A:1CA1,Y
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
    .db 22
    .db 23
    .db 9D
    .db 9E
    .db 01
    .db 81
    .db 01
    .db 81
    .db A9
    .db 00
    .db A0
    .db 00
    .db F0
    .db 0A
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
    LDA OBJ_DIRECTION_RELATED?[18],X
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
    JSR MOVE_UNK_RET_??
    LDA OBJ_TERTIARY_SWITCH?+1,X
    BNE 0A:1D10
    BCS 0A:1D5B
    BCC 0A:1D1D
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:1D1D
    LDA 4C6_OBJ_UNK[18],X
    CMP 4D8_OBJ_UNK+1,X
    BCS 0A:1D5B
    JSR MOVE_Y_FINALIZE
    LDA OBJ_POS_X[18],X
    STA TMP_06
    JSR XPOS_RTN_RET_??
    BCC 0A:1D37
    LDA OBJ_POS_X_DELTA?[18],X
    ASL A
    LDA #$00
    BCS 0A:1D34
    LDA #$FF
    STA OBJ_POS_X[18],X
    LDY OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK+1,X
    JSR UNK_SUB_B
    BNE 0A:1D4B
    LDA TMP_06
    STA OBJ_POS_X[18],X
    LDA 532_OBJ_UNK_POS_DELTA?[18],X
    BMI 0A:1D5A
    LDA #$AE
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$24
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    JSR OBJ_PAIR_SWITCH_MOD
    JMP 0A:1A1B
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0C
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_J: ; 0A:1D71, 0x015D71
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$1C
    BCC 0A:1D81
    JMP 0A:1A1B
    LDA #$00
    CPY #$14
    BCC 0A:1DA8
    BNE 0A:1DA6
    JSR SUB_UNK_CC_FAIL_CS_PASS
    BCC 0A:1DA6
    TYA
    STA 4A2_OBJ_UNK_POS?+1,X
    LDA #$01
    STA 59E_OBJ_UNK[18],Y
    LDA #$0D
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$0E
    JSR SND_BANKED_DISPATCH
    LDA #$01
    LSR A
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    ROL A
    TAY
    LDA 0A:1B04,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
S01_MSD_RTN_K: ; 0A:1DB5, 0x015DB5
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY
    LDY 4A2_OBJ_UNK_POS?+1,X
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    BEQ 0A:1DEF
    LDA 59E_OBJ_UNK[18],Y
    BNE 0A:1DF5
    SEC
    LDA OBJ_POS_X[18],X
    SBC OBJ_POS_X[18],Y
    BPL 0A:1DD3
    EOR #$FF
    CLC
    ADC #$01
    CMP #$08
    BCS 0A:1DF5
    JSR OBJ_STATE_MOVE_TO_S02_T00
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY
    LDA 4A2_OBJ_UNK_POS?+1,X
    TAX
    JSR INIT_OBJECT[X]_DATA_FULL
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    LDA #$00
    STA 4A2_OBJ_UNK_POS?+1,X
    JMP 0A:1DF5
    JSR OBJ_STATE_MOVE_TO_S02_T00
    JSR SET_OBJ_ANIM_HOLD/CLEAR_ENTRY
    RTS
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$0E
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_L: ; 0A:1E06, 0x015E06
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    LDA #$00
    LDY LEVEL/SCREEN_ON
    CPY #$03
    BNE 0A:1E1B
    LDY 4C6_OBJ_UNK[18],X
    BNE 0A:1E1B
    LDA #$04
    STA TMP_07
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$32
    BCC 0A:1E2F
    JMP 0A:1A1B
    LDA #$00
    CPY #$06
    BCC 0A:1E61
    LDA #$01
    CPY #$0C
    BCC 0A:1E61
    BEQ 0A:1E43
    CPY #$10
    BCS 0A:1E4D
    BCC 0A:1E48
    LDA #$10
    JSR SND_BANKED_DISPATCH
    LDA #$AD
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR MOVE_Y_FINALIZE
    LDA RANDOM_VALS?[2]
    AND #$0F
    TAY
    CLC
    LDA 0A:1E6B,Y
    ADC OBJ_POS_Y[18],X
    STA OBJ_POS_Y[18],X
    LDA #$02
    ORA TMP_07
    TAY
    LDA 0A:1E7B,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
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
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    LDY #$00
    LDA RANDOM_VALS?[2]
    AND #$08
    BEQ 0A:1EA2
    LDY #$01
    LDA 0A:1EE7,Y
    STA OBJ_ANIMATION_DISPLAY[18],X
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?[18],X
    CMP #$2A
    BCC 0A:1EB5
    JMP 0A:1A1B
    CMP #$01
    BEQ 0A:1EC2
    CMP #$15
    BEQ 0A:1EC2
    CMP #$29
    BEQ 0A:1EC2
    RTS
    LDA #$00
    STA TMP_00
    LDY #$07
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    CMP #$1A
    BNE 0A:1ED1
    INC TMP_00
    INY
    CPY #$12
    BCC 0A:1EC8
    LDA TMP_00
    CMP #$04
    BCS 0A:1EE6
    JSR SUB_UNK_CC_FAIL_CS_PASS
    BCC 0A:1EE6
    LDA #$14
    STA OBJ_ANIM_HOLD_TIMER?[18],Y
    RTS
    EOR 0B:0951
    ???
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$12
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_N: ; 0A:1EF9, 0x015EF9
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$1C
    BCC 0A:1F09
    JMP 0A:1A1B
    LDA #$1A
    CPY #$14
    BCC 0A:1F13
    BEQ 0A:1F17
    LDA #$1B
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    STA OBJ_ANIMATION_DISPLAY[18],X
    JSR SUB_UNK_CC_FAIL_CS_PASS
    BCC 0A:1F28
    LDA #$08
    JSR SND_BANKED_DISPATCH
    TXA
    STA OBJ_POS_X_DELTA?[18],Y
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    RTS
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
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$32
    BCC 0A:1F51
    JMP 0A:1A1B
    LDA #$36
    CPY #$14
    BEQ 0A:1F64
    BCC 0A:1F60
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    JSR SUB_UNK_CC_FAIL_CS_PASS
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$0F
    JMP SND_BANKED_DISPATCH
OBJ_STATE_SET_S03_T17: ; 0A:1F71, 0x015F71
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$17
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No hold.
    RTS ; Leave.
S01_MSD_RTN_S: ; 0A:1F81, 0x015F81
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$32
    BCC 0A:1F96
    JMP 0A:1A1B
    LDA #$87
    CPY #$14
    BEQ 0A:1FA9
    BCC 0A:1FA5
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    JSR SUB_UNK_CC_FAIL_CS_PASS
    LDA #$37
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$0F
    JMP SND_BANKED_DISPATCH
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$14
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    RTS
S01_MSD_RTN_P: ; 0A:1FC6, 0x015FC6
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR FIND_PLAYER_TO_FOCUS_ON_TO_OBJ
    INC OBJ_ANIM_HOLD_TIMER?[18],X
    LDY OBJ_ANIM_HOLD_TIMER?[18],X
    CPY #$32
    BCC 0A:1FD9
    JMP 0A:1A1B
    LDA #$3E
    CPY #$0F
    BCC 0A:1FE3
    BEQ 0A:1FE7
    LDA #$AB
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
    STA OBJ_ANIMATION_DISPLAY[18],X
    JMP SUB_UNK_CC_FAIL_CS_PASS
S01_MSD_RTN_Q: ; 0A:1FED, 0x015FED
    LDA #$8E
    BNE 0A:1FF3
S01_MSD_RTN_R: ; 0A:1FF1, 0x015FF1
    LDA #$8F
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR SUB_OBJ_SPEED_AND_XPOS_STUFF
    JSR XPOS_RTN_RET_??
    BCC 0B:0008
    LDA 556_OBJ_UPDATE_FLAGS?[18],X

    .db 3C
UNK_STREAM_SETUP_0x300_BUF: ; 1C:0001, 0x038001
    ASL A ; Shift A, make index.
    TAY ; To Y.
    LDA DT_UNK_LOW,Y ; Load low.
    STA TMP_00
    LDA DTABLE_UNK_HIGH,Y ; Load high.
    STA TMP_01
    LDA #$FF
    ADC #$00 ; Carry test. Set means 0.
    STA TMP_02 ; Store.
    LDY #$00 ; Load Y
LOOP_STREAM_OUTER: ; 1C:0015, 0x038015
    LDA #$01 ; Load A
    JSR A_TO_300_LOAD_INDEX ; Do...
    LDA [TMP_00],Y ; Load.
    JSR A_to_300_INDEXED ; Do...
    INY ; Stream++
    LDA [TMP_00],Y ; Load from stream.
    JSR A_to_300_INDEXED ; To 300.
    INY ; Steam++
LOOP_STREAM_INNER: ; 1C:0026, 0x038026
    LDA [TMP_00],Y ; Load from stream.
    INY ; Stream++
    CMP #$FF ; If A _ 0xFF. EOF Marker.
    BEQ A=FF_TO_300_INDEXED ; ==, goto.
    CMP #$FE ; If A_ 0xFE.
    BEQ FLAG_FE ; ==, goto.
    AND TMP_02 ; All others, mask?
    JSR A_to_300_INDEXED ; Store.
    JMP LOOP_STREAM_INNER ; Goto.
FLAG_FE: ; 1C:0039, 0x038039
    JSR A=FF_TO_300_INDEXED
    JMP LOOP_STREAM_OUTER
A=FF_TO_300_INDEXED: ; 1C:003F, 0x03803F
    LDA #$FF ; A =
A_TO_300_LOAD_INDEX: ; 1C:0041, 0x038041
    LDX PPU_UPDATE_BUF_INDEX ; X from. NOTE: X is still index on ret.
A_to_300_INDEXED: ; 1C:0043, 0x038043
    STA PPU_UPDATE_BUFFER[20],X ; Store to.
    INX ; Next.
    STX PPU_UPDATE_BUF_INDEX ; Store back.
    RTS
DT_UNK_LOW: ; 1C:004A, 0x03804A
    LOW(1C:0094)
DTABLE_UNK_HIGH: ; 1C:004B, 0x03804B
    HIGH(1C:0094)
    LOW(1C:009F)
    HIGH(1C:009F)
    LOW(1C:0076)
    HIGH(1C:0076)
    LOW(1C:0084)
    HIGH(1C:0084)
    LOW(1C:012F)
    HIGH(1C:012F)
    .db D7
    .db 06
    .db AB
    .db 80
    .db B7
    .db 80
    .db E3
    .db 80
    .db EC
    .db 80
    .db F5
    .db 80
    .db FE
    .db 80
    .db 07
    .db 81
    .db 0E
    .db 81
    .db 14
    .db 81
    .db 76
    .db 80
    .db 76
    .db 80
    .db 76
    .db 80
    .db 76
    .db 80
    .db 23
    .db 81
    .db 29
    .db 81
    .db CA
    .db 80
    .db 8A
    .db 22
    .db 1A
    .db 16
    .db 0B
    .db 23
    .db 00
    .db 1D
    .db 0F
    .db 16
    .db 0F
    .db 0D
    .db 1E
    .db FF
    .db E9
    .db 21
    .db 61
    .db 00
    .db 4B
    .db 4F
    .db 4E
    .db 41
    .db 4D
    .db 49
    .db 00
    .db 31
    .db 39
    .db 38
    .db 39
    .db FF
    .db CC
    .db 22
    .db 02
    .db 00
    .db 1E
    .db 1F
    .db 1C
    .db 1E
    .db 16
    .db 0F
    .db FF
    .db 0C
    .db 23
    .db 03
    .db 00
    .db 1E
    .db 1F
    .db 1C
    .db 1E
    .db 16
    .db 0F
    .db 1D
    .db FF
    .db 6C
    .db 21
    .db 11
    .db 0B
    .db 17
    .db 0F
    .db 00
    .db 19
    .db 20
    .db 0F
    .db 1C
    .db FF
    .db 8B
    .db 21
    .db 0D
    .db 19
    .db 18
    .db 1E
    .db 13
    .db 18
    .db 1F
    .db 0F
    .db 00
    .db 00
    .db FE
    .db EB
    .db 21
    .db 0F
    .db 18
    .db 0E
    .db FF
    .db 88
    .db 21
    .db C6
    .db 00
    .db C0
    .db 00
    .db CC
    .db 00
    .db C4
    .db FE
    .db A8
    .db 21
    .db D6
    .db 00
    .db D0
    .db 00
    .db DC
    .db 00
    .db D4
    .db FE
    .db DA
    .db 23
    .db 04
    .db 0E
    .db FF
    .db 63
    .db 20
    .db 26
    .db 25
    .db 32
    .db 2F
    .db 00
    .db 01
    .db FF
    .db 63
    .db 20
    .db 26
    .db 25
    .db 32
    .db 2F
    .db 00
    .db 02
    .db FF
    .db 63
    .db 20
    .db 26
    .db 25
    .db 32
    .db 2F
    .db 00
    .db 03
    .db FF
    .db 63
    .db 20
    .db 26
    .db 25
    .db 32
    .db 2F
    .db 00
    .db 04
    .db FF
    .db 6B
    .db 20
    .db 2A
    .db 2D
    .db 30
    .db 29
    .db FF
    .db 74
    .db 20
    .db 27
    .db 2C
    .db 36
    .db FF
    .db 2A
    .db 21
    .db 1D
    .db 1E
    .db 0B
    .db 11
    .db 0F
    .db 00
    .db 1D
    .db 0F
    .db 16
    .db 0F
    .db 0D
    .db 1E
    .db FF
    .db 8E
    .db 22
    .db 19
    .db 10
    .db 10
    .db FF
    .db 8E
    .db 22
    .db 19
    .db 18
    .db 00
    .db FF
    .db 00
    .db 3F
    .db FE
    .db 00
    .db 00
    .db FF
TURTLES_GAMEPLAY_INIT: ; 1C:0135, 0x038135
    LDX #$00 ; Player data offset.
    LDY #$00 ; Player focus.
    JSR PLAYER_REINIT_RTN? ; Init.
    LDA 47_TWO_PLAYERS_FLAG ; 2P?
    BNE 2P_SET ; Set, do 2nd player.
    RTS ; Leave.
2P_SET: ; 1C:0141, 0x038141
    LDX #$02 ; P2 data offset.
    LDY #$01 ; Player focus.
SET_UP_TURTLE_2_FROM_P1_DATA: ; 1C:0145, 0x038145
    LDA #$00
    STA 85_PLAYER_UNK?[2],Y ; Clear
    LDA #$01
    STA OBJ_DIRECTION_RELATED?[18],X ; Set looking to right?
    LDA TURTLE_SELECT_POSITIONS+1 ; Load turtle selected.
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    JSR P2_ENTRY_IDK ; Do.. why diff entry?
    LDA OBJ_POS_X[18],X ; Load
    SEC
    SBC #$24 ; -= 0x24
    STA OBJ_POS_X[18],X ; Store to objs.
    STA OBJ_POS_X+1,X
    RTS
PLAYER_REINIT_RTN?: ; 1C:0164, 0x038164
    LDA #$00
    STA 85_PLAYER_UNK?[2],Y ; Clear unk, player val.
    STA OBJ_DIRECTION_RELATED?[18],X ; Clear object var.
    LDA TURTLE_SELECT_POSITIONS[2] ; Load turtle select position for P1.
PROPER_LABEL: ; 1C:016E, 0x03816E
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
P2_ENTRY_IDK: ; 1C:0171, 0x038171
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$02 ; If _ #$02
    BNE KEEP_PRIMARY_SET ; !=, goto.
    TYA ; Index pos += 0x10
    CLC
    ADC #$10
    TAY ; Back to index.
KEEP_PRIMARY_SET: ; 1C:017C, 0x03817C
    LDA DATA_UNK_A,Y
    STA OBJ_POS_X[18],X
    LDA DATA_UNK_B,Y
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA #$00
    STA OBJ_SECONDARY_SWITCH?[18],X ; Clear state.
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    LDA DATA_UNK_C,Y ; Load val.
    JSR OBJECT_TO_STATE_A_COMPLEX? ; Do
    LDY #$00 ; Clear
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$03 ; If A _ #$03
    BNE 42_NOT_THREE ; !=, goto.
    LDY #$F0 ; Y= 
42_NOT_THREE: ; 1C:01A0, 0x0381A0
    TYA ; Y to A, #$00 or #$F0.
    STA 4C6_OBJ_UNK_POS?[18],X ; To object.
    JSR UPDATE_?? ; Update..
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$07 ; If _ #$07
    BNE RTS ; !=, goto.
    LDA 490_OBJ_UNK_SPEED?[18],X ; Copy P1 to P2 on respawn?
    STA 490_OBJ_UNK_SPEED?+1,X
    LDA OBJ_POS_X[18],X
    STA OBJ_POS_X+1,X
    LDA 4B4_OBJ_SPEED?[18],X
    STA 4B4_OBJ_SPEED?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?+1,X
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA 4C6_OBJ_UNK_POS?+1,X
    LDA OBJ_DIRECTION_RELATED?[18],X
    STA OBJ_DIRECTION_RELATED?+1,X
    INX ; Object++
    LDA #$0D ; Why val?
    JSR OBJECT_TO_STATE_A_COMPLEX?
    DEX
RTS: ; 1C:01D8, 0x0381D8
    RTS
DATA_UNK_A: ; 1C:01D9, 0x0381D9
    .db 80 ; If != 2 updates queued, this set.
DATA_UNK_B: ; 1C:01DA, 0x0381DA
    .db B0
DATA_UNK_C: ; 1C:01DB, 0x0381DB
    .db 80 ; Primary set.
    .db 23
    .db 80
    .db B0
    .db 80
    .db 23
    .db 80
    .db B0
    .db 80
    .db 23
    .db 80
    .db B0
    .db 80
    .db 23
    .db 80 ; Otherwise, this set.
    .db CE
    .db 80
    .db 23
    .db 80
    .db CE
    .db 80
    .db 23
    .db 80
    .db CE
    .db 80
    .db 23
    .db 80
    .db CE
    .db 80
    .db 23
PLAYER_LIFE_STEAL+?: ; 1C:01F9, 0x0381F9
    LDA 60C_UNK_INDEX ; Load
    CMP #$03 ; If _ #$03
    BCC INIT_PLAYER_THINGS? ; <, goto.
    LDA NUM_PLAYER_LIVES[2] ; Load P1 lives.
    BMI SKIP_P1_THINGS ; Negative (Under zero) skip around.
    LDA OBJ_SECONDARY_SWITCH?[18] ; Load state.
    AND #$0D ; Isolate 0000.1101
    BNE INIT_PLAYER_THINGS? ; Taken if any set.
SKIP_P1_THINGS: ; 1C:020B, 0x03820B
    LDA 47_TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ SKIP_P2_THINGS ; Not set, goto. One player game.
    LDA NUM_PLAYER_LIVES+1 ; Load P2 lives.
    BMI SKIP_P2_THINGS ; P2 out of lives.
    LDA OBJ_SECONDARY_SWITCH?+2 ; Load state.
    AND #$0D ; Isolate as before.
    BNE INIT_PLAYER_THINGS? ; Always taken if any set.
SKIP_P2_THINGS: ; 1C:021A, 0x03821A
    LDA 3C_SWITCH_CORE ; Load switch.
    CMP #$04 ; If _ #$04
    BEQ RTS ; ==, goto.
    JMP SUB_AND_611_SWITCH ; Goto.
INIT_PLAYER_THINGS?: ; 1C:0223, 0x038223
    LDY #$00 ; Clear both.
    LDX #$00
    LDA NUM_PLAYER_LIVES[2] ; Load P1 lives.
    BPL P1_HAS_LIVES ; Not negative, goto.
    LDA CTRL_NEWLY_PRESSED_A[2] ; Load pressed.
    AND #$80 ; Test A.
    BEQ A_NOT_PRESSED ; Not pressed, goto.
    LDA NUM_PLAYER_LIVES+1 ; Load P2 lives count.
    BEQ A_NOT_PRESSED ; If 0 or negative, don't let steal lives.
    BMI A_NOT_PRESSED
    DEC NUM_PLAYER_LIVES+1 ; Take life from P2.
    LDA #$00
    STA NUM_PLAYER_LIVES[2] ; Set to 0.
    STA CTRL_NEWLY_PRESSED_A[2] ; Clear newly presed for P1.
    STA CTRL_PREV_A[2] ; And previous.
    LDA #$50
    STA 93_PLAYER_UNK[2] ; Set?
    LDA #$3C
    STA OBJECT_DATA_EXTRA_A?[18],X ; Set?
    JSR PLAYER_REINIT_RTN? ; Do..?
    LDA #$01
    JSR BANKED_PLAYER_UI_INIT_FROM_A ; P2 num lives?
    TXA ; Save X.
    PHA
    LDX #$02
    JSR UPDATE_PLAYER_LIVES ; Update P2 lives, also, as one stolen.
    PLA ; Restore X.
    TAX
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    ORA #$10 ; Set. Invincible?
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    LDY #$00 ; Val?
P1_HAS_LIVES: ; 1C:0265, 0x038265
    JSR RTN_PLAYER_ANIMS_UNK? ; Do rtn.
A_NOT_PRESSED: ; 1C:0268, 0x038268
    LDA 47_TWO_PLAYERS_FLAG ; Test if 2P.
    BEQ RTS ; No, leave.
    LDY #$01 ; Player focus.
    LDX #$02 ; P2 data?
    LDA NUM_PLAYER_LIVES+1 ; Load P2 lives.
    BPL RTN_PLAYER_ANIMS_UNK? ; If positive, goto.
    LDA CTRL_NEWLY_PRESSED_A+1 ; Load P2 buttons.
    AND #$80 ; Test A.
    BNE P2_A_BUTTON_PRESSED ; Pressed, goto.
RTS: ; 1C:027A, 0x03827A
    RTS
P2_A_BUTTON_PRESSED: ; 1C:027B, 0x03827B
    LDA NUM_PLAYER_LIVES[2] ; Load P1 lives.
    BEQ RTS ; No lives, leave.
    BMI RTS ; Negative, no lives.
    DEC NUM_PLAYER_LIVES[2] ; Take 1 life.
    LDA #$00
    STA NUM_PLAYER_LIVES+1 ; Set P2 lives to 0.
    STA CTRL_NEWLY_PRESSED_A+1 ; Clear buttons.
    STA CTRL_PREV_A+1
    LDA #$50 ; Val?
    STA 93_PLAYER_UNK+1 ; Set.
    LDA #$3C ; Val?
    STA OBJECT_DATA_EXTRA_A?[18],X ; Set.
    JSR SET_UP_TURTLE_2_FROM_P1_DATA ; Set up P2 from P1 lifesteal.
    LDA #$01
    JSR BANKED_PLAYER_UI_INIT_FROM_A ; Set up P2 info.
    TXA ; Save X.
    PHA
    LDX #$00 ; Do P1.
    JSR UPDATE_PLAYER_LIVES ; Show new lives after stolen.
    PLA ; Restore X.
    TAX
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load obj.
    ORA #$10 ; Set 0001.0000
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store to obj.
    LDY #$01 ; Focus val.
RTN_PLAYER_ANIMS_UNK?: ; 1C:02AF, 0x0382AF
    STY TMP_08 ; Player focus store.
    JSR RTN_BUTTONS_TURTLE_STATES? ; Do sub on.
    LDY TMP_08 ; Get focus.
    LDA 93_PLAYER_UNK[2],Y ; Load
    BEQ ANIMATE_UPDATE_P1_O1? ; Not set, goto.
    SEC
    SBC #$01 ; Val -= 1
    STA 93_PLAYER_UNK[2],Y ; Store back.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$10 ; Test 0001.0000
    BEQ ANIMATE_UPDATE_P1_O1? ; Not set, goto.
    LDA 93_PLAYER_UNK[2],Y ; Load val
    BNE 93_STILL_VALUE ; Nonzero, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$EF ; Keep only 1110.1111
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    JMP MOVE_NEW_ANIM_FRAME
93_STILL_VALUE: ; 1C:02D8, 0x0382D8
    LDA 93_PLAYER_UNK[2],Y ; Load
    AND #$01 ; Test bit 0000.0001
    BEQ MOVE_NEW_ANIM_FRAME ; If not set, goto.
    LDA OBJ_ANIMATION_FRAME_TO[18],X ; Load from obj.
    STA PLAYER_ANIM_FRAME_SWAP?[2],Y ; Store to player.
    LDA #$00
    STA OBJ_ANIMATION_FRAME_TO[18],X ; Set to not update?
    BEQ ANIMATE_UPDATE_P1_O2? ; Always taken.
MOVE_NEW_ANIM_FRAME: ; 1C:02EC, 0x0382EC
    LDA PLAYER_ANIM_FRAME_SWAP?[2],Y ; Load val.
    STA OBJ_ANIMATION_FRAME_TO[18],X ; Switch anim to.
ANIMATE_UPDATE_P1_O1?: ; 1C:02F2, 0x0382F2
    JSR ANIMATE_UPDATE_OBJ_X? ; Swap animation?
ANIMATE_UPDATE_P1_O2?: ; 1C:02F5, 0x0382F5
    INX ; Obj++
    JSR ANIMATE_UPDATE_OBJ_X? ; Update too.
    JSR OBJECT_X_DO_UNK ; Do..
    DEX ; Obj--
    JSR OBJECT_X_DO_UNK ; Do..
    LDY TMP_08 ; Get player focus.
    LDA 93_PLAYER_UNK[2],Y ; Load.
    BNE RTS ; Set, goto.
    JSR RTN_BANKED_UNK ; Do..
    LDA 654_UPDATE_UNK_FLAG ; Load val.
    BEQ RTS ; If 0, leave.
    LDA #$00
    STA 654_UPDATE_UNK_FLAG ; Clear flag.
    JSR UPDATE_?? ; Update idk.
RTS: ; 1C:0317, 0x038317
    RTS
RTN_BUTTONS_TURTLE_STATES?: ; 1C:0318, 0x038318
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$04 ; Test 0000.0100
    BEQ BIT_#$04_NOT_SET
    JMP RTN_STATE_BIT_#$04_SET
BIT_#$04_NOT_SET: ; 1C:0322, 0x038322
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$01 ; Test bottom bit.
    BEQ BIT_#$01_NOT_SET
    JMP RTN_STATE_BIT_#$01_SET
BIT_#$01_NOT_SET: ; 1C:032C, 0x03832C
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$02
    BNE RTN_+STATE_BIT_#$02_SET
    LDA CTRL_PREV_A[2],Y
    AND #$0F ; Test UDLR.
    BNE CTRL_BUTTONS_ACTION ; Any direction pressed, goto.
    LDA CTRL_NEWLY_PRESSED_A[2],Y ; Load newly pressed.
    AND #$C0 ; Test A/B
    BNE CTRL_BUTTONS_ACTION ; Either set, goto.
    JSR SUB_INIT_OBJ_ATTR_UNK ; Init
    LDA #$80
    JMP OBJECT_TO_STATE_A_COMPLEX? ; Goto state?
SUB_INIT_OBJ_ATTR_UNK: ; 1C:0349, 0x038349
    LDA #$00 ; Init many.
    STA 43_PLAYER_UNK[2],Y
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK+1,X
    STA 520_ARR_UNK+1,X
    STA 50E_ARR_UNK+1,X
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
RTN_+STATE_BIT_#$02_SET: ; 1C:036A, 0x03836A
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    BPL 1C:037C
    LDA OBJ_SECONDARY_SWITCH?[18],X
    EOR #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
CTRL_BUTTONS_ACTION: ; 1C:037D, 0x03837D
    LDA CTRL_NEWLY_PRESSED_A[2],Y
    AND #$40
    BEQ 1C:03CE
    LDA CTRL_PREV_A[2],Y
    AND #$03
    BEQ 1C:039F
    AND #$02
    BNE 1C:0397
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    JMP $839C
    LDA OBJ_DIRECTION_RELATED?[18],X
    ORA #$40
    STA OBJ_DIRECTION_RELATED?[18],X
    JSR $8349
    LDA TURTLE_SELECT_POSITIONS[2],Y
    TAY
    LDA $83C7,Y
    JSR SND_BANKED_DISPATCH
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ORA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$03
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDY #$88
    LDA IRQ/SCRIPT_RUN_COUNT?
    AND #$04
    BNE 1C:03C3
    LDY #$9C
    TYA
    JMP $9627
DATA_SOUND_RESPAWN?: ; 1C:03C7, 0x0383C7
    .db 03
    .db 05
    .db 04
    .db 06
RTN_STATE_BIT_#$01_SET: ; 1C:03CB, 0x0383CB
    .db 4C ; Goto.
    LSR 84_UNK
    LDA CTRL_NEWLY_PRESSED_A[2],Y
    AND #$80
    BNE 1C:03D8
    JMP $8811
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA A0_PLAYER_UNK[2],Y
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ORA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA 490_OBJ_UNK_SPEED?[18],X
    STA 490_OBJ_UNK_SPEED?+1,X
    LDA OBJ_POS_X[18],X
    STA OBJ_POS_X+1,X
    LDA 4B4_OBJ_SPEED?[18],X
    STA 4B4_OBJ_SPEED?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?+1,X
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA 4C6_OBJ_UNK_POS?+1,X
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1C:0410
    LDA OBJ_DIRECTION_RELATED?[18],X
    STA OBJ_DIRECTION_RELATED?+1,X
    LDA #$01
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    STA 544_OBJ_UNK_POS?[18],X
    LDA #$F9
    STA 532_OBJ_UNK_POS?[18],X
    LDA #$40
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1C:0441
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$20
    BEQ 1C:043A
    LDA #$1E
    JSR SND_BANKED_DISPATCH
    LDA #$0E
    BNE 1C:043C
    LDA #$09
    INX
    JSR $9627
    DEX
    LDA #$90
    JMP $9627
RTN_UNK: ; 1C:0446, 0x038446
    LDA #$00
    STA 43_PLAYER_UNK[2],Y ; Clear.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$08 ; Test 0000.1000
    BEQ STATE_0x08_NOT_SET ; Not set, goto.
    LDA #$00
    STA TMP_02 ; Clear
    JMP RTN_STATE_BIT_0x08 ; Goto.
STATE_0x08_NOT_SET: ; 1C:0459, 0x038459
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load obj.
    AND #$02 ; Test 0000.0010
    BEQ STATE_0x02_NOT_SET
    JMP RTN_STATE_BIT_0x02 ; Goto.
STATE_0x02_NOT_SET: ; 1C:0463, 0x038463
    LDA CTRL_NEWLY_PRESSED_A[2],Y ; Load newly pressed.
    AND #$40 ; Test B button.
    BNE B_BUTTON_PRESSED ; If set, goto.
JMP_TO_B_UNPRESSED?: ; 1C:046A, 0x03846A
    JMP RTN_B_UNPRESSED? ; If not, goto.
B_BUTTON_PRESSED: ; 1C:046D, 0x03846D
    LDA CTRL_PREV_A[2],Y ; Load prev.
    AND #$03 ; Test L/R
    BEQ L/R_UNPRESSED
    AND #$02 ; Test L.
    BNE L_PRESSED ; Set, goto.
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load val.
    AND #$BF ; Keep 1011.1111
    JMP STORE_A_TO_OBJ_UNK ; Goto.
L_PRESSED: ; 1C:0480, 0x038480
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load val.
    ORA #$40 ; Set 0100.0000
STORE_A_TO_OBJ_UNK: ; 1C:0485, 0x038485
    STA OBJ_DIRECTION_RELATED?[18],X ; Store L/R value decided.
L/R_UNPRESSED: ; 1C:0488, 0x038488
    LDA 532_OBJ_UNK_POS?[18],X ; Load val.
    BPL VAL_LOADED_POSITIVE ; If positive, goto.
    CMP #$FC ; If _ #$FC
    BCS VAL_LOADED_POSITIVE ; >=, goto.
    CMP #$FA ; If _ #$FA
    BCS JMP_TO_B_UNPRESSED? ; >=, goto.
    LDA TURTLE_SELECT_POSITIONS[2],Y ; Load focused selected.
    TAY ; To Y index.
    LDA DATA_SOUND_RESPAWN?,Y ; Load sound.
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load state.
    ORA #$0A ; Set 0000.1010
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    LDY #$06 ; Val to add?
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load
    AND #$40 ; Test 0100.0000
    BEQ BIT_0x40_NOT_SET
    LDY #$FA ; Negative of val.
BIT_0x40_NOT_SET: ; 1C:04B2, 0x0384B2
    INX ; Next object.
    TYA ; Y decided to A.
    CLC
    ADC OBJ_POS_X[18],X ; Add with val.
    STA OBJ_POS_X[18],X ; Store to.
    DEX ; Object--
    LDA #$04
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set.
    LDA #$C0
    STA 544_OBJ_UNK_POS?[18],X ; Set.
    LDA #$FC
    STA 532_OBJ_UNK_POS?[18],X ; Set.
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$07 ; If _ #$07
    BEQ PPU_VAL_SEVEN ; ==, goto.
    INX ; Obj++
    LDA #$09 ; State.
    JSR OBJECT_TO_STATE_A_COMPLEX?
    DEX
PPU_VAL_SEVEN: ; 1C:04D8, 0x0384D8
    LDA #$8C ; State.
    JMP OBJECT_TO_STATE_A_COMPLEX? ; Abuse RTS.
VAL_LOADED_POSITIVE: ; 1C:04DD, 0x0384DD
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    ORA #$02 ; Set 0000.0010
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    LDA #$02
    STA OBJECT_DATA_EXTRA_B?[18],X ; Store to.
    LDY #$00 ; Index set A.
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load
    AND #$40 ; Keep 0100.0000
    BEQ BIT_0x40_NOT_SET
    LDY #$04 ; Index set B.
BIT_0x40_NOT_SET: ; 1C:04F5, 0x0384F5
    LDA DATA_UNK_A,Y ; Move data to obj.
    STA 4FC_ARR_UNK[18],X
    LDA DATA_UNK_B,Y
    STA 4EA_ARR_UNK[18],X
    LDA DATA_UNK_C,Y
    STA 4FC_ARR_UNK+1,X
    LDA DATA_UNK_D,Y
    STA 4EA_ARR_UNK+1,X
    LDA #$00 ; Clear.
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 520_ARR_UNK+1,X ; Clear in other obj..? Seems to be other player related obj, but !sure yet.
    STA 50E_ARR_UNK+1,X
    LDA #$05
    JSR OBJECT_TO_STATE_A_COMPLEX? ; To state.
RTN_STATE_BIT_0x02: ; 1C:0526, 0x038526
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load val.
    AND #$40 ; Test bit.
    BNE BIT_0x40_SET ; If set, goto.
    LDA 601_IRQ_FLAG_DELAY_MOD_+ ; Load
    BMI 601_TOP_SET ; If top bit set, goto.
    LDA 661_UNK_LEVEL_A_SETS ; Load
    BEQ 661_ZERO ; If == 0, goto.
601_TOP_SET: ; 1C:0537, 0x038537
    LDA #$87 ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCS RET_CARRY_SET ; RETURN OPT A
    BCC RET_CC_A ; RETURN OPT B
661_ZERO: ; 1C:0540, 0x038540
    LDA #$87 ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RET_CC_A ; If CC, goto.
    LDA #$07 ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RET_CC_A ; If CC, goto.
    LDA #$0A ; Val?
    JSR RTN_UNK ; Do..?
    BCS RET_CARRY_SET
RET_CC_A: ; 1C:0555, 0x038555
    LDA OBJ_POS_X[18],X ; Load
    CMP #$E4 ; If _ #$E4
    BCS RET_CARRY_SET ; >=, goto.
    JMP OBJ_NEXT_UNK ; <, goto.
BIT_0x40_SET: ; 1C:055F, 0x03855F
    LDA #$88 ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RET_CC_B ; If CC, goto.
    LDA #$08 ; Try..?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RET_CC_B ; CC, goto.
    LDA #$0B ; Val?
    JSR RTN_UNK
    BCS RET_CARRY_SET ; Carry set, goto.
RET_CC_B: ; 1C:0574, 0x038574
    LDA OBJ_POS_X[18],X ; Load
    CMP #$18 ; If _ #$18
    BCC RET_CARRY_SET ; <, goto.
    JMP OBJ_NEXT_UNK ; Goto.
RET_CARRY_SET: ; 1C:057E, 0x03857E
    LDA #$00
    STA TMP_02 ; Clear.
    JMP RTN_STATE_BIT_0x08
RTN_B_UNPRESSED?: ; 1C:0585, 0x038585
    LDY TMP_08 ; Get player focus.
    LDA CTRL_PREV_A[2],Y
    STA TMP_02
    AND #$01
    BEQ 1C:05DD
    LDA 601_IRQ_FLAG_DELAY_MOD_+
    BMI 1C:059A
    LDA 661_UNK_LEVEL_A_SETS
    BEQ 1C:05A3
    LDA #$87
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:05B8
    BCS 1C:05D4
    LDA #$87
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:05B8
    LDA #$07
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:05B8
    LDA #$0A
    JSR RTN_UNK
    BCS 1C:05D4
    LDA OBJ_POS_X[18],X
    CMP #$90
    BCC 1C:0605
    LDA 601_IRQ_FLAG_DELAY_MOD_+
    BMI 1C:05CD
    LDA 8B_UNK
    BNE 1C:05CD
    LDA #$01
    STA 43_PLAYER_UNK[2],Y
    LDA OBJ_POS_X[18],X
    CMP #$E4
    BCC 1C:0605
    LDA TMP_02
    AND #$FE
    STA TMP_02
    JMP 1C:0605
    LDA TMP_02
    AND #$02
    BEQ 1C:0605
    LDA #$88
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:05F8
    LDA #$08
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:05F8
    LDA #$0B
    JSR RTN_UNK
    BCS 1C:05FF
    LDA OBJ_POS_X[18],X
    CMP #$18
    BCS 1C:0605
    LDA TMP_02
    AND #$FD
    STA TMP_02
    LDA TMP_02
    AND #$08
    BEQ 1C:064E
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BNE 1C:0618
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$97
    BCC 1C:0645
    LDA 601_IRQ_FLAG_DELAY_MOD_+
    BPL 1C:0624
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$9A
    BCC 1C:0645
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$58
    BCC 1C:0645
    LDY TMP_08
    LDA 60_PLAYER_UNK[1],Y
    BNE 1C:063E
    LDA A0_PLAYER_UNK[2],Y
    BNE 1C:063E
    LDA #$0C
    JSR RTN_UNK
    BCC RTN_STATE_BIT_0x08
    LDA #$89
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC RTN_STATE_BIT_0x08
    LDA TMP_02
    AND #$F7
    STA TMP_02
    JMP $868C
    LDA TMP_02
    AND #$04
    BEQ RTN_STATE_BIT_0x08
    LDA 661_UNK_LEVEL_A_SETS
    BEQ 1C:0660
    LDA #$85
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCS 1C:0686
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$C8
    BCC RTN_STATE_BIT_0x08
    LDA 601_IRQ_FLAG_DELAY_MOD_+
    BPL 1C:067F
    LDA 8B_UNK
    BNE 1C:067F
    LDY TMP_08
    LDA #$01
    STA 43_PLAYER_UNK[2],Y
    LDA TMP_02
    AND #$F0
    ORA #$07
    STA TMP_02
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$E0
    BCC RTN_STATE_BIT_0x08
    LDA TMP_02
    AND #$FB
    STA TMP_02
RTN_STATE_BIT_0x08: ; 1C:068C, 0x03868C
    LDA TMP_02 ; Load
    AND #$0F ; Isolate 0000.1111
    ASL A ; << 2, *4.
    ASL A
    TAY ; To index.
    LDA DATA_UNK_A,Y ; Load
    STA 4FC_ARR_UNK[18],X ; Store to obj/obj+1
    STA 4FC_ARR_UNK+1,X
    LDA DATA_UNK_B,Y ; Load
    STA 4EA_ARR_UNK[18],X ; Same
    STA 4EA_ARR_UNK+1,X
    LDA DATA_UNK_C,Y ; Load
    STA 520_ARR_UNK[18],X ; Same
    STA 520_ARR_UNK+1,X
    LDA DATA_UNK_D,Y ; Load
    STA 50E_ARR_UNK[18],X ; Same
    STA 50E_ARR_UNK+1,X
    LDA 4FC_ARR_UNK[18],X ; Load
    ORA 4EA_ARR_UNK[18],X ; Combine with.
    BEQ OBJ_NEXT_UNK ; No bits set, goto.
    LDY TMP_08 ; Get player focus.
    LDA 43_PLAYER_UNK[2],Y ; Load val
    BEQ OBJ_NEXT_UNK ; If not set, goto.
    LDA #$F0 ; Load
    STA 4FC_ARR_UNK[18],X ; Set obj.
    STA 4FC_ARR_UNK+1,X
    LDA #$00 ; Clear
    STA 4EA_ARR_UNK[18],X ; Clear obj.
    STA 4EA_ARR_UNK+1,X
OBJ_NEXT_UNK: ; 1C:06D6, 0x0386D6
    INX ; Obj++?
    LDA #$03 ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RET_CC_UNK ; CC returned, goto.
    LDY LEVEL_SCREEN_ON ; Y from.
    LDA DATA_UNK,Y ; Data from.
    BNE COMMIT_A_TO_OBJ ; If != 0, goto.
RET_CC_UNK: ; 1C:06E5, 0x0386E5
    LDA #$00 ; Clear
COMMIT_A_TO_OBJ: ; 1C:06E7, 0x0386E7
    STA 4C6_OBJ_UNK_POS?[18],X
    DEX ; Obj--?
    LDA 544_OBJ_UNK_POS?[18],X ; Load from.
    CLC
    ADC 5D4_ARR_OBJ_TIMER?[18],X ; Add with.
    STA 544_OBJ_UNK_POS?[18],X ; Store to.
    LDA 532_OBJ_UNK_POS?[18],X ; Load
    ADC #$00
    STA 532_OBJ_UNK_POS?[18],X ; Store 
    BPL VAL_CARRY_POSITIVE ; If positive after carry, goto.
    LDA OBJ_POS_Y[18],X ; Load
    CMP #$2C ; If _ #$2C
    BCS VAR_ABOVE_2C ; >=, goto.
    LDY TMP_08 ; Get player focus.
    LDA #$01
    STA 60_PLAYER_UNK[1],Y ; Set true.
VAR_ABOVE_2C: ; 1C:070D, 0x03870D
    LDA 532_OBJ_UNK_POS?[18],X ; Load value.
    CMP #$FC ; If _ #$FC
    BCS 1C:0715 ; >=, goto.
    RTS ; <, RTS as-is. NOTE: Carry clear might be important.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load object state.
    AND #$DF ; Keep 1101.1111
    STA OBJ_SECONDARY_SWITCH?[18],X ; Store back.
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$07 ; If _ #$07
    BEQ EQ_RTN ; ==, goto.
    INX ; Obj++
    LDA #$09 ; Set obj state.
    JSR OBJECT_TO_STATE_A_COMPLEX?
    DEX ; Obj--
EQ_RTN: ; 1C:072A, 0x03872A
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load state.
    AND #$08 ; Test 0000.1000
    BEQ GOTO_STATE_4 ; Not set, goto.
RTS: ; 1C:0731, 0x038731
    RTS ; Leave, set.
GOTO_STATE_4: ; 1C:0732, 0x038732
    LDA #$04
    JMP OBJECT_TO_STATE_A_COMPLEX? ; Set state, abuse RTS.
VAL_CARRY_POSITIVE: ; 1C:0737, 0x038737
    LDY TMP_08 ; Get player focus.
    LDA 60_PLAYER_UNK[1],Y ; Load val.
    BEQ P_VAL_60_ZERO ; Not set, goto.
    LDA OBJ_POS_Y[18],X ; Load val.
    BMI RTS ; If negative, leave.
    CMP #$2C ; If _ #$2C
    BCC RTS ; <, goto. Leave.
    LDA #$00 ; Clear.
    STA 60_PLAYER_UNK[1],Y
P_VAL_60_ZERO: ; 1C:074C, 0x03874C
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load object val.
    CMP #$CF ; If _ #$CF
    BCS RTN_RETURNED_CC ; >=, goto.
    LDA #$03 ; Goto state.
    JSR RTN_UNK_RTS_CARRY_SET_FAIL? ; Do..?
    BCC RTN_RETURNED_CC ; If CC, goto.
    LDY LEVEL_SCREEN_ON
    LDA DATA_UNK,Y ; Load data.
    CMP 4C6_OBJ_UNK_POS?[18],X ; If _ Obj val.
    BCS RTN_RETURNED_CC ; >=, goto.
    STA 4C6_OBJ_UNK_POS?[18],X ; Replace object with loaded.
    JMP 1C:077B ; Goto.
RTN_RETURNED_CC: ; 1C:076A, 0x03876A
    LDA 4C6_OBJ_UNK_POS?[18],X ; Load
    BMI OBJ_VAL_NEGATIVE ; If neg, goto.
    CMP #$20 ; If _ #$20
    BCS OBJ_VAL_NEGATIVE ; >=, goto.
    LDA #$00
    STA 4D8_OBJ_UNK[18],X ; Clear object vals.
    STA 4C6_OBJ_UNK_POS?[18],X
    LDA #$0D ; Val?
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCS 1C:0792
    INC 4A2_OBJ_UNK_POS?[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    CLC
    ADC 4C6_OBJ_UNK_POS?[18],X
    STA OBJ_POS_Y[18],X
    JMP $877B
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BNE 1C:07A0
    LDA #$80
    JSR OBJECT_TO_STATE_A_COMPLEX?
    JMP 1C:07A7
    INX
    LDA #$00
    JSR OBJECT_TO_STATE_A_COMPLEX?
    DEX
    LDA #$00
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK+1,X
    STA 520_ARR_UNK+1,X
    STA 50E_ARR_UNK+1,X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA OBJ_SECONDARY_SWITCH?[18],X
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$06
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC OBJ_VAL_NEGATIVE
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ORA #$20
    STA OBJ_SECONDARY_SWITCH?[18],X
OBJ_VAL_NEGATIVE: ; 1C:07D0, 0x0387D0
    RTS
DATA_UNK: ; 1C:07D1, 0x0387D1
    .db 00
    .db 00
    .db AC
    .db F0
    .db 00
    .db 00
    .db 00
    .db 00
    .db E0
    .db 00
    .db 00
    .db 00
DATA_UNK_A: ; 1C:07DD, 0x0387DD
    .db 00
DATA_UNK_B: ; 1C:07DE, 0x0387DE
    .db 00
DATA_UNK_C: ; 1C:07DF, 0x0387DF
    .db 00
DATA_UNK_D: ; 1C:07E0, 0x0387E0
    .db 00
    .db 30
    .db 01
    .db 00
    .db 00
    .db D0
    .db FE
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db C2
    .db 00
    .db F4
    .db 00
    .db F4
    .db 00
    .db 0C
    .db FF
    .db 86
    .db 00
    .db C0
    .db 00
    .db C0
    .db 00
    .db 00
    .db 00
    .db 3E
    .db FF
    .db B4
    .db 00
    .db 0C
    .db FF
    .db 4C
    .db FF
    .db 7A
    .db FF
DATA_UNK_A: ; 1C:0809, 0x038809
    .db 00
DATA_UNK_B: ; 1C:080A, 0x03880A
    .db 03
DATA_UNK_C: ; 1C:080B, 0x03880B
    .db E8
DATA_UNK_D: ; 1C:080C, 0x03880C
    .db 02
    .db 00
    .db FD
    .db 18
    .db FD
    .db B9
    .db 3A
    .db 00
    .db 29
    .db 03
    .db F0
    .db 17
    .db 29
    .db 01
    .db F0
    .db 0B
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db 4C
    .db 2F
    .db 88
    .db BD
    .db 36
    .db 04
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db A5
    .db 42
    .db C9
    .db 07
    .db D0
    .db 04
    .db A9
    .db 80
    .db D0
    .db 09
    .db BD
    .db 12
    .db 04
    .db 29
    .db 02
    .db D0
    .db 05
    .db A9
    .db 84
    .db 20
    .db 27
    .db 96
    .db A4
    .db 08
    .db A9
    .db 00
    .db 9D
    .db 20
    .db 05
    .db 9D
    .db 0E
    .db 05
    .db 9D
    .db FC
    .db 04
    .db 9D
    .db EA
    .db 04
    .db 85
    .db 02
    .db B9
    .db 3A
    .db 00
    .db D0
    .db 03
    .db 4C
    .db 2A
    .db 89
    .db 29
    .db 01
    .db F0
    .db 32
    .db BD
    .db C6
    .db 04
    .db F0
    .db 06
    .db A5
    .db 42
    .db C9
    .db 08
    .db F0
    .db 07
    .db A9
    .db 00
    .db 20
    .db 30
    .db E6
    .db B0
    .db 15
    .db AD
    .db 01
    .db 06
    .db 30
    .db 09
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 90
    .db 90
    .db 02
    .db E6
    .db 02
    .db BD
    .db 7E
    .db 04
    .db C9
    .db E4
    .db 90
    .db 2D
    .db B9
    .db 3A
    .db 00
    .db 29
    .db FE
    .db 99
    .db 3A
    .db 00
    .db 4C
    .db B7
    .db 88
    .db B9
    .db 3A
    .db 00
    .db 29
    .db 02
    .db F0
    .db 1B
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 18
    .db 90
    .db 0C
    .db BD
    .db C6
    .db 04
    .db D0
    .db 0F
    .db A9
    .db 01
    .db 20
    .db 30
    .db E6
    .db 90
    .db 08
    .db B9
    .db 3A
    .db 00
    .db 29
    .db FD
    .db 99
    .db 3A
    .db 00
    .db B9
    .db 3A
    .db 00
    .db 29
    .db 04
    .db F0
    .db 42
    .db BD
    .db C6
    .db 04
    .db D0
    .db 07
    .db A9
    .db 05
    .db 20
    .db 30
    .db E6
    .db B0
    .db 2B
    .db AD
    .db 01
    .db 06
    .db 10
    .db 1F
    .db BD
    .db 6C
    .db 04
    .db C9
    .db C8
    .db 90
    .db 54
    .db A5
    .db 8B
    .db D0
    .db 14
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db B9
    .db 3A
    .db 00
    .db 29
    .db F0
    .db 09
    .db 07
    .db 99
    .db 3A
    .db 00
    .db E6
    .db 02
    .db BD
    .db 6C
    .db 04
    .db C9
    .db E0
    .db 90
    .db 35
    .db B9
    .db 3A
    .db 00
    .db 29
    .db FB
    .db 99
    .db 3A
    .db 00
    .db 4C
    .db 2A
    .db 89
    .db B9
    .db 3A
    .db 00
    .db 29
    .db 08
    .db F0
    .db 23
    .db A5
    .db 42
    .db C9
    .db 07
    .db D0
    .db 07
    .db BD
    .db A2
    .db 04
    .db C9
    .db 97
    .db 90
    .db 0E
    .db BD
    .db 6C
    .db 04
    .db C9
    .db 58
    .db 90
    .db 07
    .db A9
    .db 02
    .db 20
    .db 30
    .db E6
    .db 90
    .db 08
    .db B9
    .db 3A
    .db 00
    .db 29
    .db F7
    .db 99
    .db 3A
    .db 00
    .db A5
    .db 02
    .db 99
    .db 43
    .db 00
    .db B9
    .db 3A
    .db 00
    .db 29
    .db 0F
    .db 0A
    .db A8
    .db B9
    .db 0E
    .db 8A
    .db 85
    .db 00
    .db B9
    .db 0F
    .db 8A
    .db 85
    .db 01
    .db A0
    .db 00
    .db B1
    .db 00
    .db F0
    .db 0A
    .db B1
    .db 00
    .db 9D
    .db FC
    .db 04
    .db C8
    .db C8
    .db 4C
    .db 60
    .db 89
    .db C8
    .db C8
    .db B1
    .db 00
    .db F0
    .db 0A
    .db B1
    .db 00
    .db 9D
    .db FC
    .db 04
    .db A9
    .db FF
    .db 9D
    .db EA
    .db 04
    .db C8
    .db C8
    .db B1
    .db 00
    .db F0
    .db 08
    .db B1
    .db 00
    .db 9D
    .db 20
    .db 05
    .db 4C
    .db 7C
    .db 89
    .db C8
    .db C8
    .db B1
    .db 00
    .db F0
    .db 08
    .db 9D
    .db 20
    .db 05
    .db A9
    .db FF
    .db 9D
    .db 0E
    .db 05
    .db A5
    .db 42
    .db C9
    .db 07
    .db D0
    .db 18
    .db BD
    .db FC
    .db 04
    .db 9D
    .db FD
    .db 04
    .db BD
    .db EA
    .db 04
    .db 9D
    .db EB
    .db 04
    .db BD
    .db 20
    .db 05
    .db 9D
    .db 21
    .db 05
    .db BD
    .db 0E
    .db 05
    .db 9D
    .db 0F
    .db 05
    .db BD
    .db C6
    .db 04
    .db F0
    .db 6E
    .db BD
    .db 7E
    .db 04
    .db A8
    .db BD
    .db 6C
    .db 04
    .db C9
    .db 50
    .db 90
    .db 63
    .db 20
    .db AA
    .db E7
    .db C9
    .db 05
    .db F0
    .db 5C
    .db A9
    .db 01
    .db 1D
    .db 12
    .db 04
    .db 9D
    .db 12
    .db 04
    .db BD
    .db 90
    .db 04
    .db 9D
    .db 91
    .db 04
    .db BD
    .db 7E
    .db 04
    .db 9D
    .db 7F
    .db 04
    .db BD
    .db B4
    .db 04
    .db 9D
    .db B5
    .db 04
    .db BD
    .db A2
    .db 04
    .db 9D
    .db A3
    .db 04
    .db BD
    .db 12
    .db 04
    .db 29
    .db 02
    .db F0
    .db 08
    .db BD
    .db 12
    .db 04
    .db 09
    .db 08
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 40
    .db 9D
    .db 20
    .db 05
    .db 9D
    .db 21
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 44
    .db 05
    .db 9D
    .db 32
    .db 05
    .db 9D
    .db D9
    .db 04
    .db 9D
    .db C7
    .db 04
    .db A9
    .db 40
    .db 9D
    .db D4
    .db 05
    .db A5
    .db 42
    .db C9
    .db 07
    .db F0
    .db 07
    .db E8
    .db A9
    .db 09
    .db 20
    .db 27
    .db 96
    .db CA
    .db A9
    .db 90
    .db 4C
    .db 27
    .db 96
    .db 60
    .db 24
    .db 8A
    .db 2C
    .db 8A
    .db 34
    .db 8A
    .db 24
    .db 8A
    .db 3C
    .db 8A
    .db 44
    .db 8A
    .db 4C
    .db 8A
    .db 54
    .db 8A
    .db 5C
    .db 8A
    .db 64
    .db 8A
    .db 6C
    .db 8A
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db F0
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
    .db FF
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db A0
    .db 00
    .db 00
    .db 00
    .db F0
    .db 00
    .db 00
    .db 00
    .db C0
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
    .db C0
    .db 00
    .db 00
    .db 00
    .db C0
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 60
    .db FF
    .db F0
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 40
    .db FF
    .db 00
    .db 00
    .db 40
    .db FF
    .db 00
    .db 00
    .db 40
    .db FF
RTN_STATE_BIT_#$04_SET: ; 1C:0A74, 0x038A74
    LDA OBJECT_DATA_EXTRA_A?[18],X ; Load
    BNE SWITCH_OBJECT_DATA_EXTRA_B ; If set switch off of B.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$09 ; Isolate 0000.1001
    BNE SWITCH_OBJECT_DATA_EXTRA_B ; If either set, also do.
    LDA #$05
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set otherwise.
SWITCH_OBJECT_DATA_EXTRA_B: ; 1C:0A85, 0x038A85
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load val.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on them.
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
    LOW(SWITCH_RTN_H)
    HIGH(SWITCH_RTN_H)
    LOW(SWITCH_RTN_I)
    HIGH(SWITCH_RTN_I)
    LOW(SWITCH_RTN_J)
    HIGH(SWITCH_RTN_J)
    LOW(SWITCH_RTN_K)
    HIGH(SWITCH_RTN_K)
SWITCH_RTN_F: ; 1C:0AA1, 0x038AA1
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:0AEB
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$60
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    CMP #$07
    BNE 1C:0ADE
    LDA OBJ_POS_X[18],X
    BMI 1C:0ACA
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA #$60
    BNE 1C:0AD9
    LDA OBJ_DIRECTION_RELATED?[18],X
    ORA #$40
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA #$FF
    STA 4EA_ARR_UNK[18],X
    LDA #$A0
    STA 4FC_ARR_UNK[18],X
    BNE 1C:0AE6
    JSR $920B
    LDA #$03
    JSR $9627
    LDA #$5E
    JMP SND_BANKED_DISPATCH
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:0B49
    JSR $920B
    LDA #$00
    STA OBJ_ANIMATION_FRAME_TO[18],X
    STA OBJ_ANIMATION_FRAME_TO+1,X
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA NUM_PLAYER_LIVES[2],Y
    SEC
    SBC #$01
    STA NUM_PLAYER_LIVES[2],Y
    PHA
    JSR UPDATE_PLAYER_LIVES
    PLA
    BPL 1C:0B23
    LDA NUM_PLAYER_LIVES[2]
    BPL 1C:0B4A
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1C:0B1A
    LDA NUM_PLAYER_LIVES+1
    BPL 1C:0B4A
    LDA #$07
    STA 3C_SWITCH_CORE
    LDA #$00
    STA 4B_SWITCH_GAME_OVER/FINISHED
    RTS
    LDY TMP_08
    CPY #$00
    BNE 1C:0B2F
    JSR $8164
    JMP $8B32
    JSR $8145
    LDA #$3C
    STA OBJECT_DATA_EXTRA_A?[18],X
    JSR UPDATE_??
    LDY TMP_08
    LDA #$50
    STA 93_PLAYER_UNK[2],Y
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ORA #$10
    STA OBJ_SECONDARY_SWITCH?[18],X
    RTS
    LDA #$00
    JMP BANKED_PLAYER_UI_INIT_FROM_A
SWITCH_RTN_E: ; 1C:0B4F, 0x038B4F
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    JSR SWITCH_CODE_PTRS_PAST_JSR
    ADC [8B_UNK,X]
    LDY #$8C
    LDA #$8C
    AND #$8E
    AND 8D_UNK,X
    LDY TMP_08
    JSR $920B
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$09
    BNE 1C:0BA7
    LDA **:$0091,Y
    CMP #$06
    BCS 1C:0BA7
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$01
    JSR $9627
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    CMP #$03
    BEQ 1C:0B9D
    CMP #$09
    BEQ 1C:0B9D
    CMP #$05
    BEQ 1C:0B98
    CMP #$06
    BEQ 1C:0B98
    CMP #$07
    BNE 1C:0BA2
    LDA #$3C
    JMP $8BA4
    LDA #$3D
    JMP $8BA4
    LDA #$3B
    JMP SND_BANKED_DISPATCH
    LDA #$00
    STA **:$0091,Y
    LDA #$3E
    JSR SND_BANKED_DISPATCH
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    STA OBJ_DIRECTION_RELATED?[18],X
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],Y
    AND #$40
    ORA OBJ_DIRECTION_RELATED?[18],X
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1C:0BDE
    LDA OBJ_POS_X[18],X
    CMP #$E4
    BCS 1C:0BEC
    LDA #$87
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:0C1D
    BCS 1C:0BEC
    LDA OBJ_POS_X[18],X
    CMP #$18
    BCC 1C:0BEC
    LDA #$88
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:0C1D
    LDY TMP_08
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$09
    BEQ 1C:0C0E
    LDA #$02
    STA 85_PLAYER_UNK?[2],Y
    LDA #$00
    STA 544_OBJ_UNK_POS?[18],X
    LDA #$00
    STA 532_OBJ_UNK_POS?[18],X
    LDA #$40
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$07
    JMP $9627
    LDA #$10
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA #$03
    STA 85_PLAYER_UNK?[2],Y
    LDA #$08
    JMP $9627
    LDY TMP_08
    LDA #$02
    STA 85_PLAYER_UNK?[2],Y
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$09
    BNE 1C:0C31
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA A0_PLAYER_UNK[2],Y
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1C:0C63
    LDA 490_OBJ_UNK_SPEED?[18],X
    STA 490_OBJ_UNK_SPEED?+1,X
    LDA OBJ_POS_X[18],X
    STA OBJ_POS_X+1,X
    LDA 4B4_OBJ_SPEED?[18],X
    STA 4B4_OBJ_SPEED?+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?+1,X
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$09
    BNE 1C:0C5C
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA 4C6_OBJ_UNK_POS?+1,X
    INX
    LDA #$09
    JSR $9627
    DEX
    LDY #$00
    JSR $8C7C
    LDA #$00
    STA 544_OBJ_UNK_POS?[18],X
    LDA #$FA
    STA 532_OBJ_UNK_POS?[18],X
    LDA #$40
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$07
    JMP $9627
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1C:0C85
    INY
    INY
    LDA $8C98,Y
    STA 4FC_ARR_UNK[18],X
    STA 4FC_ARR_UNK+1,X
    LDA $8C99,Y
    STA 4EA_ARR_UNK[18],X
    STA 4EA_ARR_UNK+1,X
    RTS
    BRK
    ???
    BRK
    ???
    BRK
    INC **:$0100,X
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    BPL 1C:0CA8
    JMP $91E5
    RTS
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1C:0CC0
    LDA #$87
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCS 1C:0CD5
    LDA OBJ_POS_X[18],X
    CMP #$E4
    BCC 1C:0D1C
    BCS 1C:0CCE
    LDA #$88
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCS 1C:0CD5
    LDA OBJ_POS_X[18],X
    CMP #$18
    BCS 1C:0D1C
    LDA #$A8
    STA 5D4_ARR_OBJ_TIMER?[18],X
    BNE 1C:0CEA
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1C:0CCE
    LDA #$3F
    JSR SND_BANKED_DISPATCH
    LDA #$02
    JSR $9627
    LDA #$01
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$00
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA 4FC_ARR_UNK[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK[18],X
    STA 4EA_ARR_UNK+1,X
    LDY TMP_08
    LDA #$04
    STA 85_PLAYER_UNK?[2],Y
    LDA A0_PLAYER_UNK[2],Y
    BEQ 1C:0D1B
    LDA 4C6_OBJ_UNK_POS?[18],X
    BEQ 1C:0D16
    CMP A0_PLAYER_UNK[2],Y
    BCC 1C:0D1B
    BEQ 1C:0D1B
    LDA #$00
    STA A0_PLAYER_UNK[2],Y
    RTS
    JSR $8D3F
    LDA 532_OBJ_UNK_POS?[18],X
    BMI 1C:0CA8
    LDA 85_PLAYER_UNK?[2],Y
    CMP #$02
    BNE 1C:0D1B
    LDA #$A8
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDY #$04
    JMP $8C7C
    LDA 5D4_ARR_OBJ_TIMER?[18],X
    CMP #$0E
    BCS 1C:0D3F
    INC 5D4_ARR_OBJ_TIMER?[18],X
    LDA 532_OBJ_UNK_POS?[18],X
    BMI 1C:0D48
    CMP #$08
    BCS 1C:0D5F
    LDA 544_OBJ_UNK_POS?[18],X
    CLC
    ADC 5D4_ARR_OBJ_TIMER?[18],X
    STA 544_OBJ_UNK_POS?[18],X
    LDA 532_OBJ_UNK_POS?[18],X
    ADC #$00
    STA 532_OBJ_UNK_POS?[18],X
    BPL 1C:0D5F
    JMP $8E1A
    LDY TMP_08
    LDA 60_PLAYER_UNK[1],Y
    BEQ 1C:0D74
    LDA OBJ_POS_Y[18],X
    BMI 1C:0D1B
    CMP #$2C
    BCC 1C:0D1B
    LDA #$00
    STA 60_PLAYER_UNK[1],Y
    LDA A0_PLAYER_UNK[2],Y
    BNE 1C:0DA6
    LDA #$03
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:0D90
    LDY LEVEL_SCREEN_ON
    LDA $87D1,Y
    CMP 4C6_OBJ_UNK_POS?[18],X
    BCS 1C:0D90
    STA 4C6_OBJ_UNK_POS?[18],X
    JMP $8DCB
    LDA 4C6_OBJ_UNK_POS?[18],X
    BPL 1C:0D98
    JMP $8E1A
    CMP #$20
    BCS 1C:0E1A
    LDA #$00
    STA 4D8_OBJ_UNK[18],X
    STA 4C6_OBJ_UNK_POS?[18],X
    BEQ 1C:0DCB
    LDA 4C6_OBJ_UNK_POS?[18],X
    CMP #$08
    BCC 1C:0DCB
    CMP A0_PLAYER_UNK[2],Y
    BCC 1C:0E1A
    LDA #$0D
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCS 1C:0DC0
    LDA #$00
    STA A0_PLAYER_UNK[2],Y
    BEQ 1C:0E1A
    LDA #$00
    STA 4D8_OBJ_UNK[18],X
    LDA A0_PLAYER_UNK[2],Y
    STA 4C6_OBJ_UNK_POS?[18],X
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1C:0DD8
    INX
    LDA #$00
    JSR $9627
    DEX
    LDA #$00
    STA 4FC_ARR_UNK[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK[18],X
    STA 4EA_ARR_UNK+1,X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    LDA #$10
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDY TMP_08
    LDA OBJECT_DATA_EXTRA_A?[18],X
    BNE 1C:0E01
    LDA #$05
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    BEQ 1C:0E03
    LDA #$03
    STA 85_PLAYER_UNK?[2],Y
    LDA #$06
    JSR RTN_UNK_RTS_CARRY_SET_FAIL?
    BCC 1C:0E15
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ORA #$20
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$08
    JMP $9627
    LDY TMP_08
    LDA OBJ_POS_Y[18],X
    CMP #$2C
    BCS 1C:0E28
    LDA #$01
    STA 60_PLAYER_UNK[1],Y
    RTS
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:0E28
    JMP $91E5
SWITCH_RTN_A: ; 1C:0E31, 0x038E31
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:0E9F
    LDA 4A2_OBJ_UNK_POS?[18],X
    CMP #$E0
    BCS 1C:0EB0
    LDA OBJ_POS_X[18],X
    CMP #$18
    BCC 1C:0EB0
    CMP #$E4
    BCS 1C:0EB0
    LDA #$06
    JSR $9627
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$00
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    STA 43_PLAYER_UNK[2],Y
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],Y
    AND #$40
    EOR #$40
    ORA OBJ_DIRECTION_RELATED?[18],X
    STA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BNE 1C:0E86
    LDA OBJ_POS_X[18],Y
    CLC
    ADC #$08
    JMP $8E8C
    LDA OBJ_POS_X[18],Y
    SEC
    SBC #$08
    STA OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],Y
    CLC
    ADC #$04
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA 4C6_OBJ_UNK_POS?[18],Y
    STA 4C6_OBJ_UNK_POS?[18],X
    RTS
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    CMP #$06
    BNE 1C:0EB3
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    CMP #$07
    BCC 1C:0EB6
    JSR $8EC5
    JMP $91E5
    LDY TMP_08
    LDA CTRL_NEWLY_PRESSED_A[2],Y
    BEQ 1C:0EC0
    INC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    JSR $8ECE
    BNE 1C:0ECD
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],Y
    RTS
    LDY TMP_08
    INC 59E_OBJ_UNK_TIMER?[18],X
    LDA 59E_OBJ_UNK_TIMER?[18],X
    AND #$1F
    BNE 1C:0F03
    LDA **:$06D6
    BNE 1C:0F03
    LDA OBJECT_DATA_EXTRA_A?[18],X
    SEC
    SBC #$03
    STA OBJECT_DATA_EXTRA_A?[18],X
    BEQ 1C:0EF1
    BPL 1C:0EFB
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],X
    LDA #$05
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    STA 85_PLAYER_UNK?[2],Y
    LDA #$01
    STA 662_PLAYER_UPDATE_UNK[2],Y
    LDA OBJECT_DATA_EXTRA_A?[18],X
    RTS
SWITCH_RTN_B: ; 1C:0F04, 0x038F04
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:0F66
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],Y
    AND #$40
    BNE 1C:0F19
    LDA #$D8
    BNE 1C:0F1B
    LDA #$2F
    STA TMP_02
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1C:0F28
    LDA #$F9
    BNE 1C:0F2A
    LDA #$00
    STA TMP_03
    LDA OBJ_POS_X[18],Y
    CLC
    ADC TMP_02
    ADC TMP_03
    STA OBJ_POS_X[18],X
    LDA 4A2_OBJ_UNK_POS?[18],Y
    CLC
    ADC #$01
    STA 4A2_OBJ_UNK_POS?[18],X
    STA OBJ_POS_Y[18],X
    LDA #$41
    JSR SND_BANKED_DISPATCH
    LDA #$0B
    JSR $9627
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    JSR $920B
    LDA #$00
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    STA 59E_OBJ_UNK_TIMER?[18],X
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    RTS
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    CMP #$06
    BNE 1C:0FAF
    LDA #$25
    STA OBJ_ANIMATION_FRAME_TO[18],Y
    LDA IRQ/SCRIPT_RUN_COUNT?
    AND #$04
    BEQ 1C:0F80
    LDA #$26
    STA OBJ_ANIMATION_FRAME_TO[18],Y
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    CMP #$04
    BCC 1C:0F8D
    JSR $8F9C
    JMP $91E5
    LDY TMP_08
    LDA CTRL_NEWLY_PRESSED_A[2],Y
    BEQ 1C:0F97
    INC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    JSR $8ECE
    BNE 1C:0FAE
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],Y
    LDY TMP_08
    LDA #$00
    STA **:$008F,Y
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    RTS
    JSR $8FA4
    JMP $91E5
SWITCH_RTN_D: ; 1C:0FB5, 0x038FB5
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:0FDF
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$40
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA #$11
    JSR $9627
    TXA
    PHA
    LDA #$3D
    CPX #$02
    BNE 1C:0FD5
    LDA #$3E
    JSR LEVEL_RELATED_DATA_A_PASSED?
    PLA
    TAX
    LDA #$20
    JMP SND_BANKED_DISPATCH
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:0FAE
    TXA
    PHA
    CPX #$02
    BEQ 1C:0FF0
    LDA TURTLE_SELECT_POSITIONS[2]
    LDX #$11
    BNE 1C:0FF4
    LDA TURTLE_SELECT_POSITIONS+1
    LDX #$15
    JSR SUB_SET_COLORS_PLAYERS?
    PLA
    TAX
    JMP $91E5
SWITCH_RTN_K: ; 1C:0FFC, 0x038FFC
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:1012
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$40
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA #$A0
    JMP $9627
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:0FAE
    JMP $91E5
SWITCH_RTN_C: ; 1C:101A, 0x03901A
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    CMP #$01
    BEQ 1C:1059
    BCS 1C:109F
    LDA #$3D
    JSR SND_BANKED_DISPATCH
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    JSR $920B
    LDA #$00
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    STA 59E_OBJ_UNK_TIMER?[18],X
    STA 43_PLAYER_UNK[2],Y
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],Y
    AND #$40
    ORA OBJ_DIRECTION_RELATED?[18],X
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    RTS
    JSR $8ECE
    BNE 1C:1061
    JMP $8F9C
    LDA CTRL_NEWLY_PRESSED_A[2],Y
    AND #$40
    BNE 1C:1073
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    JMP $90C6
    INC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    CMP #$04
    BCC 1C:1092
    JSR $8F9C
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],Y
    LDY TMP_08
    LDA #$01
    STA 3F6_PLAYER_SCORE_ADD_VALUE[2],Y
    JSR 1E:1C72
    JMP $91E5
    LDA #$04
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDY TMP_08
    LDA #$02
    STA 85_PLAYER_UNK?[2],Y
    RTS
    LDA OBJ_ANIM_HOLD_TIMER?[18],X
    BNE 1C:109E
    LDA #$0E
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA 45A_OBJ_DATA_ENTRY?[18],Y
    CLC
    ADC #$01
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    CMP #$02
    BCC 1C:10C6
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],Y
    LDY TMP_08
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    RTS
    LDY #$00
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1C:10D1
    LDY #$04
    STY TMP_02
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA 45A_OBJ_DATA_ENTRY?[18],Y
    ASL A
    STA TMP_04
    CLC
    ADC TMP_02
    TAY
    LDA $9122,Y
    STA TMP_02
    LDA $9123,Y
    STA TMP_03
    LDY TMP_04
    LDA $912A,Y
    STA TMP_04
    LDA $912B,Y
    STA TMP_05
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_POS_X[18],X
    CLC
    ADC TMP_02
    STA OBJ_POS_X[18],Y
    LDA 4C6_OBJ_UNK_POS?[18],X
    SEC
    SBC TMP_03
    STA 4C6_OBJ_UNK_POS?[18],Y
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?[18],Y
    CLC
    ADC 4C6_OBJ_UNK_POS?[18],Y
    STA OBJ_POS_Y[18],Y
    LDA TMP_04
    STA OBJ_ANIMATION_FRAME_TO[18],Y
    LDA TMP_05
    JMP $9627
    .db 0C
    .db 06
    .db 1A
    .db 28
    .db F4
    .db 06
    .db E6
    .db 28
    .db 0B
    .db 98
    .db 0A
    .db 94
SWITCH_RTN_H: ; 1C:112E, 0x03912E
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:114C
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$10
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    JSR $920B
    LDA #$13
    JMP $9627
    LDA #$41
    JMP SND_BANKED_DISPATCH
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    AND #$07
    BNE 1C:1158
    LDA #$41
    JSR SND_BANKED_DISPATCH
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:11A7
    JMP $91E5
SWITCH_RTN_I: ; 1C:1160, 0x039160
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:118E
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$40
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA OBJECT_DATA_EXTRA_A?[18],X
    SEC
    SBC #$02
    BCS 1C:117B
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],X
    JSR $920B
    LDA #$13
    JSR $9627
    LDY TMP_08
    LDA #$01
    STA 662_PLAYER_UPDATE_UNK[2],Y
    RTS
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    AND #$07
    BNE 1C:119A
    LDA #$41
    JSR SND_BANKED_DISPATCH
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:11A7
    JSR $91E5
    LDA #$20
    STA 93_PLAYER_UNK[2],Y
    RTS
SWITCH_RTN_J: ; 1C:11A8, 0x0391A8
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:11C1
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    LDA #$50
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    JSR $920B
    LDA #$13
    JMP $9627
    DEC 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    BNE 1C:11E4
    LDA #$12
    JSR $9627
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],X
    STA 85_PLAYER_UNK?[2],Y
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$E0
    CPX #$00
    BEQ 1C:11DE
    ORA #$01
    STA OBJ_DIRECTION_RELATED?[18],X
    JSR UPDATE_??
    RTS
    LDY TMP_08
    LDA #$00
    STA 85_PLAYER_UNK?[2],Y
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$0C
    STA 93_PLAYER_UNK[2],Y
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$F0
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$E0
    CPX #$00
    BEQ 1C:1207
    ORA #$01
    STA OBJ_DIRECTION_RELATED?[18],X
    RTS
    LDA #$00
    STA 43_PLAYER_UNK[2],Y
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK+1,X
    STA 520_ARR_UNK+1,X
    STA 50E_ARR_UNK+1,X
    RTS
SWITCH_RTN_G: ; 1C:122F, 0x03922F
    LDY TMP_08
    LDA 85_PLAYER_UNK?[2],Y
    BNE 1C:125A
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    STA OBJ_DIRECTION_RELATED?[18],X
    JSR $920B
    LDA #$01
    STA 85_PLAYER_UNK?[2],Y
    STA 662_PLAYER_UPDATE_UNK[2],Y
    LDA #$0F
    JSR $9627
    INX
    LDA #$00
    JSR $9627
    DEX
    LDA #$40
    JMP SND_BANKED_DISPATCH
    LDA OBJ_ENABLED_STATE+MORE?[18],X
    BPL 1C:1294
    LDA OBJECT_DATA_EXTRA_A?[18],X
    SEC
    SBC #$05
    STA OBJECT_DATA_EXTRA_A?[18],X
    BEQ 1C:1271
    BPL 1C:1278
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],X
    LDA #$05
    STA OBJECT_DATA_EXTRA_B?[18],X
    BNE 1C:1285
    LDA OBJ_SECONDARY_SWITCH?[18],X
    AND #$F0
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    STA 85_PLAYER_UNK?[2],Y
    LDA #$50
    STA 93_PLAYER_UNK[2],Y
    LDA #$01
    STA 662_PLAYER_UPDATE_UNK[2],Y
    RTS
TURTLE_SELECT_RTN: ; 1C:1295, 0x039295
    LDA STATE_TURTLE_SELECT
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(TURTLE_SELECT_CLEAR_SCREEN) ; Screen manip.
    HIGH(TURTLE_SELECT_CLEAR_SCREEN)
    LOW(TURTLE_SELECT_RTN_1) ; Cursor things?
    HIGH(TURTLE_SELECT_RTN_1)
    LOW(TURTLE_SELECT_RTN_2) ; Setup screen+music.
    HIGH(TURTLE_SELECT_RTN_2)
    LOW(TURTLE_SELECT_RTN_3) ; Attribute updates.
    HIGH(TURTLE_SELECT_RTN_3)
    LOW(TURTLE_SELECT_RTN_4) ; Mods the positions.
    HIGH(TURTLE_SELECT_RTN_4)
    LOW(TURTLE_SELECT_RTN_5) ; Pick confirmed.
    HIGH(TURTLE_SELECT_RTN_5)
TURTLE_SELECT_CLEAR_SCREEN: ; 1C:12A7, 0x0392A7
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; Disable rendering.
    INC STATE_TURTLE_SELECT ; Next state.
    JMP DISPATCH_CLEAR_SCREEN
TURTLE_SELECT_RTN_1: ; 1C:12B1, 0x0392B1
    LDA TITLE_PLAYERS_COUNT_CURSOR_0/1 ; Get players count cursor.
    AND #$01 ; Get 0/1
    ORA 47_TWO_PLAYERS_FLAG ; Or with...?
    STA 47_TWO_PLAYERS_FLAG ; Store...
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; Rendering.
    JSR INIT_STREAM+MISC_UNK
    INC STATE_TURTLE_SELECT
    RTS
TURTLE_SELECT_RTN_2: ; 1C:12C4, 0x0392C4
    LDA #$E0 ; Set BG GFX
    STA IRQ_GFX_DATA_BANK_R0
    LDA #$E2
    STA IRQ_GFX_DATA_BANK_R1
    LDX #$08 ; Turtle select file.
    JSR BANK_PAIR_SAVE+PPU_FILE_BANK_14/15
    LDY #$00
    STY TURTLE_SELECT_POSITIONS[2] ; Clear..
    INY ; Y=1
    LDA 47_TWO_PLAYERS_FLAG ; Load
    EOR #$01 ; Invert.
    STA 701_TSELECT_CONFIRMED/TIMER ; Store.
    BEQ SKIP_Y_NEGATIVE ; If invert was 0, goto.
    LDY #$FF ; Y=
SKIP_Y_NEGATIVE: ; 1C:12E1, 0x0392E1
    STY TURTLE_SELECT_POSITIONS+1 ; Store 1 or FF.
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; Stop rendering for 5 frames.
    INC STATE_TURTLE_SELECT ; Next state.
    LDA #$6A
    JSR SND_BANKED_DISPATCH ; Start music.
    JMP WRITE_PPU_CTRL_COPY ; Enable rendering?
TURTLE_SELECT_RTN_3: ; 1C:12F2, 0x0392F2
    LDA #$01 ; Enable?
    STA OBJ_ENABLED_STATE+MORE?[18]
    STA OBJ_ENABLED_STATE+MORE?+1
    LDA #$C4 ; Set sprite bank R2.
    STA ZP_R2-R5_BANK_VALUES[4]
    LDA #$00
    STA ARR_SPRITE_OBJ_TIMER?[2] ; Clear...?
    STA ARR_SPRITE_OBJ_TIMER?+1
    LDY #$00 ; Init loop.
LOOP_MAKE_UPDATE_BUF: ; 1C:1308, 0x039308
    LDA TESELECT_PALETTE_DATA_INIT,Y ; Load
    STA PPU_PALETTE_BUF?[32],Y ; Store to.
    INY ; Y++
    CPY #$20 ; If Y _ #$20
    BCC LOOP_MAKE_UPDATE_BUF ; <, goto.
    LDX #$00 ; X=
    LDA #$09 ; Data update selection.
    LDY TURTLE_SELECT_POSITIONS[2] ; Tutle select position.
    JSR TURTLE_SELECTION_ATTR_UPDATE ; Update attrs.
    LDX #$01 ; X=
    LDA #$12 ; Data update selection.
    LDY TURTLE_SELECT_POSITIONS+1 ; Selected pos.
    BMI DONT_RUN_P2_RTN ; If minus, don't run P2 RTN.
    JSR TURTLE_SELECTION_ATTR_UPDATE ; Do rtn.
DONT_RUN_P2_RTN: ; 1C:1327, 0x039327
    LDA TURTLE_SELECT_POSITIONS[2] ; Load
    STA TMP_0A ; Store
    LDA TURTLE_SELECT_POSITIONS+1 ; Load
    STA TMP_0B
    JSR TSEL_QUEUE_BG_PALETTE_UPDATE ; Do...?
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; Stop rendering frames.
    INC STATE_TURTLE_SELECT ; Next state.
    RTS
TESELECT_PALETTE_DATA_INIT: ; 1C:133A, 0x03933A
    .db 0F
    .db 16
    .db 18
    .db 20
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 0F
    .db 1A
    .db 11
    .db 20
    .db 0F
    .db 1A
    .db 27
    .db 20
    .db 0F
    .db 0F
    .db 11
    .db 20
    .db 0F
    .db 0F
    .db 16
    .db 20
    .db 0F
    .db 0F
    .db 11
    .db 20
    .db 0F
    .db 0F
    .db 16
    .db 20
TURTLE_SELECT_RTN_4: ; 1C:135A, 0x03935A
    JSR RTN_CURSOR_OBJECT_UPDATE? ; Update cursors?
    INC ARR_SPRITE_OBJ_TIMER?+1 ; Inc ??
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load
    CMP #$12 ; If _ #$12
    BCC COUNTER_NOT_TRIGGERED_A? ; <, goto.
    LDA #$00 ; Clear
    STA ARR_SPRITE_OBJ_TIMER?+1 ; Clear counter?
    LDA ARR_SPRITE_OBJ_TIMER?[2] ; Load val
    EOR #$01 ; Invert bottom bit.
    STA ARR_SPRITE_OBJ_TIMER?[2] ; Store back.
COUNTER_NOT_TRIGGERED_A?: ; 1C:1374, 0x039374
    LDA ARR_SPRITE_OBJ_TIMER?[2] ; Load data
    BNE DATA_NOT_ZERO
    LDY #$00 ; Y=
    LDA 701_TSELECT_CONFIRMED/TIMER ; A=
    LSR A ; >> 1
    BCS SHIFTED_1_TO_CARRY
    STY OBJ_ANIMATION_FRAME_TO+1 ; Clear.
SHIFTED_1_TO_CARRY: ; 1C:1384, 0x039384
    LSR A ; >> 1
    BCS DATA_NOT_ZERO ; If we shift off a 1, goto.
    STY OBJ_ANIMATION_FRAME_TO[18] ; Clear val.
DATA_NOT_ZERO: ; 1C:138A, 0x03938A
    LDA TURTLE_SELECT_POSITIONS[2] ; Load val
    STA TMP_08 ; P1 previous
    LDA TURTLE_SELECT_POSITIONS+1 ; Load val
    STA TMP_09 ; P2 previous.
    LDA 701_TSELECT_CONFIRMED/TIMER ; Load 
    CMP #$03 ; If _ #$03
    BEQ BOTH_TURTLES_SELECTED ; ==, goto.
    STA TMP_00 ; Save.
    LDX #$01 ; Player modifying.
    LSR TMP_00 ; Shift bit.
    BCS PLAYER_2_CONFIRMED ; If set, skip.
    JSR RTN_MODIFY_SELECTION ; Mod selection.
    LDA TURTLE_SELECT_POSITIONS+1 ; Load pos.
    CMP TMP_09 ; Compare to previous.
    BNE SELECTION_NOT_SAME_AS_PREV ; !=, goto.
PLAYER_2_CONFIRMED: ; 1C:13AA, 0x0393AA
    DEX ; X=0
    LSR TMP_00 ; Shift temp.
    BCS RTS ; If shift 1, leave.
    JSR RTN_MODIFY_SELECTION ; Modify player 0.
    LDA TURTLE_SELECT_POSITIONS[2] ; Load P1 Pos.
    CMP TMP_08 ; Compare to previous.
    BNE SELECTION_NOT_SAME_AS_PREV ; !=, goto.
RTS: ; 1C:13B8, 0x0393B8
    RTS
BOTH_TURTLES_SELECTED: ; 1C:13B9, 0x0393B9
    INC STATE_TURTLE_SELECT ; Next state.
    LDA #$83
    STA 701_TSELECT_CONFIRMED/TIMER ; Set....used as counter later?
    LDA #$00 ; Clear/disable sprites used for cursors?
    STA ARR_SPRITE_OBJ_TIMER?[2]
    STA ARR_SPRITE_OBJ_TIMER?+1
    RTS ; Leave.
SELECTION_NOT_SAME_AS_PREV: ; 1C:13CA, 0x0393CA
    LDA #$00
    LDY TMP_08,X
    JSR TURTLE_SELECTION_ATTR_UPDATE
    TXA
    LSR A
    LDA #$09
    BCC 1C:13D9
    LDA #$12
    LDY TURTLE_SELECT_POSITIONS[2],X
    JSR TURTLE_SELECTION_ATTR_UPDATE
    LDA TURTLE_SELECT_POSITIONS[2]
    STA TMP_0A
    LDA TURTLE_SELECT_POSITIONS+1
    STA TMP_0B
    JMP TSEL_QUEUE_BG_PALETTE_UPDATE
RTN_MODIFY_SELECTION: ; 1C:13E9, 0x0393E9
    LDA CTRL_NEWLY_PRESSED_A[2],X ; Get pressed.
    BMI A_BUTTON_PRESSED ; Branch if A pressed.
    PHA ; Save A.
    AND #$0C ; Keep bits up/down.
    BEQ U/D_NOT_PRESSED ; Not pressed.
    JSR TSELECT_INVERT_ROW ; Pressed, do rtn.
U/D_NOT_PRESSED: ; 1C:13F5, 0x0393F5
    PLA ; Pull buttons.
    AND #$03 ; Keep left/right buttons.
    BEQ 1C:13FD ; Not pressed, goto.
    JSR TSELECT_INVERT_COLUMN ; Pressed, do rtn.
    RTS ; Leave, modded.
A_BUTTON_PRESSED: ; 1C:13FE, 0x0393FE
    TXA ; Player to A.
    BNE PLAYER_A_SELECT_2 ; != 0, goto.
    LDA #$02 ; A=
PLAYER_A_SELECT_2: ; 1C:1403, 0x039403
    ORA 701_TSELECT_CONFIRMED/TIMER ; Or val.
    STA 701_TSELECT_CONFIRMED/TIMER ; Store back.
    LDA #$57 ; Play sound.
    JMP SND_BANKED_DISPATCH ; Abuse RTS.
TSELECT_INVERT_ROW: ; 1C:140E, 0x03940E
    TXA ; X to A.
    EOR #$01 ; Invert player data selection.
    TAY ; Other player to Y index.
    LDA TURTLE_SELECT_POSITIONS[2],X ; Load editing.
    EOR #$02 ; Invert row.
    CMP TURTLE_SELECT_POSITIONS[2],Y ; CODE MISTAKE: Not ZP mode. Compare to other player.
    BEQ LEAVE_NO_MOD ; Other player has selected, abort.
    STA TURTLE_SELECT_POSITIONS[2],X ; Otherwise, store.
    PHA ; Save A.
    LDA #$56
    JSR SND_BANKED_DISPATCH ; Play sound.
    PLA ; Restore A.
LEAVE_NO_MOD: ; 1C:1424, 0x039424
    RTS
TSELECT_INVERT_COLUMN: ; 1C:1425, 0x039425
    TXA
    EOR #$01
    TAY
    LDA TURTLE_SELECT_POSITIONS[2],X
    EOR #$01
    CMP TURTLE_SELECT_POSITIONS[2],Y
    BEQ 1C:143B
    STA TURTLE_SELECT_POSITIONS[2],X
    PHA
    LDA #$56
    JSR SND_BANKED_DISPATCH
    PLA
    RTS
TURTLE_SELECTION_ATTR_UPDATE: ; 1C:143C, 0x03943C
    STX TMP_07 ; X to. Y=Pos
    STA TMP_06 ; A to.
    TYA ; Y val to A.
    ASL A ; A to word index.
    TAY ; Back to Y.
    LDA TSELECT_DATA_PPU_ADDRS_L,Y ; Load PPU lower.
    STA TMP_02 ; PPU Low here.
    LDA TSELECT_DATA_PPU_ADDRS_H,Y ; Load PPU higher.
    STA TMP_03 ; PPU High here.
    LDY TMP_06 ; Load original A.
    LDA #$02 ; A=
    STA TMP_00 ; Setup loop count.
    LDX PPU_UPDATE_BUF_INDEX ; Load X from.
UPDATE_MAKE_LOOP: ; 1C:1455, 0x039455
    LDA #$04 ; 4 byte update?
    STA PPU_UPDATE_BUFFER[20],X ; Set up.
    LDA TMP_02 ; Load PPU low.
    STA PPU_UPDATE_BUFFER+1,X ; Make addr.
    LDA TMP_03 ; Load PPU high.
    STA PPU_UPDATE_BUFFER+2,X ; Make addr.
    LDA #$03 ; Load from.
    STA PPU_UPDATE_BUFFER+3,X ; To buf.
    LDA TSELECT_PPU_BUF_DATA,Y ; Load data.
    STA PPU_UPDATE_BUFFER+4,X ; Store to.
    INY ; Stream++
    LDA TSELECT_PPU_BUF_DATA,Y ; Load data.
    STA PPU_UPDATE_BUFFER+5,X ; Store to.
    INY ; Stream++
    LDA TSELECT_PPU_BUF_DATA,Y ; A from
    STA PPU_UPDATE_BUFFER+6,X ; Store to.
    INY ; Stream++
    CLC ; Prep add.
    TXA ; Slot pos to A.
    ADC #$07 ; Move to new slot.
    TAX ; Slot index back to X.
    CLC ; Prep add.
    LDA #$08 ; A=
    ADC TMP_02 ; Accumulate change to PPU low addr.
    STA TMP_02 ; Store back.
    DEC TMP_00 ; Dec loop count.
    BPL UPDATE_MAKE_LOOP ; If positive, continue.
    LDA #$00
    STA PPU_UPDATE_BUFFER[20],X ; Null next slot.
    STX PPU_UPDATE_BUF_INDEX ; X final to index.
    LDX TMP_07 ; Load X passed?
    RTS
TSELECT_DATA_PPU_ADDRS_L: ; 1C:1498, 0x039498
    .db C9
TSELECT_DATA_PPU_ADDRS_H: ; 1C:1499, 0x039499
    .db 23
    .db CC
    .db 23
    .db E1
    .db 23
    .db E4
    .db 23
TSELECT_PPU_BUF_DATA: ; 1C:14A0, 0x0394A0
    .db 40
    .db 50
    .db 10
    .db 44
    .db 55
    .db 11
    .db 04
    .db 05
    .db 01
    .db 80
    .db A0
    .db 20
    .db 88
    .db AA
    .db 22
    .db 08
    .db 0A
    .db 02
    .db C0
    .db F0
    .db 30
    .db CC
    .db FF
    .db 33
    .db 0C
    .db 0F
    .db 03
TSEL_QUEUE_BG_PALETTE_UPDATE: ; 1C:14BB, 0x0394BB
    TXA ; Save X.
    PHA
    LDA TMP_0A ; Load prev P1 turtle selected.
    ASL A ; << 2, *4
    ASL A
    TAY ; Yo Y index.
    LDX #$08 ; Palette entry to change, BG[2]
    JSR PALETTE_UPDATE_MOD_BG[X]
    LDA TMP_0B
    BMI NO_P2_PREV ; No P2 here.
    ASL A ; << 2, *4
    ASL A
    TAY ; To Y index.
    LDX #$0C ; Which entry to change, BG[3]
    JSR PALETTE_UPDATE_MOD_BG[X]
NO_P2_PREV: ; 1C:14D3, 0x0394D3
    LDA #$05 ; Total size?
    JSR UNK_STREAM_SETUP_0x300_BUF
    PLA ; Restore X.
    TAX
    RTS ; RTS.
PALETTE_UPDATE_MOD_BG[X]: ; 1C:14DB, 0x0394DB
    LDA #$03 ; To change.
    STA TMP_00 ; Loop count.
LOOP_MORE: ; 1C:14DF, 0x0394DF
    LDA TSEL_BLANK_BLINK_PALETTE?,Y ; Load val
    STA PPU_PALETTE_BUF?[32],X ; Store to update buf.
    INX ; X++
    INY ; Y++
    DEC TMP_00 ; Loop--
    BPL LOOP_MORE ; Move all 3 bytes.
    RTS
TSEL_BLANK_BLINK_PALETTE?: ; 1C:14EC, 0x0394EC
    .db 0F
    .db 1A
    .db 11
    .db 20
    .db 0F
    .db 1A
    .db 27
    .db 20
    .db 0F
    .db 1A
    .db 14
    .db 20
    .db 0F
    .db 1A
    .db 16
    .db 20
    .db 0F
    .db 0F
    .db 0F
    .db 0F
RTN_CURSOR_OBJECT_UPDATE?: ; 1C:1500, 0x039500
    LDX #$00 ; X=Which player
    LDA TURTLE_SELECT_POSITIONS[2] ; A=Selected pos.
    JSR RTN_SETUP_OBJECT?
    INX ; Player 2.
    LDA TURTLE_SELECT_POSITIONS+1 ; Load pos.
    BMI RTS ; If negative, not 2P games.
RTN_SETUP_OBJECT?: ; 1C:150C, 0x03950C
    ASL A ; A to word size.
    TAY ; To Y index.
    LDA TSELECT_CURSOR_POS_X,Y ; Load val
    STA OBJ_POS_X[18],X ; Store to...
    LDA TSELECT_CURSOR_POS_Y,Y ; Load val
    STA OBJ_POS_Y[18],X ; Store to...
    LDA TSELECT_DATA_UNK,X ; Load val
    STA OBJ_ANIMATION_FRAME_TO[18],X ; Store to...
RTS: ; 1C:1520, 0x039520
    RTS
TSELECT_DATA_UNK: ; 1C:1521, 0x039521
    .db 6A
    .db 6B
TSELECT_CURSOR_POS_X: ; 1C:1523, 0x039523
    .db 34
TSELECT_CURSOR_POS_Y: ; 1C:1524, 0x039524
    .db 30
    .db 94
    .db 30
    .db 34
    .db 90
    .db 94
    .db 90
TURTLE_SELECT_RTN_5: ; 1C:152B, 0x03952B
    LDA CTRL_NEWLY_PRESSED_A[2] ; Load pressed.
    ORA CTRL_NEWLY_PRESSED_A+1 ; From both players.
    BMI TSELECT_FINAL_ANIM_TIMEOUT/SKIP ; If A pressed on either.
    JSR RTN_CURSOR_OBJECT_UPDATE? ; Update cursor.
    DEC 701_TSELECT_CONFIRMED/TIMER ; Dec timer.
    BEQ TSELECT_FINAL_ANIM_TIMEOUT/SKIP ; Timed out, goto.
    INC ARR_SPRITE_OBJ_TIMER?+1 ; Inc sprite attr.
    LDA ARR_SPRITE_OBJ_TIMER?+1 ; Load val
    CMP #$11 ; If A _ #$11
    BCC TIMER_UNDER ; <, goto.
    LDA #$00 ; Clear
    STA ARR_SPRITE_OBJ_TIMER?+1 ; This.
    LDA ARR_SPRITE_OBJ_TIMER?[2] ; Load P1.
    EOR #$01 ; Invert bit.
    STA ARR_SPRITE_OBJ_TIMER?[2] ; Store back.
TIMER_UNDER: ; 1C:1550, 0x039550
    LDA ARR_SPRITE_OBJ_TIMER?[2] ; Load P1
    BNE P1_VAL_NONZERO ; != 0, goto.
    LDA #$04 ; A=
    STA TMP_0A ; Store different previous?
    STA TMP_0B
    JMP QUEUE_BG_UPDATES ; Goto.
P1_VAL_NONZERO: ; 1C:155E, 0x03955E
    LDA TURTLE_SELECT_POSITIONS[2] ; Load P1 pos.
    STA TMP_0A ; Store to.
    LDA TURTLE_SELECT_POSITIONS+1 ; P2
    STA TMP_0B ; Store to.
QUEUE_BG_UPDATES: ; 1C:1566, 0x039566
    JMP TSEL_QUEUE_BG_PALETTE_UPDATE ; Do rtn abuse RTS.
TSELECT_FINAL_ANIM_TIMEOUT/SKIP: ; 1C:1569, 0x039569
    LDA 47_TWO_PLAYERS_FLAG ; Not really sure if flag or val.
    BNE SINGLE_PLAYER_GAME? ; != 0, goto.
    STA TURTLE_SELECT_POSITIONS+1 ; Store to select?
SINGLE_PLAYER_GAME?: ; 1C:156F, 0x03956F
    LDA #$00 ; Clear
    STA STATE_TURTLE_SELECT
    STA 701_TSELECT_CONFIRMED/TIMER
    STA ARR_SPRITE_OBJ_TIMER?[2] ; Sprites
    STA ARR_SPRITE_OBJ_TIMER?+1
    LDX #$00 ; P1?
    JSR INIT_OBJECT[X]_DATA?
    INX ; P2?
    JSR INIT_OBJECT[X]_DATA?
    JMP SOUND_INIT_RTN? ; Sound init, abuse RTS.
OBJECT_X_DO_UNK: ; 1C:1589, 0x039589
    LDA 544_OBJ_UNK_POS?[18],X ; Load
    ORA 532_OBJ_UNK_POS?[18],X ; Or with
    BEQ VALUES_NOT_SET_A
    LDA 4D8_OBJ_UNK[18],X ; Load val
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS?[18],X ; Add with.
    STA 4D8_OBJ_UNK[18],X ; Store to.
    LDA 4C6_OBJ_UNK_POS?[18],X ; Load val
    ADC 532_OBJ_UNK_POS?[18],X ; Add with
    BMI ADD_RESULT_NEGATIVE ; Minus set, goto.
    CMP #$20 ; If A _ #$20
    BCS ADD_RESULT_NEGATIVE ; >=, goto.
    LDA #$00 ; Store 0.
ADD_RESULT_NEGATIVE: ; 1C:15A9, 0x0395A9
    STA 4C6_OBJ_UNK_POS?[18],X ; Store.
VALUES_NOT_SET_A: ; 1C:15AC, 0x0395AC
    LDA 4FC_ARR_UNK[18],X ; Load value.
    ORA 4EA_ARR_UNK[18],X ; Or with.
    BEQ VALUES_NOT_SET_B ; None set, goto.
    LDA 490_OBJ_UNK_SPEED?[18],X ; Load val
    CLC
    ADC 4FC_ARR_UNK[18],X ; Add with.
    STA 490_OBJ_UNK_SPEED?[18],X ; Store to.
    LDA OBJ_POS_X[18],X ; Load val.
    ADC 4EA_ARR_UNK[18],X ; Add with.
    STA OBJ_POS_X[18],X ; Store to.
VALUES_NOT_SET_B: ; 1C:15C7, 0x0395C7
    LDA 520_ARR_UNK[18],X ; Load val
    ORA 50E_ARR_UNK[18],X ; Or bits.
    BEQ VALUES_NOT_SET_C ; Not set.
    LDA 4B4_OBJ_SPEED?[18],X ; Load val
    CLC ; Prep add.
    ADC 520_ARR_UNK[18],X ; Add val.
    STA 4B4_OBJ_SPEED?[18],X ; Store.
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    ADC 50E_ARR_UNK[18],X ; Add
    STA 4A2_OBJ_UNK_POS?[18],X ; Store.
VALUES_NOT_SET_C: ; 1C:15E2, 0x0395E2
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$07 ; If _ #$07
    BEQ VALUES_NOT_SET_E ; ==, goto.
    LDA B7_UNK_SPRITES? ; Load val
    ORA BA_UNK_SPRITES? ; Add bits.
    BEQ VALUES_NOT_SET_D
    LDA 490_OBJ_UNK_SPEED?[18],X ; Load val
    SEC ; Prep sub.
    SBC B7_UNK_SPRITES? ; Subtract.
    STA 490_OBJ_UNK_SPEED?[18],X ; Store back.
    LDA OBJ_POS_X[18],X ; Load val
    SBC BA_UNK_SPRITES? ; Subtract.
    STA OBJ_POS_X[18],X ; Store back.
VALUES_NOT_SET_D: ; 1C:15FF, 0x0395FF
    LDA 83_UNK ; Load val.
    ORA 84_UNK ; Get 
    BEQ VALUES_NOT_SET_E
    LDA 4B4_OBJ_SPEED?[18],X ; Load val.
    SEC ; Prep sub.
    SBC 83_UNK ; Subtract with.
    STA 4B4_OBJ_SPEED?[18],X ; Store.
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load
    SBC 84_UNK ; Subtract.
    STA 4A2_OBJ_UNK_POS?[18],X ; Store.
VALUES_NOT_SET_E: ; 1C:1616, 0x039616
    LDA 4D8_OBJ_UNK[18],X ; Load value.
    CLC ; Prep add.
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    LDA 4C6_OBJ_UNK_POS?[18],X ; Load
    ADC 4A2_OBJ_UNK_POS?[18],X ; Add.
    STA OBJ_POS_Y[18],X ; Store.
    RTS
OBJECT_TO_STATE_A_COMPLEX?: ; 1C:1627, 0x039627
    CMP #$80 ; If val _ #$80
    BCS VAL_ABOVE_#$80 ; >=, goto.
    TAY ; To Y index.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load val.
    AND #$20 ; Keep only 0010.0000
    BEQ 0x20_EQ_0_A ; Not set, goto.
    LDA DATA_UNK_A,Y ; Load from.
    JMP SKIP_TO_UNK ; Goto.
0x20_EQ_0_A: ; 1C:1639, 0x039639
    LDA DATA_UNK_B,Y ; Load from.
    JMP SKIP_TO_UNK
VAL_ABOVE_#$80: ; 1C:163F, 0x03963F
    AND #$7F ; Get bottom bits.
    STA TMP_00 ; Store to.
    LDY TMP_08 ; Y from.
    LDA TURTLE_SELECT_POSITIONS[2],Y ; Get selected.
    CLC
    ADC TMP_00 ; Add with.
    TAY ; To Y index.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load from object.
    AND #$20 ; Get bit.
    BEQ 0x20_EQ_0_B ; Not set, goto.
    LDA DATA_UNK_C,Y ; Load from.
    JMP SKIP_TO_UNK
0x20_EQ_0_B: ; 1C:1659, 0x039659
    LDA DATA_UNK_D,Y ; Load from.
SKIP_TO_UNK: ; 1C:165C, 0x03965C
    CMP OBJ_ENABLED_STATE+MORE?[18],X ; If A _ Obj.var
    BEQ VALUES_MATCH ; ==, goto.
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Store enabled value.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; No hold timer, force animation update.
    STA 45A_OBJ_DATA_ENTRY?[18],X ; Clear unk.
VALUES_MATCH: ; 1C:166C, 0x03966C
    LDY TMP_08 ; Y from, which player doing.
    RTS ; Leave.
DATA_UNK_B: ; 1C:166F, 0x03966F
    .db 00
    .db 01
    .db 02
    .db 03
    .db 04
    .db 05
    .db 08
    .db 0A
    .db 13
    .db 0F
    .db 0F
    .db 09
    .db 0C
    .db 10
    .db 11
    .db 0B
    .db 12
    .db 06
    .db 07
    .db 16
    .db 17
    .db 18
DATA_UNK_A: ; 1C:1685, 0x039685
    .db 00
    .db 0D
    .db 02
    .db 0E
    .db 04
    .db 05
    .db 15
    .db 0A
    .db 14
    .db 0F
DATA_UNK_D: ; 1C:168F, 0x03968F
    .db 19
    .db 29
    .db 39
    .db 49
    .db 1A
    .db 2A
    .db 3A
    .db 4A
    .db 1B
    .db 2B
    .db 3B
    .db 4B
    .db 1D
    .db 2D
    .db 3D
    .db 4D
    .db 1E
    .db 2E
    .db 3E
    .db 4E
    .db 1F
    .db 2F
    .db 3F
    .db 4F
    .db 20
    .db 30
    .db 40
    .db 50
    .db 1C
    .db 2C
    .db 3C
    .db 4C
    .db 25
    .db 35
    .db 45
    .db 55
DATA_UNK_C: ; 1C:16B3, 0x0396B3
    .db 24
    .db 34
    .db 44
    .db 54
    .db 21
    .db 31
    .db 41
    .db 51
    .db 22
    .db 32
    .db 42
    .db 52
    .db 1D
    .db 2D
    .db 3D
    .db 4D
    .db 23
    .db 33
    .db 43
    .db 53
    .db 27
    .db 37
    .db 47
    .db 57
    .db 28
    .db 38
    .db 48
    .db 58
    .db 26
    .db 36
    .db 46
    .db 56
ANIMATE_UPDATE_OBJ_X?: ; 1C:16D3, 0x0396D3
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load unk. Timer?
    BEQ GFX_TIMEOUT? ; If zero, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Subtract otherwise.
RTS: ; 1C:16DB, 0x0396DB
    RTS
GFX_TIMEOUT?: ; 1C:16DC, 0x0396DC
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load val
    BMI RTS ; Not enabled, RTS.
    ASL A ; << 1, word size index.
    TAY ; Turn to array.
    LDA DATA_PTRS_UNK_L,Y ; Move stream pointer.
    STA TMP_00
    LDA DATA_PTRS_UNK_H,Y
    STA TMP_01
    LDY TMP_08 ; Index from.
    LDA 60_PLAYER_UNK[1],Y ; Move val.
    STA TMP_03
REENTER_UNK: ; 1C:16F4, 0x0396F4
    LDA 45A_OBJ_DATA_ENTRY?[18],X ; Load val from object.
    INC 45A_OBJ_DATA_ENTRY?[18],X ; ++ val.
    STA TMP_02 ; Prev val to.
    ASL A ; << 1, *2.
    CLC ; Prep add.
    ADC TMP_02 ; *3, add orginal value back to.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load data from stream.
    CMP #$FF ; If _ #$FF
    BEQ STREAM_MARK_FF ; ==, goto.
    CMP #$FE ; If _ #$FE
    BEQ STREAM_MARK_FE ; ==, goto.
    LDA TMP_03 ; Load val.
    BEQ CHANGE_ANIMATION_FROM_STREAM ; If 0, goto.
    LDA #$00
    BEQ INJECT_ANIMATION_FROM_A ; Always taken.
CHANGE_ANIMATION_FROM_STREAM: ; 1C:1713, 0x039713
    LDA [TMP_00],Y ; Load data from stream.
INJECT_ANIMATION_FROM_A: ; 1C:1715, 0x039715
    STA OBJ_ANIMATION_FRAME_TO[18],X ; Switch animation frames?
    INY ; Stream++
    LDA [TMP_00],Y ; Load from stream.
    CMP #$FF ; If _ #$FF
    BEQ STREAM_MARK_B_FF
    CPX #$02 ; If OBJ _ #$02
    BEQ CHANGE_PLAYER_TWO_GFX ; ==, goto.
    CPX #$00 ; If OBJ _ #$00
    BNE STREAM_MARK_B_FF ; !=, goto.
    STA ZP_R2-R5_BANK_VALUES[4] ; Change P1 animation GFX.
    JMP STREAM_MARK_B_FF
CHANGE_PLAYER_TWO_GFX: ; 1C:172C, 0x03972C
    STA ZP_R2-R5_BANK_VALUES+1 ; Store P2 GFX.
STREAM_MARK_B_FF: ; 1C:172E, 0x03972E
    INY ; Stream++
    LDA [TMP_00],Y ; Load from.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to object.
    RTS ; Leave.
STREAM_MARK_FF: ; 1C:1735, 0x039735
    LDY TMP_08 ; Y from.
    LDA #$00 ; Clear..
    STA 45A_OBJ_DATA_ENTRY?[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load object state.
    ORA #$80 ; Set disabled.
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Store back to.
    RTS
STREAM_MARK_FE: ; 1C:1748, 0x039748
    LDA #$00 ; Clear..
    STA 45A_OBJ_DATA_ENTRY?[18],X
    BEQ REENTER_UNK ; Always taken.
DATA_PTRS_UNK_L: ; 1C:174F, 0x03974F
    .db 01
DATA_PTRS_UNK_H: ; 1C:1750, 0x039750
    .db 98
    .db 05
    .db 98
    .db 09
    .db 98
    .db 0D
    .db 98
    .db 14
    .db 98
    .db 21
    .db 98
    .db 25
    .db 98
    .db 29
    .db 98
    .db 30
    .db 98
    .db 37
    .db 98
    .db 45
    .db 98
    .db 49
    .db 98
    .db 5F
    .db 98
    .db 63
    .db 98
    .db 67
    .db 98
    .db 6E
    .db 98
    .db 72
    .db 98
    .db 79
    .db 98
    .db 80
    .db 98
    .db 8A
    .db 98
    .db 8E
    .db 98
    .db 92
    .db 98
    .db 3E
    .db 98
    .db 99
    .db 98
    .db A3
    .db 98
    .db A7
    .db 98
    .db AE
    .db 98
    .db BB
    .db 98
    .db C8
    .db 98
    .db D5
    .db 98
    .db DF
    .db 98
    .db E3
    .db 98
    .db E7
    .db 98
    .db EB
    .db 98
    .db F8
    .db 98
    .db DF
    .db 98
    .db 05
    .db 99
    .db 0C
    .db 99
    .db 19
    .db 99
    .db 26
    .db 99
    .db 2A
    .db 99
    .db 2E
    .db 99
    .db 35
    .db 99
    .db 46
    .db 99
    .db 53
    .db 99
    .db 60
    .db 99
    .db 42
    .db 99
    .db 6D
    .db 99
    .db 71
    .db 99
    .db 75
    .db 99
    .db 82
    .db 99
    .db 42
    .db 99
    .db 8F
    .db 99
    .db 96
    .db 99
    .db A3
    .db 99
    .db B0
    .db 99
    .db B4
    .db 99
    .db B8
    .db 99
    .db BF
    .db 99
    .db D0
    .db 99
    .db DD
    .db 99
    .db EA
    .db 99
    .db CC
    .db 99
    .db F7
    .db 99
    .db FB
    .db 99
    .db FF
    .db 99
    .db 0C
    .db 9A
    .db CC
    .db 99
    .db 19
    .db 9A
    .db 20
    .db 9A
    .db 2D
    .db 9A
    .db 3A
    .db 9A
    .db 3E
    .db 9A
    .db 42
    .db 9A
    .db 49
    .db 9A
    .db 5A
    .db 9A
    .db 67
    .db 9A
    .db 74
    .db 9A
    .db 56
    .db 9A
    .db 81
    .db 9A
    .db 85
    .db 9A
    .db 89
    .db 9A
    .db 96
    .db 9A
    .db 56
    .db 9A
    .db A3
    .db 9A
    .db AA
    .db 9A
    .db B7
    .db 9A
    .db C4
    .db 9A
    .db C8
    .db 9A
    .db 00
    .db FF
    .db FF
    .db FF
    .db 01
    .db 20
    .db 04
    .db FF
    .db 02
    .db 20
    .db 10
    .db FE
    .db 03
    .db 20
    .db 06
    .db 04
    .db 20
    .db 06
    .db FE
    .db 05
    .db 21
    .db 06
    .db 06
    .db 21
    .db 06
    .db 07
    .db 21
    .db 06
    .db 08
    .db 21
    .db 06
    .db FE
    .db 09
    .db 21
    .db 03
    .db FE
    .db 0A
    .db 21
    .db 80
    .db FF
    .db 0B
    .db BA
    .db 06
    .db 0C
    .db BA
    .db 06
    .db FE
    .db 0D
    .db 20
    .db 08
    .db 0E
    .db 20
    .db 08
    .db FE
    .db 9A
    .db B9
    .db 04
    .db 1D
    .db 20
    .db 05
    .db FE
    .db 9B
    .db B9
    .db 04
    .db 01
    .db 20
    .db 04
    .db FE
    .db 53
    .db B9
    .db 04
    .db FE
    .db 54
    .db B8
    .db 06
    .db 55
    .db B8
    .db 1C
    .db 00
    .db 00
    .db 1C
    .db 56
    .db B8
    .db 30
    .db 00
    .db 00
    .db 20
    .db 57
    .db B8
    .db 0C
    .db 58
    .db B8
    .db 0C
    .db FF
    .db 47
    .db FF
    .db 0C
    .db FE
    .db AA
    .db 20
    .db 04
    .db FF
    .db 4B
    .db 25
    .db 06
    .db 4C
    .db 25
    .db 06
    .db FE
    .db 15
    .db FF
    .db FF
    .db FE
    .db 60
    .db FF
    .db 06
    .db 61
    .db FF
    .db 06
    .db FE
    .db 51
    .db FF
    .db 04
    .db 52
    .db FF
    .db 04
    .db FF
    .db 54
    .db B8
    .db 06
    .db 55
    .db B8
    .db 1C
    .db 00
    .db 00
    .db FF
    .db FF
    .db A8
    .db 20
    .db 04
    .db FF
    .db A9
    .db 20
    .db 04
    .db FF
    .db 0D
    .db 20
    .db 08
    .db 0E
    .db 20
    .db 08
    .db FE
    .db 19
    .db FF
    .db 07
    .db 1A
    .db FF
    .db 07
    .db 1B
    .db FF
    .db 07
    .db FE
    .db CA
    .db B8
    .db 06
    .db FE
    .db 12
    .db 22
    .db 80
    .db 13
    .db 22
    .db 18
    .db FE
    .db 0F
    .db 22
    .db 07
    .db 10
    .db 22
    .db 07
    .db 11
    .db 22
    .db 07
    .db 10
    .db 22
    .db 07
    .db FE
    .db 0F
    .db 22
    .db 02
    .db 16
    .db 24
    .db 02
    .db 17
    .db 24
    .db 03
    .db 18
    .db 24
    .db 04
    .db FF
    .db 0F
    .db 22
    .db 02
    .db 5A
    .db C0
    .db 02
    .db 5B
    .db C0
    .db 03
    .db 5C
    .db C0
    .db 04
    .db FF
    .db 19
    .db 23
    .db 06
    .db 1A
    .db 23
    .db 06
    .db 1B
    .db 23
    .db 12
    .db FF
    .db 14
    .db 25
    .db 03
    .db FE
    .db 43
    .db 38
    .db 06
    .db FE
    .db 44
    .db 38
    .db 06
    .db FE
    .db 0F
    .db 26
    .db 07
    .db 10
    .db 26
    .db 07
    .db 11
    .db 26
    .db 07
    .db 10
    .db 26
    .db 07
    .db FE
    .db 0F
    .db 26
    .db 02
    .db 16
    .db 27
    .db 02
    .db 17
    .db 27
    .db 03
    .db 18
    .db 27
    .db 04
    .db FF
    .db 12
    .db 26
    .db 80
    .db 13
    .db 26
    .db 18
    .db FE
    .db 9C
    .db BA
    .db 08
    .db 9D
    .db BA
    .db 10
    .db 9E
    .db BA
    .db 06
    .db 9D
    .db BA
    .db E0
    .db FE
    .db 0F
    .db 26
    .db 02
    .db AD
    .db C0
    .db 02
    .db AE
    .db C0
    .db 03
    .db AF
    .db C0
    .db 04
    .db FF
    .db C2
    .db 38
    .db 06
    .db FE
    .db C3
    .db 38
    .db 06
    .db FE
    .db 21
    .db 39
    .db 80
    .db 22
    .db 39
    .db 14
    .db FE
    .db 1E
    .db 39
    .db 07
    .db 1F
    .db 39
    .db 07
    .db 20
    .db 39
    .db 07
    .db 1F
    .db 39
    .db 07
    .db FE
    .db 23
    .db 25
    .db 03
    .db FE
    .db 1E
    .db 39
    .db 02
    .db 25
    .db 3B
    .db 02
    .db 26
    .db 3B
    .db 03
    .db 27
    .db 3B
    .db 04
    .db FF
    .db 1E
    .db 39
    .db 02
    .db 5D
    .db C1
    .db 02
    .db 5E
    .db C1
    .db 03
    .db 5F
    .db C1
    .db 04
    .db FF
    .db 28
    .db 3A
    .db 06
    .db 29
    .db 3A
    .db 06
    .db 2A
    .db 3A
    .db 12
    .db 23
    .db 3A
    .db 06
    .db FF
    .db 45
    .db 38
    .db 06
    .db FE
    .db 46
    .db 38
    .db 06
    .db FE
    .db 1E
    .db 3C
    .db 07
    .db 1F
    .db 3C
    .db 07
    .db 20
    .db 3C
    .db 07
    .db 1F
    .db 3C
    .db 07
    .db FE
    .db 1E
    .db 3C
    .db 02
    .db 25
    .db 3D
    .db 02
    .db 26
    .db 3D
    .db 03
    .db 27
    .db 3D
    .db 04
    .db FF
    .db 21
    .db 3C
    .db 80
    .db 22
    .db 3C
    .db 14
    .db FE
    .db 9F
    .db BA
    .db 08
    .db A0
    .db BA
    .db 10
    .db A1
    .db BA
    .db 06
    .db A0
    .db BA
    .db E0
    .db FE
    .db 1E
    .db 3C
    .db 02
    .db B0
    .db C1
    .db 02
    .db B1
    .db C1
    .db 03
    .db B2
    .db C1
    .db 04
    .db FF
    .db C4
    .db 38
    .db 06
    .db FE
    .db C5
    .db 38
    .db 06
    .db FE
    .db 2E
    .db 3E
    .db 80
    .db 2F
    .db 3E
    .db 14
    .db FE
    .db 2B
    .db 3E
    .db 07
    .db 2C
    .db 3E
    .db 07
    .db 2D
    .db 3E
    .db 07
    .db 2C
    .db 3E
    .db 07
    .db FE
    .db 30
    .db 25
    .db 03
    .db FE
    .db 2B
    .db 3E
    .db 02
    .db 32
    .db 40
    .db 02
    .db 33
    .db 40
    .db 03
    .db 34
    .db 40
    .db 04
    .db FF
    .db 2B
    .db 3E
    .db 02
    .db 64
    .db C2
    .db 02
    .db 65
    .db C2
    .db 03
    .db 66
    .db C2
    .db 04
    .db FF
    .db 35
    .db 3F
    .db 06
    .db 36
    .db 3F
    .db 06
    .db 37
    .db 3F
    .db 12
    .db 30
    .db 3F
    .db 06
    .db FF
    .db 47
    .db 38
    .db 06
    .db FE
    .db 48
    .db 38
    .db 06
    .db FE
    .db 2B
    .db 41
    .db 07
    .db 2C
    .db 41
    .db 07
    .db 2D
    .db 41
    .db 07
    .db 2C
    .db 41
    .db 07
    .db FE
    .db 2B
    .db 41
    .db 02
    .db 32
    .db 42
    .db 02
    .db 33
    .db 42
    .db 03
    .db 34
    .db 42
    .db 04
    .db FF
    .db 2E
    .db 41
    .db 80
    .db 2F
    .db 41
    .db 14
    .db FE
    .db A2
    .db BA
    .db 08
    .db A3
    .db BA
    .db 10
    .db A4
    .db BA
    .db 06
    .db A3
    .db BA
    .db E0
    .db FE
    .db 2B
    .db 41
    .db 02
    .db B3
    .db C2
    .db 02
    .db B4
    .db C2
    .db 03
    .db B5
    .db C2
    .db 04
    .db FF
    .db C6
    .db 38
    .db 06
    .db FE
    .db C7
    .db 38
    .db 06
    .db FE
    .db 3B
    .db 43
    .db 80
    .db 3C
    .db 43
    .db 14
    .db FE
    .db 38
    .db 43
    .db 07
    .db 39
    .db 43
    .db 07
    .db 3A
    .db 43
    .db 07
    .db 39
    .db 43
    .db 07
    .db FE
    .db 3D
    .db 25
    .db 03
    .db FE
    .db 38
    .db 43
    .db 02
    .db 3F
    .db 45
    .db 02
    .db 62
    .db 45
    .db 03
    .db 63
    .db 45
    .db 04
    .db FF
    .db 38
    .db 43
    .db 02
    .db 67
    .db C3
    .db 02
    .db 68
    .db C3
    .db 03
    .db 69
    .db C3
    .db 04
    .db FF
    .db 40
    .db 44
    .db 06
    .db 41
    .db 44
    .db 06
    .db 42
    .db 44
    .db 12
    .db 3D
    .db 25
    .db 06
    .db FF
    .db 49
    .db 38
    .db 06
    .db FE
    .db 4A
    .db 38
    .db 06
    .db FE
    .db 38
    .db 46
    .db 07
    .db 39
    .db 46
    .db 07
    .db 3A
    .db 46
    .db 07
    .db 39
    .db 46
    .db 07
    .db FE
    .db 38
    .db 46
    .db 02
    .db 3F
    .db 47
    .db 02
    .db 62
    .db 47
    .db 03
    .db 63
    .db 47
    .db 04
    .db FF
    .db 3B
    .db 46
    .db 80
    .db 3C
    .db 46
    .db 14
    .db FE
    .db A5
    .db BA
    .db 08
    .db A6
    .db BA
    .db 10
    .db A7
    .db BA
    .db 06
    .db A6
    .db BA
    .db E0
    .db FE
    .db 38
    .db 46
    .db 02
    .db B6
    .db C3
    .db 02
    .db B7
    .db C3
    .db 03
    .db B8
    .db C3
    .db 04
    .db FF
    .db C8
    .db 38
    .db 06
    .db FE
    .db C9
    .db 38
    .db 06
    .db FE
SUB_AND_611_SWITCH: ; 1C:1ACC, 0x039ACC
    JSR ANIMATE_PLAYERS? ; Do this.
611_SWITCH: ; 1C:1ACF, 0x039ACF
    LDA 611_SWITCH_UNK ; Load val.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on it.
    LOW(611_SWITCH_RTN_A)
    HIGH(611_SWITCH_RTN_A)
    LOW(611_SWITCH_RTN_B)
    HIGH(611_SWITCH_RTN_B)
    LOW(611_SWITCH_RTN_C)
    HIGH(611_SWITCH_RTN_C)
    LOW(611_SWITCH_RTN_D)
    HIGH(611_SWITCH_RTN_D)
    LOW(611_SWITCH_RTN_E)
    HIGH(611_SWITCH_RTN_E)
    LOW(611_SWITCH_RTN_F)
    HIGH(611_SWITCH_RTN_F)
    LOW(611_SWITCH_RTN_G)
    HIGH(611_SWITCH_RTN_G)
    LOW(611_SWITCH_RTN_H)
    HIGH(611_SWITCH_RTN_H)
    LOW(611_SWITCH_RTN_I)
    HIGH(611_SWITCH_RTN_I)
    LOW(611_SWITCH_RTN_J)
    HIGH(611_SWITCH_RTN_J)
    LOW(611_SWITCH_RTN_K)
    HIGH(611_SWITCH_RTN_K)
611_SWITCH_RTN_A: ; 1C:1AEB, 0x039AEB
    .db A2
    .db 00
    .db 86
    .db 08
    .db A4
    .db 09
    .db B9
    .db 4D
    .db 00
    .db 30
    .db 0D
    .db BD
    .db 36
    .db 04
    .db 29
    .db 01
    .db 9D
    .db 36
    .db 04
    .db A9
    .db 80
    .db 20
    .db 27
    .db 96
    .db E6
    .db 08
    .db E8
    .db E8
    .db E4
    .db 04
    .db D0
    .db E4
    .db EE
    .db 11
    .db 06
611_SWITCH_RTN_B: ; 1C:1B0E, 0x039B0E
    .db A2
    .db 00
    .db 86
    .db 06
    .db 86
    .db 08
    .db A4
    .db 08
    .db B9
    .db 4D
    .db 00
    .db 10
    .db 04
    .db E6
    .db 06
    .db D0
    .db 4B
    .db 20
    .db 3B
    .db 9D
    .db A0
    .db 00
    .db BD
    .db 7E
    .db 04
    .db DD
    .db 86
    .db 9B
    .db F0
    .db 19
    .db 90
    .db 02
    .db C8
    .db C8
    .db B9
    .db 8A
    .db 9B
    .db 9D
    .db FC
    .db 04
    .db 9D
    .db FD
    .db 04
    .db B9
    .db 8B
    .db 9B
    .db 9D
    .db EA
    .db 04
    .db 9D
    .db EB
    .db 04
    .db 4C
    .db 47
    .db 9B
    .db E6
    .db 06
    .db A0
    .db 04
    .db BD
    .db A2
    .db 04
    .db DD
    .db 87
    .db 9B
    .db F0
    .db 19
    .db 90
    .db 02
    .db C8
    .db C8
    .db B9
    .db 8A
    .db 9B
    .db 9D
    .db 20
    .db 05
    .db 9D
    .db 21
    .db 05
    .db B9
    .db 8B
    .db 9B
    .db 9D
    .db 0E
    .db 05
    .db 9D
    .db 0F
    .db 05
    .db 4C
    .db 6C
    .db 9B
    .db E6
    .db 06
    .db E6
    .db 08
    .db E8
    .db E8
    .db E4
    .db 04
    .db D0
    .db A0
    .db A5
    .db 06
    .db C5
    .db 04
    .db D0
    .db 0B
    .db A9
    .db 00
    .db 8D
    .db 12
    .db 04
    .db 8D
    .db 14
    .db 04
    .db EE
    .db 11
    .db 06
    .db 60
    .db 58
    .db B8
    .db 7A
    .db C8
    .db C0
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
    .db 40
    .db FF
611_SWITCH_RTN_C: ; 1C:1B92, 0x039B92
    .db A5
    .db B4
    .db C9
    .db 21
    .db 90
    .db 1D
    .db A9
    .db 04
    .db 8D
    .db 0C
    .db 06
    .db A9
    .db 02
    .db 8D
    .db 5F
    .db 06
    .db A9
    .db 22
    .db 85
    .db B5
    .db A9
    .db 00
    .db 85
    .db B2
    .db A9
    .db 00
    .db 85
    .db AF
    .db A9
    .db 80
    .db 85
    .db 7C
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_D: ; 1C:1BB6, 0x039BB6
    .db A5
    .db B5
    .db C9
    .db 23
    .db 90
    .db F9
    .db A5
    .db B2
    .db C9
    .db 08
    .db B0
    .db 0E
    .db A9
    .db 27
    .db 20
    .db 52
    .db DB
    .db A9
    .db 5F
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db 03
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_E: ; 1C:1BD4, 0x039BD4
    .db A5
    .db B2
    .db C9
    .db E0
    .db 90
    .db DB
    .db A9
    .db 05
    .db 8D
    .db 0C
    .db 06
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_F: ; 1C:1BE3, 0x039BE3
    .db AD
    .db 0C
    .db 06
    .db C9
    .db 06
    .db D0
    .db CB
    .db A9
    .db 4E
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db C2
    .db EE
    .db 11
    .db 06
    .db A9
    .db 64
    .db 20
    .db 52
    .db DB
    .db 60
611_SWITCH_RTN_G: ; 1C:1BFC, 0x039BFC
    .db A2
    .db 00
    .db 86
    .db 08
    .db A9
    .db 00
    .db 85
    .db 06
    .db BD
    .db 12
    .db 04
    .db 30
    .db 57
    .db A4
    .db 08
    .db B9
    .db 4D
    .db 00
    .db 30
    .db 42
    .db 20
    .db 3B
    .db 9D
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 40
    .db B0
    .db 02
    .db E6
    .db 06
    .db A9
    .db 40
    .db 9D
    .db FC
    .db 04
    .db 9D
    .db FD
    .db 04
    .db A9
    .db FF
    .db 9D
    .db EA
    .db 04
    .db 9D
    .db EB
    .db 04
    .db BD
    .db A2
    .db 04
    .db C9
    .db B8
    .db B0
    .db 04
    .db E6
    .db 06
    .db D0
    .db 10
    .db A9
    .db 40
    .db 9D
    .db 20
    .db 05
    .db 9D
    .db 21
    .db 05
    .db A9
    .db FF
    .db 9D
    .db 0E
    .db 05
    .db 9D
    .db 0F
    .db 05
    .db A5
    .db 06
    .db C9
    .db 02
    .db D0
    .db 0A
    .db A9
    .db FE
    .db 9D
    .db 32
    .db 05
    .db A9
    .db 80
    .db 9D
    .db 12
    .db 04
    .db E6
    .db 08
    .db E8
    .db E8
    .db E4
    .db 04
    .db D0
    .db A1
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 20
    .db 05
    .db A9
    .db FE
    .db 9D
    .db 0E
    .db 05
    .db BD
    .db 44
    .db 05
    .db 18
    .db 69
    .db 80
    .db 9D
    .db 44
    .db 05
    .db BD
    .db 32
    .db 05
    .db 69
    .db 00
    .db 9D
    .db 32
    .db 05
    .db D0
    .db DA
    .db A9
    .db 00
    .db 9D
    .db 44
    .db 05
    .db 9D
    .db 32
    .db 05
    .db A9
    .db 00
    .db 20
    .db 27
    .db 96
    .db E8
    .db A9
    .db 00
    .db 20
    .db 27
    .db 96
    .db CA
    .db AD
    .db 00
    .db 04
    .db 0D
    .db 02
    .db 04
    .db D0
    .db BE
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_H: ; 1C:1C9D, 0x039C9D
    .db A9
    .db 4F
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db B9
    .db A9
    .db 40
    .db 85
    .db 40
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_I: ; 1C:1CAE, 0x039CAE
    .db C6
    .db 40
    .db D0
    .db AD
    .db A9
    .db 6B
    .db 85
    .db 2F
    .db A9
    .db 9F
    .db 85
    .db 30
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A2
    .db 08
    .db 20
    .db 3B
    .db 9D
    .db A9
    .db F4
    .db 8D
    .db 86
    .db 04
    .db A9
    .db 94
    .db 8D
    .db AA
    .db 04
    .db A9
    .db 00
    .db 8D
    .db CE
    .db 04
    .db 8D
    .db 04
    .db 05
    .db A9
    .db FE
    .db 8D
    .db F2
    .db 04
    .db A9
    .db 1F
    .db 8D
    .db 08
    .db 04
    .db A9
    .db 03
    .db 8D
    .db 3E
    .db 04
    .db EE
    .db 11
    .db 06
    .db A9
    .db 48
    .db 4C
    .db 13
    .db D4
611_SWITCH_RTN_J: ; 1C:1CEC, 0x039CEC
    .db A2
    .db 08
    .db 20
    .db 89
    .db 95
    .db AD
    .db 86
    .db 04
    .db C9
    .db B4
    .db B0
    .db 08
    .db A2
    .db 08
    .db 20
    .db 3B
    .db 9D
    .db EE
    .db 11
    .db 06
    .db 60
611_SWITCH_RTN_K: ; 1C:1D01, 0x039D01
    .db A9
    .db 60
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db F6
    .db A9
    .db 04
    .db 85
    .db 3C
    .db A9
    .db 00
    .db 8D
    .db 11
    .db 06
    .db 60
ANIMATE_PLAYERS?: ; 1C:1D14, 0x039D14
    LDY #$02 ; Target for one player.
    LDA 47_TWO_PLAYERS_FLAG ; Load.
    BEQ SINGLE_PLAYER_GAME
    LDY #$04 ; Target for 2 players.
SINGLE_PLAYER_GAME: ; 1C:1D1C, 0x039D1C
    STY TMP_04 ; Y to.
    LDX #$00 ; X=
    STX TMP_08 ; Clear.
LOOP_TARGET: ; 1C:1D22, 0x039D22
    LDY TMP_08 ; Y from. Player lives check index val to use.
    LDA NUM_PLAYER_LIVES[2],Y ; Load number of lives.
    BMI PLAYER_HAS_NO_LIVES
    JSR ANIMATE_UPDATE_OBJ_X? ; Do.
    JSR OBJECT_X_DO_UNK ; Do...
PLAYER_HAS_NO_LIVES: ; 1C:1D2F, 0x039D2F
    INX ; Object++
    CPX #$02 ; If X _ #$02
    BNE SKIP_INC ; !=, goto.
    INC TMP_08 ; ++ val.
SKIP_INC: ; 1C:1D36, 0x039D36
    CPX TMP_04 ; If X _ Var
    BNE LOOP_TARGET ; !=, goto.
    RTS
    LDA #$00
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK+1,X
    STA 520_ARR_UNK+1,X
    STA 50E_ARR_UNK+1,X
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
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF

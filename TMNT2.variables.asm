; Work in progress disassembly of TMNT2 for the Nintendo Entertainment System.
; Created by Aaron Bottegal.


; NES PPU Registers

PPU_CTRL:                                     .equ $2000
PPU_MASK:                                     .equ $2001
PPU_STATUS:                                   .equ $2002
PPU_OAM_ADDR:                                 .equ $2003
PPU_OAM_DATA:                                 .equ $2004
PPU_SCROLL:                                   .equ $2005
PPU_ADDR:                                     .equ $2006
PPU_DATA:                                     .equ $2007


; NES APU Registers

APU_SQ1_CTRL:                                 .equ $4000
APU_SQ1_SWEEP:                                .equ $4001
APU_SQ1_LTIMER:                               .equ $4002
APU_SQ1_LENGTH:                               .equ $4003
APU_SQ2_CTRL:                                 .equ $4004
APU_SQ2_SWEEP:                                .equ $4005
APU_SQ2_LTIMER:                               .equ $4006
APU_SQ2_LENGTH:                               .equ $4007
APU_TRI_CTRL:                                 .equ $4008
APU_TRI_UNUSED:                               .equ $4009
APU_TRI_LTIMER:                               .equ $400A
APU_TRI_LENGTH:                               .equ $400B
APU_NSE_CTRL:                                 .equ $400C
APU_NSE_UNUSED:                               .equ $400D
APU_NSE_LOOP:                                 .equ $400E
APU_NSE_LENGTH:                               .equ $400F
APU_DMC_CTRL:                                 .equ $4010
APU_DMC_LOAD:                                 .equ $4011
APU_DMC_ADDR:                                 .equ $4012
APU_DMC_LENGTH:                               .equ $4013
OAM_DMA:                                      .equ $4014
APU_STATUS:                                   .equ $4015
NES_CTRL1:                                    .equ $4016
APU_FSEQUENCE:                                .equ $4017
NES_CTRL2:                                    .equ $4017


; NES RAM/WRAM Variables.


          .rsset 0x0000
TMP_00:                                       .rs 1
TMP_01:                                       .rs 1
TMP_02:                                       .rs 1
TMP_03:                                       .rs 1
TMP_04:                                       .rs 1
TMP_05:                                       .rs 1
TMP_06:                                       .rs 1
TMP_07:                                       .rs 1
TMP_08:                                       .rs 1
TMP_09:                                       .rs 1
TMP_0A:                                       .rs 1
TMP_0B:                                       .rs 1
TMP_0C:                                       .rs 1
TMP_0D:                                       .rs 1
TMP_0E:                                       .rs 1
TMP_0F:                                       .rs 1
TMP_10:                                       .rs 1
TMP_11:                                       .rs 1
TMP_12:                                       .rs 1
TMP_13:                                       .rs 1
TMP_14:                                       .rs 1
TMP_15:                                       .rs 1
TMP_16:                                       .rs 1
TMP_17:                                       .rs 1
STATE_SWITCH_INITIAL_MENUS:                   .rs 1
SUBSTATE_SWITCH_MENUS:                        .rs 1


          .rsset 0x001B
IRQ/SCRIPT_RUN_COUNT?:                        .rs 1
FLAG_GAME_SCREEN_UNFINISHED:                  .rs 1
DISABLE_RENDERING_X_FRAMES:                   .rs 1
PPU_UPDATE_BUF_INDEX:                         .rs 1
GAME_STARTED:                                 .rs 1
TWO_PLAYERS_FLAG:                             .rs 1
TITLE_PLAYERS_COUNT_CURSOR_0/1:               .rs 1
INF_LOOP_COUNTER:                             .rs 1
RANDOM_VALS?:                                 .rs 2
KONAMI_CODE_TRIGGERED_FLAG?:                  .rs 1


          .rsset 0x0027
ATTRACT_LEVEL:                                .rs 1
28_BANK_CFG_INDEX?:                           .rs 1
LOWER_BANK_SAVE_PAIRED?:                      .rs 1
IRQ_BANK_VALUES_R[0/1]:                       .rs 2


          .rsset 0x002D
IRQ_GFX_DATA_BANK_R0:                         .rs 1
IRQ_GFX_DATA_BANK_R1:                         .rs 1
ZP_R2-R5_BANK_VALUES:                         .rs 4
TURTLE_SELECTION:                             .rs 2


          .rsset 0x0038
CTRL_NEWLY_PRESSED_A:                         .rs 2
CTRL_PREV_A:                                  .rs 2
3C_SWITCH_CORE:                               .rs 1
3D_UNK:                                       .rs 1
3E_UNK:                                       .rs 1
3F_ATTRACT_EXIT_FLAG:                         .rs 1
40_TIMER?:                                    .rs 2
LEVEL/SCREEN_ON:                              .rs 1
43_PLAYER_UNK:                                .rs 2
45_UNK:                                       .rs 1


          .rsset 0x0047
TWO_PLAYERS_FLAG:                             .rs 1
PPU_ADDR_IRQ:                                 .rs 2
4A_UNK:                                       .rs 1
4B_SWITCH_GAME_PREP/OVER:                     .rs 1
4C_UNK:                                       .rs 1
NUM_PLAYER_LIVES:                             .rs 2


          .rsset 0x0050
IRQ_HANDLER_JMP:                              .rs 3


          .rsset 0x0056
IRQ_56_OR'D:                                  .rs 1
57_IRQ_LATCH_VAL_COPY:                        .rs 1
58_IRQ_UNK:                                   .rs 1


          .rsset 0x005A
IRQ_LATCH_VALUE_COPY_5A:                      .rs 1


          .rsset 0x005C
IRQ_EXTENDED/HANDLER/SECONDARY:               .rs 1
5D_IRQ_BANK?:                                 .rs 1
FLAG_IRQ_ENABLE:                              .rs 1


          .rsset 0x0060
60_PLAYER_UNK:                                .rs 1
R_**:$0061:                                   .rs 1


          .rsset 0x0072
72_STREAM_PTR_UNK:                            .rs 2
74_STREAM_UNK_A:                              .rs 1
75_STREAM_UNK_B:                              .rs 1
76_UNK:                                       .rs 1
77_UNK:                                       .rs 1
PLAYER?_UNK:                                  .rs 2


          .rsset 0x007B
7B_UNK:                                       .rs 1
7C_UNK:                                       .rs 1
FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE:        .rs 1
7E_STREAM_UNK:                                .rs 1
7F_OBJ_SPECIAL_INDEX?:                        .rs 1
80_UNK:                                       .rs 1
81_UNK:                                       .rs 1
82_UNK:                                       .rs 1
83_UNK:                                       .rs 1
84_UNK:                                       .rs 1
85_PLAYER_UNK?:                               .rs 2
87_UNK:                                       .rs 1
88_UNK_SWITCH?:                               .rs 1


          .rsset 0x008A
R_**:$008A:                                   .rs 1
8B_UNK:                                       .rs 1
8C_UNK:                                       .rs 1
8D_UNK:                                       .rs 1
8E_UNK:                                       .rs 1
8F_ARR_UNK:                                   .rs 2
PLAYERS_UNK:                                  .rs 2
93_PLAYER_UNK:                                .rs 2
95_UNK:                                       .rs 1
96_UNK:                                       .rs 1
97_COPY_607:                                  .rs 1
98_UNK:                                       .rs 1
99_UNK:                                       .rs 1
9A_UNK:                                       .rs 1
9B_UNK:                                       .rs 1
9C_UNK:                                       .rs 1
9D_UNK:                                       .rs 1
9E_UNK:                                       .rs 1
9F_UNK:                                       .rs 1
A0_PLAYER_UNK:                                .rs 2
A2_UNK:                                       .rs 1
A3_UNK:                                       .rs 1


          .rsset 0x00A5
A5_UNK:                                       .rs 1
IRQ_FLAG_R2-R5_BANK_7E:                       .rs 1
A7_IRQ_REPLACE_SECONDARY_INDEX:               .rs 1
FILE_PLAYER_OBJ_USE_B:                        .rs 2
FILE_PLAYER_OBJ_USE_A:                        .rs 2


          .rsset 0x00AD
R_**:$00AD:                                   .rs 1
AE_ARR_UNK:                                   .rs 2
B0_UNK:                                       .rs 1
B1_SCROLL_X_COPY_IRQ_ZP:                      .rs 2
B3_SCROLL_X_IRQ_J:                            .rs 1
NAMETABLE_FOCUS_VAL?:                         .rs 2
B6_NAMETABLE_FOCUS_UNK:                       .rs 1
OBJ_POS_X_SUBPIXEL_DELTA?:                    .rs 1
B8_UNK:                                       .rs 1
B9_UNK:                                       .rs 1
OBJ_POS_X_DELTA?:                             .rs 1
BB_UNK:                                       .rs 1
BC_UNK:                                       .rs 1
BD_PLAYER?_UNK:                               .rs 2


          .rsset 0x00C0
C0_UNK:                                       .rs 1


          .rsset 0x00C3
C3_UNK:                                       .rs 1
C4_UNK:                                       .rs 1
C5_UNK:                                       .rs 1
C6_SPR_ARR_UNK:                               .rs 2


          .rsset 0x00C9
C9_UNK:                                       .rs 1


          .rsset 0x00D8
D8_IRQ_CONFIG_B:                              .rs 1
D9_IRQ_CONFIG_A:                              .rs 1
DA_FLAG?_UNK:                                 .rs 1
R_**:$00DB:                                   .rs 1
DC_UNK:                                       .rs 1
R_**:$00DD:                                   .rs 1
DE_FLAG_PALETTE_UNK:                          .rs 1
DF_UNK:                                       .rs 1
R_**:$00E0:                                   .rs 1
R_**:$00E1:                                   .rs 1
ZL_E2_SOUND_UNK:                              .rs 1
R_**:$00E3:                                   .rs 1
R_**:$00E4:                                   .rs 1
R_**:$00E5:                                   .rs 1
R_**:$00E6:                                   .rs 1
R_**:$00E7:                                   .rs 1
R_**:$00E8:                                   .rs 1
R_**:$00E9:                                   .rs 1
R_**:$00EA:                                   .rs 1


          .rsset 0x00EC
R_**:$00EC:                                   .rs 1
R_**:$00ED:                                   .rs 1
R_**:$00EE:                                   .rs 1
R_**:$00EF:                                   .rs 1
F0_UNK:                                       .rs 1


          .rsset 0x00F5
COPY_BANK_CFG_F5:                             .rs 1
COPY_BANK_CFG:                                .rs 1
MMC3_MIRRORING_COPY:                          .rs 1
CTRL_NEWLY_PRESSED_B:                         .rs 2
CTRL_PREV_B:                                  .rs 2
PPU_SCROLL_Y_COPY_IRQ:                        .rs 1
PPU_SCROLL_X_COPY_IRQ:                        .rs 1
PPU_MASK_RAM_COPY:                            .rs 1
PPU_CTRL_RAM_COPY:                            .rs 1
R_**:$0100:                                   .rs 1


          .rsset 0x0104
R_**:$0104:                                   .rs 1


          .rsset 0x010A
10A_ARR_UNK:                                  .rs 1
R_**:$010B:                                   .rs 1


          .rsset 0x010D
R_**:$010D:                                   .rs 1
R_**:$010E:                                   .rs 1
R_**:$010F:                                   .rs 1
R_**:$0110:                                   .rs 1


          .rsset 0x0116
R_**:$0116:                                   .rs 1


          .rsset 0x011A
R_**:$011A:                                   .rs 1


          .rsset 0x011C
R_**:$011C:                                   .rs 1


          .rsset 0x0122
R_**:$0122:                                   .rs 1


          .rsset 0x0128
R_**:$0128:                                   .rs 1


          .rsset 0x0146
R_**:$0146:                                   .rs 1


          .rsset 0x014C
R_**:$014C:                                   .rs 1


          .rsset 0x0152
R_**:$0152:                                   .rs 1


          .rsset 0x0158
R_**:$0158:                                   .rs 1


          .rsset 0x015A
R_**:$015A:                                   .rs 1
15B_SND?_UNK:                                 .rs 1


          .rsset 0x015E
R_**:$015E:                                   .rs 1


          .rsset 0x0161
161_SND?_UNK:                                 .rs 1


          .rsset 0x0163
R_**:$0163:                                   .rs 1


          .rsset 0x0166
166_SND?_UNK:                                 .rs 1


          .rsset 0x0177
R_**:$0177:                                   .rs 1


          .rsset 0x017B
R_**:$017B:                                   .rs 1


          .rsset 0x017F
R_**:$017F:                                   .rs 1


          .rsset 0x0182
R_**:$0182:                                   .rs 1


          .rsset 0x0185
R_**:$0185:                                   .rs 1


          .rsset 0x0188
R_**:$0188:                                   .rs 1


          .rsset 0x018A
R_**:$018A:                                   .rs 1


          .rsset 0x018C
R_**:$018C:                                   .rs 1


          .rsset 0x018E
R_**:$018E:                                   .rs 1


          .rsset 0x0190
R_**:$0190:                                   .rs 1


          .rsset 0x0192
R_**:$0192:                                   .rs 1


          .rsset 0x0196
R_**:$0196:                                   .rs 1


          .rsset 0x0198
R_**:$0198:                                   .rs 1


          .rsset 0x019A
R_**:$019A:                                   .rs 1


          .rsset 0x019E
R_**:$019E:                                   .rs 1


          .rsset 0x01A0
R_**:$01A0:                                   .rs 1


          .rsset 0x01A2
R_**:$01A2:                                   .rs 1


          .rsset 0x01A4
R_**:$01A4:                                   .rs 1


          .rsset 0x01A6
R_**:$01A6:                                   .rs 1


          .rsset 0x01A8
R_**:$01A8:                                   .rs 1


          .rsset 0x01AA
R_**:$01AA:                                   .rs 1


          .rsset 0x01AC
R_**:$01AC:                                   .rs 1


          .rsset 0x01AE
R_**:$01AE:                                   .rs 1


          .rsset 0x01B0
R_**:$01B0:                                   .rs 1


          .rsset 0x01B2
R_**:$01B2:                                   .rs 1
R_**:$01B3:                                   .rs 1
1B4_SOUND_TRI_ZERO_FLAG:                      .rs 1


          .rsset 0x0200
SPRITE_PAGE:                                  .rs 256
PPU_UPDATE_BUFFER:                            .rs 20
R_**:$0314:                                   .rs 1
R_**:$0315:                                   .rs 1
R_**:$0316:                                   .rs 1
R_**:$0317:                                   .rs 1
R_**:$0318:                                   .rs 1


          .rsset 0x03C0
R_**:$03C0:                                   .rs 1


          .rsset 0x03C8
R_**:$03C8:                                   .rs 1


          .rsset 0x03D3
CONTINUES_LEFT:                               .rs 1
PSWAP_INDEX?:                                 .rs 1
3D5_UNK:                                      .rs 1
PALETTE_SWAP_QUEUEING_IN_PROGRESS:            .rs 1
3D7_PSWAP_COUNTDOWN:                          .rs 1
3D8_UNK:                                      .rs 1
3D9_UNK:                                      .rs 1
3DA_PSWAP_COUNTDOWN_VAL:                      .rs 1
3DB_UNKNOWN:                                  .rs 1


          .rsset 0x03E3
LOW_BANK_DATA:                                .rs 1
UPPER_BANK_DATA:                              .rs 1
SOUND_VALUE:                                  .rs 1


          .rsset 0x03E7
ATTRACT_INJECT_TIMER:                         .rs 1
ATTRACT_CTRL_DATA_PTR:                        .rs 2
3EA_PLAYER?_UNK:                              .rs 2
KONAMI_CODE_TRACKERS?:                        .rs 3
3EF_UNK:                                      .rs 1
SCORES_BCD_0000XX:                            .rs 1
SCORES_BCD_00XX00:                            .rs 1
SCORES_BCD_XX0000:                            .rs 1


          .rsset 0x03F6
3F6_PLAYER_SCORE_ADD_VALUE:                   .rs 2


          .rsset 0x0400
OBJ_ANIMATION_DISPLAY:                        .rs 18
OBJ_SECONDARY_SWITCH?:                        .rs 18
OBJ_ENABLED_STATE+MORE?:                      .rs 18
OBJ_DIRECTION_RELATED?:                       .rs 18
OBJ_ANIM_HOLD_TIMER?:                         .rs 18
45A_OBJ_DATA_ENTRY?STATE_STEP?:               .rs 18
OBJ_POS_Y:                                    .rs 18
OBJ_POS_X?:                                   .rs 18
OBJ_POS_X_SUBPIXEL?:                          .rs 18
4A2_OBJ_UNK_POS?:                             .rs 18
4B4_OBJ_SPEED?:                               .rs 18
4C6_OBJ_UNK:                                  .rs 18
4D8_OBJ_UNK:                                  .rs 18
OBJ_POS_X_DELTA?:                             .rs 18
OBJ_POS_X_SUBPIXEL_DELTA?:                    .rs 18
503_OBJ_POS_X_LARGEST?:                       .rs 18
520_OBJ_POS_X_LARGE?:                         .rs 18
532_OBJ_UNK_POS_DELTA?:                       .rs 18
544_OBJ_UNK_POS_DELTA?:                       .rs 18
556_OBJ_STATUS_FLAGS:                         .rs 18
OBJECT_DATA_HEALTH?:                          .rs 18
OBJECT_DATA_EXTRA_B?:                         .rs 18
OBJ_TERTIARY_SWITCH?:                         .rs 18
59E_OBJ_UNK/EXTRA_TIMER:                      .rs 18
5B0_OBJ_UNK:                                  .rs 18
5C2_OBJ_DATA_PTR/MISC_INDEX:                  .rs 18
5D4_EXTRA_TIMER/OBJ/FOCUS:                    .rs 18


          .rsset 0x05EE
5EE_UNK:                                      .rs 1
5EF_UNK:                                      .rs 1
5F0_UNK:                                      .rs 1
5F1_UNK:                                      .rs 1
5F2_UNK:                                      .rs 1
5F3_UNK:                                      .rs 1


          .rsset 0x05F5
5F5_UNK:                                      .rs 1


          .rsset 0x05F7
5F7_UNK:                                      .rs 1
5F8_UNK:                                      .rs 1
ZP_13_INDEX_VAL_UNK:                          .rs 1
5FA_UNK:                                      .rs 1
5FB_TIMER_ALL_FINISHED?:                      .rs 1
R_**:$05FC:                                   .rs 1
5FD_UNK:                                      .rs 1
R_**:$05FE:                                   .rs 1


          .rsset 0x0600
600_UNK_INDEX:                                .rs 1
601_IRQ_FLAG_DELAY_MOD_+:                     .rs 1
602_COUNTER?_UNK:                             .rs 1
603_unk:                                      .rs 1
604_UNK:                                      .rs 1
605_UNK:                                      .rs 1
606_NMI_SWITCH_STATE_UNK:                     .rs 1
607_UNK:                                      .rs 1
608_UNK:                                      .rs 1
609_UNK:                                      .rs 1
60A_SWITCH_WHICH?:                            .rs 1
60B_STREAM_INDEX_UNK:                         .rs 1
60C_UNK_INDEX:                                .rs 1
R2_TO_R5_BANK_DATA:                           .rs 4
611_SWITCH_UNK:                               .rs 1
612_STEP?_UNK:                                .rs 1


          .rsset 0x0615
STATE_TURTLE_SELECT:                          .rs 1
PPU_FLAG_UNK_MODIFY_LATCH_UNK:                .rs 1


          .rsset 0x0618
PLAYER_ANIM_FRAME_SWAP?:                      .rs 2
61A_UNK_INDEX:                                .rs 1
61B_UPDATE_FROM_RAM/PALETTE/DEV_MISC:         .rs 1
61C_UNK:                                      .rs 1


          .rsset 0x0628
628_UNK:                                      .rs 1


          .rsset 0x0634
634_UNK_INDEX:                                .rs 1
635_UNK_INDEX?:                               .rs 1
636_UNK:                                      .rs 1
637_UNK:                                      .rs 1
638_UNK:                                      .rs 1
639_SWITCH_EOL_SCRIPT?:                       .rs 1
TIMER_GAME_SCRIPT?:                           .rs 1
63B_TEXT_FADE_OUT_DONE?:                      .rs 1


          .rsset 0x063E
63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG?:       .rs 1


          .rsset 0x0640
FLAG_WEIRD_UPDATES_A:                         .rs 1
PPU_ADDR_UNK_A:                               .rs 2
PPU_ADDR_OR_A:                                .rs 1
PPU_ADDR_UNK_B:                               .rs 2
PPU_ADDR_OR_B:                                .rs 1
FLAG_WEIRD_UPDATES_B:                         .rs 1
PPU_ADDR_UNK_C:                               .rs 2
PPU_ADDR_OR_C:                                .rs 1
PPU_ADDR_UNK_D:                               .rs 2
PPU_ADDR_OR_D:                                .rs 1
FLAG?_PPU_UPDATE_WEIRD_CLEARS:                .rs 1


          .rsset 0x0654
654_UPDATE_UNK_FLAG:                          .rs 1
CONTINUE_OPTION_ON:                           .rs 1
656_ARR_AE_COPY_UNK:                          .rs 2


          .rsset 0x0659
PPU_SCROLL_X_COPY_IRQ:                        .rs 1
IRQ_L_SCROLL_X:                               .rs 1


          .rsset 0x065C
NAMETABLE_VAR_UNK:                            .rs 1
IRQ_L_NAMETABLE_FOCUS:                        .rs 1


          .rsset 0x065F
IRQ_CONFIG_CHANGE_INDEX:                      .rs 1
660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK:            .rs 1
661_UNK_LEVEL_A_SETS:                         .rs 1
662_PLAYER_UPDATE_UNK:                        .rs 2


          .rsset 0x066D
66D_LEVEL_SELECT_WHICH:                       .rs 1


          .rsset 0x0670
670_UNK:                                      .rs 1


          .rsset 0x0674
674_UNK:                                      .rs 1


          .rsset 0x0678
678_UNK:                                      .rs 1 ; 678_UNK


          .rsset 0x067C
67C_UNK:                                      .rs 1


          .rsset 0x0680
680_UNK:                                      .rs 1


          .rsset 0x0684
684_UNK:                                      .rs 1


          .rsset 0x0688
688_UNK:                                      .rs 1


          .rsset 0x068C
68C_UNK:                                      .rs 1


          .rsset 0x0694
694_OBJ/PLAYER_UNK?:                          .rs 4
PLAYER_UNK_698:                               .rs 4
PLAYER_UNK_69C:                               .rs 4


          .rsset 0x06A8
6A8_COPIED_TO_PLAYERS_UNK:                    .rs 2


          .rsset 0x06D6
6D6_OBJ_UNK:                                  .rs 1
ARR_RAM_CUSTOM_PACKET_61B_FLAG:               .rs 40


          .rsset 0x06D9
PPU_PALETTE_BUF?:                             .rs 32


          .rsset 0x0700
OBJ_HANDLER_FOCUS_SCRATCHPAD:                 .rs 1
701_TSELECT_CONFIRMED/TIMER:                  .rs 1
ARR_SPRITE_OBJ_TIMER?:                        .rs 2
704_OBJ_USE_UNK:                              .rs 1
705_UNK:                                      .rs 1
706_UNK:                                      .rs 1
707_UNK:                                      .rs 1
708_UNK:                                      .rs 1
709_UNK:                                      .rs 1


          .rsset 0x070C
70C_UNK:                                      .rs 1


          .rsset 0x070E
70E_OBJ_UNK:                                  .rs 1
R_**:$070F:                                   .rs 1
710_UNK:                                      .rs 1


          .rsset 0x0712
712_FLAG_PALETTE_UNK:                         .rs 1


          .rsset 0x0714
714_UNK:                                      .rs 1
A/B_WHICH_RESULT:                             .rs 1
716_UNK:                                      .rs 1
717_OBJ_INDEX_A_UNK:                          .rs 1
718_OBJ_INDEX_B_UNK:                          .rs 1
719_OBJ_CMP_UNK:                              .rs 1


          .rsset 0x071C
71C_ARR_UNK:                                  .rs 2 ; Unsure of size.


          .rsset 0x072E
72E_ARR_UNK:                                  .rs 1


          .rsset 0x0740
740_UNK:                                      .rs 1


          .rsset 0x074F
R_**:$074F:                                   .rs 1
R_**:$0750:                                   .rs 1


          .rsset 0x075F
R_**:$075F:                                   .rs 1


          .rsset 0x0770
R_**:$0770:                                   .rs 1


          .rsset 0x0780
R_**:$0780:                                   .rs 1


          .rsset 0x6C22
R_**:$6C22:                                   .rs 1


          .rsset 0x6F6E
R_**:$6F6E:                                   .rs 1


          .rsset 0x7384
R_**:$7384:                                   .rs 1


          .rsset 0x7CA5
R_**:$7CA5:                                   .rs 1

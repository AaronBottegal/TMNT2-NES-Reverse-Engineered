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
TMP_00:                                       .rs 1 ; 0x0000
TMP_01:                                       .rs 1 ; 0x0001
TMP_02:                                       .rs 1 ; 0x0002
TMP_03:                                       .rs 1 ; 0x0003
TMP_04:                                       .rs 1 ; 0x0004
TMP_05:                                       .rs 1 ; 0x0005
TMP_06:                                       .rs 1 ; 0x0006
TMP_07:                                       .rs 1 ; 0x0007
TMP_08:                                       .rs 1 ; 0x0008
TMP_09:                                       .rs 1 ; 0x0009
TMP_0A:                                       .rs 1 ; 0x000A
TMP_0B:                                       .rs 1 ; 0x000B
TMP_0C:                                       .rs 1 ; 0x000C
TMP_0D:                                       .rs 1 ; 0x000D
TMP_0E:                                       .rs 1 ; 0x000E
TMP_0F:                                       .rs 1 ; 0x000F
TMP_10:                                       .rs 1 ; 0x0010
TMP_11:                                       .rs 1 ; 0x0011
TMP_12:                                       .rs 1 ; 0x0012
TMP_13:                                       .rs 1 ; 0x0013
TMP_14:                                       .rs 1 ; 0x0014
TMP_15:                                       .rs 1 ; 0x0015
TMP_16:                                       .rs 1 ; 0x0016
TMP_17:                                       .rs 1 ; 0x0017
STATE_SWITCH_INITIAL_MENUS:                   .rs 1 ; 0x0018
SUBSTATE_SWITCH_MENUS:                        .rs 1 ; 0x0019


          .rsset 0x001B
IRQ/SCRIPT_RUN_COUNT?:                        .rs 1 ; 0x001B
FLAG_GAME_SCREEN_UNFINISHED:                  .rs 1 ; 0x001C
DISABLE_RENDERING_X_FRAMES:                   .rs 1 ; 0x001D
PPU_UPDATE_BUF_INDEX:                         .rs 1 ; 0x001E
GAME_STARTED:                                 .rs 1 ; 0x001F
TWO_PLAYERS_FLAG:                             .rs 1 ; 0x0020
TITLE_PLAYERS_COUNT_CURSOR_0/1:               .rs 1 ; 0x0021
INF_LOOP_COUNTER:                             .rs 1 ; 0x0022
RANDOM_VALS?:                                 .rs 2 ; 0x0023 to 0x0024
KONAMI_CODE_TRIGGERED_FLAG?:                  .rs 1 ; 0x0025


          .rsset 0x0027
ATTRACT_LEVEL:                                .rs 1 ; 0x0027
28_BANK_CFG_INDEX?:                           .rs 1 ; 0x0028
LOWER_BANK_SAVE_PAIRED?:                      .rs 1 ; 0x0029
IRQ_BANK_VALUES_R[0/1]:                       .rs 2 ; 0x002A to 0x002B


          .rsset 0x002D
IRQ_GFX_DATA_BANK_R0:                         .rs 1 ; 0x002D
IRQ_GFX_DATA_BANK_R1:                         .rs 1 ; 0x002E
ZP_R2-R5_BANK_VALUES:                         .rs 4 ; 0x002F to 0x0032
TURTLE_SELECTION:                             .rs 2 ; 0x0033 to 0x0034


          .rsset 0x0038
CTRL_NEWLY_PRESSED_A:                         .rs 2 ; 0x0038 to 0x0039
CTRL_PREV_A:                                  .rs 2 ; 0x003A to 0x003B
3C_SWITCH_CORE:                               .rs 1 ; 0x003C
3D_UNK:                                       .rs 1 ; 0x003D
3E_UNK:                                       .rs 1 ; 0x003E
3F_ATTRACT_EXIT_FLAG:                         .rs 1 ; 0x003F
40_TIMER?:                                    .rs 2 ; 0x0040 to 0x0041
LEVEL/SCREEN_ON:                              .rs 1 ; 0x0042
43_PLAYER_UNK:                                .rs 2 ; 0x0043 to 0x0044
45_UNK:                                       .rs 1 ; 0x0045


          .rsset 0x0047
TWO_PLAYERS_FLAG:                             .rs 1 ; 0x0047
PPU_ADDR_IRQ:                                 .rs 2 ; 0x0048 to 0x0049
4A_UNK:                                       .rs 1 ; 0x004A
4B_SWITCH_GAME_PREP/OVER:                     .rs 1 ; 0x004B
4C_UNK:                                       .rs 1 ; 0x004C
NUM_PLAYER_LIVES:                             .rs 2 ; 0x004D to 0x004E


          .rsset 0x0050
IRQ_HANDLER_JMP:                              .rs 3 ; 0x0050 to 0x0052


          .rsset 0x0056
IRQ_56_OR'D:                                  .rs 1 ; 0x0056
57_IRQ_LATCH_VAL_COPY:                        .rs 1 ; 0x0057
58_IRQ_UNK:                                   .rs 1 ; 0x0058


          .rsset 0x005A
IRQ_LATCH_VALUE_COPY_5A:                      .rs 1 ; 0x005A


          .rsset 0x005C
IRQ_EXTENDED/HANDLER/SECONDARY:               .rs 1 ; 0x005C
5D_IRQ_BANK?:                                 .rs 1 ; 0x005D
FLAG_IRQ_ENABLE:                              .rs 1 ; 0x005E


          .rsset 0x0060
60_PLAYER_UNK:                                .rs 1 ; 0x0060
R_**:$0061:                                   .rs 1 ; 0x0061


          .rsset 0x0072
72_STREAM_PTR_UNK:                            .rs 2 ; 0x0072 to 0x0073
74_STREAM_UNK_A:                              .rs 1 ; 0x0074
75_STREAM_UNK_B:                              .rs 1 ; 0x0075
76_UNK:                                       .rs 1 ; 0x0076
77_UNK:                                       .rs 1 ; 0x0077
PLAYER?_UNK:                                  .rs 2 ; 0x0078 to 0x0079


          .rsset 0x007B
7B_UNK:                                       .rs 1 ; 0x007B
7C_UNK:                                       .rs 1 ; 0x007C
FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE:        .rs 1 ; 0x007D
7E_STREAM_UNK:                                .rs 1 ; 0x007E
7F_OBJ_SPECIAL_INDEX?:                        .rs 1 ; 0x007F
80_UNK:                                       .rs 1 ; 0x0080
81_UNK:                                       .rs 1 ; 0x0081
82_UNK:                                       .rs 1 ; 0x0082
83_UNK:                                       .rs 1 ; 0x0083
84_UNK:                                       .rs 1 ; 0x0084
85_PLAYER_UNK?:                               .rs 2 ; 0x0085 to 0x0086
87_CB_INDEX?:                                 .rs 1 ; 0x0087
88_UNK_SWITCH?:                               .rs 1 ; 0x0088


          .rsset 0x008A
FLAG_8A_UNK_ROCKSTEADY?:                      .rs 1 ; 0x008A
8B_BOSS?_UNK:                                 .rs 1 ; 0x008B
8C_UNK:                                       .rs 1 ; 0x008C
8D_UNK:                                       .rs 1 ; 0x008D
8E_UNK:                                       .rs 1 ; 0x008E
8F_ARR_UNK:                                   .rs 2 ; 0x008F to 0x0090
PLAYERS_UNK:                                  .rs 2 ; 0x0091 to 0x0092
93_PLAYER_UNK:                                .rs 2 ; 0x0093 to 0x0094
95_UNK:                                       .rs 1 ; 0x0095
96_UNK:                                       .rs 1 ; 0x0096
97_COPY_607:                                  .rs 1 ; 0x0097
98_UNK:                                       .rs 1 ; 0x0098
99_UNK:                                       .rs 1 ; 0x0099
9A_UNK:                                       .rs 1 ; 0x009A
9B_UNK:                                       .rs 1 ; 0x009B
9C_UNK:                                       .rs 1 ; 0x009C
9D_UNK:                                       .rs 1 ; 0x009D
9E_UNK:                                       .rs 1 ; 0x009E
9F_UNK:                                       .rs 1 ; 0x009F
A0_PLAYER_UNK:                                .rs 2 ; 0x00A0 to 0x00A1
A2_UNK:                                       .rs 1 ; 0x00A2
A3_UNK:                                       .rs 1 ; 0x00A3


          .rsset 0x00A5
A5_UNK:                                       .rs 1 ; 0x00A5
IRQ_FLAG_R2-R5_BANK_7E:                       .rs 1 ; 0x00A6
A7_IRQ_REPLACE_SECONDARY_INDEX:               .rs 1 ; 0x00A7
FILE_PLAYER_OBJ_USE_B:                        .rs 2 ; 0x00A8 to 0x00A9
FILE_PLAYER_OBJ_USE_A:                        .rs 2 ; 0x00AA to 0x00AB


          .rsset 0x00AD
R_**:$00AD:                                   .rs 1 ; 0x00AD
AE_ARR_UNK:                                   .rs 2 ; 0x00AE to 0x00AF
B0_UNK:                                       .rs 1 ; 0x00B0
B1_SCROLL_X_COPY_IRQ_ZP:                      .rs 2 ; 0x00B1 to 0x00B2
B3_SCROLL_X_IRQ_J:                            .rs 1 ; 0x00B3
NAMETABLE_FOCUS_VAL?:                         .rs 2 ; 0x00B4 to 0x00B5
B6_NAMETABLE_FOCUS_UNK:                       .rs 1 ; 0x00B6
OBJ_POS_X_SUBPIXEL_DELTA?:                    .rs 1 ; 0x00B7
B8_UNK:                                       .rs 1 ; 0x00B8
B9_UNK:                                       .rs 1 ; 0x00B9
OBJ_POS_X_DELTA?:                             .rs 1 ; 0x00BA
BB_UNK:                                       .rs 1 ; 0x00BB
BC_UNK:                                       .rs 1 ; 0x00BC
BD_PLAYER?_UNK:                               .rs 2 ; 0x00BD to 0x00BE


          .rsset 0x00C0
C0_UNK:                                       .rs 1 ; 0x00C0


          .rsset 0x00C3
C3_UNK:                                       .rs 1 ; 0x00C3
C4_UNK:                                       .rs 1 ; 0x00C4
C5_UNK:                                       .rs 1 ; 0x00C5
C6_SPR_ARR_UNK:                               .rs 2 ; 0x00C6 to 0x00C7


          .rsset 0x00C9
C9_UNK:                                       .rs 1 ; 0x00C9


          .rsset 0x00D8
D8_IRQ_CONFIG_B:                              .rs 1 ; 0x00D8
D9_IRQ_CONFIG_A:                              .rs 1 ; 0x00D9
DA_FLAG?_UNK:                                 .rs 1 ; 0x00DA
R_**:$00DB:                                   .rs 1 ; 0x00DB
DC_UNK:                                       .rs 1 ; 0x00DC
DD_UNK:                                       .rs 1 ; 0x00DD
DE_FLAG_PALETTE_UNK:                          .rs 1 ; 0x00DE
DF_UNK:                                       .rs 1 ; 0x00DF
R_**:$00E0:                                   .rs 1 ; 0x00E0
R_**:$00E1:                                   .rs 1 ; 0x00E1
ZL_E2_SOUND_UNK:                              .rs 1 ; 0x00E2
R_**:$00E3:                                   .rs 1 ; 0x00E3
R_**:$00E4:                                   .rs 1 ; 0x00E4
R_**:$00E5:                                   .rs 1 ; 0x00E5
R_**:$00E6:                                   .rs 1 ; 0x00E6
R_**:$00E7:                                   .rs 1 ; 0x00E7
R_**:$00E8:                                   .rs 1 ; 0x00E8
R_**:$00E9:                                   .rs 1 ; 0x00E9
R_**:$00EA:                                   .rs 1 ; 0x00EA


          .rsset 0x00EC
R_**:$00EC:                                   .rs 1 ; 0x00EC
R_**:$00ED:                                   .rs 1 ; 0x00ED
R_**:$00EE:                                   .rs 1 ; 0x00EE
R_**:$00EF:                                   .rs 1 ; 0x00EF
F0_UNK:                                       .rs 1 ; 0x00F0


          .rsset 0x00F5
COPY_BANK_CFG_F5:                             .rs 1 ; 0x00F5
COPY_BANK_CFG:                                .rs 1 ; 0x00F6
MMC3_MIRRORING_COPY:                          .rs 1 ; 0x00F7
CTRL_NEWLY_PRESSED_B:                         .rs 2 ; 0x00F8 to 0x00F9
CTRL_PREV_B:                                  .rs 2 ; 0x00FA to 0x00FB
PPU_SCROLL_Y_COPY_IRQ:                        .rs 1 ; 0x00FC
PPU_SCROLL_X_COPY_IRQ:                        .rs 1 ; 0x00FD
PPU_MASK_RAM_COPY:                            .rs 1 ; 0x00FE
PPU_CTRL_RAM_COPY:                            .rs 1 ; 0x00FF
R_**:$0100:                                   .rs 1 ; 0x0100


          .rsset 0x0104
R_**:$0104:                                   .rs 1 ; 0x0104


          .rsset 0x010A
10A_ARR_UNK:                                  .rs 1 ; 0x010A
R_**:$010B:                                   .rs 1 ; 0x010B


          .rsset 0x010D
R_**:$010D:                                   .rs 1 ; 0x010D
R_**:$010E:                                   .rs 1 ; 0x010E
R_**:$010F:                                   .rs 1 ; 0x010F
R_**:$0110:                                   .rs 1 ; 0x0110


          .rsset 0x0116
R_**:$0116:                                   .rs 1 ; 0x0116


          .rsset 0x011A
R_**:$011A:                                   .rs 1 ; 0x011A


          .rsset 0x011C
R_**:$011C:                                   .rs 1 ; 0x011C


          .rsset 0x0122
R_**:$0122:                                   .rs 1 ; 0x0122


          .rsset 0x0128
R_**:$0128:                                   .rs 1 ; 0x0128


          .rsset 0x0146
R_**:$0146:                                   .rs 1 ; 0x0146


          .rsset 0x014C
R_**:$014C:                                   .rs 1 ; 0x014C


          .rsset 0x0152
R_**:$0152:                                   .rs 1 ; 0x0152


          .rsset 0x0158
R_**:$0158:                                   .rs 1 ; 0x0158


          .rsset 0x015A
R_**:$015A:                                   .rs 1 ; 0x015A
15B_SND?_UNK:                                 .rs 1 ; 0x015B


          .rsset 0x015E
R_**:$015E:                                   .rs 1 ; 0x015E


          .rsset 0x0161
161_SND?_UNK:                                 .rs 1 ; 0x0161


          .rsset 0x0163
R_**:$0163:                                   .rs 1 ; 0x0163


          .rsset 0x0166
166_SND?_UNK:                                 .rs 1 ; 0x0166


          .rsset 0x0177
R_**:$0177:                                   .rs 1 ; 0x0177


          .rsset 0x017B
R_**:$017B:                                   .rs 1 ; 0x017B


          .rsset 0x017F
R_**:$017F:                                   .rs 1 ; 0x017F


          .rsset 0x0182
R_**:$0182:                                   .rs 1 ; 0x0182


          .rsset 0x0185
R_**:$0185:                                   .rs 1 ; 0x0185


          .rsset 0x0188
R_**:$0188:                                   .rs 1 ; 0x0188


          .rsset 0x018A
R_**:$018A:                                   .rs 1 ; 0x018A


          .rsset 0x018C
R_**:$018C:                                   .rs 1 ; 0x018C


          .rsset 0x018E
R_**:$018E:                                   .rs 1 ; 0x018E


          .rsset 0x0190
R_**:$0190:                                   .rs 1 ; 0x0190


          .rsset 0x0192
R_**:$0192:                                   .rs 1 ; 0x0192


          .rsset 0x0196
R_**:$0196:                                   .rs 1 ; 0x0196


          .rsset 0x0198
R_**:$0198:                                   .rs 1 ; 0x0198


          .rsset 0x019A
R_**:$019A:                                   .rs 1 ; 0x019A


          .rsset 0x019E
R_**:$019E:                                   .rs 1 ; 0x019E


          .rsset 0x01A0
R_**:$01A0:                                   .rs 1 ; 0x01A0


          .rsset 0x01A2
R_**:$01A2:                                   .rs 1 ; 0x01A2


          .rsset 0x01A4
R_**:$01A4:                                   .rs 1 ; 0x01A4


          .rsset 0x01A6
R_**:$01A6:                                   .rs 1 ; 0x01A6


          .rsset 0x01A8
R_**:$01A8:                                   .rs 1 ; 0x01A8


          .rsset 0x01AA
R_**:$01AA:                                   .rs 1 ; 0x01AA


          .rsset 0x01AC
R_**:$01AC:                                   .rs 1 ; 0x01AC


          .rsset 0x01AE
R_**:$01AE:                                   .rs 1 ; 0x01AE


          .rsset 0x01B0
R_**:$01B0:                                   .rs 1 ; 0x01B0


          .rsset 0x01B2
R_**:$01B2:                                   .rs 1 ; 0x01B2
R_**:$01B3:                                   .rs 1 ; 0x01B3
1B4_SOUND_TRI_ZERO_FLAG:                      .rs 1 ; 0x01B4


          .rsset 0x0200
SPRITE_PAGE:                                  .rs 256 ; 0x0200 to 0x02FF
PPU_UPDATE_BUFFER:                            .rs 20 ; 0x0300 to 0x0313
R_**:$0314:                                   .rs 1 ; 0x0314
R_**:$0315:                                   .rs 1 ; 0x0315
R_**:$0316:                                   .rs 1 ; 0x0316
R_**:$0317:                                   .rs 1 ; 0x0317
R_**:$0318:                                   .rs 1 ; 0x0318


          .rsset 0x03C0
R_**:$03C0:                                   .rs 1 ; 0x03C0


          .rsset 0x03C8
R_**:$03C8:                                   .rs 1 ; 0x03C8


          .rsset 0x03D3
CONTINUES_LEFT:                               .rs 1 ; 0x03D3
PSWAP_INDEX?:                                 .rs 1 ; 0x03D4
3D5_UNK:                                      .rs 1 ; 0x03D5
PALETTE_SWAP_QUEUEING_IN_PROGRESS:            .rs 1 ; 0x03D6
3D7_PSWAP_COUNTDOWN:                          .rs 1 ; 0x03D7
3D8_UNK:                                      .rs 1 ; 0x03D8
3D9_UNK:                                      .rs 1 ; 0x03D9
3DA_PSWAP_COUNTDOWN_VAL:                      .rs 1 ; 0x03DA
3DB_UNKNOWN:                                  .rs 1 ; 0x03DB


          .rsset 0x03E3
LOW_BANK_DATA:                                .rs 1 ; 0x03E3
UPPER_BANK_DATA:                              .rs 1 ; 0x03E4
SOUND_VALUE:                                  .rs 1 ; 0x03E5


          .rsset 0x03E7
ATTRACT_INJECT_TIMER:                         .rs 1 ; 0x03E7
ATTRACT_CTRL_DATA_PTR:                        .rs 2 ; 0x03E8 to 0x03E9
3EA_PLAYER?_UNK:                              .rs 2 ; 0x03EA to 0x03EB
KONAMI_CODE_TRACKERS?:                        .rs 3 ; 0x03EC to 0x03EE
3EF_UNK:                                      .rs 1 ; 0x03EF
SCORES_BCD_0000XX:                            .rs 1 ; 0x03F0
SCORES_BCD_00XX00:                            .rs 1 ; 0x03F1
SCORES_BCD_XX0000:                            .rs 1 ; 0x03F2


          .rsset 0x03F6
3F6_PLAYER_SCORE_ADD_VALUE:                   .rs 2 ; 0x03F6 to 0x03F7


          .rsset 0x0400
OBJ_ANIMATION_DISPLAY:                        .rs 18 ; 0x0400 to 0x0411
OBJ_SECONDARY_SWITCH?:                        .rs 18 ; 0x0412 to 0x0423
OBJ_ENABLED_STATE+MORE?:                      .rs 18 ; 0x0424 to 0x0435
OBJ_STATE_DIR_RELATED_C_SPR_DATA?:            .rs 18 ; 0x0436 to 0x0447
OBJ_ANIM_HOLD_TIMER?:                         .rs 18 ; 0x0448 to 0x0459
45A_OBJ_DATA_ENTRY?STATE_STEP?:               .rs 18 ; 0x045A to 0x046B
OBJ_POS_Y??:                                  .rs 18 ; 0x046C to 0x047D
OBJ_POS_X?:                                   .rs 18 ; 0x047E to 0x048F
OBJ_POS_X_SUBPIXEL?:                          .rs 18 ; 0x0490 to 0x04A1
OBJ_POS_X??:                                  .rs 18 ; 0x04A2 to 0x04B3
4B4_OBJ_SPEED?:                               .rs 18 ; 0x04B4 to 0x04C5
4C6_OBJ_UNK:                                  .rs 18 ; 0x04C6 to 0x04D7
4D8_OBJ_UNK:                                  .rs 18 ; 0x04D8 to 0x04E9
OBJ_POS_X_DELTA?:                             .rs 18 ; 0x04EA to 0x04FB
OBJ_POS_X_SUBPIXEL_DELTA?:                    .rs 18 ; 0x04FC to 0x050D
503_OBJ_POS_X_LARGEST?:                       .rs 18 ; 0x050E to 0x051F
520_OBJ_POS_X_LARGE?:                         .rs 18 ; 0x0520 to 0x0531
532_OBJ_UNK_POS_DELTA?:                       .rs 18 ; 0x0532 to 0x0543
544_OBJ_UNK_POS_DELTA?:                       .rs 18 ; 0x0544 to 0x0555
556_OBJ_STATUS_FLAGS_A:                       .rs 18 ; 0x0556 to 0x0567
OBJECT_DATA_HEALTH?:                          .rs 18 ; 0x0568 to 0x0579
OBJECT_DATA_EXTRA_B?:                         .rs 18 ; 0x057A to 0x058B
OBJ_TERTIARY_SWITCH?:                         .rs 18 ; 0x058C to 0x059D
59E_OBJ_UNK/EXTRA_TIMER:                      .rs 18 ; 0x059E to 0x05AF
STATUS_FLAGS_B/OBJ_FOCUS:                     .rs 18 ; 0x05B0 to 0x05C1
5C2_OBJ_DATA_PTR/MISC_INDEX:                  .rs 18 ; 0x05C2 to 0x05D3
5D4_EXTRA_TIMER/OBJ/FOCUS:                    .rs 18 ; 0x05D4 to 0x05E5


          .rsset 0x05EE
5EE_UNK:                                      .rs 1 ; 0x05EE
5EF_UNK:                                      .rs 1 ; 0x05EF
5F0_UNK:                                      .rs 1 ; 0x05F0
5F1_UNK:                                      .rs 1 ; 0x05F1
5F2_UNK:                                      .rs 1 ; 0x05F2
5F3_UNK:                                      .rs 1 ; 0x05F3


          .rsset 0x05F5
5F5_UNK:                                      .rs 1 ; 0x05F5
5F6_UNK:                                      .rs 1 ; 0x05F6
5F7_UNK:                                      .rs 1 ; 0x05F7
5F8_OBJ_SETS_UNK:                             .rs 1 ; 0x05F8
ZP_13_INDEX_VAL_UNK:                          .rs 1 ; 0x05F9
5FA_UNK:                                      .rs 1 ; 0x05FA
5FB_TIMER_ALL_FINISHED?:                      .rs 1 ; 0x05FB
R_**:$05FC:                                   .rs 1 ; 0x05FC
5FD_UNK:                                      .rs 1 ; 0x05FD
5FE_UNK:                                      .rs 1 ; 0x05FE


          .rsset 0x0600
600_UNK_INDEX:                                .rs 1 ; 0x0600
601_IRQ_FLAG_DELAY_MOD_+:                     .rs 1 ; 0x0601
602_COUNTER?_UNK:                             .rs 1 ; 0x0602
603_unk:                                      .rs 1 ; 0x0603
604_UNK:                                      .rs 1 ; 0x0604
605_UNK:                                      .rs 1 ; 0x0605
606_NMI_SWITCH_STATE_UNK:                     .rs 1 ; 0x0606
607_UNK:                                      .rs 1 ; 0x0607
608_UNK:                                      .rs 1 ; 0x0608
609_UNK:                                      .rs 1 ; 0x0609
60A_CB_SWITCH_WHICH?:                         .rs 1 ; 0x060A
60B_STREAM_INDEX_MAP?:                        .rs 1 ; 0x060B
60C_UNK_INDEX:                                .rs 1 ; 0x060C
R2_TO_R5_BANK_DATA:                           .rs 4 ; 0x060D to 0x0610
611_SWITCH_UNK:                               .rs 1 ; 0x0611
612_STEP?_UNK:                                .rs 1 ; 0x0612


          .rsset 0x0615
STATE_TURTLE_SELECT:                          .rs 1 ; 0x0615
PPU_FLAG_UNK_MODIFY_LATCH_UNK:                .rs 1 ; 0x0616


          .rsset 0x0618
PLAYER_ANIM_FRAME_SWAP?:                      .rs 2 ; 0x0618 to 0x0619
61A_UNK_INDEX:                                .rs 1 ; 0x061A
61B_UPDATE_FROM_RAM/PALETTE/DEV_MISC:         .rs 1 ; 0x061B
61C_UNK:                                      .rs 1 ; 0x061C


          .rsset 0x0628
628_UNK:                                      .rs 1 ; 0x0628


          .rsset 0x0634
634_UNK_INDEX:                                .rs 1 ; 0x0634
635_UNK_INDEX?:                               .rs 1 ; 0x0635
636_UNK:                                      .rs 1 ; 0x0636
637_UNK:                                      .rs 1 ; 0x0637
638_UNK:                                      .rs 1 ; 0x0638
639_SWITCH_EOL_SCRIPT?:                       .rs 1 ; 0x0639
TIMER_GAME_SCRIPT?:                           .rs 1 ; 0x063A
63B_TEXT_FADE_OUT_DONE?:                      .rs 1 ; 0x063B


          .rsset 0x063E
63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG?:       .rs 1 ; 0x063E


          .rsset 0x0640
FLAG_WEIRD_UPDATES_A:                         .rs 1 ; 0x0640
PPU_ADDR_UNK_A:                               .rs 2 ; 0x0641 to 0x0642
PPU_ADDR_OR_A:                                .rs 1 ; 0x0643
PPU_ADDR_UNK_B:                               .rs 2 ; 0x0644 to 0x0645
PPU_ADDR_OR_B:                                .rs 1 ; 0x0646
FLAG_WEIRD_UPDATES_B:                         .rs 1 ; 0x0647
PPU_ADDR_UNK_C:                               .rs 2 ; 0x0648 to 0x0649
PPU_ADDR_OR_C:                                .rs 1 ; 0x064A
PPU_ADDR_UNK_D:                               .rs 2 ; 0x064B to 0x064C
PPU_ADDR_OR_D:                                .rs 1 ; 0x064D
FLAG?_PPU_UPDATE_WEIRD_CLEARS:                .rs 1 ; 0x064E


          .rsset 0x0654
654_UPDATE_UNK_FLAG:                          .rs 1 ; 0x0654
CONTINUE_OPTION_ON:                           .rs 1 ; 0x0655
656_ARR_AE_COPY_UNK:                          .rs 2 ; 0x0656 to 0x0657


          .rsset 0x0659
PPU_SCROLL_X_COPY_IRQ:                        .rs 1 ; 0x0659
IRQ_L_SCROLL_X:                               .rs 1 ; 0x065A


          .rsset 0x065C
NAMETABLE_VAR_UNK:                            .rs 1 ; 0x065C
IRQ_L_NAMETABLE_FOCUS:                        .rs 1 ; 0x065D


          .rsset 0x065F
IRQ_CONFIG_CHANGE_INDEX:                      .rs 1 ; 0x065F
660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK:            .rs 1 ; 0x0660
661_UNK_LEVEL_A_SETS:                         .rs 1 ; 0x0661
662_PLAYER_UPDATE_UNK:                        .rs 2 ; 0x0662 to 0x0663


          .rsset 0x066D
66D_LEVEL_SELECT_WHICH:                       .rs 1 ; 0x066D


          .rsset 0x0670
670_MAP_DATA_A:                               .rs 1 ; 0x0670


          .rsset 0x0674
674_MAP_DATA_B:                               .rs 1 ; 0x0674


          .rsset 0x0678
678_MAP_DATA_C:                               .rs 1 ; 0x0678, 678_UNK


          .rsset 0x067C
67C_MAP_DATA_D:                               .rs 1 ; 0x067C


          .rsset 0x0680
680_MAP_DATA_E:                               .rs 1 ; 0x0680


          .rsset 0x0684
684_MAP_DATA_F:                               .rs 1 ; 0x0684


          .rsset 0x0688
688_MAP_DATA_G:                               .rs 1 ; 0x0688


          .rsset 0x068C
68C_MAP_DATA_H:                               .rs 1 ; 0x068C


          .rsset 0x0694
694_OBJ/PLAYER_UNK?:                          .rs 4 ; 0x0694 to 0x0697
PLAYER_UNK_698:                               .rs 4 ; 0x0698 to 0x069B
PLAYER_UNK_69C:                               .rs 4 ; 0x069C to 0x069F


          .rsset 0x06A8
6A8_COPIED_TO_PLAYERS_UNK:                    .rs 2 ; 0x06A8 to 0x06A9


          .rsset 0x06D6
6D6_OBJ_UNK:                                  .rs 1 ; 0x06D6
ARR_RAM_CUSTOM_PACKET_61B_FLAG:               .rs 40 ; 0x06D7 to 0x06FE


          .rsset 0x06D9
PPU_PALETTE_BUF?:                             .rs 32 ; 0x06D9 to 0x06F8


          .rsset 0x0700
OBJ_HANDLER_FOCUS_SCRATCHPAD:                 .rs 1 ; 0x0700
701_TSELECT_CONFIRMED/TIMER:                  .rs 1 ; 0x0701
ARR_SPRITE_OBJ_TIMER?:                        .rs 2 ; 0x0702 to 0x0703
704_OBJ_USE_UNK:                              .rs 1 ; 0x0704
705_UNK:                                      .rs 1 ; 0x0705
706_UNK:                                      .rs 1 ; 0x0706
707_SWITCHED_ON??:                            .rs 1 ; 0x0707
708_UNK:                                      .rs 1 ; 0x0708
709_UNK_CB_INDEX:                             .rs 1 ; 0x0709


          .rsset 0x070C
70C_UNK:                                      .rs 1 ; 0x070C
70D_UNK:                                      .rs 1 ; 0x070D
70E_OBJ_UNK:                                  .rs 1 ; 0x070E
R_**:$070F:                                   .rs 1 ; 0x070F
710_BOSS_WHICH_HIT?:                          .rs 1 ; 0x0710
711_UNK:                                      .rs 1 ; 0x0711
712_FLAG_PALETTE_UNK:                         .rs 1 ; 0x0712


          .rsset 0x0714
714_UNK:                                      .rs 1 ; 0x0714
A/B_WHICH_RESULT:                             .rs 1 ; 0x0715
716_UNK:                                      .rs 1 ; 0x0716
OBJ_INDEXES_GROUP_UNK:                        .rs 3 ; 0x0717 to 0x0719


          .rsset 0x071C
71C_ARR_UNK:                                  .rs 2 ; 0x071C to 0x071D, Unsure of size.


          .rsset 0x072E
72E_ARR_UNK:                                  .rs 1 ; 0x072E


          .rsset 0x0740
740_UNK:                                      .rs 1 ; 0x0740


          .rsset 0x074F
R_**:$074F:                                   .rs 1 ; 0x074F
R_**:$0750:                                   .rs 1 ; 0x0750


          .rsset 0x075F
R_**:$075F:                                   .rs 1 ; 0x075F


          .rsset 0x0770
R_**:$0770:                                   .rs 1 ; 0x0770


          .rsset 0x0780
R_**:$0780:                                   .rs 1 ; 0x0780


          .rsset 0x6C22
R_**:$6C22:                                   .rs 1


          .rsset 0x6F6E
R_**:$6F6E:                                   .rs 1


          .rsset 0x7384
R_**:$7384:                                   .rs 1


          .rsset 0x7CA5
R_**:$7CA5:                                   .rs 1

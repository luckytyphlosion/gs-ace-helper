wPartyCount EQU $da22
wBoxNames EQU $d8bf
OpenSRAM EQU $30e1
CloseSRAM EQU $30f1
jp_de EQU $30fd
CopyBytes EQU $311a
wOverworldMap EQU $c700
_ComposeMailMessage EQU $6242
wJumptableIndex EQU $ce63
wCurPartySpecies EQU $d004
wCurPartyMon EQU $d005
wCurPartyLevel EQU $d040
TryAddMonToPartyPredefID EQU $06
wPartyMon6ID EQU $db20
SentGetPkmnIntoFromBoxPredefID EQU $08
SFX_SAVE EQU $0025
PlaySFX EQU $3e24
Predef EQU $2e49
SaveGameData EQU $4ccc
wPokemonWithdrawDepositParameter EQU $d008
PC_DEPOSIT EQU $01
wMonType EQU $ce5f
wTileMap EQU $c3a0
PrintNum EQU $323d
ButtonSound EQU $0a60
PrintTextBoxText EQU $0f61
wc1d5 EQU $c1d5
YesNoBox EQU $1c41
PrintBCDNumber EQU $3ade
CopyName2 EQU $317e
wCmdQueue EQU $d405
hJoyDown EQU $ffa6
hJoyPressed EQU $ffa9
BICYCLE EQU $07
wCurItem EQU $d002
UseRegisteredItem_Party EQU $77c8
HMENURETURN_SCRIPT EQU %10000000
hMenuReturn EQU $ffa2
BicycleFunction EQU $50c0
wPartyMon6Exp EQU $db22
wTMsHMs EQU $d57e
wItems EQU $d5b8
wOptions EQU $d199
rSVBK EQU $ff70
DebugPrintHex EQU $33ce
wEventFlags EQU $d7b7
Checksum EQU $52e1
hROMBank EQU $ff9f
PrintText EQU $0f5e
wPartyMon6DVs EQU $db2f

PRINTNUM_MONEY_F        EQU 5
PRINTNUM_LEFTALIGN_F    EQU 6
PRINTNUM_LEADINGZEROS_F EQU 7

PRINTNUM_MONEY          EQU 1 << PRINTNUM_MONEY_F
PRINTNUM_LEFTALIGN      EQU 1 << PRINTNUM_LEFTALIGN_F
PRINTNUM_LEADINGZEROS   EQU 1 << PRINTNUM_LEADINGZEROS_F

SCREEN_WIDTH EQU 20
SCREEN_HEIGHT EQU 18
WAIT_BUTTON EQU $06
TX_NUM EQU $09

	const_def
	const A_BUTTON_F
	const B_BUTTON_F
	const SELECT_F
	const START_F
	const D_RIGHT_F
	const D_LEFT_F
	const D_UP_F
	const D_DOWN_F

NO_INPUT   EQU %00000000
A_BUTTON   EQU 1 << A_BUTTON_F
B_BUTTON   EQU 1 << B_BUTTON_F
SELECT     EQU 1 << SELECT_F
START      EQU 1 << START_F
D_RIGHT    EQU 1 << D_RIGHT_F
D_LEFT     EQU 1 << D_LEFT_F
D_UP       EQU 1 << D_UP_F
D_DOWN     EQU 1 << D_DOWN_F
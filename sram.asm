SECTION "SRAM 0", SRAM, BANK[0]
sScratch:: ds 7 * 7 * 8 ; a000
sDecompressBuffer:: ds 7 * 7 * 16 ; a188 
; a498 to a5ff free

; a600
sPartyMail::
sPartyMon1Mail:: mailmsg sPartyMon1Mail
sPartyMon2Mail:: mailmsg sPartyMon2Mail
sPartyMon3Mail:: mailmsg sPartyMon3Mail
sPartyMon4Mail:: mailmsg sPartyMon4Mail
sPartyMon5Mail:: mailmsg sPartyMon5Mail
sPartyMon6Mail:: mailmsg sPartyMon6Mail

; a71a
sPartyMailBackup::
sPartyMon1MailBackup:: mailmsg sPartyMon1MailBackup
sPartyMon2MailBackup:: mailmsg sPartyMon2MailBackup
sPartyMon3MailBackup:: mailmsg sPartyMon3MailBackup
sPartyMon4MailBackup:: mailmsg sPartyMon4MailBackup
sPartyMon5MailBackup:: mailmsg sPartyMon5MailBackup
sPartyMon6MailBackup:: mailmsg sPartyMon6MailBackup

; a834
sMailboxCount:: db
sMailbox::
sMailbox1::  mailmsg sMailbox1
sMailbox2::  mailmsg sMailbox2
sMailbox3::  mailmsg sMailbox3
sMailbox4::  mailmsg sMailbox4
sMailbox5::  mailmsg sMailbox5
sMailbox6::  mailmsg sMailbox6
sMailbox7::  mailmsg sMailbox7
sMailbox8::  mailmsg sMailbox8
sMailbox9::  mailmsg sMailbox9
sMailbox10:: mailmsg sMailbox10

; aa0b
sMailboxCountBackup:: db
sMailboxBackup::
sMailbox1Backup::  mailmsg sMailbox1Backup
sMailbox2Backup::  mailmsg sMailbox2Backup
sMailbox3Backup::  mailmsg sMailbox3Backup
sMailbox4Backup::  mailmsg sMailbox4Backup
sMailbox5Backup::  mailmsg sMailbox5Backup
sMailbox6Backup::  mailmsg sMailbox6Backup
sMailbox7Backup::  mailmsg sMailbox7Backup
sMailbox8Backup::  mailmsg sMailbox8Backup
sMailbox9Backup::  mailmsg sMailbox9Backup
sMailbox10Backup:: mailmsg sMailbox10Backup
; abe2
; most space is reserved here but labels unknown
	ds 134

sLuckyNumberDay:: ds 1 ; ac68
sLuckyIDNumber:: ds 2 ; ac69
sBackupStatusFlags:: ds $47d ; ac6b (wStatusFlags)
sBackupPokemonData:: ds $4df ; b0e8 (wPartyCount)
sBackupGameData:: ds $226 ; b5c7 (wGameData)
sWindowStackEnd:: ; b7ec to sWindowStack at $bfff

SECTION "SRAM 1", SRAM, BANK[1]

sOptions:: ds 8 ; a000
sValidCheck1:: ds 1 ; a008
sGameData:: ds $84d ; a009
sMapData:: ds $34; a856
sPokemonData:: ds $4df ; a88a
sChecksum:: ds 2 ; ad69
sValidCheck2:: ds 1 ; ad6b
sBox:: ds $44e ; ad6c

sLinkBattleStats::
sLinkBattleWins::   ds 2 ; b1ba
sLinkBattleLosses:: ds 2 ; b1bc
sLinkBattleDraws::  ds 2 ; b1be

sLinkBattleRecords:: ds 90 ; b1c0, 6 records
sHallOfFame:: ds $b7c ; b21a
sHallOfFameEnd:: ; bd96
sBackupObjectStructs:: ds $1aa ; bd96
; bf3f


SECTION "Boxes 1-7",  SRAM, BANK [2]

	box sBox1 ; a000
	box sBox2 ; a450
	box sBox3 ; a8a0
	box sBox4 ; acf0
	box sBox5 ; b1f0
	box sBox6 ; b590
	box sBox7 ; b9e0
; be2e

SECTION "Boxes 8-14", SRAM, BANK [3]

	box sBox8
	box sBox9
	box sBox10
	box sBox11
	box sBox12
	box sBox13
	box sBox14
; be2e
	ds 11 ; ???

sBackupValidCheck1:: ds 1 ; be38
sBackupMapData:: ds $34 ; be39
sBackupChecksum:: ds 2 ; be6d
sBackupValidCheck2:: ds 1 ; be6f
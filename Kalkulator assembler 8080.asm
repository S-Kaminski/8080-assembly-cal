     ORG 800H
	 LXI H,OUT_START
	 RST 3
	 JMP START
START
	 HLT
OUT_ENTR    DB 10,13,'@'
OUT_HASH1    DB '############@'
OUT_START 	 DB '##############'10,13,'# KALKULATOR #'10,13,'##############@'
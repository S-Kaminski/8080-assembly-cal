     ORG 800H
	 LXI H,OUT_START
	 RST 3
	 JMP START
OPER1
	 LXI H,IN_OP1INF
	 RST 3
	 RST 5
	 RET
OPER2
     LXI H,IN_OP2INF
	 RST 3
	 RST 5
	 RET
DODAJ
	 LXI H,OUT_DINFO
	 RST 3
     CALL OPER1
	 LXI H,OUT_ENOP1
	 RST 3
	 CALL OUTPUT
	 CALL DEdoBC
	 CALL OPER2
	 LXI H,OUT_ENOP2
	 RST 3
	 CALL OUTPUT
	 LXI H,OUT_ENTR
	 RST 3
	 CALL BCdoHL
	 DAD D
	 CC PRZENIESIENIE
	 JMP WYDRUK_WYNIKU
PRZENIESIENIE
     MVI A,1
	 RST 4
     RET
ODEJMIJ
NEGUJ
     LXI H,OUT_NINFO
	 RST 3
	 CALL OPER1
	 LXI H,OUT_ENOP1
	 RST 3
	 CALL OUTPUT
	 CALL NEGOWANIE
	 LXI H,OUT_ENTR
	 RST 3
	 CALL BCdoHL
	 JMP WYDRUK_WYNIKU
NEGOWANIE
	 MOV A,D
	 CMA
	 MOV B,A
	 MOV A,E
	 CMA
	 MOV C,A
     RET
DEdoBC
     MOV B,D
	 MOV C,E
	 RET
BCdoHL
     MOV H,B
	 MOV L,C
	 RET
OUTPUT
     MOV A,D
	 RST 4
	 MOV A,E
	 RST 4
	 RET
WYDRUK_WYNIKU
     MOV A,H
	 RST 4
	 MOV A,L
	 RST 4
	 LXI H,OUT_WYNIK
	 RST 3
	 JMP START
START
	 LXI H,OUT_ENTR
	 RST 3
	 LXI H,OUT_FINF0
	 RST 3
	 LXI H,OUT_FINF1
	 RST 3
ZNAK
	 LXI H,IN_FNSIGN
	 RST 3
	 RST 2
	 CPI '+'
	 JZ DODAJ
	 CPI '-'
	 JZ ODEJMIJ
	 CPI 'n'
	 JZ NEGUJ
	 LXI H,OUT_BSIGN
	 RST 3
	 JMP ZNAK
	 HLT
OUT_ENTR    DB 10,13,'@'
OUT_HASH1    DB '############@'
OUT_START 	 DB '##############'10,13,'# KALKULATOR #'10,13,'##############@'
OUT_FINF0    DB 10,13,'## OPERACJE ##',10,13,'@'
OUT_FINF1    DB '  (+) DODAJ',10,13,'  (-) ODEJMIJ',10,13,'  (n) NEGUJ@'
OUT_BSIGN    DB 10,13,'# NIE ROZPOZNANO ZNAKU #@'
IN_FNSIGN 	 DB 10,13,'> PODAJ ZNAK OPERACJI: @'
IN_OP1INF	 DB 10,13,'> OPERAND 1(HEKSADECYMALNIE): @'
IN_OP2INF	 DB 10,13,'> OPERAND 2(HEKSADECYMALNIE): @'
OUT_DINFO    DB 10,13,'## DODAWANIE ##@'
OUT_OINFO    DB 10,13,'## ODEJMOWANIE ##@'
OUT_NINFO    DB 10,13,'## NEGOWANIE ##@'
OUT_ENOP1    DB 10,13,'PODANY OPERAND 1: @'
OUT_ENOP2    DB 10,13,'PODANY OPERAND 2: @'
OUT_WYNIK    DB ' <--- WYNIK OPERACJI ##@'
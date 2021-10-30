;===Koneksi LCD RS=p3.2, E=p3.3, Data=P1====

ORG 000H
AJMP START

;=======LCD KONSTANTA======
DISPCLR EQU 00000001B
FUNCSET EQU 00111000B
ENTRMOD EQU 00000110B
DISPON EQU 00001100B

ORG 100H
START:
LCALL INITLCD

MOV A,#80H
CALL INSTLCD
MOV DPTR,#TULISAN1
CALL LCDSTRING

LOOP: AJMP LOOP
;=======PROSEDUR KONTROL DATA OPERASI========
INSTLCD:
CLR P3.2 ;RS=0 fo LCD instr
SJMP LCDOUT
DATALCD:SETB P3.2 ;RS=1 fo LCD data ASCII
SJMP LCDOUT
LCDOUT: MOV P1,A ;send ASCII/instr to LCD
SETB P3.3 ;send pulse enab to LCD
CLR P3.3
SETB P3.3
LCALL DELAY
RET

;=======PROSEDUR INISIALISASI LCD=============
INITLCD:
MOV A,#DISPCLR
LCALL INSTLCD
LCALL DELAY
MOV A,#FUNCSET
LCALL INSTLCD
LCALL DELAY
MOV A,#DISPON
LCALL INSTLCD
LCALL DELAY
MOV A,#ENTRMOD
LCALL INSTLCD
LCALL DELAY
RET

;=======PROSEDUR PENULISAN DATA KE LCD
WR_DT:
ADD A,#30H
LCALL DATALCD
LCALL DELAY
RET
;=======PROSEDUR CETAK STRING=========
PRINTSTRINGLOOP:
LCALL DATALCD
INC DPTR
LCDSTRING:
CLR A
MOVC A,@A+DPTR
JNZ PRINTSTRINGLOOP
RET

;=======PROSEDUR DELAY=========
DELAY:
MOV R6,#150
MUTER:
MOV R7,#250
DJNZ R7,$
DJNZ R6,MUTER
RET

;=======DATABASE STRING=======
TULISAN1:
DB 'tugas UTS ',0

END

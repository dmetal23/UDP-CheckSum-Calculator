.equ SWI_Open, 0x66 @open a file
.equ SWI_Close,0x68 @close a file
.equ SWI_PrStr, 0x69 @ Write a null-ending string 
.equ SWI_RdStr,0x6a @ Read an Integer from a file
.equ SWI_PrInt,0x6b @ Write an Integer
.equ Stdout, 1 @ Set output target to be Stdout
.equ SWI_Exit, 0x11 @ Stop execution
.global _start
.text
_start:
@ Open udp.dat input file for reading
LDR R0,=InFileName
MOV R1,#0
SWI SWI_Open
BCS InFileError

@ save filehandle to stack for close, SWI_RdStr overwrites R0
STMFD R13!, {R0}

@ read the big string from the file
LDR R1, =mystring
MOV R2, #1040
SWI SWI_RdStr
BCS ReadError

@ restore the file handle from stack and close file
LDMFD R13!, {R0}
SWI SWI_Close

LDR R0, =mystring @ load the starting address of the data read in R0
MOV R1, #0        @ clear R1 to be accumulator

RLoop:
LDRB R2, [R0]     @ retrieve the index character
ADDNE R0, R0, #1  @ increment the string index
CMP R2, #0        @ check to see if it is equal to 0
ADDNE R1, R1, R2  @ add to accumulator if it is not zero
BNE RLoop         @ repeat loop if it is not zero

MVN R1, R1        @ negate for ones complement
AND R1, R1, #0xff @ keep only least significant byte

@ Print resulting integer as checksum
MOV R0,#Stdout
SWI SWI_PrInt

Exit:
SWI SWI_Exit @ stop executing 

InFileError:
MOV R0, #Stdout
LDR R1, =FileOpenInpErrMsg
SWI SWI_PrStr 
BAL Exit @ give up, go to end

ReadError:
MOV R0, #Stdout
LDR R1, =FileReadErrMsg
SWI SWI_PrStr 
BAL Exit @ give up, go to end
.data
.align
InFileHandle: .skip 4
InFileName: .asciz "udp.dat"
FileOpenInpErrMsg: .asciz "Failed to open input file.\n"
FileReadErrMsg: .asciz "Failed to read input file.\n"
mystring: .skip 1040
.end
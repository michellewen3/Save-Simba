;;***********************************************************
; Programming Assignment 3
; Student Name: Michelle Wen
; UT Eid: mw37583
; Simba in the Jungle
; This is the starter code. You are given the main program
; and some declarations. The subroutines you are responsible for
; are given as empty stubs at the bottom. Follow the contract. 
; You are free to rearrange your subroutines if the need were to 
; arise.

;***********************************************************

.ORIG x3000

;***********************************************************
; Main Program
;***********************************************************
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_INITIAL
        TRAP  x22 
	LDI   R0,BLOCKS
	JSR   LOAD_JUNGLE
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_LOADED
        TRAP  x22                        ; output end message
        TRAP  x25                        ; halt
JUNGLE_LOADED       .STRINGZ "\nJungle Loaded\n"
JUNGLE_INITIAL      .STRINGZ "\nJungle Initial\n"
BLOCKS		    .FILL x5000

;***********************************************************
; Global constants used in program
;***********************************************************
;***********************************************************
; This is the data structure for the Jungle grid
;***********************************************************
GRID               .STRINGZ "+-+-+-+-+"
ROW0               .STRINGZ "| | | | |"
                   .STRINGZ "+-+-+-+-+"
ROW1               .STRINGZ "| | | | |"
                   .STRINGZ "+-+-+-+-+"
ROW2               .STRINGZ "| | | | |"
                   .STRINGZ "+-+-+-+-+"
ROW3               .STRINGZ "| | | | |"
                   .STRINGZ "+-+-+-+-+"

;***********************************************************
; this data stores the state of current position of Simba and his Home
;***********************************************************
CURRENT_ROW        .BLKW   1       ; row position of Simba
CURRENT_COL        .BLKW   1       ; col position of Simba 
HOME_ROW           .BLKW   1       ; Home coordinates (row and col)
HOME_COL           .BLKW   1

;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
; The code above is provided for you. 
; DO NOT MODIFY THE CODE ABOVE THIS LINE.
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************

;***********************************************************
; DISPLAY_JUNGLE
;   Displays the current state of the Jungle Grid 
;   This can be called initially to display the un-populated jungle
;   OR after populating it, to indicate where Simba is (*), any 
;   Hyena's(#) are, and Simba's Home (H).
; Input: None
; Output: None
; Notes: The displayed grid must have the row and column numbers
;***********************************************************
DISPLAY_JUNGLE      
	ST R7, StoreR7
	ST R0, StoreR0

	LD R0, Enter
	TRAP x21	;enter	
	LEA R0, TopStr
	TRAP x22	;printed the column numbers at the top
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Space
	TRAP x21	;space
	TRAP x21	;space
	LEA R0, GRID
	TRAP x22	;printed the grid line
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Row0
	TRAP x21	;printed row 0 number
	LD R0, Space
	TRAP x21	;space
	LEA R0, ROW0	
	TRAP x22	;printed row 0
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Space
	TRAP x21	;space
	TRAP x21	;space
	LEA R0, GRID
	TRAP x22	;printed the grid line
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Row1
	TRAP x21	;printed row 1 number
	LD R0, Space
	TRAP x21	;space
	LEA R0, ROW1
	TRAP x22	;printed row 1
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Space
	TRAP x21	;space
	TRAP x21	;space	
	LEA R0, GRID
	TRAP x22	;printed the grid line
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Row2
	TRAP x21	;printed row 2 number
	LD R0, Space
	TRAP x21	;space
	LEA R0, ROW2
	TRAP x22	;printed row 2
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Space
	TRAP x21	;space
	TRAP x21	;space	
	LEA R0, GRID
	TRAP x22	;printed the grid line
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Row3
	TRAP x21	;printed row 3 number
	LD R0, Space
	TRAP x21	;space
	LEA R0, ROW3
	TRAP x22	;printed row 3
	LD R0, Enter
	TRAP x21	;enter
	LD R0, Space
	TRAP x21	;space
	TRAP x21	;space	
	LEA R0, GRID
	TRAP x22	;printed the grid line
	LD R0, Enter
	TRAP x21	;enter

	LD R7, StoreR7	;restore R7
	LD R0, StoreR0	;restore R0

	RET

TopStr	.STRINGZ "   0 1 2 3 "
Enter	.FILL #10
Space	.FILL #32
Row0	.FILL #48
Row1	.FILL #49
Row2	.FILL #50
Row3	.FILL #51
StoreR7	.BLKW 1
StoreR0	.BLKW 1

;***********************************************************
; LOAD_JUNGLE
; Input:  R0  has the address of the head of a linked list of
;         gridblock records. Each record has four fields:
;		1. row # (0-3)
;		2. col # (0-3)
;		3. Symbol (can be I->Initial,H->Home or #->Hyena)
;               4. Address of the next gridblock in the list
;         The list is guaranteed to: 
;               * have only one Inital and one Home gridblock
;               * have zero or more gridboxes with Hyenas
;               * be terminated by a gridblock whose next address 
;                 field is a zero
; Output: None
;   This function loads the JUNGLE from a linked list by inserting 
;   the appropriate characters in boxes (I(*),#,H)
;   You must also change the contents of these
;   locations: 
;        1.  (CURRENT_ROW, CURRENT_COL) to hold the (row, col) 
;            numbers of Simba's Initial gridblock
;        2.  (HOME_ROW, HOME_COL) to hold the (row, col) 
;            numbers of the Home gridblock
;       
;***********************************************************
LOAD_JUNGLE 
	ST R7, StoR7
	ST R0, StoR0
	ST R1, StoR1
	ST R2, StoR2
	ST R3, StoR3
	ST R4, StoR4
	ST R5, StoR5
	ST R6, StoR6

Again	LDR	R1, R0, #0	;R1 holds row number
	LDR	R2, R0, #1	;R2 holds column number
	ADD	R3, R0, #0	;saving R0 into R3
	JSR 	GRID_ADDRESS	;R0 holds address location of row,column
	LDR	R4, R3, #2	;R4 holds character
	ADD	R5, R4, #0	;saving R4 in R5 (so R5 has character, unchanged)
	LD 	R6, Initial	;R6 holds #-73
	ADD	R4, R4, R6	;checking if character is I
	BRz	OutputI	
	LD	R6, Home	;R6 holds #-72
	ADD	R4, R5, R6	;checking if character is H
	BRz	CharH

Back2	STR	R5, R0, #0	;store character to M[grid address]

Back	LDR	R0, R3, #3	;R0 holds address of next linked list
	ADD	R0, R0, #0
	BRz	End2		;checking if end of linked list
	BRnp	Again

OutputI
	LD	R6, Aster	;R6 holds #42
	STR	R6, R0, #0	;store asterisk to M[grid address]
	ST	R1, CURRENT_ROW	;store row number to this label
	ST	R2, CURRENT_COL	;store column number to this label	
	BRnzp	Back

CharH
	ST	R1, HOME_ROW	;store row number to this label
	ST	R2, HOME_COL	;store column number to this label
	BRnzp 	Back2

End2
	LD R7, StoR7
	LD R0, StoR0
	LD R1, StoR1
	LD R2, StoR2
	LD R3, StoR3
	LD R4, StoR4
	LD R5, StoR5
	LD R6, StoR6

	RET

Initial	.FILL #-73
Aster	.FILL #42
Home	.FILL #-72
StoR7	.BLKW 1
StoR0	.BLKW 1
StoR1	.BLKW 1
StoR2	.BLKW 1
StoR3	.BLKW 1
StoR4	.BLKW 1
StoR5	.BLKW 1
StoR6	.BLKW 1


;***********************************************************
; GRID_ADDRESS
; Input:  R1 has the row number (0-4)
;         R2 has the column number (0-4)
; Output: R0 has the corresponding address of the space in the GRID
; Notes: This is a key routine.  It translates the (row, col) logical 
;        GRID coordinates of a gridblock to the physical address in 
;        the GRID memory.
;***********************************************************
GRID_ADDRESS     
	ST R7, StorR7
	ST R1, StorR1
	ST R2, StorR2
	ST R3, StorR3
	ST R4, StorR4
	ST R5, StorR5
	ST R6, StorR6	

	ADD R5, R1, #0
	BRz RowZero
	ADD R5, R1, #0
	ADD R5, R5, #-1
	BRz RowOne
	ADD R5, R1, #0
	ADD R5, R5, #-2
	BRz RowTwo
	ADD R5, R1, #0
	ADD R5, R5, #-3
	BRz RowThree

RowZero LEA R0, ROW0		;branch here if R1=0
	ADD R4, R2, #0
	BRz ZeroZero
	ADD R4, R2, #0	
	ADD R4, R4, #-1
	BRz ZeroOne	
	ADD R4, R2, #0		
	ADD R4, R4, #-2
	BRz ZeroTwo
	ADD R4, R2, #0
	ADD R4, R4, #-3
	BRz ZeroThree
ZeroZero				;R2=0
	ADD R0, R0, #1
	BRnzp End
ZeroOne					;R2=1
	ADD R0, R0, #3
	BRnzp End
ZeroTwo					;R2=2
	ADD R0, R0, #5
	BRnzp End
ZeroThree				;R2=3
	ADD R0, R0, #7
	BRnzp End


RowOne  LEA R0, ROW1		;branch here if R1=1
	ADD R4, R2, #0
	BRz OneZero
	ADD R4, R2, #0
	ADD R4, R4, #-1
	BRz OneOne
	ADD R4, R2, #0
	ADD R4, R4, #-2
	BRz OneTwo
	ADD R4, R2, #0
	ADD R4, R4, #-3
	BRz OneThree
OneZero					;R2=0
	ADD R0, R0, #1
	BRnzp End
OneOne					;R2=1
	ADD R0, R0, #3
	BRnzp End
OneTwo					;R2=2
	ADD R0, R0, #5
	BRnzp End
OneThree				;R2=3
	ADD R0, R0, #7
	BRnzp End

RowTwo  LEA R0, ROW2		;branch here if R1=2
	ADD R4, R2, #0	
	BRz TwoZero
	ADD R4, R2, #0
	ADD R4, R4, #-1
	BRz TwoOne
	ADD R4, R2, #0
	ADD R4, R4, #-2
	BRz TwoTwo
	ADD R4, R2, #0
	ADD R4, R4, #-3
	BRz TwoThree
TwoZero					;R2=0
	ADD R0, R0, #1
	BRnzp End
TwoOne					;R2=1
	ADD R0, R0, #3
	BRnzp End
TwoTwo					;R2=2
	ADD R0, R0, #5
	BRnzp End
TwoThree				;R2=3
	ADD R0, R0, #7
	BRnzp End

RowThree 			;branch here if R1=3
	LEA R0, ROW3
	ADD R4, R2, #0
	BRz ThreeZero
	ADD R4, R2, #0
	ADD R4, R4, #-1
	BRz ThreeOne
	ADD R4, R2, #0
	ADD R4, R4, #-2
	BRz ThreeTwo
	ADD R4, R2, #0
	ADD R4, R4, #-3
	BRz ThreeThree
ThreeZero				;R2=0
	ADD R0, R0, #1
	BRnzp End
ThreeOne				;R2=1
	ADD R0, R0, #3
	BRnzp End
ThreeTwo				;R2=2
	ADD R0, R0, #5
	BRnzp End
ThreeThree				;R2=3
	ADD R0, R0, #7
	BRnzp End

End
	LD R7, StorR7
	LD R1, StorR1
	LD R2, StorR2
	LD R3, StorR3
	LD R4, StorR4
	LD R5, StorR5
	LD R6, StorR6

          RET

StorR7	.BLKW 1
StorR1	.BLKW 1
StorR2	.BLKW 1
StorR3	.BLKW 1
StorR4	.BLKW 1
StorR5	.BLKW 1
StorR6	.BLKW 1

          .END


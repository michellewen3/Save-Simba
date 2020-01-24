;***********************************************************
; Programming Assignment 4
; Student Name: Michelle Wen
; UT Eid: mw37583
; -------------------Save Simba (Part II)---------------------
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
GAMEON
        LEA   R0,PROMPT
        TRAP  x22
        TRAP  x20                        ; get a character from keyboard into R0
        TRAP  x21                        ; echo character entered
        LD    R3, ASCII_Q_COMPLEMENT     ; load the 2's complement of ASCII 'Q'
        ADD   R3, R0, R3                 ; compare the first character with 'Q'
        BRz   EXIT                       ; if input was 'Q', exit
;; call a converter to convert i,j,k,l to up(0) left(1),down(2),right(3) respectively
        JSR   IS_INPUT_VALID      
        ADD   R2, R2, #0                 ; R2 will be zero if the move was valid
        BRz   VALID_INPUT
        LEA   R0, INVALID_MOVE_STRING    ; if the inpuy was invalid, output corresponding
        TRAP  x22                        ; message and go back to prompt
        BR    GAMEON
VALID_INPUT                 
        JSR   APPLY_MOVE                 ; apply the move (Input in R0)
        JSR   DISPLAY_JUNGLE
        JSR   IS_GAME_OVER      
        ADD   R2, R2, #0                 ; R2 will be zero if reached end
        BRnp  GAMEON                     ; otherwise, loop back
EXIT   
        LEA   R0, GOODBYE_STRING
        TRAP  x22                        ; output a goodbye message
        TRAP  x25                        ; halt
JUNGLE_LOADED       .STRINGZ "\nJungle Loaded\n"
JUNGLE_INITIAL      .STRINGZ "\nJungle Initial\n"
ASCII_Q_COMPLEMENT  .FILL    x-71    ; two's complement of ASCII code for 'q'
PROMPT .STRINGZ "\nEnter Move (up(i) left(j),down(k),right(l)): "
INVALID_MOVE_STRING .STRINGZ "\nInvalid Input (ijkl)\n"
GOODBYE_STRING      .STRINGZ "\nYou Saved Simba !Goodbye!\n"
BLOCKS               .FILL x5000

;***********************************************************
; Global constants used in program
;***********************************************************

ASCII_OFFSET       .FILL   x0030
ASCII_NEWLINE      .FILL   x000A

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
	LEA R0, ROW0
	ADD R0, R0, #10
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
	LEA R0, ROW1
	ADD R0, R0, #10
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
	LEA R0, ROW2
	ADD R0, R0, #10
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
	LEA R0, ROW3
	ADD R0, R0, #10
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
FARR0 	.FILL ROW0
FARR1	.FILL ROW1
FARR2	.FILL ROW2
FARR3	.FILL ROW3

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

RowZero LD R0, FARR0		;branch here if R1=0
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


RowOne  LD R0, FARR1		;branch here if R1=1
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

RowTwo  LD R0, FARR2		;branch here if R1=2
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
	LD R0, FARR3
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
FARCURR_ROW .FILL CURRENT_ROW
FARCURR_COL .FILL CURRENT_COL
FARHOME_ROW .FILL HOME_ROW
FARHOME_COL .FILL HOME_COL

;***********************************************************
; SAFE_MOVE
; Input: R0 has 'i','j','k','l'
; Output: R1, R2 have the new row and col
;         If the move is to a Hyena or 
;         outside the Grid then return R1=-1 
; Notes: Translates user entered move to actual row and column
;        Also checks the contents of the intended space to
;        move to in determining if the move is safe
;        Calls GRID_ADDRESS
;        This subroutine does not check if the input (R0) is 
;        valid. This functionality is implemented elsewhere.
;***********************************************************
SAFE_MOVE      
	ST R7, SaveR7
	ST R0, SaveR0 
	ST R3, SaveR3
	ST R4, SaveR4
	ST R5, SaveR5
	ST R6, SaveR6

	LDI R1, FARCURR_ROW	;R1 has row # of initial
	LDI R2, FARCURR_COL	;R2 has column # of initial
	NOT R3, R1
	ADD R3, R3, #1		;R3 gets negated row #
	NOT R4, R2
	ADD R4, R4, #1		;R4 gets negated col #	

	LD  R5, Inputi		;checking if input is 'i'	 
	ADD R5, R5, R0
	BRnp Noti 
	ADD R3, R3, #0		;checking if row 0
	BRz Unsafe

	JSR GRID_ADDRESS	;R0 gets grid address of simba
	LD  R7, Hyena		;used to check for hyena	
	LD  R5, iMove
	ADD R5, R0, R5		;R5 gets the new address above 		
	LDR R6, R5, #0		;R6 gets M[address]
	ADD R5, R7, R6		;checking if hyena
	BRz Unsafe

	ADD R1, R1, #-1		;Row-1, R2 stays same
	BRnzp Done4

Noti	LD  R5, Inputk		;checking if input is k
	ADD R5, R5, R0
	BRnp Notk
	ADD R3, R3, #3		;checking if row 3
	BRz Unsafe

	JSR GRID_ADDRESS	;R0 gets grid address of simba
	LD  R7, Hyena		;used to check for hyena	
	LD  R5, kMove
	ADD R5, R5, R0		;R5 gets new address below
	LDR R6, R5, #0		;R6 gets M[address]
	ADD R5, R7, R6		;checking if hyena
	BRz Unsafe

	ADD R1, R1, #1		;Row+1, R2 stays the same
	BRnzp Done4

Notk	LD  R5, Inputj		;checking if input is j
	ADD R5, R5, R0
	BRnp Notj
	ADD R4, R4, #0		;checking if column 0
	BRz Unsafe

	JSR GRID_ADDRESS	;R0 gets grid address of simba
	LD  R7, Hyena		;used to check for hyena	
	LD  R5, jMove
	ADD R5, R5, R0		;R5 gets new address on left
	LDR R6, R5, #0		;R6 gets M[address]
	ADD R5, R7, R6		;checking if hyena
	BRz Unsafe

	ADD R2, R2, #-1		;R1 stays same, R2-1
	BRnzp Done4

Notj	ADD R4, R4, #3		;input is l, if not i,j,k
	BRz Unsafe		;checking if column 3

	JSR GRID_ADDRESS	;R0 gets grid address of simba
	LD  R7, Hyena		;used to check for hyena	
	LD R5, lMove
	ADD R5, R5, R0		;R5 gets new address on right 
	LDR R6, R5, #0		;R6 gets M[address]
	ADD R5, R7, R6		;checking if hyena
	BRz Unsafe

	ADD R2, R2, #1		;R1 stays same, R2+1
	BRnzp Done4

Unsafe
	AND R1, R1, #0
	ADD R1, R1, #-1		;R1 gets -1

Done4
	LD R7, SaveR7
	LD R0, SaveR0
	LD R3, SaveR3
	LD R4, SaveR4
	LD R5, SaveR5
	LD R6, SaveR6

        RET

Inputi	.FILL #-105
Inputj	.FILL #-106
Inputk	.FILL #-107
Hyena	.FILL #-35
iMove	.FILL #-20
kMove	.FILL #20
jMove	.FILL #-2
lMove	.FILL #2
SaveR7	.BLKW 1
SaveR0	.BLKW 1
SaveR3	.BLKW 1
SaveR4	.BLKW 1
SaveR5	.BLKW 1
SaveR6	.BLKW 1

;***********************************************************
; IS_INPUT_VALID
; Input: R0 has the move (character i,j,k,l)
; Output:  R2  zero if valid; -1 if invalid
; Notes: Validates move to make sure it is one of i,j,k,l
;        Only checks if a valid character is entered
;***********************************************************
IS_INPUT_VALID
	ST R7, SttR7
	ST R0, SttR0
	ST R1, SttR1

	AND R2, R2, #0		;clear R2

	LD  R1, Checki		;R1 <- -105
	ADD R2, R1, R0
	BRz Valid		;checking if input is "i"
	
	LD  R1, Checkj		;R1 <- -106
	ADD R2, R1, R0
	BRz Valid		;checking if input is "j"

	LD  R1, Checkk		;R1 <- -107
	ADD R2, R1, R0
	BRz Valid		;checking if input is "k"

	LD  R1, Checkl		;R1 <- -108
	ADD R2, R1, R0
	BRz Valid		;checking if input is "l"

	AND R2, R2, #0		;otherwise, input is invalid
	ADD R2, R2, #-1		;R2 <- -1
	BRnzp End3

Valid	AND R2, R2, #0		;R2 <- 0

End3	LD R7, SttR7
	LD R0, SttR0
	LD R1, SttR1

        RET

Checki	.FILL #-105
Checkj	.FILL #-106
Checkk	.FILL #-107
Checkl	.FILL #-108
SttR7	.BLKW 1
SttR0	.BLKW 1
SttR1	.BLKW 1

;***********************************************************
; APPLY_MOVE - Checks if the move can be done by calling
; SAFE_MOVE (which you also write) which returns the coordinates 
; where the move would result in if valid (R1 is -1 otherwise)
; If the move is valid then Moves the player to the new space whose
;   coordinates are given; Also clear path for the move to take effect
; If the move is invalid then just print a message (UnSafe Move) and return.
; Input:  
;         R0 has move (i or j or k or l)
; Output: None
; Notes:  Calls SAFE_MOVE and GRID_ADDRESS
;***********************************************************
APPLY_MOVE   
	ST R7, SaveeR7
	ST R0, SaveeR0
	ST R1, SaveeR1
	ST R2, SaveeR2
	ST R3, SaveeR3
	ST R4, SaveeR4
	ST R5, SaveeR5
	ST R6, SaveeR6

	AND R4, R4, #0
	ADD R4, R4, R0		;save R0 in R4

	JSR SAFE_MOVE		;R1 and R2 get row/col of new address
	ADD R3, R1, #1		;checking if R1 = -1
	BRz NoMove		;otherwise, it's a safe move

	STI R1, FARCURR_ROW	;update current_row and current_col
	STI R2, FARCURR_COL

	JSR GRID_ADDRESS	;R0 has address of NEW location
	LD  R3, Asteri		
	STR R3, R0, #0		;store asterisk in new location
	LD R6, Spacer

	LD  R3, Inputii		;checking if input is 'i'	 
	ADD R3, R3, R4
	BRnp tryk
	LD  R5, OldAdd2 
	ADD R5, R0, R5		;R5 gets old address
	STR R6, R5, #0		;store space in address
	ADD R5, R5, #-10	;R5 gets address of bar in between
	STR R6, R5, #0		;store space in address
	BRnzp Done5

tryk	LD  R3, Inputkk		;checking if input is 'k'	 
	ADD R3, R3, R4
	BRnp tryj
	LD  R5, OldAdd1
	ADD R5, R0, R5		;R5 gets old address
	STR R6, R5, #0		;store space in address
	ADD R5, R5, #10		;R5 gets address of bar in between
	STR R6, R5, #0		;store space in address
	BRnzp Done5

tryj	LD  R3, Inputjj		;checking if input is 'j'	 
	ADD R3, R3, R4
	BRnp tryl
	ADD R5, R0, #2		;R5 gets old address
	STR R6, R5, #0		;store space in address
	ADD R5, R5, #-1		;R5 gets address of bar in between
	STR R6, R5, #0		;store space in address
	BRnzp Done5

tryl
	ADD R5, R0, #-2		;R5 gets old address
	STR R6, R5, #0		;store space in address
	ADD R5, R5, #1		;R5 gets address of bar in between
	STR R6, R5, #0		;store space in address
	BRnzp Done5

NoMove 	LEA R0, Unsafe_Move
	TRAP x22
	
Done5

	LD R7, SaveeR7
	LD R0, SaveeR0
	LD R1, SaveeR1
	LD R2, SaveeR2
	LD R3, SaveeR3
	LD R4, SaveeR4
	LD R5, SaveeR5
	LD R6, SaveeR6

         RET

Inputii	.FILL #-105
Inputjj	.FILL #-106
Inputkk	.FILL #-107
Asteri	.FILL #42
Spacer	.FILL #32
Unsafe_Move .STRINGZ "\nUnsafe Move! Please try again."
OldAdd1	.FILL #-20
OldAdd2	.FILL #20
SaveeR7	.BLKW 1
SaveeR0	.BLKW 1
SaveeR1	.BLKW 1
SaveeR2	.BLKW 1
SaveeR3	.BLKW 1
SaveeR4	.BLKW 1
SaveeR5	.BLKW 1
SaveeR6	.BLKW 1

;***********************************************************
; IS_GAME_OVER
; Checks to see if the player has reached the End point.
; Input:  None
; Output: R2 is zero if Game over (reached end); -1 if Game still ON
; 
;***********************************************************
IS_GAME_OVER      
	ST R7, SSR7
	ST R0, SSR0
	ST R1, SSR1
	ST R3, SSR3
	ST R4, SSR4
	ST R5, SSR5
	ST R6, SSR6
	
	LDI R1, FARCURR_ROW	;R1 gets current row of simba
	LDI R2, FARCURR_COL	;R2 gets current col of simba
	LDI R3, FARHOME_ROW 	;R3 gets home row
	LDI R4, FARHOME_COL	;R4 gets home col
	NOT R3, R3
	ADD R3, R3, #1		;negate R3
	ADD R5, R3, R1		;checking rows
	BRz CheckC
	
StillOn	AND R2, R2, #0
	ADD R2, R2, #-1		;R2 gets -1, game is still on
	BRnzp Done6

CheckC	NOT R4, R4
	ADD R4, R4, #1		;negate R4
	ADD R6, R4, R2		;checking columns
	BRz Over		
	BRnp StillOn

Over	AND R2, R2, #0

Done6
	LD R7, SSR7
	LD R0, SSR0
	LD R1, SSR1
	LD R3, SSR3
	LD R4, SSR4
	LD R5, SSR5
	LD R6, SSR6

        RET

SSR7	.BLKW 1
SSR0	.BLKW 1
SSR1	.BLKW 1
SSR3	.BLKW 1
SSR4	.BLKW 1
SSR5	.BLKW 1
SSR6	.BLKW 1

        .END


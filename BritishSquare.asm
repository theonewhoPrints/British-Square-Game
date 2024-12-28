#
# FILE:         BritishSquare
# AUTHOR:       Isaac Soares, RIT 2024
#
# SECTION NUMBER:
#               Section 3
#		
# DESCRIPTION:
#	starting program that starts British Square game, and 
#	displays Command Line features to the User.
#
# ARGUMENTS:
#	a0: parameter box of opposing player
#       a1: user input
#       a2: parameter box for current player turn
#       a3: the array containing the grid
#
# INPUT:
# 	The Users input, and updated data from the model file.
#
# OUTPUT:
#	The board of British Square Game updated as game commences,
#       alongside error and game messages 

#-------------------------------

#
# Numeric Constants
#
PRINT_STRING = 4
READ_INT = 5
PRINT_INT = 1

#-------------------------------

#
# DATA AREAS
#
	.data
	.align 2                # word data must be on word boundaries
        
valid_spaces:
        .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 
length_spaces:
        .word 25

array:
       
        .word newline, game_header_text_3, default_row, row_1, num_row_2
        .word default_row, row_4, num_row_5, default_row, row_7
        .word num_row_8, default_row, row_10, num_row_11, default_row
        .word row_13, num_row_14, default_row, game_header_text_3

length:
        .word 19                # length of grid array

X_moves_made:
        .space 1000 

O_moves_made:
        .space 1000 

X_amt_moves_made:
        .word 0

O_amt_moves_made: 
        .word 0

O_illegal_moves:
        .space 1000 

X_illegal_moves:
        .space 1000 

O_illegal_indx:
        .word 0


X_illegal_indx:
        .word 0


# Paramter Box containing data on Player X
parm_X:
        .word X_moves_made 
        .word X_loop            
        .word X_amt_moves_made 
        .word X                 
        .word O_illegal_moves   
        .word O_illegal_indx    
        .word quit_text_X
        .word winning_text_X

                

# Paramter Box containing data on Player O
parm_O:
        .word O_moves_made
        .word O_loop
        .word O_amt_moves_made
        .word O
        .word X_illegal_moves
        .word X_illegal_indx
        .word quit_text_O
        .word winning_text_O


        .align	0

X: 
        .asciiz "X" 

O:
        .asciiz "O" 

newline:
	.asciiz	"\n"

game_header_text_1:
        .asciiz "\n****************************\n"

game_header_text_2:
        .asciiz "**     British Square     **"

game_header_text_3:
        .asciiz "***********************\n"

winning_text_1:
        .asciiz "************************\n"

winning_text_O:
        .asciiz "**   Player O wins!   **\n"

winning_text_X:
        .asciiz "**   Player X wins!   **\n"

tie_text:
        .asciiz "**   Game is a tie    **\n"

results_1_text:
        .asciiz "\nGame Totals\n"

results_X_text:
        .asciiz "X's total="

results_O_text:
        .asciiz " O's total="


no_legal_O:
        .asciiz "\nPlayer O has no legal moves, turn skipped.\n"

no_legal_X:
        .asciiz "\nPlayer X has no legal moves, turn skipped.\n"

default_row:
        .asciiz "*+---+---+---+---+---+*\n"
row_1:
        .asciiz "*|   |   |   |   |   |*\n"
row_4:
        .asciiz "*|   |   |   |   |   |*\n"
row_7:
        .asciiz "*|   |   |   |   |   |*\n"
row_10:
        .asciiz "*|   |   |   |   |   |*\n"
row_13:
        .asciiz "*|   |   |   |   |   |*\n"

num_row_2:
        .asciiz "*|0  |1  |2  |3  |4  |*\n"

num_row_5:
        .asciiz "*|5  |6  |7  |8  |9  |*\n"

num_row_8:
        .asciiz "*|10 |11 |12 |13 |14 |*\n"

num_row_11:
        .asciiz "*|15 |16 |17 |18 |19 |*\n"

num_row_14:
        .asciiz "*|20 |21 |22 |23 |24 |*\n"

input_text1:
        .asciiz "\nPlayer X enter a move (-2 to quit, -1 to skip move): "

input_text2:
        .asciiz "\nPlayer O enter a move (-2 to quit, -1 to skip move): "


error_1_text:
        .asciiz "\nIllegal location, try again\n"

error_2_text:
        .asciiz "\nIllegal move, can't place first stone of game in middle square\n"

error_3_text:
        .asciiz "\nIllegal move, square is occupied\n"

error_4_text:
        .asciiz "\nIllegal move, square is blocked\n"

quit_text_X:
        .asciiz "\Player X quit the game.\n"

quit_text_O:
        .asciiz "\Player O quit the game.\n"



#-------------------------------

#
# CODE AREAS
#
	.text			# this is program code
	.align	2		# instructions must be on word boundaries
	.globl  main		# main is a global label
        .globl  model           
        .globl  error_1
        .globl  error_2
        .globl  error_3
        .globl  error_4
        .globl  skip
        
#
# EXECUTION BEGINS HERE
#

#-------------------------------

# Name:		main
# Description:	starts execution of program and calls orderly functions to process
# Returns:      none
main:
        addi    $sp, $sp, -4
        sw	$ra, 0($sp)	
        jal     print_header 
        jal     print_grid
        jal     input_output

main_done:
	lw	$ra, 0($sp)	
	addi	$sp, $sp, 4     # deallocate stack space
	jr	$ra		# return from main and exit spim


#-------------------------------

# Name:		print_header
# Description:	This function prints the header of 
#		the British Square Game 
# params:       none
# returns:      Printed Header on CLI
print_header: 
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)
        li      $v0, PRINT_STRING
        la      $a0, game_header_text_1         
        syscall

        li      $v0, PRINT_STRING
        la      $a0, game_header_text_2
        syscall

        li      $v0, PRINT_STRING
        la      $a0, game_header_text_1
        syscall

        lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra

#-------------------------------

# Name:		print_grid
# Description:	Prints the grid of
#		the British Square Game 
# params:       none
# returns:      Printed Grid on CLI
# Destroys:	t0,t1
print_grid:   
        addi	$sp, $sp, -4
	sw	$ra, 0($sp)


print_grid_updating:

printing_loop:
        la      $t0, array
        lw      $t1, length
        li      $v0, PRINT_STRING
p_loop:
        beq     $t1, $zero, end
        lw      $a0, 0($t0)     # cont print each word in grid array until
        syscall                 # exhausted.
        addi    $t0, $t0, 4
        addi    $t1, $t1, -1
        j       p_loop

end:      
        lw	$ra, 0($sp)
        addi	$sp, $sp, 4
        jr	$ra

#-------------------------------

# Name:		input_output
# Description:	reads in input of user by integer array,
#               and proccesses output logic
# arguments:
#	a0: parameter box of opposing player
#       a1: user input
#       a2: parameter box for current player turn
#       a3: the array containing the grid        
# Returns:      Conditional errors, updated data to resume game.
# Destroys:     t0,t1,t2
input_output:
        addi    $sp, $sp, -16
        sw      $ra, 12($sp)
        sw      $s2, 8($sp)
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)


# X Player's turn rotation
X_loop:
        la      $a0, parm_O
        jal     valid_count
        move    $s2, $v0
        la      $a0, parm_X
        jal     valid_count
        move    $s1, $v0
        move    $t0, $s2                # gather validations from valid count 
        move    $t1, $s1

        add     $t2, $t0, $t1
        beq     $t2, $zero, winner      # was a end condition found

        beq     $t0, $zero, no_moves_X  # was no moves confirmed

        li      $v0, PRINT_STRING
        la      $a0, input_text1
        syscall
        li      $v0, READ_INT
        syscall
        
        move    $a1, $v0                # get user input for model

        la      $a0, parm_O             # passed param box for model
        la      $a2, parm_X
        la      $s0, O_loop
        la      $a3, array              # passed grid for model
        
        li      $t0, -2
        beq     $t0, $a1, quitting      # if user wants to quit
        li      $t0, -1
        beq     $t0, $a1, skip          # if user wants to skip.
        jal     model                   # call to model to gather logic/data
        jal     print_grid           

        
# O Player's turn rotation
O_loop:
        la      $a0, parm_X
        jal     valid_count
        move    $s2, $v0
        la      $a0, parm_O
        jal     valid_count
        move    $s1, $v0
        move    $t0, $s2                
        move    $t1, $s1

        
        add     $t2, $t0, $t1
        beq     $t2, $zero, winner 

        beq     $t0, $zero, no_moves_O 

        li      $v0, PRINT_STRING
        la      $a0, input_text2
        syscall
        li      $v0, READ_INT
        syscall
        
        move    $a1, $v0

        la      $a0, parm_X
        la      $a2, parm_O
        la      $s0, X_loop 
        la      $a3, array
        
        li      $t0, -2
        beq     $t0, $a1, quitting
        li      $t0, -1
        beq     $t0, $a1, skip
        jal     model
        jal     print_grid
        j       X_loop

#-------------------------------

# Name:		valid_count
# Description:	Determines how many valid moves there are for the player 
#               specified in a0
# arguments:    
#       a0: the player whos moves we are searching for
#	   
# Returns:      none
# Destroys:     t0,t1,t2,t3,t4,t5,t6,t8
valid_count:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)

        la      $t0, valid_spaces               
        la      $t1, length_spaces            
        lw      $t1, 0($t1)
        lw      $t2, 16($a0)            # Load address of invalid list
        lw      $t3, 20($a0)            # Load size of invalid list
        lw      $t3, 0($t3)

        li      $t4, 0                

valid_loop:
        beq     $t1, $zero, done               
        lw      $t5, 0($t0)             # Load current number from valid spaces
        addi    $t0, $t0, 4                     
        addi    $t1, $t1, -1                    

    
        lw      $t2, 16($a0)            # Reset pointer to invalid list
        lw      $t6, 20($a0)            # Reload size of the invalid list
        lw      $t6, 0($t6)


invalid_loop:
        beq     $t6, $zero, check_found         
        lw      $t8, 0($t2)             # Load current number from invalid list
        addi    $t2, $t2, 4                     
        addi    $t6, $t6, -1                    
        beq     $t5, $t8, valid_loop    # mark as found when matched
        j       invalid_loop

check_found:
                 
        addi    $t4, $t4, 1             # Increment count if not found
        j       valid_loop



done:  
        move    $v0, $t4                # dellocate stack when done
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra

#-------------------------------

# Name:		no_moves_O
# Description:	prints message when no moves can be made by plyaer O.
no_moves_O:
        li      $v0, PRINT_STRING
        la      $a0, no_legal_O
        syscall
        j       X_loop

#-------------------------------

# Name:		no_moves_X
# Description:	prints message when no moves can be made by plyaer X.
no_moves_X:
        li      $v0, PRINT_STRING
        la      $a0, no_legal_X
        syscall
        j       O_loop

#-------------------------------

# Name:		error_1
# Description:	prints error message when a illegal location.
error_1:     
        lw      $ra, 0($sp)             # when jumping from model.asm, we're 
        addi    $sp, $sp, 4             # restoring the stack from model.
        li      $v0, PRINT_STRING
        la      $a0, error_1_text
        syscall
        lw      $t0, 4($a2)
        jr      $t0

#-------------------------------

# Name:		error_2
# Description:	prints error message when try to place in stone on first move
error_2:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        li      $v0, PRINT_STRING
        la      $a0, error_2_text
        syscall
        lw      $t0, 4($a2)
        jr      $t0
#-------------------------------

# Name:		error_3
# Description:	prints error message when a square is occupied
error_3:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        li      $v0, PRINT_STRING
        la      $a0, error_3_text
        syscall
        lw      $t0, 4($a2)
        jr      $t0

#-------------------------------

# Name:		error_4
# Description:	prints error message when a square is blocked.
error_4:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        li      $v0, PRINT_STRING
        la      $a0, error_4_text
        syscall
        lw      $t0, 4($a2)
        jr      $t0

#-------------------------------
# Name:		skip
# Description:	jumps to next players move when one is skipped.
skip:
        jal     print_grid 
        jr      $s0

#-------------------------------

# Name:		results
# Description:	accesses and prints results.
# arguments:    none
#	   
# Returns:      none
# Destroys:     t0,t1
results:
        li      $v0, PRINT_STRING
        la      $a0, results_1_text
        syscall

        li      $v0, PRINT_STRING
        la      $a0, results_X_text
        syscall

        la      $t0, parm_X
        lw      $t1, 8($t0)
        lw      $a0, 0($t1)
        li      $v0, PRINT_INT
        syscall
        
        li      $v0, PRINT_STRING
        la      $a0, results_O_text
        syscall

        la      $t0, parm_O
        lw      $t1, 8($t0)
        lw      $a0, 0($t1)
        li      $v0, PRINT_INT
        syscall

        li      $v0, PRINT_STRING
        la      $a0, newline
        syscall

        jr      $ra
#-------------------------------

# Name:		winner
# Description:	determines game status at end of game, based on moves made
#               per player
# arguments:    none
#	   
# Returns:      printed message of who the winner is, or if a tie.
# Destroys:     t0,t1,t2,t3,t4,t5,t6
winner:
        jal     results
        la      $t0, parm_X
        lw      $t1, 8($t0)             
        lw      $t5, 0($t1)             # load moves made of X


        la      $t2, parm_O
        lw      $t3, 8($t2)             
        lw      $t6, 0($t3)             # load moves made of O
       

        beq     $t5, $t6, tie           # moves made equal amount, go too win
        slt     $t4, $t5, $t6           # which players moves are greater
        beq     $t4, $zero, X_wins      # go too X if greater moves made 
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        li      $v0, PRINT_STRING
        la      $a0, winning_text_O
        syscall
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        j       io_done

X_wins:
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        li      $v0, PRINT_STRING
        la      $a0, winning_text_X
        syscall
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        j       io_done

tie:
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        li      $v0, PRINT_STRING
        la      $a0, tie_text
        syscall
        li      $v0, PRINT_STRING
        la      $a0, winning_text_1
        syscall
        j       io_done
    
#-------------------------------

# Name:		quitting
# Description:	delivers a quit of the game when requested by user.
# arguments:    a2: accessing paramater box of player to get printed message
#               on who is currently quitting.
#	   
# Returns:      printed message of who the winner is, or if a tie.
quitting:
        
        jal     results                 # print results before quitting
        li      $v0, PRINT_STRING
        lw      $a0, 24($a2)
        syscall

        j       io_done

io_done:
        lw      $ra, 12($sp)
        lw      $s2, 8($sp)
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 16            #restore stack of input_output
        jr      $ra

#
# End of printing program.
#


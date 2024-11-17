#
# FILE:         $File$
# AUTHOR:       Isaac Soares, RIT 2024
# CONTRIBUTORS:
#		I. Soares
# SECTION NUMBER:
#               Section 3
#		
# DESCRIPTION:
#	This program is an implementation of printing for British
#	Square Game.
#
# ARGUMENTS:
#	None
#
# INPUT:
# 	The numbers to be sorted.  The user will enter a 9999 to
#	represent the end of the data
#
# OUTPUT:
#	A "before" line with the numbers in the order they were
#	entered, and an "after" line with the same numbers sorted.
#
#
# REVISION HISTORY:
#	Jan  2017	- P. White, added more/better merge tests 
#	Aug  2016	- P. White, Initial version of merge sort exp.
#


#------------------------------- Fix into real header

#
# Numeric Constants
#

# MAX_NUMBERS = 20
# STOP_INPUT = 9999
PRINT_STRING = 4
READ_INT = 5
# PRINT_INT = 1





#
# DATA AREAS
#
	.data
	.align	2		# word data must be on word boundaries
        


array:
        # .space edit this param
        .word newline, game_header_text_3, default_row, row_1, num_row_2
        .word default_row, row_4, num_row_5, default_row, row_7
        .word num_row_8, default_row, row_10, num_row_11, default_row
        .word row_13, num_row_14, default_row, game_header_text_3, newline

length:
        .word 20 #look at how phil does it. 


parm_X:
        #.word X_moves_made
        .word X_loop
        #.word X_possible_moves #we can do if this is equal to zero in print
        #say no more moves possible. #because 
        #of illegal move square is blocked, and also from there can 
        # go to certain loop

parm_O:
        #.word O_moves_made
        .word O_loop
        #.word O_possible_moves #we can do if this is equal to zero in print
        #say no more moves possible. #because 
        #of illegal move square is blocked, and also from there can 
        # go to certain loop


        .align	0

newline:
	.asciiz	"\n"

game_header_text_1:
        .asciiz "\n****************************\n"

game_header_text_2:
        .asciiz "**     British Square     **"

game_header_text_3:
        .asciiz "***********************"


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

#-------------------------------

#
# CODE AREAS
#
	.text			# this is program code
	.align	2		# instructions must be on word boundaries
	.globl  main		# main is a global label
        .globl model            #idk if we need
        .globl printing
        .globl error_1
        .globl error_2


#
# EXECUTION BEGINS HERE
#
main:
        addi    $sp, $sp, -4
        sw	$ra, 0($sp)	
	# sw	$s7, 4($sp)	
	# sw	$s6, 0($sp)
        jal     print_header #just stub for printing algorithm.
        jal     print_grid
        jal     input_output

main_done:
        # lw	$s6, 0($sp)
        # lw	$s7, 4($sp)
	lw	$ra, 4($sp)	# restore the ra
	addi	$sp, $sp, 4	# deallocate stack space
	jr	$ra		# return from main and exit spim


#-------------------------------

# Name:		Print Header
# Description:	This function prints the header of 
#		the British Square Game 
# params:       none
# returns:      none
# Destroys:	t0, 
print_header: #line 422.

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

print_grid:   #this is going to be used to update.
        addi	$sp, $sp, -4
	sw	$ra, 0($sp)

print_grid_updating:

        printing_loop:
                la $t0, array
                lw $t1, length
                li $v0, PRINT_STRING
        p_loop:
                beq $t1, $zero, end
                lw $a0, 0($t0)
                syscall
                addi $t0, $t0, 4
                addi $t1, $t1, -1
                j    p_loop

        end:
                
        lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra



#-------------------------------

# Name:		input_output
# Description:	reads in input of user by integer array 
# Arguments:	a0:	the address of the array
# 		a1:	the max number of elements in the array
# Returns:      none
# Destroys:     t0,t1,t2
#


input_output:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)

        #li      $a1, 0    #don't load in arguments. 
        # li      $t0, 0
        # li      $t1, 3
        # move    $t1, $a0 #line 306 in merge_sort.asm # move a0 into t1
        # li      $v0, PRINT_STRING
        # la      $a0, input_text1
        # syscall




X_loop:
        #li      $a0, 3
        
        #beq     $t0, $a1, io_done
        li      $v0, PRINT_STRING
        la      $a0, input_text1
        syscall
        li      $v0, READ_INT
        syscall
        sw      $v0, 0($a1)
        la      $a2, parm_X
        jal     model           #will change prints based on condtion
                                # then we print those things
        # addi    $t0, $t0, 1
        # j       io_loop

        # display over here

O_loop:
        li      $v0, PRINT_STRING
        la      $a0, input_text2
        syscall
        li      $v0, READ_INT
        syscall
        sw      $v0, 0($a1)
        la      $a2, parm_O
        jal     model
        jal     X_loop





io_done:
        lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
        
        
        

error_1:
        li      $v0, PRINT_STRING
        la      $a0, error_1_text
        syscall
        lw      $t0, 0($a2)
        jalr    $t0

error_2:
        li      $v0, PRINT_STRING
        la      $a0, error_2_text
        syscall
        lw      $t0, 0($a2)
        jalr    $t0


        



#
# End of printing program.
#

# FIGURE OUT HOW TO FIX THE SQUARES. we can update a string array.
# should I empty the addresses of a0 afterwards?? 
# when a move is made, the view will be updated/called. 
# game conditions and such are stord in the system, the bored is all 
# stored in data structures. 
# once we export them we can re show them again in the function.
# see how to export a array like from virtual function box lab.
# and merge and sort on expandng and sending out arrays.

# MODEL:      where we will be changing board arrays and seeing input from 
# controller (like if controller said this load this 
# .word to print speciically. 
# VIEW:       where we will be doing loops to update board 
# CONTROLLER: where we will be doing askig i/o




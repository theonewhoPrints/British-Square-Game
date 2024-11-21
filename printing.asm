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
        .word row_13, num_row_14, default_row, game_header_text_3

length:
        .word 19 #look at how phil does it. 

X_moves_made:
        .space 100 # 4 * 25 moves a player can make

O_moves_made:
        .space 100 # 4 * 25 moves a player can make

X_amt_moves_made:
        .word 0

O_amt_moves_made: #should be on  bottomsss
        .word 0

O_illegal_moves:
        .space 100 # do a another loop so if there's smthn already inside we don't add it twice

X_illegal_moves:
        .space 100 # do a another loop so if there's smthn already inside we don't add it twice

O_illegal_indx:
        .word 0


X_illegal_indx:
        .word 0



parm_X:
        .word X_moves_made #0
        .word X_loop            #4
        #.word X_possible_moves
        .word X_amt_moves_made #8
        .word X                 #12
        .word O_illegal_moves   #16
        .word O_illegal_indx    #20
        .word quit_text_X

                


parm_O:
        .word O_moves_made
        .word O_loop
        #.word O_possible_moves 
        .word O_amt_moves_made
        .word O
        .word X_illegal_moves
        .word X_illegal_indx
        .word quit_text_O


##########################################################
        .align	0

X: #maybe make non null terminiating
        .asciiz "X" #let's instead load whichever one based on param.

O:
        .asciiz "O" #let's instead load whichever one based on param.

newline:
	.asciiz	"\n"

game_header_text_1:
        .asciiz "\n****************************\n"

game_header_text_2:
        .asciiz "**     British Square     **"

game_header_text_3:
        .asciiz "***********************\n"


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

hello:
        .asciiz "hello\n"

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

quit_text_X:
        .asciiz "\nPlayer X quit the game\n"

quit_text_O:
        .asciiz "\nPlayer O quit the game\n"



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
        .globl error_3
        .globl skip
        .globl X_moves_made
        .globl end_pr
        #.globl quitting


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
        jal     input_output #I can make into j 
        #j       main_done

        li      $v0, PRINT_STRING
        la      $a0, hello
        syscall


        lw	$ra, 0($sp)	# restore the ra
	addi	$sp, $sp, 4	# deallocate stack space
	j       done	# return from main and exit spim


# main_done:
#         # lw	$s6, 0($sp)
#         # lw	$s7, 4($sp)
#         li      $v0, PRINT_STRING
#         la      $a0, hello
#         syscall
# 	lw	$ra, 0($sp)	# restore the ra
# 	addi	$sp, $sp, 4	# deallocate stack space
# 	jr	$ra		# return from main and exit spim


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
        addi    $sp, $sp, -8
        sw      $ra, 4($sp)
        sw      $s0, 0($sp)



X_loop:
       
        li      $v0, PRINT_STRING
        la      $a0, input_text1
        syscall
        li      $v0, READ_INT
        syscall
        # sw      $v0, 0($a1) #switch to move later.
        move    $a1, $v0
        la      $a0, parm_O
        la      $a2, parm_X
        #la      $s0, O_loop
        la      $a3, array #might mess with s0 later used for opposite.
        #jal     play_1


        li      $t1, -2
        beq     $a1, $t1, quitting

        jal     model
        jal     print_grid           

        # display over here

O_loop:
        li      $v0, PRINT_STRING
        la      $a0, input_text2
        syscall
        li      $v0, READ_INT
        syscall
        # sw      $v0, 0($a1) #switch to move later.
        move    $a1, $v0
        la      $a0, parm_X
        la      $a2, parm_O
        #la      $s0, X_loop  #remeber to use proper adddress for this 
        la      $a3, array #might mess with s0 later used for opposite.

        li      $t1, -2
        beq     $a1, $t1, quitting

        #jal     play_1
        jal     model
        jal     print_grid
        j       X_loop






	
        
        
        

error_1:
        li      $v0, PRINT_STRING
        la      $a0, error_1_text
        syscall
        lw      $t0, 4($a2)
        jalr    $t0

error_2:
        li      $v0, PRINT_STRING
        la      $a0, error_2_text
        syscall
        lw      $t0, 4($a2)
        jalr    $t0


error_3:
        li      $v0, PRINT_STRING
        la      $a0, error_3_text
        syscall
        lw      $t0, 4($a2)
        jalr    $t0




skip:
        jalr    $s0

        
quitting:


        # addi	$sp, $sp, -4   
	# sw	    $ra, 0($sp)

        
        # lw	$ra, 4($sp)
        # lw      $s0, 0($sp)
	# addi	$sp, $sp, 8


        li      $v0, PRINT_STRING
        lw      $a0, 24($a2)
        syscall
        lw	$ra, 4($sp)
        lw      $s0, 0($sp)
	addi	$sp, $sp, 8
        jr      $ra
       

# io_done:
#         # li      $v0, PRINT_STRING
#         # la      $a0, hello
#         # syscall
#         lw	$ra, 4($sp)
#         lw      $s0, 0($sp)
# 	addi	$sp, $sp, 8
#         jr      $ra



done:



# end_pr:


#
# End of printing program.
#






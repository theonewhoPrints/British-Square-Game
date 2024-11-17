#
# FILE:         $File$
# AUTHOR:       Isaac Soares, RIT 2024
#               
# CONTRIBUTORS:
#	   I. Soares
#
# DESCRIPTION:
#	This file contains the functionality of moving around in british square

#-------------------------------


.text
.align 2 
# .globl printing
.globl model
.globl error_1
.globl error_2


#
# Name:         merge
# Description:  takes two individually sorted areas of an array and
#		merges them into a single sorted area
#
#		The two areas are defined between (inclusive)
#		area1:	low   - mid
#		area2:	mid+1 - high
#
#		Note that the area will be contiguous in the array
#
# Arguments:    a0:     a parameter block containing 3 values
#			- the address of the array to sort
#			- the address of the scrap array needed by merge
#			- the address of the compare function to use
#			  when ordering data
#               a1:     the index of the first element of the area
#               a2:     the index of the last element of the area
#               a3:     the index of the middle element of the area
# Returns:      none
# Destroys:     t0,t1
#





    .data 
    .align 2
    valid_input:
        .word -2,-1,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 
    length:
        .word 26




        .align 0
    print:
        .asciiz "hello"

    print1:
        .asciiz "hello again"
    


    .text
    .align 2
    .globl printing

model:
    #find a way to read input 
    # and for now print it to see present in file. 
    # load and assign addresses of memory read to a's and then passed here. 
    addi	$sp, $sp, -4
	sw	    $ra, 0($sp)
    # sw      $s0, 0($sp)

    # lw      $s0, 0($a1)
    jal check_if_num
    li      $v0, 4
    la      $a0, print
    syscall

    jal center_square
    li      $v0, 4
    la      $a0, print1
    syscall


    # lw      $s0, 0($sp)
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra


    # li      $v0, 1
    # move    $a0, $t0
    # syscall

    # addi    $sp, $sp, -12
    # sw	    $ra, 8($sp)	
	# sw	    $s7, 4($sp)	
	# sw	    $s6, 0($sp)
    # we can do a jal here for each check every time after a move. 



check_if_num:
    # addi    $sp, $sp don't rly have too 
    #         if al funcs are never used again
    #          here.

    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    la      $t0, valid_input
    lw      $t1, length
    lw      $t4, 0($a1)
    
check_if_num_loop:
    beq     $t1, $zero, end   # from index 0 -- 25  if it wasn't caught between those 26 
                            # we gotta end. 
    lw      $t3, 0($t0)     # per each valid input

    beq     $t3, $t4, valid  #if a valid input = user input we're good
    addi    $t0, $t0, 4
    addi    $t1, $t1, -1
   
    jal       check_if_num_loop


valid:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra 
   


end:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    # sw      $ra, 0($sp)
    jal     error_1
    # lw	$ra, 0($sp)
	# addi	$sp, $sp, 4
	# jr	$ra


center_square:
    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    lw      $t0, 0($a1)
    li      $t1, 12
    beq     $t0, $t1, end_2
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra

end_2:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jal     error_2


#jal do x, jal do 0 - based on who inputs so they can only both first share
# the error catching - + 1 for each of their moves made and a total 
#array for both of them combined
#after errors - right now do loops of between x and 0 - diff io loop for 
# both  - WE CAN USE A VBOX(POINTER) - point to next person 
# look at eperiment 4 for how to do stack for it maybe. 
# we will have to restore it(the pointer) - jalr does it well merge t2
# so we make a box, and for the box we load into it wether func1 or func 2 
# for that iteratio in same variable, so has to be emptied every time.
# actually a param box for each player, and load for that iteration.
#always load from parm when doing arithmetic, if current loaded, 
# goes back and also sees current loaded






    # what parts are going to be re-called and printed? 
    # let's look at the conditions and how they can be printed.
    # here we make the loops for things to be printed 
    #  RIGHT NOW JUST WORRY ABOUT ERRORS AND CONDITIONS YOU CAN HANDLE HERE FOR INPUT

    # the point of the stack is to load in times when you do jal, and after jal you 
    # go down on the stack to save that return address after the initial one. 

    # at the end then you do lw and addi a positive, and jr $ra

    # we do stack again on functions we want to return too, and then variable returns 
    # on variables we want back. 






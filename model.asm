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
.globl model
.globl error_1
.globl error_2
.globl error_3
.globl skip
.globl X_moves_made
.globl end_pr
#.globl quitting

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
        .word -1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 
    length:
        .word 26


    total_moves_made:
        .space 200

    tt_amt_moves_made:
        .word 0


    .text
    .align 2
    .globl printing



continue_play_1:

    addi	$sp, $sp, -4
	sw	    $ra, 0($sp)

    jal     check_if_num
    jal     if_neg1
    
    jal     center_square
    jal     store_move
    jal     update_grid


    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra
    

model:
    addi	$sp, $sp, -4   
	sw	    $ra, 0($sp)


    # la      $t0, tt_amt_moves_made #can be lw only.
    # lw      $t1, 0($t0)
    # beq     $t1, $zero, continue_play_1

    jal check_if_num

    
    # li      $t1, -2
    # beq     $a1, $t1, quit



    
    jal     if_neg1
   
    jal     if_made

    jal store_move
   
    jal update_grid
    
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra

# quit:
#     lw      $ra, 0($sp)
#     addi    $sp, $sp, 4
#     j       quitting

    


check_if_num:

    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    la      $t0, valid_input
    lw      $t1, length     
    move    $t4, $a1
    
check_if_num_loop:
    beq     $t1, $zero, end   # from index 0 -- 25  if it wasn't caught between those 26 
                            # we gotta end. 
    lw      $t3, 0($t0)     # per each valid input

    beq     $t3, $t4, valid  #if a valid input = user input we're good
    addi    $t0, $t0, 4      # check if this is actually saving.
    addi    $t1, $t1, -1
   
    j       check_if_num_loop


valid:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra 
   


end:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    j     error_1
   


center_square:
    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    # lw      $t0, 0($a1)         #should be s
    move    $t0, $a1
    li      $t1, 12             #should be s 
    beq     $t0, $t1, end_2
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra

end_2:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    j       error_2


if_neg1:
    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    move    $t0, $a1
    li      $t1, -1
    beq     $t0, $t1, repeat
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra

# if_neg2:
#     addi    $sp, $sp, -4
#     sw	    $ra, 0($sp)	
#     move    $t0, $a1
#     li      $t1, -2
#     beq     $t0, $t1, quit
#     lw      $ra, 0($sp)
#     addi    $sp, $sp, 4
#     jr      $ra

# quit:
#     lw      $ra, 0($sp)
#     addi    $sp, $sp, 4
#     j       quitting



repeat:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    j       skip    



store_move:
    addi    $sp, $sp, -4
    sw	    $ra, 0($sp)	
    
    lw      $t0, 8($a2)  # acess amt moves made
    lw      $t1, 0($t0)  #acess element in amt moves made

    la      $t6, tt_amt_moves_made #should be total_moves_made
    lw      $t7, 0($t6)


    lw      $t2, 0($a2) # access base address of arr to store moves
    la      $t8, total_moves_made
    mul     $t3, $t1, 4  # offset ( el * 4)
    mul     $t9, $t7, 4

    add     $t4, $t2, $t3 #add offset to base 
    add     $t5, $t8, $t9
    

    sw      $a1, 0($t4)     #store arg in offset pos in arr
    sw      $a1, 0($t5)

    addi    $t1, $t1, 1     #increment amt moves made

    addi    $t7, $t7, 1     #increment amt moves made

    sw      $t1, 0($t0)     #store back into first element in amt moves made.

    sw      $t7, 0($t6)     #store back into first element in amt moves made.

    

    lw      $t6, 20($a2) #total moves made  #maybe extra idk 
    lw      $t0, 0($t6)



    mul     $t2, $t0, 4
    lw      $t3, 16($a2)
    add    $t4, $t3, $t2
    li      $t5, 1
    add    $t5, $a1, $t5
    sw      $t5, 0($t4)
    addi    $t0, $t0,1
    #####
    mul     $t2, $t0, 4
    add    $t4, $t3, $t2
    li      $t5, -1
    add    $t5, $a1, $t5
    sw      $t5, 0($t4)
    addi    $t0, $t0,1
##########
    mul     $t2, $t0, 4
    add    $t4, $t3, $t2
    li      $t5, 5
    add    $t5, $a1, $t5
    sw      $t5, 0($t4)
    addi    $t0, $t0,1



    mul     $t2, $t0, 4
    add    $t4, $t3, $t2
    li      $t5, -5
    add    $t5, $a1, $t5
    sw      $t5, 0($t4)
    addi    $t0, $t0,1

    sw      $t0, 0($t6)


    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra


    # move    $a0, $t0
    # li      $v0, 1
    # syscall
    

    

if_made:
    addi    $sp, $sp, -20
    sw	    $ra, 16($sp)	
    sw      $s3, 12($sp)
    sw      $s2, 8($sp)
    sw      $s1, 4($sp)
    sw      $s0, 0($sp)


    
    lw      $s1, tt_amt_moves_made
    la      $s0, total_moves_made
    #might need the stack here or in if_made_loop.

if_made_loop: 
    
    beq     $s1, $zero, continue
    lw      $t2, 0($s0)    
    

    beq     $a1, $t2, invalid
    addi    $s0, $s0, 4
    addi    $s1, $s1, -1

    j       if_made_loop

continue:
    
    lw	    $ra, 16($sp)	
    lw      $s3, 12($sp)
    lw      $s2, 8($sp)
    lw      $s1, 4($sp)
    lw      $s0, 0($sp)
    addi    $sp, $sp, 20

    jr      $ra

invalid:
    lw	    $ra, 16($sp)	
    lw      $s3, 12($sp)
    lw      $s2, 8($sp)
    lw      $s1, 4($sp)
    lw      $s0, 0($sp)
    addi    $sp, $sp, 20
    j       error_3
    # lw      $ra, 0($sp)
    # addi    $sp, $sp, 4
    # jr      $ra

update_grid:
    addi    $sp, $sp, -24
    sw      $ra, 20($sp)
    sw      $s4, 16($sp)  
    sw      $s3, 12($sp)  
    sw      $s2, 8($sp)   
    sw      $s1, 4($sp)
    sw      $s0, 0($sp)      
    



    lw      $s0, 12($a2)        
    lb      $s1, 0($s0) 
    li      $t2, 1   

    
    
    lw      $s2, 16($a3)  
    lw      $s3, 12($a3)  
    li      $s4, 5              
    slt     $t1, $a1, $s4
    li      $s4, 0  
    beq     $t1, $t2, cont_func #only need to catch on condition 
                                # so t2 don't need to be saved.



    lw      $s2, 28($a3)  
    lw      $s3, 24($a3)  
    li      $s4, 10
    slt     $t1, $a1, $s4
    li      $s4, 5
    beq     $t1, $t2, cont_func


    lw      $s2, 40($a3)  
    lw      $s3, 36($a3)  
    li      $s4, 15
    slt     $t1, $a1, $s4
    li      $s4, 10
    beq     $t1, $t2, cont_func



    lw      $s2, 52($a3) 
    lw      $s3, 48($a3)  
    li      $s4, 20
    slt     $t1, $a1, $s4
    li      $s4, 15
    beq     $t1, $t2, cont_func

    lw      $s2, 64($a3)  
    lw      $s3, 60($a3)  
    li      $s4, 20

   
cont_func:
    
    li      $t3, 4        
    move    $t1, $a1

    sub    $t1, $t1, $s4

    mul     $t1, $t1, $t3  #I think we can use 4 here - instead of using mul with reg
    addi    $t1, $t1, 3 #first one too add too

    add     $s2, $s2, $t1
    add     $s3, $s3, $t1
    sb      $s1, 0($s2)
    sb      $s1, 0($s3)

    addi    $s2, $s2, 1
    addi    $s3, $s3, 1
    sb      $s1, 0($s2)
    sb      $s1, 0($s3)

    addi    $s2, $s2, -2
    addi    $s3, $s3, -2
    sb      $s1, 0($s3)
    sb      $s1, 0($s2) 

    lw      $ra, 20($sp)
    lw      $s4, 16($sp)  
    lw      $s3, 12($sp)  
    lw      $s2, 8($sp)   
    lw      $s1, 4($sp)
    lw      $s0, 0($sp)      
    addi    $sp, $sp, 24
    jr      $ra






    

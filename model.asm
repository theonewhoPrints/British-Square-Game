#
# FILE:         model
# AUTHOR:       Isaac Soares, RIT 2024
# SECTION NUMBER:
#               Section 3
#		
# DESCRIPTION:
#	This file contains the logic behind the British Square Game,
#	updates the data of the moves being made.
#
# ARGUMENTS:
#	a0: parameter box of opposing player
#   a1: user input
#   a2: parameter box for current player turn
#   a3: the array containing the grid
#
# INPUT:
# 	The Users input, alongside parameter boxes that update 
#
# OUTPUT:
#	data for the BritishSquare file to handle, including 
#   moves that were made, moves that can be made, etc.

#-------------------------------

#
# DATA AREAS
#

        .data
        .align  2   #initialize word boundariees.
valid_input:
        .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
        .word 24

length:
        .word 25

total_moves_made:
        .space 200

tt_amt_moves_made:
        .word 0

#-------------------------------

#
# CODE AREAS
#

        .text			# this is program code
	    .align  2		
        .globl  model
        .globl  error_1
        .globl  error_2
        .globl  error_3
        .globl  error_4	
        .globl  skip

#-------------------------------

# Name:		continue_play_1
# Description:	Logic for first move of the game
# Returns:      none
continue_play_1:
        jal     check_if_num

        jal     center_square
        jal     store_move
        jal     store_illegals

        jal     update_grid


        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra

#-------------------------------

# Name:		model
# Description:	handles executing lgoci functions of game in order.
# Returns:      none
# Destroys:     t0,t1
model:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)


        la      $t0, tt_amt_moves_made 
        lw      $t1, 0($t0)
        beq     $t1, $zero, continue_play_1     #  go too if at first move.

        jal    check_if_num

        jal     if_made
        jal     if_blocked

        jal     store_move
        jal     store_illegals
        jal     update_grid                     # modify ascii's of grid 

        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra

#-------------------------------

# Name:		check_if_num
# Description:	checks if input is a valid number.
# Arguments:	a1:	user input
# 		
# Returns:      none
# Destroys:     t0,t1,t3,t4
check_if_num:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)
        la      $t0, valid_input
        lw      $t1, length
        move    $t4, $a1

check_if_num_loop:
        beq     $t1, $zero, end     # if input not found in valid list,
                                    # end process and repeat
        lw      $t3, 0($t0)         # access list of valid inputs

        beq     $t3, $t4, valid     # if input in valid list, cont. process
        addi    $t0, $t0, 4
        addi    $t1, $t1, -1
        j       check_if_num_loop

valid:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra

end:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        j       error_1

#-------------------------------

# Name:		center_square
# Description:	determines if first move is middle stone (12)
# Arguments:	a1:	user input
# 		
# Returns:      none
# Destroys:     t0,t1
center_square:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)
        move    $t0, $a1
        li      $t1, 12 
        beq     $t0, $t1, end_2     # when input = 12, process must restart.

        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra

end_2:
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        j       error_2
#-------------------------------

# Name:		store_move
# Description:	stores the move a player makes in corresponding relevant arrays.
# Arguments:	a1:	user input
# 		        a2: parameter box of current player turn
# Returns:      none
# Destroys:     t0,t1,t2,t3,t4,t5,t6,t7,t8,t9
store_move:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)	

        # PLAYER 
        lw      $t0, 8($a2)  
        lw      $t1, 0($t0)     # total players's amount of moves made 
        sll     $t3, $t1, 2     
        lw      $t2, 0($a2)     # X's stones array

        add     $t4, $t2, $t3   # add offset to base 
        sw      $a1, 0($t4)     # store current stone in X's stone array
        addi    $t1, $t1, 1     
        sw      $t1, 0($t0)     # load number of moves made back 
                               
        # TOTAL
        la      $t6, tt_amt_moves_made  
        lw      $t7, 0($t6)     # total number of moves made 
        sll     $t9, $t7, 2 
        
        la      $t8, total_moves_made
        
        # calculating address position
        add     $t5, $t8, $t9
        sw      $a1, 0($t5)     # store current stone in total stone array.
        addi    $t7, $t7, 1  
        sw      $t7, 0($t6)     # load number of moves made back
                              
        lw      $ra, 0($sp) 
        addi    $sp, $sp, 4
        jr      $ra

#-------------------------------

# Name:		store_illegals
# Description:	determines and stores moves other player cannot make
# Arguments:    a0: opposing players paramter box
#           	a1:	user input
#               a2: parameter box of current player turn
# Returns:      none
# Destroys:     t0,t1,t2,t3,t4,t5  
store_illegals:
        addi    $sp, $sp, -8
        sw      $ra, 4($sp)	
        sw      $s0, 0($sp)

        
        lw      $t0, 20($a0)    # opposing player illegal moves amount address
        lw      $t1, 0($t0)     # opposing illegal moves amount index value.

        mul     $t2, $t1, 4  

        lw      $t3, 16($a0)    #current actual stones illegal


        add     $t4, $t3, $t2 
        sw      $a1, 0($t4)
        addi    $t1, $t1,1

        sw      $t1, 0($t0)     # add index back

        lw      $t0, 20($a2)    # current playes illegal amount address
        lw      $t1, 0($t0)  


        mul     $t2, $t1, 4  


        lw      $t3, 16($a2) 

        add     $t4, $t3, $t2 
        sw      $a1, 0($t4)
        addi    $t1, $t1,1
        sw      $t1, 0($t0)

        ######### CHECKERS FOR LEFT #########
        move    $s0, $a1
        li      $t1, 0
        beq     $t1, $s0, edge_add_lt       # if a move is on the left side, 
        move    $s0, $a1                    # calculate left blocked moves.
        li      $t1, 5
        beq     $t1, $s0, edge_add_lt
        move    $s0, $a1
        li      $t1, 10
        beq     $t1, $s0, edge_add_lt
        move    $s0, $a1
        li      $t1, 15
        beq     $t1, $s0, edge_add_lt
        move    $s0, $a1
        li      $t1, 20
        beq     $t1, $s0, edge_add_lt
    

        ######### CHECKERS FOR RIGHT #########
        li      $t1, 4
        beq     $t1, $s0, edge_add_rt       # if a move is on the right side, 
        move    $s0, $a1                    # calculate right blocked moves.
        li      $t1, 9
        beq     $t1, $s0, edge_add_rt
        move    $s0, $a1
        li      $t1, 14
        beq     $t1, $s0, edge_add_rt
        move    $s0, $a1
        li      $t1, 19
        beq     $t1, $s0, edge_add_rt
        move    $s0, $a1
        li      $t1, 24
        beq     $t1, $s0, edge_add_rt
   
        ######### MIDDLE STONES #########
        jal     plus_one                
        jal     minus_one
        jal     plus_five
        jal     minus_five       

        lw      $ra, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra

edge_add_lt:
        jal     plus_one
        jal     plus_five
        jal     minus_five
        lw      $ra, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra

edge_add_rt:
        jal     minus_one
        jal     plus_five
        jal     minus_five
        lw      $ra, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 8
        jr      $ra

plus_one:

        addi    $sp, $sp, -12
        sw      $ra, 8($sp)	
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s1, 20($a2)        
        lw      $s0, 0($s1)         # Current players illegal_moves amount
    
        mul     $t2, $s0, 4  
      
        lw      $t3, 16($a2)        # load illegal moves word arr addr. 

        add     $t4, $t3, $t2 
        li      $t5, 1
        add     $t5, $a1, $t5
        sw      $t5, 0($t4)         # store the created illegal move.
        addi    $s0, $s0,1

        sw      $s0, 0($s1)         # store length/index of now illegal move

        
        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12        # re allocate stack for jump back
        jr      $ra

minus_one:
        addi    $sp, $sp, -12
        sw      $ra, 8($sp)	
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s1, 20($a2) 
        lw      $s0, 0($s1)  
        
        mul     $t2, $s0, 4  
       
        lw      $t3, 16($a2) 

        add     $t4, $t3, $t2 
        li      $t5, -1
        add     $t5, $a1, $t5
        sw      $t5, 0($t4)
        addi    $s0, $s0,1

        sw      $s0, 0($s1)
       
        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12
        jr      $ra

plus_five:
        addi    $sp, $sp, -12
        sw      $ra, 8($sp)	
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s1, 20($a2) 
        lw      $s0, 0($s1)  
       
        mul     $t2, $s0, 4 
     
        lw      $t3, 16($a2) 

        add     $t4, $t3, $t2 
        li      $t5, 5
        add     $t5, $a1, $t5
        sw      $t5, 0($t4)
        addi    $s0, $s0,1

        sw      $s0, 0($s1)
       
        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12
        jr      $ra

minus_five:
        addi    $sp, $sp, -12
        sw      $ra, 8($sp)	
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s1, 20($a2) 
        lw      $s0, 0($s1)  
        
        mul     $t2, $s0, 4  
        
        lw      $t3, 16($a2) 

        add     $t4, $t3, $t2 
        li      $t5, -5
        add     $t5, $a1, $t5
        sw      $t5, 0($t4)
        addi    $s0, $s0,1

        sw      $s0, 0($s1)
       
        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12
        jr      $ra

#-------------------------------

# Name:		if_blocked 
# Description:	determines if a current move is blocked or not.
# Arguments:    a0: opposing players paramter box
#           	
# Returns:      none
# Destroys:     t2,t3
if_blocked: 
        addi    $sp, $sp, -12
        sw      $ra, 8($sp)	
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s0, 16($a0)        # this is the illegal moves 
        lw      $s1, 20($a0)       
        lw      $t3, 0($s1)         # indexes of illegal moves

forloop: 
        beq     $t3, $zero, cont    # if not present in illegal, resume process
        lw      $t2, 0($s0) 
        beq     $a1, $t2, blocked   # if present in illegal, restart process

        addi    $s0, $s0, 4
        addi    $t3, $t3, -1
        j       forloop

cont:

        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12
        jr      $ra

blocked:
        lw      $ra, 8($sp)	
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 12
        j       error_4				

 #-------------------------------

# Name:		if_made
# Description:	determines if a current move has yet to be made.
# Arguments:    none
#           	
# Returns:      none
# Destroys:     t2
if_made:
        addi    $sp, $sp, -20
        sw      $ra, 16($sp)
        sw      $s3, 12($sp)
        sw      $s2, 8($sp)
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s1, tt_amt_moves_made
        la      $s0, total_moves_made

if_made_loop:
        beq     $s1, $zero, continue        # if not in made, continue process
        lw      $t2, 0($s0)

        beq     $a1, $t2, invalid           # if present in made, restart
        addi    $s0, $s0, 4
        addi    $s1, $s1, -1

        j       if_made_loop                # continue until a above conds. met

continue:
        lw      $ra, 16($sp)
        lw      $s3, 12($sp)
        lw      $s2, 8($sp)
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 20
        jr      $ra

invalid:
        lw      $ra, 16($sp)
        lw      $s3, 12($sp)
        lw      $s2, 8($sp)
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp, $sp, 20
        j       error_3

#-------------------------------

# Name:		update_grid
# Description:	updates the grid after a valid move is confirmed.
# Arguments:    a2: current players vbox.
#           	a3: address of array holding chars that create grid.
# Returns:      none
# Destroys:     t1,t2,t3
update_grid:
        addi    $sp, $sp, -24
        sw      $ra, 20($sp)
        sw      $s4, 16($sp)
        sw      $s3, 12($sp)
        sw      $s2, 8($sp)
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

        lw      $s0, 12($a2)
        lb      $s1, 0($s0)         # from curr player param box access X or O
        li      $t2, 1

        lw      $s2, 16($a3)        # load in different words of array to mod.
        lw      $s3, 12($a3)
        li      $s4, 5
        slt     $t1, $a1, $s4
        li      $s4, 0
        beq     $t1, $t2, cont_func # comparison computation to see which 
                                    # sectors to change in grid arr.
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

        sub     $t1, $t1, $s4       # calculate positions to change 

        mul     $t1, $t1, $t3 
        addi    $t1, $t1, 3 

        add     $s2, $s2, $t1
        add     $s3, $s3, $t1
        sb      $s1, 0($s2)         # store byte back once changed.
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

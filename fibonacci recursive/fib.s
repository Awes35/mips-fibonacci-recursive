	# Program to display nth term of fibonacci sequence, based on recursive calculation
	# term "n" is specified by user input (integer).
	# prompt user input, call fibonacci function, print out resulting value

	# Written by Kollen G


        .data
        .align  2
prompt:	.asciiz	"\nEnter n'th term of Fib sequence to be computed: "
result:	.asciiz	"\nThe value of the n'th Fib sequence term is: "

#--------------------------------
        .text
       	.globl	main
       	
main:
	move	$s0, $0		# s0 : computed Fibonacci value
	
	la 	$a0, prompt	#load prompt string
	li 	$v0, 4		#code to print string
	syscall			#print

	li 	$v0, 5		#take int input
	syscall
	move	$s1, $v0	# s1 = user input
	
	move	$a0, $s1
	jal	fib
	move	$s0, $v0	# s0 = result from fib
	j	print

#------ Display results and exit ---------------------------------

print:
	la 	$a0, result	#load display string
	li 	$v0, 4		#code to print string
	syscall			#print
	
	li 	$v0, 1		#code to print int
	move	$a0, $s0	#load computed fibonacci
	syscall			#print

#----------------- Exit ---------------------
	li	$v0, 10
	syscall


	
#******************************************************************
	# fib function
	#
	# a0 - user input "n"
	# 
    	#
    	# v0 - computed fib	
fib:
#--------------- Usual stuff at function beginning  ---------------
        addi    $sp, $sp, -24
        sw	$ra, 20($sp)
        sw	$s0, 16($sp)
        sw	$s1, 12($sp)
        sw	$s2, 8($sp)
        sw	$s3, 4($sp)
        sw	$s4, 0($sp)
#-------------------------- function body -------------------------
	move    $s0, $a0        # s0: set to n
        li      $t1, 1          # t1: set to 1 for base case test

        # base cases
        ble     $s0, 0, done    # if (n==0)
        ble     $s0, 1, done    # if (n==1)
        
        #recursive calls
        addi	$a0, $s0, -1	# a0 = (n-1)
        jal	fib		# compute
        move	$s1, $v0	# s1 = fib(n-1)
        
        addi	$a0, $s0, -1	# a0 = (n-2)
        jal	fib		# compute
        move	$s2, $a0	# s2 = fib(n-2)
        sll	$s2, $s2, 2	# s2 = 4 * fib(n-2)
        
        add	$t1, $s1, $s2	# t1 = fib(n-1) + 4*fib(n-2)
done:	move	$v0, $t1

#-------------------- Usual stuff at function end -----------------
        lw  	$ra, 20($sp)
        lw	$s0, 16($sp)
        lw	$s1, 12($sp)
        lw	$s2, 8($sp)
        lw	$s3, 4($sp)
        lw	$s4, 0($sp)        
        addi	$sp, $sp, 24
        jr      $ra



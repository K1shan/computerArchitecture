.data

prompt:       .asciiz "Enter twenty integers.\n"
newl:         .asciiz "\n"
output1:      .asciiz "Your integer is at element :"
uinput:       .asciiz "Please input integer to search in :"      
      
      
              .align 2
array:        .space 80

              .text

main:  
       li $v0,4                    #print_string
       la $a0,prompt               #prompting message from prompt lable
       syscall              
  
       la $s0, array               #loading address of array
       li $s1,20                   # size of array  

loop:   
       li $v0,5                    #read_integer
       syscall              
       sw $v0,0($s0)               #storing value from $v0 into address of $s0
       addi $s0,$s0,4              #adding 4 each time user loop
       addi $s1,$s1,-1             #decrement 1 each time loop
       bnez $s1,loop               #loop again
      
ask:
       li $v0,4
       la $a0,uinput
       syscall
       li $v0,5                    #read_int
       syscall
       move $s2,$v0                #$s2 is no.
      
       li $t0,0                    #intialize

       la $s0,array                #loading address of array
      
      
      
loop2:  
  
      
       add $t0,$t0,1               #increament $t0 by 1 to change location
       lw $s3, 0($s0)              #loading word at address
       beq $s2,$s3,found           #checking that search_key is equal to words
       addi,$s0,$s0,4              #increament the address by 4 so we can get new word
      
  
       bne $t0,$s1,loop2           #if $t0 != $s1 then loop
      
found:
       move $t1,$t0                #move $t0 into $t1
      
       j out_put

notfound:
       beq $t1,$s1,exit
       j loop2

out_put:      
       li $v0,4                    #print_string
       la $a0,output1              #prompting message from output1
       syscall
       li $v0,1                    #print_int
       move $a0,$t1                #load location of element into $a0 to print
       syscall
       li $v0,4                    #print_string
       la $a0,newl                 #printing newline
       syscall
      
       j ask                     #going to ask again
      
exit:
       li $v0,4
       syscall
       li $v0, 10
       syscall


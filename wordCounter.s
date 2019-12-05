# Write wcFlattened in assembly language

# VARIABLES: the registers have the follwing uses:
#
# %r10 - lineCount in c program
# %r12 - wordCount
# %r13 - charCount
# %r14 - i in c program
# %r15 - iInWord in c program
# %rax - holds current char from getchar

.section .data
# .data indicate what memory storage will be required
format: .asciz "%7d%8d%8d\n"

.section .text
# .text contains prgram instructions


.globl main

main:


 movq $0, %rax
 push %rbp
 call getchar # rax should have current char
 movq %rax, %r14
 popq %rbp

 #Assign 0 to variables to reset the unexpected value change
 movq $0, %r10
 movq $0, %r12
 movq $0, %r13
 movq $0, %r15

#Start a loop
start_loop:
 cmpq $255, %r14
 jg loop_exit
 

 incq %r13


 #AA here
 movq %rax, %rdi
 call isSpaceCharacter
 cmpq $0, %rax
 je exit_AA
  cmpq $0, %r15
  je exit_AA_inner
  incq %r12
  movq $0, %r15
 exit_AA_inner: 
 jmp exit_BB
exit_AA: 
 

#BB here
 cmpq $0, %r15
 jne exit_BB
 movq $1, %r15
exit_BB:
 

#CC here
 cmpq $10, %r14
 jne exit_CC
 incq %r10
exit_CC:
 
 
 movq $0, %rax
 push %rbp
 call getchar # rax should have current char
 movq %rax, %r14
 popq %rbp
 jmp start_loop
loop_exit:



#DD here
 cmpq $0, %r15
 je exit_DD
 incq %r12
exit_DD: 
 
 


 #printf part
 push %rbp
 lea format, %rdi
 movq %r10, %rsi
 movq %r12, %rdx
 movq %r13, %rcx
 call printf
 pop %rbp
 
ret
 int $0x80


.type isSpaceCharacter, @function
isSpaceCharacter:
 push %rbp
 movq %rsp,%rbp

 cmpq $32,%rdi
 je method_exit
 cmpq $9,%rdi
 je method_exit
 cmpq $10,%rdi
 je method_exit
 cmpq $11, %rdi
 je method_exit
 cmpq $12, %rdi
 je method_exit
 cmpq $13, %rdi
 je method_exit 

 movq $0,%rax
 movq %rbp,%rsp
 popq %rbp
 ret
method_exit:
 movq $1,%rax
 movq %rbp, %rsp
 popq %rbp
 ret









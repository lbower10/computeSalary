#
# Author: Logan Bowers
# Description: This program computes total of all
#   salaries for ten employees
# Register Usage:
#   rax to hold mulq values 
#   rdi acts as "i" in mainLoop,
#   rbx holds memory address for hours array 
#   rcx holds mem address for rates array
#   r13 holds mem address for salaries array
#   r8 used to hold total
#   r9 used to hold value in rax on line 45
#   r10 holds hours on line 49
#   r11 holds $40 for multiplication 
#   r12 holds $2 for multiplication

.data
    n: .quad 10
    hours: .quad 1, 40, 45, 4, 20, 19, 65, 2, 9, 10
    rates: .quad 10, 7, 15, 8, 12, 9, 7, 8, 9, 10
    salaries: .quad 0,0,0,0,0,0,0,0,0,0
    total: .quad 0
.text
.global main
main:
    movq $0, %r8    # r8 gets 0 here, will get total at end
    movq $0, %rdi   # rdi = 0
    movq $hours, %rbx
    movq $rates, %rcx
    movq $salaries, %r13
mainLoop: cmp n, %rdi   # i > n?
    jge endLoop
    cmp $40, (%rbx, %rdi, 8)    # if hours <= 40 
    jg overTime                 # else go to overTime label
    movq (%rbx, %rdi, 8), %rax
    imulq (%rcx, %rdi, 8)   # rax = hours[i]*rates[i]
    movq %rax, (%r13, %rdi, 8)  # salaries[i] = whats in rax
    addq %rax, %r8  # total += salaries[i]
    incq %rdi   # i++
    jmp mainLoop
overTime:
    movq (%rcx, %rdi, 8), %rax  # move rates into rax
    movq $40, %r11
    imulq %r11       # rax *= 40
    movq %rax, %r9
    movq (%rcx, %rdi, 8), %rax  # move rates into rax
    movq $2, %r12
    imulq %r12        # rax *= 2
    movq (%rbx, %rdi, 8), %r10  # move hours to r10
    subq $40, %r10
    imulq %r10
    addq %rax, %r9  # 40*rate[i]+(hours[i]-40)*rates[i]*2 
    movq %r9, (%r13, %rdi, 8)   # salaries[i] = whats in r9
    incq %rdi
    addq %r9, %r8   # total += salaries[i]
    jmp mainLoop
endLoop:
    movq %r8, total # move whats in r8 into total
    movq $1, %rax   # end program system calls
    movq $0, %rbx
    int $0x80
    retq


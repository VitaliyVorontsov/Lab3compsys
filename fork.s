.include "defs.h"

.section .bss
n: .quad 0
pid: .quad 0

.section .data
nforks: .quad 5

.section .text
.global _start

newline: .byte '\n'

_start:
fork:
        movq $SYS_FORK, %rax
        syscall

        movq %rax, pid

        cmp $0, pid
        jne parent

child:
        movq nforks, %rcx
        addq $0x30, %rcx
        movq %rcx, n

        movq $SYS_WRITE, %rax
        movq $STDOUT, %rdi
        movq $n, %rsi
        movq $1, %rdx
        syscall

        decb nforks

        cmp $0, nforks
        je end
        jne fork

parent:
        movq $SYS_WAIT4, %rax
        movq pid, %rdi
        movq $0, %rsi
        movq $0, %rdx
        movq $0, %r10
        syscall

end:
        movq $SYS_WRITE, %rax
        movq $STDOUT, %rdi
        movq $newline, %rsi
        movq $1, %rdx
        syscall

        movq $SYS_EXIT, %rax
        movq $0, %rdi
        syscall


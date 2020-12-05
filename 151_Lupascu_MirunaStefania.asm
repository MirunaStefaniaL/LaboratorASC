.data
	matrix: .space 1600
	n: .space 4
	m: .space 4
	role: .space 80
	visited: .space 80
	q: .space 80
	mal: .space 80
	
	lines: .space 4
	columns: .space 4
	
	primulMal: .space 4
 	lg: .space 4
 	nod: .space 4
 	index: .space 4
 	
 	lineIndex: .space 4
	columnIndex: .space 4
 	
 	ct: .space 4
 	x: .space 4
 	y: .space 4
 	task : .space 4
 	b: .space 4
 	
 	ascii: .space 4
 	
 	newLine: .asciz "\n"	
	virgula: .asciz "; "
	puncte: .asciz ": "
	malit: .asciz "switch malitios index %d"
	host: .asciz "host index %d"
	switch: .asciz "switch index %d"
	controller: .asciz "controller index %d"
	
	Yes: .asciz "Yes\n"
 	No: .asciz "No\n"
 	
 	formatRead1: .asciz "%d"
 	formatRead2: .asciz "%d %d"
 	formatHost: .asciz "host index %d"
 	formatReadStr: .asciz "%s"
 	str: .space 80
 	
 	
 	
 	
.text
.globl main

//edi matrice
//esi role


main:
	movl $0, index

    	pushl $n
    	push $formatRead1
    	call scanf
    	popl %ebx
    	popl %ebx
 
    	pushl $m
    	push $formatRead1
    	call scanf
    	popl %ebx
    	popl %ebx
 
    	movl $0, index
    	lea matrix, %edi
    	lea role, %esi
 
et_citire:
    movl index, %ecx
    cmp m, %ecx
    je vector
 
    pushl $y
    pushl $x
    push $formatRead2
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx
 
    //liniarizat
    movl x, %eax
    movl n, %ebx
    movl $0, %edx
    mull %ebx
    addl y, %eax
    movl $1, (%edi, %eax, 4)
 
    movl y, %eax
    movl n, %ebx
    movl $0, %edx
    mull %ebx
    addl x, %eax
    movl $1, (%edi, %eax, 4)
 
    addl $1, index
    jmp et_citire
    
vector:
	movl $0, index
	
for_vector:
	mov index, %ecx
	cmp n, %ecx
	je cerinta
	
	push $x
	push $formatRead1
	call scanf
	pop %ebx
	pop %ebx
	
	movl index, %eax
	movl x, %ebx
	movl %ebx, (%esi, %eax, 4)
	
	addl $1, index
	jmp for_vector
 
cerinta:

	push $task
	push $formatRead1
	call scanf
	pop %ebx
	pop %ebx
	
	cmp $1, task
	je initializare1
	
	cmp $2, task
	je initializare2
	
	cmp $3, task
	je cerinta3
	
	//si cele 2 extremitati
	
cerinta3:
	
	pushl $y
    	pushl $x
    	push $formatRead2
    	call scanf
    	popl %ebx
    	popl %ebx
    	popl %ebx
    	
    	lea str, %esi
    	
    	jmp string

string:
	
	 push $str
	 push $formatReadStr
	 call scanf
	 pop %ebx
	 pop %ebx
	 
	 jmp initializare3

//	 
//CERINTA1
//
	 
initializare1:

	movl $0, lineIndex
	movl n, %eax
	movl %eax, columns
	
	movl n, %eax
	movl %eax, lines 
	
	jmp for_lines1
	
for_lines1:
	
	movl $0, ct
	
	movl lineIndex, %ecx
	movl lines, %ebx
	cmp %ebx, %ecx
	je etexit
	
	movl $0, columnIndex
	
	movl lineIndex, %ecx
	movl (%esi, %ecx, 4), %ebx
	cmp $3, %ebx 
	je malitios1
	
	add $1, lineIndex
	jmp for_lines1
	

malitios1:

	//afisam si o linie noua 
	movl ct, %eax
	addl $1, %eax
	addl $1, ct
	movl $1, %ebx
	cmp %ebx, %eax
	je verif_primul1
	
	movl lineIndex, %ecx
	
	push %ecx
	push $malit
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	push $puncte
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp for21

	
for21:	
	
	//incepe al doilea for
	movl columnIndex, %eax
	movl columns, %ebx
	cmp %ebx, %eax
	je cont_for_lines1
	
	//prelucrare
	movl $0, %edx
	
	movl lineIndex, %eax
	movl columns, %ecx
	mull %ecx
	addl columnIndex, %eax
	
	movl (%edi, %eax, 4), %ecx
	cmp $1, %ecx
	je afisare1
	
	add $1, columnIndex
	jmp for21
	
cont_for_lines1:
	addl $1, lineIndex
	jmp for_lines1

afisare1:
	
	movl columnIndex, %ecx
	movl (%esi, %ecx, 4), %ebx
	
	cmp $1, %ebx
	je afisare_host1
	
	cmp $2, %ebx
	je afisare_switch1
	
	cmp $3, %ebx
	je afisare_malitios1
	
	cmp $4, %ebx
	je afisare_controller1

verif_primul1:
	addl $1, primulMal
	movl primulMal, %ebx
	cmp $1, %ebx
	jne afisare_linie_noua1
	
	jmp malitios1
		
afisare_linie_noua1:
	push $newLine
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp malitios1
			
	
afisare_host1:
	movl columnIndex, %ebx
	
	pushl %ebx
	push $host
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp afisare_virgula1


afisare_switch1:
	movl columnIndex, %ebx
	
	pushl %ebx
	push $switch
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp afisare_virgula1
	
	
afisare_malitios1:
	movl columnIndex, %ebx
	
	pushl %ebx
	push $malit
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp afisare_virgula1

afisare_controller1:
	movl columnIndex, %ebx
	
	pushl %ebx
	push $controller
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp afisare_virgula1

afisare_virgula1:
	push $virgula
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	add $1, columnIndex
	jmp for21

//
//CERINTA2
//

initializare2:

	movl $0, nod
	
	movl $1, %eax
	movl %eax, lg
	movl $0, %eax
	movl %eax, index
	//il adaugam pe 0
	 
	lea q, %esi
	movl $0, %eax
	movl $0, (%esi, %eax, 4)
	
	lea visited, %esi
	movl $1, (%esi, %eax, 4)
	
	jmp et_while2
	
et_while2:
	movl index, %ecx
	cmp lg, %ecx
	je et_conex2
	
	//nodul curent in q
	lea q, %esi
	movl (%esi, %ecx, 4), %ebx
	movl %ebx, nod
	
	addl $1, index
	
	//verificam daca este host
	//role[nod] =eax
	lea role, %esi
	movl (%esi, %ebx, 4), %eax
	
	cmp $1, %eax
	je afisare_host2
	
	movl $0, columnIndex
	jmp continue_2while2

afisare_host2:

	movl nod, %eax
	pushl %eax
	push $formatHost
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	push $virgula
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	movl $0, columnIndex
	jmp continue_2while2
	
continue_2while2:
	
	movl columnIndex, %ebx
	cmp n, %ebx
	je et_while2
	
	movl $0, %edx
	movl nod, %eax
	movl n, %ebx
	mull %ebx
	addl columnIndex, %eax
	
	//elementul din matrice
	movl (%edi, %eax, 4), %ebx
	
	cmp $1, %ebx
	je nevizitat2
	
	addl $1, columnIndex
	jmp continue_2while2
	
nevizitat2:
	lea visited, %esi
	movl columnIndex, %ebx
	movl (%esi, %ebx, 4), %eax
	
	cmp $0, %eax
	je adauga_coada2
	
	addl $1, columnIndex
	jmp continue_2while2

adauga_coada2:
	movl columnIndex, %ebx
	movl lg, %eax
	
	//l am adaugat in coada
	lea q, %esi
	movl %ebx, (%esi, %eax, 4)
	addl $1, lg
	
	//l am vizitat
	lea visited, %esi
	movl $1, (%esi, %ebx, 4)
	
	add $1, columnIndex
	jmp continue_2while2
	
et_conex2:
	//parcurgem visited
	
	push $newLine
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	movl $0, index
	jmp et_for2
	
et_for2:
	movl index, %ecx
	cmp n, %ecx
	je afisare_conex2
	
	lea visited, %esi
	movl (%esi, %ecx, 4), %ebx
	
	cmp $0, %ebx	
	je afisare_nu_conex2
	
	addl $1, index
	jmp et_for2
	
afisare_nu_conex2:
	push $No
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp etexit
	
afisare_conex2:
	push $Yes
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp etexit
//
//CERINTA3
//
initializare3:
	movl $0, index
	jmp initializare_mal3

initializare_mal3:
	movl index, %ecx
	cmp n, %ecx
	je incepe3
	
	lea role, %esi
	movl (%esi, %ecx, 4), %ebx
	
	cmp $3, %ebx
	je adauga3
	
	addl $1, index
	jmp initializare_mal3
	
adauga3:
	lea mal, %esi
	movl index, %ecx
	movl $1, (%esi, %ecx, 4)
	
	addl $1, index
	jmp initializare_mal3
	
incepe3:
	
	lea matrix, %edi
	
	movl  $0, index
	movl $1, lg
	
	movl $0, %eax
	
	lea q, %esi
	movl x, %ebx
	movl %ebx, (%esi, %eax, 4)
	
	lea visited, %esi
	movl x, %eax
	movl $1, %ebx
	movl %ebx, (%esi, %eax, 4)
	
	jmp et_while3

et_while3:
	movl index, %ecx
	cmp lg, %ecx
	je et_verificare3
	
	//nodul curent in q
	lea q, %esi
	movl (%esi, %ecx, 4), %ebx
	movl %ebx, nod
	
	addl $1, index
	
	movl $0, columnIndex
	jmp continue_2while3


continue_2while3:
	
	movl columnIndex, %ebx
	cmp n, %ebx
	je et_while3
	
	lea mal, %esi
	movl (%esi, %ebx, 4), %eax
	
	movl $0, %edx
	cmp %edx, %eax
	je not_mal3
	
	addl $1, columnIndex
	jmp continue_2while3

not_mal3:
	movl $0, %edx
	movl nod, %eax
	movl n, %ebx
	mull %ebx
	addl columnIndex, %eax
	
	//elementul din matrice
	movl (%edi, %eax, 4), %ebx
	
	movl $1, %edx
	cmp %edx, %ebx
	je nevizitat3
	
	addl $1, columnIndex
	jmp continue_2while3
	
nevizitat3:

	lea visited, %esi
	movl columnIndex, %ebx
	movl (%esi, %ebx, 4), %eax
	
	movl $0, %edx
	cmp %edx, %eax
	je adauga_coada3
	
	addl $1, columnIndex
	jmp continue_2while3

adauga_coada3:
	movl columnIndex, %ebx
	movl lg, %eax
	
	//l am adaugat in coada
	lea q, %esi
	movl %ebx, (%esi, %eax, 4)
	addl $1, lg
	
	//l am vizitat
	lea visited, %esi
	movl $1, (%esi, %ebx, 4)
	
	add $1, columnIndex
	jmp continue_2while3
	
et_verificare3:
	
	movl y, %ebx
	lea visited, %esi
	movl (%esi, %ebx, 4), %eax
	
	movl $0, %ebx
	
	lea str, %esi
	movl $0, index
	
	cmp %eax, %ebx
	je nesigur3	
	
	jmp afisare3
	
modifica3:
	//cat este diferenta
	movb ascii, %ah
	addb $26, %ah
	
	movl index, %ecx
	movb %ah, (%esi, %ecx, 1)
	addl $1, index
	jmp nesigur3
	
nesigur3:
	movl index, %ecx
	movb (%esi, %ecx, 1), %al
	cmp $0, %al
	je afisare3
	
	subb $10, %al
	mov %al, ascii
	
	mov $97, %ah
	cmp %ah, %al
	jl modifica3
	
	movb %al, (%esi, %ecx, 1)
	addl $1, index
	jmp nesigur3

afisare3:
	push $str
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	jmp etexit	
	
etexit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
		
	 

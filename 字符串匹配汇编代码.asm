#$a0=len_str, $a1=*str, $a2=len_pattern, $a3=*pattern
addi $a0 $zero 60   		#len_str
addi $a1 $zero 0    		#*str
addi $a2 $zero 4    		#len_pattern
addi $a3 $zero 400  		#*pattern
#$t0=i, $t1=j, $s0=cnt          #int i, j, cnt
addi $t0 $0  0	
addi $s0 $0  0
#t2=len_str - len_pattern+1
sub $t2 $a0 $a2
addi $t2 $t2 1 
#t3=len_pattern+1
addi $t3 $a2 1
for_loopi:
	beq $t0,$t2,end_loopi
	  addi $t1 $0  0 			#t1��j=0
	  for_loopj:
	  beq $t1,$t3 end_loopj
	    add $t4 $t0 $t1			#$t4=i + j
	    add $t5 $t4 $a1			#&str[i+j]=&str[0]+i+j
	    lb $t6 0($t5)			#str[i + j]
	    add $t4 $t1 $a3			#&pattern[j]=&pattern[0]+j
	    lb $t5 0($t4)			#pattern[j]
	    addi $t1 $t1 1			#j += 1
	    bne $t5 $t6 end_loopj 		#if(str[i + j] != pattern[j]) break
	    j for_loopj
	    end_loopj:
        addi $t0 $t0 1				#i += 1 
	beq $t1,$t3,count              		#j+1==len_pattern+1
	j for_loopi
	  count:
	  addi $s0 $s0 1
	  j for_loopi
end_loopi:
add $v0 $0 $s0

addi $s0 $zero 0

Print:
srl $t0 $s0 12
andi $t0 $t0 3
addi $t1 $zero 0
beq $t0 $t1 AN0
addi $t1 $t1 1
beq $t0 $t1 AN1
addi $t1 $t1 1
beq $t0 $t1 AN2
addi $t1 $t1 1
beq $t0 $t1 AN3

AN0:
addi $s1 $zero 0x100
andi $t2 $v0 0x000F 
j AN_exit

AN1:
addi $s1 $zero 0x200
andi $t2 $v0 0x00F0
srl $t2 $t2 4
j AN_exit

AN2:
addi $s1 $zero 0x400
andi $t2 $v0 0x0F00
srl $t2 $t2 8
j AN_exit

AN3:
addi $s1 $zero 0x800
andi $t2 $v0 0xF000
srl $t2 $t2 12

AN_exit:
addi $t1 $zero 0
beq $t2 $t1 BCD0
addi $t1 $t1 1
beq $t2 $t1 BCD1
addi $t1 $t1 1
beq $t2 $t1 BCD2
addi $t1 $t1 1
beq $t2 $t1 BCD3
addi $t1 $t1 1
beq $t2 $t1 BCD4
addi $t1 $t1 1
beq $t2 $t1 BCD5
addi $t1 $t1 1
beq $t2 $t1 BCD6
addi $t1 $t1 1
beq $t2 $t1 BCD7
addi $t1 $t1 1
beq $t2 $t1 BCD8
addi $t1 $t1 1
beq $t2 $t1 BCD9
addi $t1 $t1 1
beq $t2 $t1 BCDa
addi $t1 $t1 1
beq $t2 $t1 BCDb
addi $t1 $t1 1
beq $t2 $t1 BCDc
addi $t1 $t1 1
beq $t2 $t1 BCDd
addi $t1 $t1 1
beq $t2 $t1 BCDe
addi $t1 $t1 1
beq $t2 $t1 BCDf

BCD0:
addi $t3 $zero 0x003F
j BCD_exit

BCD1:
addi $t3 $zero 0x0006
j BCD_exit

BCD2:
addi $t3 $zero 0x005B
j BCD_exit

BCD3:
addi $t3 $zero 0x004F
j BCD_exit

BCD4:
addi $t3 $zero 0x0066
j BCD_exit

BCD5:
addi $t3 $zero 0x006D
j BCD_exit

BCD6:
addi $t3 $zero 0x007D
j BCD_exit

BCD7:
addi $t3 $zero 0x0007
j BCD_exit

BCD8:
addi $t3 $zero 0x007F
j BCD_exit

BCD9:
addi $t3 $zero 0x006F
j BCD_exit

BCDa:
addi $t3 $zero 0x0077
j BCD_exit

BCDb:
addi $t3 $zero 0x007C
j BCD_exit

BCDc:
addi $t3 $zero 0x0039
j BCD_exit

BCDd:
addi $t3 $zero 0x005E
j BCD_exit

BCDe:
addi $t3 $zero 0x0079
j BCD_exit

BCDf:
addi $t3 $zero 0x0071

BCD_exit:
add $s2 $s1 $t3
addi $t4 $zero 0x4000
sll $t4 $t4 16
addi $t4 $t4 0x0010
sw $s2 0($t4)
addi $s0 $s0 1
j Print

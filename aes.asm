; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
org 100h   
.data segment 
    SBOX db 0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76
     db 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0
     db 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15
     db 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75
     db 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84
     db 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF
     db 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8
     db 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2
     db 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73
     db 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB
     db 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79
     db 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08
     db 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A
     db 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E
     db 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF
     db 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16

     STATE db 0x32, 0x88,0x31,0xe0
     db 0x43, 0x5a, 0x31, 0x37
     db 0xf6,0x30, 0x98, 0x07
     db 0xa8, 0x8d, 0xa2, 0x34   
     
state2 db  16 DUP(?)  
key2 db 16 DUP(?)       
RCONSTANT DW 0
     
Key db 16 DUP(?) 

MATRIX DB 02H,03H,01H,01H,01H,02H,03H,01H,01H,01H,02H,03H,03H,01H,01H,02H  
RCON DB 01H,02H,04H,08H,10H,20H,40H,80H,1BH,36H      



OUTPUT PROC   
    PUSH SI 
    PUSH CX 
    PUSH BX 
    XOR BX,BX
    MOV SI,0 
    MOV AH,02H 
    MOV CX,16
    L_OUTPUT:  
    MOV DL,STATE[SI]
    MOV BL,STATE[SI]
    AND DL,11110000b
    AND BL,00001111b
    SHR DL,4
    CMP DL,9
    JBE NUMBER_1
    JMP CHAR_1
    NUMBER_1:
    ADD DL,48  ;zero starts from 48
    INT 21H
    JMP SECOND
    SECOND:
    MOV DL,BL
    CMP DL,9
    JBE NUMBER_2
    JMP CHAR_2
    NUMBER_2:
    ADD DL,48   
    INT 21H
    JMP ENDOUT 
    CHAR_1: 
    ADD DL,55 ;as A starts from 65
    INT 21H
    JMP SECOND 
    CHAR_2:
    ADD DL,55
    INT 21H
    JMP ENDOUT 
    
    ENDOUT: 
    MOV DL,' '
    INT 21H
    INC SI
    LOOP L_OUTPUT
    POP BX
    POP CX
    POP SI 
    ret 
    OUTPUT ENDP 

INPUT_STATE PROC  
    PUSH SI 
    PUSH CX 
    PUSH BX 
    PUSH AX
    XOR BX,BX 
    XOR AX,AX
    MOV SI,0  
    MOV CX,16
    INPUT_ARRAY:
    MOV AH,1
    INT 21H
    CMP AL,57
    JBE DIGIT_1
    JMP CHARAC_1
    DIGIT_1:
    SUB AL,48
    MOV BH,AL
    JMP LOWER
    CHARAC_1:
    SUB AL,55
    MOV BH,AL
    JMP LOWER
    LOWER:
    MOV AH,1
    INT 21H 
    MOV BL,AL
    CMP BL,57
    JBE DIGIT_2
    JMP CHARAC_2
    DIGIT_2:
    SUB BL,48
    JMP END_IN
    CHARAC_2:
    SUB BL,55
    JMP END_IN
    END_IN:
    SHL BH,4
    XOR BL,BH
    MOV STATE[SI],BL
    INC SI 
    MOV AH,02H
    MOV DL,' '
    INT 21H
    LOOP INPUT_ARRAY
  
    POP AX
    POP BX
    POP CX
    POP SI
    ret 
    INPUT_STATE ENDP   
INPUT_KEY PROC  
    PUSH SI 
    PUSH CX 
    PUSH BX 
    PUSH AX
    XOR BX,BX 
    XOR AX,AX
    MOV SI,0  
    MOV CX,16
    INPUT_ARRAY_2:
    MOV AH,1
    INT 21H
    CMP AL,57
    JBE DIGIT_1_2
    JMP CHARAC_1_2
    DIGIT_1_2:
    SUB AL,48
    MOV BH,AL
    JMP LOWER_2
    CHARAC_1_2:
    SUB AL,55
    MOV BH,AL
    JMP LOWER_2
    LOWER_2:
    MOV AH,1
    INT 21H 
    MOV BL,AL
    CMP BL,57
    JBE DIGIT_2_2
    JMP CHARAC_2_2
    DIGIT_2_2:
    SUB BL,48
    JMP END_IN_2
    CHARAC_2_2:
    SUB BL,55
    JMP END_IN_2
    END_IN_2:
    SHL BH,4
    XOR BL,BH
    MOV KEY[SI],BL
    INC SI   
    MOV AH,02H
    MOV DL,' '
    INT 21H
    LOOP INPUT_ARRAY_2
  
    POP AX
    POP BX
    POP CX
    POP SI
    ret 
    INPUT_KEY ENDP

SubBytes PROC       
    push cx
    XOR SI,0 ; monitors index in state array 
    XOR AX,AX
    MOV CX,16
    LSUB:MOV AL,state[SI]
    MOV DI,AX  ; DI used to find index in SBOX array= lower_4_bits+16*higher_4_bits= index in hexa 
    MOV BL,SBOX[DI]
    MOV state[SI],BL
    INC SI 
    LOOP LSUB 
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI 
    pop cx
    ret 
    SubBytes ENDP 


ShiftRows PROC   
    push cx
    ;for i=1 
    MOV SI,4 
    XOR BX,BX
    MOV BL,STATE[SI]
    PUSH BX 
    MOV CX,3
    LOOP_ROW1: 
    INC SI 
    MOV AL,STATE[SI]
    DEC SI
    MOV STATE[SI],AL
    INC SI
    LOOP LOOP_ROW1
    POP BX 
    MOV STATE[7],BL 
    ;for i=2 
    MOV SI,8 
    XOR BX,BX 
    MOV BL,STATE[SI]
    PUSH BX
    INC SI 
    MOV BL,STATE[SI]
    PUSH BX 
    MOV CX,2
    LOOP_ROW2:
    INC SI 
    MOV AL,STATE[SI]
    SUB SI,2
    MOV STATE[SI],AL
    ADD SI,2
    LOOP LOOP_ROW2
    POP AX 
    POP BX 
    MOV STATE[10],BL
    MOV STATE[11],AL
    ;for i=3 
    MOV SI,15 
    XOR BX,BX
    MOV BL,STATE[SI]
    PUSH BX
    MOV CX,3
    LOOP_ROW3:
    DEC SI
    MOV AL,STATE[SI]
    INC SI
    MOV STATE[SI],AL
    DEC SI
    LOOP LOOP_ROW3
    POP BX
    MOV STATE[12],BL  
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI  
    pop cx
    ret
    ShiftRows ENDP 

MixColumns PROC   ;calls MultiplyBy2 and MultiplyBy3 
    push cx 
    XOR CX,CX
    ;FIRST ROW 
    MOV SI,0  
    FIRST_ROW: 
    XOR BX,BX
    PUSH SI
    MOV DI,0  
    MOV DL,4
    INNER_LOOP1:  
    MOV AL,State[SI]
    MOV AH,MATRIX[DI] 
    CMP AH,2  
    JZ MUL2
    CMP AH,3
    JZ MUL3
    JMP end
    MUL2: CALL MultiplyBy2 
    JMP end
    MUL3: CALL MultiplyBy3 
    JMP end 
    end:   
    INC DI 
    ADD SI,4
    XOR BL,AL
    DEC DL
    JNZ INNER_LOOP1 
    
    POP SI
    MOV state2[SI],BL
    INC SI 
    CMP SI,4 
    JNZ FIRST_ROW 
     
    ;SECOND ROW 
    MOV CX,0 
    MOV SI,4
    SECOND_ROW: 
    XOR BX,BX
    PUSH SI 
    MOV SI,CX
    MOV DI,4  
    MOV DL,4
    INNER_LOOP2:  
    MOV AL,State[SI]
    MOV AH,MATRIX[DI] 
    CMP AH,2  
    JZ MUL2_2
    CMP AH,3
    JZ MUL3_2
    JMP end2
    MUL2_2: CALL MultiplyBy2 
    JMP end2
    MUL3_2: CALL MultiplyBy3 
    JMP end2 
    end2:   
    INC DI 
    ADD SI,4
    XOR BL,AL
    DEC DL
    JNZ INNER_LOOP2 
    
    POP SI
    MOV state2[SI],BL
    INC SI 
    INC CX
    CMP CX,4
    JNZ SECOND_ROW 
    
    
    
    ;THIRD ROW 
    MOV CX,0 
    MOV SI,8
    THIRD_ROW: 
    XOR BX,BX
    PUSH SI 
    MOV SI,CX
    MOV DI,8  
    MOV DL,4
    INNER_LOOP3:  
    MOV AL,State[SI]
    MOV AH,MATRIX[DI] 
    CMP AH,2  
    JZ MUL2_3
    CMP AH,3
    JZ MUL3_3
    JMP end3
    MUL2_3: CALL MultiplyBy2 
    JMP end3
    MUL3_3: CALL MultiplyBy3 
    JMP end3 
    end3:   
    INC DI 
    ADD SI,4
    XOR BL,AL
    DEC DL
    JNZ INNER_LOOP3 
    
    POP SI
    MOV state2[SI],BL
    INC SI 
    INC CX
    CMP CX,4
    JNZ THIRD_ROW    
    
    
    ;FOURTH ROW 
    MOV CX,0 
    MOV SI,12
    FOURTH_ROW: 
    XOR BX,BX
    PUSH SI 
    MOV SI,CX
    MOV DI,12  
    MOV DL,4
    INNER_LOOP4:  
    MOV AL,State[SI]
    MOV AH,MATRIX[DI] 
    CMP AH,2  
    JZ MUL2_4
    CMP AH,3
    JZ MUL3_4
    JMP end4
    MUL2_4: CALL MultiplyBy2 
    JMP end4
    MUL3_4: CALL MultiplyBy3 
    JMP end4 
    end4:   
    INC DI 
    ADD SI,4
    XOR BL,AL
    DEC DL
    JNZ INNER_LOOP4 
    
    POP SI
    MOV state2[SI],BL
    INC SI 
    INC CX
    CMP CX,4
    JNZ FOURTH_ROW  
    
    ;to move from temporary state2 to original state
    XOR SI,SI 
    MOV CX,16   
    move: MOV AL,STATE2[SI]
    MOV STATE[SI],AL  
    INC SI
    Loop move
     
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI   
    pop cx
    ret
    MixColumns ENDP  



;multiplication by x (i.e., {00000010} or {02}) can be implemented at the byte level as a left shift and a subsequent conditional bitwise XOR with {1b}
MultiplyBy2 PROC  
    CMP AL,80H 
    JAE MultiplyByIrreduciblePoly
    SHL AL,1 
    JMP end1 
    MultiplyByIrreduciblePoly: 
    SHL AL,1
    XOR AL,1BH
    end1: ret
    MultiplyBy2 ENDP

;multiplication by 3 is multiplication by 2 followed by XORing with the number to be multiplied by 3 
MultiplyBy3 PROC 
    PUSH BX
    MOV BL,AL
    CALL MultiplyBy2
    XOR AL,BL
    POP BX
    ret 
    MultiplyBy3 ENDP
      
AddRoundKey PROC 
    push CX
    MOV SI,0 
    MOV CX,16 
    LRoundKey: MOV AL,state[SI]
    MOV BL,key[SI]
    XOR AL,BL
    MOV state[SI],AL 
    INC SI
    Loop LRoundKey 
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI 
    pop CX
    ret 
    AddRoundKey ENDP  


KeyScheduling PROC 
    ;First Column in new Key
    ;RotWord
    PUSH BX 
    PUSH DI  
    PUSH CX 
    PUSH SI
    MOV BL,key[3] 
    MOV CX,3 
    MOV DI,3 
    MOV SI,0
    LRotWord: 
    ADD DI,4  
    MOV BH, key[DI]
    SUB DI,4
    MOV KEY2[SI],BH
    ADD DI,4  
    ADD SI,4
    LOOP LRotWord
    MOV Key2[SI],BL  
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI
    POP SI 
    POP CX
    POP DI 
    POP BX     
    ;SubWord
    PUSH BX 
    PUSH DI  
    PUSH CX 
    PUSH SI
    XOR SI,0 
    XOR AX,AX
    LSUBWORD:MOV AL,key2[SI]
    MOV DI,AX   
    MOV BL,SBOX[DI]
    MOV key2[SI],BL
    ADD SI,4 
    CMP SI,16
    JNZ LSUBWORD
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI 
    POP SI 
    POP CX
    POP DI 
    POP BX
    ;XORing with Rcon
    PUSH BX 
    PUSH DI  
    PUSH CX 
    PUSH SI  
    MOV SI,0 
    MOV CX,16  
    MOV DI,RCONSTANT
    LXOR: MOV AL,key2[SI]
    MOV BL,key[SI]
    XOR AL,BL
    MOV key2[SI],AL 
    ADD SI,4
    CMP SI,16
    JNZ LXOR 
    MOV AL,key2[0]
    MOV BL,RCON[DI]
    XOR AL,BL 
    MOV KEY2[0],AL
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI 
    POP SI 
    POP CX
    POP DI 
    POP BX 
    ;Remaining three rows
    PUSH BX 
    PUSH DI  
    PUSH CX 
    PUSH SI 
    MOV SI,1 
    MOV DI,0
    OUTERLOOPKEY:
    PUSH SI
    PUSH DI 
    MOV CX,4
    INNERLOOPKEY:
    MOV AL,key[SI]
    MOV BL,key2[DI] 
    XOR AL,BL  
    MOV key2[SI],AL 
    ADD SI,4  
    ADD DI,4
    LOOP INNERLOOPKEY
    POP DI 
    POP SI 
    INC SI 
    INC DI
    CMP SI,4
    JNZ OUTERLOOPKEY 
    
    ;Change key to new key
    MOV CX,16 
    MOV SI,0
    MOVE_KEY:
    MOV BL,KEY2[SI]
    MOV KEY[SI],BL
    INC SI
    LOOP MOVE_KEY
    
    XOR SI,SI
    XOR AX,AX
    XOR CX,CX
    XOR BX,BX
    XOR DI,DI 
    POP SI 
    POP CX
    POP DI 
    POP BX
    
    ret
    KeyScheduling ENDP  


                 
                
.code segment 
    MOV AH,2
    MOV DL,'P'
    INT 21H
    
    MOV AH,2
    MOV DL,'l'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'a'
    INT 21H
    MOV AH,2
    MOV DL,'s'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'n'
    INT 21H
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'y'
    INT 21H
    MOV AH,2
    MOV DL,'o'
    INT 21H
    MOV AH,2
    MOV DL,'u'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'p'
    INT 21H
    MOV AH,2
    MOV DL,'l'
    INT 21H
    MOV AH,2
    MOV DL,'a'
    INT 21H
    MOV AH,2
    MOV DL,'i'
    INT 21H
    MOV AH,2
    MOV DL,'n'
    INT 21H
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'x'
    INT 21H
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,':'
    INT 21H 
    MOV AH,2
    MOV DL,' ' 
    INT 21H
    CALL INPUT_STATE
    INT 21H
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV DL, 13
    MOV AH, 02h
    INT 21H 
    MOV AH,2
    MOV DL,'P' 
    INT 21H
    MOV AH,2
    MOV DL,'l'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'a'
    INT 21H
    MOV AH,2
    MOV DL,'s'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'n'
    INT 21H
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'y'
    INT 21H
    MOV AH,2
    MOV DL,'o'
    INT 21H
    MOV AH,2
    MOV DL,'u'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H 
    MOV AH,2
    MOV DL,'k'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'y'
    INT 21H
    MOV AH,2
    MOV DL,':'
    INT 21H 
    MOV AH,2
    MOV DL,' ' 
    INT 21H  
    CALL INPUT_KEY 
    CALL AddRoundKey    
    MOV CX,0  
    MAIN_LOOP:
    CALL SubBytes 
    CALL ShiftRows 
    CALL MixColumns   
    CALL KeyScheduling  
    CALL AddRoundKey
    INC CX 
    INC Rconstant
    CMP CX,9
    JNZ MAIN_LOOP 
    
    CALL SubBytes 
    CALL ShiftRows
    CALL KeyScheduling 
    CALL AddRoundKey 
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV DL, 13
    MOV AH, 02h
    INT 21h
    MOV AH,2
    MOV DL,'Y'
    INT 21H
    MOV AH,2
    MOV DL,'o'
    INT 21H
    MOV AH,2
    MOV DL,'u'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H 
    MOV AH,2
    MOV DL,' '
    INT 21H
    MOV AH,2
    MOV DL,'c'
    INT 21H
    MOV AH,2
    MOV DL,'i'
    INT 21H
    MOV AH,2
    MOV DL,'p'
    INT 21H
    MOV AH,2
    MOV DL,'h'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'r'
    INT 21H 
    
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,'e'
    INT 21H
    MOV AH,2
    MOV DL,'x'
    INT 21H
    MOV AH,2
    MOV DL,'t'
    INT 21H
    MOV AH,2
    MOV DL,':'
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    CALL OUTPUT 
      
   
    
   
ret


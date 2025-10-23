.DATA

    IMAGE DQ ?
    SYSTEMTABLE DQ ?
    WAITFORKEY DQ ?
    OUTPUTSTRING DQ ?
    WAITFOREVENT DQ ?

    CONVERTED DW 16 DUP(0)
        DW 0
    
    KeyCharBuffer DW 0,0

    EFI_INPUT_KEY STRUCT
        ScanCode    WORD ?
        UnicodeChar WORD ?
    EFI_INPUT_KEY ENDS

    KeyBuffer EFI_INPUT_KEY <>

    EFI_TIME STRUCT
        Year        WORD ?
        Month       WORD ?
        Day         WORD ?
        Hour        WORD ?
        Minute      WORD ?
        Second      WORD ?
        Pad1        BYTE ?
        Nanosecond  DWORD ?
        TimeZone    WORD ?
        Daylight    BYTE ?
        Pad2        BYTE ?
    EFI_TIME ENDS

    TimeBuffer EFI_TIME <>

    RETURNWITHLFCR DW 0AH, 0DH, 0

    CMDEXIT DW 'E', 'X', 'I', 'T'
        DW 0AH, 0DH, 0

    MSGOUTED DW 'M', 'A', 'D', 'E', ' ', 'B', 'Y', ' ', 'S', 'H', 'A', 'D', 'E', 'Y', 'K', 'I', 'R', 'B', 'Y'
        DW 0AH, 0DH, 0

    MSGSTART DW 'W', 'R', 'I', 'T', 'E', ' ', 'A', 'N', 'Y', 'T', 'H', 'I', 'N', 'G', ' ', 'Y', 'O', 'U', ' ', 'W', 'A', 'N', 'T'
        DW 0AH, 0DH, 0

    MSGRLEXIT DW 0AH, 0DH, 'P', 'R', 'E', 'S', 'S', ' ', 'A', 'N', 'Y', ' ', 'K', 'E', 'Y', ' ', 'T', 'O', ' ', 'E', 'X', 'I', 'T'
        DW 0AH, 0DH, 0

    MSGEXIT DW 'T', 'O', ' ', 'E', 'X', 'I', 'T', ' ', 'P', 'R', 'E', 'S', 'S', ' ', 'C', 'T', 'R', 'L', '+', 'C'
        DW 0AH, 0DH, 0


    INCLUDE efiservices.inc

.CODE
EFI_MAIN PROC
    MOV IMAGE, RCX
    MOV SYSTEMTABLE, RDX


    LEA RDX, [MSGOUTED]
    CALL UEFI_ConsoleOutputString

    LEA RDX, [MSGSTART]
    CALL UEFI_ConsoleOutputString

    LEA RDX, [MSGEXIT]
    CALL UEFI_ConsoleOutputString

    LOOP_START:
        MOV RCX, 01H
        CALL UEFI_KeyEvent

        LEA RDX, [KeyBuffer]
        CALL UEFI_ReadKeyStroke

        movzx   eax, word ptr [KeyBuffer + 2]
        CMP EAX, 0003H
        JE LOOPEND

        movzx   eax, word ptr [KeyBuffer + 2]
        CMP EAX, 000DH
        JE ENTERED

        MOV AX, WORD PTR [KeyBuffer + 2]
        MOV [KeyCharBuffer], AX
        MOV WORD PTR [KeyCharBuffer + 2], 0
        LEA RDX, [KeyCharBuffer]
        CALL UEFI_ConsoleOutputString
        
        JMP LOOP_START

        ENTERED:

            LEA RDX, [RETURNWITHLFCR]
            CALL UEFI_ConsoleOutputString

            JMP LOOP_START

    LOOPEND:

    LEA RDX, [MSGRLEXIT]
    CALL UEFI_ConsoleOutputString

    MOV RCX, 01H
    CALL UEFI_KeyEvent

    LEA RDX, [KeyBuffer]
    CALL UEFI_ReadKeyStroke

    LEA RCX, [TimeBuffer]
    CALL UEFI_GetTime

    LEA RDX, [TimeBuffer.Year]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString

    
    LEA RDX, [TimeBuffer.Month]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString

    
    LEA RDX, [TimeBuffer.Day]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString

    
    LEA RDX, [TimeBuffer.Hour]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString

    
    LEA RDX, [TimeBuffer.Minute]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString


    LEA RDX, [TimeBuffer.Second]
    LEA RCX, [CONVERTED]
    CALL convhextostr

    LEA RDX, [CONVERTED]
    CALL UEFI_ConsoleOutputString


    LEA RDX, [RETURNWITHLFCR]
    CALL UEFI_ConsoleOutputString

    MOV RAX, 0
    RET

EFI_MAIN ENDP

INCLUDE x64uefi.inc

EFI_CALLED:
    CLRTBL:
        MOV RCX, IMAGE
        MOV RDX, SYSTEMTABLE
        RET

    convhextostr:
        push    rax
        push    rbx
        push    rcx
        push    rdx
        push    rsi
        push    rdi
        push    r9

        mov     rbx, rcx
        movzx   eax, word ptr [rdx]
        xor     esi, esi

    loop_div:
        xor     edx, edx
        mov     edi, 10
        div     edi
        add     dl, '0'
        mov     word ptr [rbx + rsi*2], dx
        inc     esi
        cmp     eax, 0
        jne     loop_div

        mov     rcx, rsi
        shr     rcx, 1
        cmp     rcx, 0
        je      no_swap
        xor     rdi, rdi
    swap_loop:
        mov     ax, word ptr [rbx + rdi*2]
        mov     r9, rsi
        dec     r9
        sub     r9, rdi
        mov     dx, word ptr [rbx + r9*2]
        mov     word ptr [rbx + rdi*2], dx
        mov     word ptr [rbx + r9*2], ax
        inc     rdi
        cmp     rdi, rcx
        jl      swap_loop
    no_swap:
        mov     word ptr [rbx + rsi*2], 0

        pop     r9
        pop     rdi
        pop     rsi
        pop     rdx
        pop     rcx
        pop     rbx
        pop     rax
        ret

END
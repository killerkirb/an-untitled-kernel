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

    MOV RAX, 0
    RET

EFI_MAIN ENDP

INCLUDE x64uefi.inc

EFI_CALLED:
    CLRTBL:
        MOV RCX, IMAGE
        MOV RDX, SYSTEMTABLE
        RET
END
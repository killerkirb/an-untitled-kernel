UEFI_ConsoleOutputString:
    mov     rax, SYSTEMTABLE
    mov     rax, [rax + EFI_SYSTEM_TABLE_ConOut]
    
    mov     rcx, rax
    mov     rax, [rax + CONOUT_OutputString]
    call    rax
    ret



UEFI_ReadKeyStroke:
    mov rax, SYSTEMTABLE
    mov rax, [rax + EFI_SYSTEM_TABLE_ConIn]
    mov rcx, rax
    mov rax, [rax + CONIN_ReadKeyStroke]
    call rax
    ret

UEFI_EVENTLISTENER:
    mov rax, SYSTEMTABLE
    mov rax, [rax + EFI_SYSTEM_TABLE_BootServices]
    mov rax, [rax + BS_WaitForEvent]
    mov WAITFOREVENT, rax
    ret

UEFI_KeyEvent:
    call UEFI_EVENTLISTENER
    mov rax, SYSTEMTABLE
    mov rax, [rax + EFI_SYSTEM_TABLE_ConIn]
    lea rdx, [rax + CONIN_WaitForKey]
    mov rax, qword ptr [WAITFOREVENT]
    call rax
    ret


UEFI_GetTime:
    mov rax, SYSTEMTABLE
    mov rax, [rax + EFI_SYSTEM_TABLE_RuntimeServices]
    mov rax, [rax + RT_GetTime]
    call rax
    ret
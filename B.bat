@echo off
set /p "nam=Enter file name (without extension):"

ml64 /nologo %nam%.asm /c /Fo %nam%.obj
link /nologo /SUBSYSTEM:EFI_APPLICATION /ENTRY:EFI_MAIN /MACHINE:X64 %nam%.obj /OUT:%nam%.efi

copy %nam%.efi builds /Y


@echo on

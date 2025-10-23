; ---------- EFI_SYSTEM_TABLE offsets (relative to start of EFI_SYSTEM_TABLE) ----
EFI_SYSTEM_TABLE_Hdr              equ 0H
EFI_SYSTEM_TABLE_FirmwareVendor   equ 18H
EFI_SYSTEM_TABLE_FirmwareRevision equ 20H
EFI_SYSTEM_TABLE_ConsoleInHandle  equ 28H
EFI_SYSTEM_TABLE_ConIn            equ 30H
EFI_SYSTEM_TABLE_ConsoleOutHandle equ 38H
EFI_SYSTEM_TABLE_ConOut           equ 40H
EFI_SYSTEM_TABLE_StandardErrorHandle equ 48H
EFI_SYSTEM_TABLE_StdErr           equ 50H
EFI_SYSTEM_TABLE_RuntimeServices  equ 58H
EFI_SYSTEM_TABLE_BootServices     equ 60H
EFI_SYSTEM_TABLE_NumberOfTableEntries equ 68H
EFI_SYSTEM_TABLE_ConfigurationTable equ 70H

; --- EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL Offsets ---
CONOUT_Reset               equ 0H
CONOUT_OutputString        equ 8H
CONOUT_TestString          equ 10H
CONOUT_QueryMode           equ 18H
CONOUT_SetMode             equ 20H
CONOUT_SetAttribute        equ 28H
CONOUT_ClearScreen         equ 30H
CONOUT_SetCursorPosition   equ 38H
CONOUT_EnableCursor        equ 40H
CONOUT_Mode                equ 48H

; --- EFI_SIMPLE_TEXT_INPUT_PROTOCOL Offsets ---
CONIN_Reset          equ 0H
CONIN_ReadKeyStroke  equ 8H
CONIN_WaitForKey     equ 10H

; ---------- EFI_BOOT_SERVICES offsets (relative to start of EFI_BOOT_SERVICES) ----
BS_RaiseTPL                          equ 18H
BS_RestoreTPL                        equ 20H
BS_AllocatePages                     equ 28H
BS_FreePages                         equ 30H
BS_GetMemoryMap                      equ 38H
BS_AllocatePool                      equ 40H
BS_FreePool                          equ 48H
BS_CreateEvent                       equ 50H
BS_SetTimer                          equ 58H
BS_WaitForEvent                      equ 60H
BS_SignalEvent                       equ 68H
BS_CloseEvent                        equ 70H
BS_CheckEvent                        equ 78H
BS_InstallProtocolInterface          equ 80H
BS_ReinstallProtocolInterface        equ 88H
BS_UninstallProtocolInterface        equ 90H
BS_HandleProtocol                    equ 98H
BS_Reserved                          equ A0H
BS_RegisterProtocolNotify            equ A8H
BS_LocateHandle                      equ B0H
BS_LocateDevicePath                  equ B8H
BS_InstallConfigurationTable         equ C0H
BS_LoadImage                         equ C8H
BS_StartImage                        equ D0H
BS_Exit                             equ D8H
BS_UnloadImage                       equ E0H
BS_ExitBootServices                  equ E8H
BS_GetNextMonotonicCount             equ F0H
BS_Stall                             equ F8H
BS_SetWatchdogTimer                  equ 100H
BS_ConnectController                 equ 108H
BS_DisconnectController              equ 110H
BS_OpenProtocol                      equ 118H
BS_CloseProtocol                     equ 120H
BS_OpenProtocolInformation           equ 128H
BS_ProtocolsPerHandle                equ 130H
BS_LocateHandleBuffer                equ 138H
BS_LocateProtocol                    equ 140H
BS_InstallMultipleProtocolInterfaces equ 148H
BS_UninstallMultipleProtocolInterfaces equ 150H
BS_CalculateCrc32                    equ 158H
BS_CopyMem                           equ 160H
BS_SetMem                            equ 168H
BS_CreateEventEx                     equ 170H

; ---------- EFI_RUNTIME_SERVICES offsets (relative to start of EFI_RUNTIME_SERVICES) ----
RT_GetTime                          equ 18H
RT_SetTime                          equ 20H
RT_GetWakeupTime                    equ 28H
RT_SetWakeupTime                    equ 30H
RT_SetVirtualAddressMap             equ 38H
RT_ConvertPointer                   equ 40H
RT_GetVariable                      equ 48H
RT_GetNextVariableName              equ 50H
RT_SetVariable                      equ 58H
RT_GetNextHighMonotonicCount        equ 60H
RT_ResetSystem                      equ 68H
RT_UpdateCapsule                    equ 70H
RT_QueryCapsuleCapabilities         equ 78H
RT_QueryVariableInfo                equ 80H

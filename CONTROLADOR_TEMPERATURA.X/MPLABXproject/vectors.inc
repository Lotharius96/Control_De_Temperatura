;******************************************************************************
;   This file is a basic template for assembly code for a PIC18F25K50. Copy    *
;   this file into your project directory and modify or add to it as needed.  *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on the         *
;   features of the assembler.                                                *
;                                                                             *
;   Refer to the PIC18Fx5K5X Data Sheet for additional                    *
;   information on the architecture and instruction set.                      *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:   vectors.inc                                                             *
;    Date:         March 10th 2015                                                           *
;    File Version:  1.0                                                          *
;                                                                             *
;    Author:      FZAMORA                                                            *
;    Company:     CEX.com.co                                                            *
;                                                                             *
;******************************************************************************
;                                         



;FOR C18 HID BOOTLOADER (ref: Raul bootloader
;#define REMAPPED_APPLICATION_RESET_VECTOR       0x121E
;#define REMAPPED_APPLICATION_HIGH_ISR_VECTOR    0x1208
;#define REMAPPED_APPLICATION_LOW_ISR_VECTOR     0x1218
;#define BOOTLOADER_ABSOLUTE_ENTRY_ADDRESS       0x001C  ;//Execute a
;"_asm goto 0x001C _endasm" instruction, if you want to enter the bootloader
; mode from the application via software




;FOR ASM HID BOOTLOADER (adaptado a SAKA bootloader
#if nobootloader
	#define REMAPPED_APP_RESET_VECTOR		0x0
	#define REMAPPED_APP_HIGH_ISR_VECTOR	0x8
	#define REMAPPED_APP_LOW_ISR_VECTOR		0x18	
#else	
	#define REMAPPED_APP_RESET_VECTOR		0x800
	#define REMAPPED_APP_HIGH_ISR_VECTOR	0x808
	#define REMAPPED_APP_LOW_ISR_VECTOR		0x818
	#define BOOTLOADER_ABSOLUTE_ENTRY_ADD	0x2A  ;//Execute a
;"_asm goto 0x2A _endasm" instruction, if you want to enter the bootloader
; mode from the application via software


;	#define REMAPPED_APP_RESET_VECTOR		0xA00
;	#define REMAPPED_APP_HIGH_ISR_VECTOR	0xA08
;	#define REMAPPED_APP_LOW_ISR_VECTOR		0xA18
;	#define BOOTLOADER_ABSOLUTE_ENTRY_ADD	0x2A  ;//Execute a
;"_asm goto 0x2A _endasm" instruction, if you want to enter the bootloader
; mode from the application via software

;	#define REMAPPED_APP_RESET_VECTOR		0x1000
;	#define REMAPPED_APP_HIGH_ISR_VECTOR	0x1008
;	#define REMAPPED_APP_LOW_ISR_VECTOR		0x1018
;	#define BOOTLOADER_ABSOLUTE_ENTRY_ADD	0x1C  ;//Execute a
;"_asm goto 0x2A _endasm" instruction, if you want to enter the bootloader
; mode from the application via software
#endif


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
;    Filename:   blinkerASM171.asm                                                             *
;    Date:         March 20th 2017                                                           *
;    File Version:  1.0                                                          *
;                                                                             *
;    Author:      FZAMORA                                                            *
;    Company:     CEX.com.co                                                            *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Files Required: p18F25K50_fz.INC                                             *
;                                                                             *
;******************************************************************************
;* Notas:  plantilla para trabajar con HID USB bootloader PIC18F25K50 en assembler
;* con board CEX 1.0. 
;* -Modo bootloader:  conectar a micro USB mientras se mantiene presionado RESET(RE3/MCLR)
;* hasta que el programa HIDBootloader.exe (win) reconozca el hardware.  El bootloader
;* ocupa memoria flash desde 0x000 hasta 0x7FF (2KB).
;* -Modo Run: para ejecutar programa de usuario cargado previamente con bootloader,
;* (desde 0x800 hasta 0x7FFF)...
;* conectar USB o cualquier otra fuente de alimentación soportada por board CEX 1.0
;* sin presionar RESET.
;* Demo Programa ejemplo: 
;* Conexiones CEX 1.0 requeridas: 
;* -Conecte D9 del shield con +5V (ánodo común G y B)
;* - Conecte A0 con D2 en shield. (RA3 --> cátodo Green)
;* - Conecte A1 con D2 en shield. (RA2 --> cátodo Blue)
;*Al energizar board modo run, led BLUE parpadea con frecuencia 
;* cercana a 1Hz. Si se presiona SW2, se enciende adicionalmente led GREEN, de fondo.
;* El parpadeo de BLUE ahora producirá una mezcla entre GREEN (Blue= off) y GREEN+BLUE
;* (Blue = on)a la frecuencia indiada cercana a 1Hz. Para modificar ejemplo abra proyecto 
;* o cree uno nuevo con archivo fuente .asm y archivos header (x3) mencionados aquí.
;* No olvide agregar el linker (script) requerido para bootloader o no bootloader.
;* Al modificar código ejemplo, ensamble todo (build all), conecte board en modo bootloader,
;* desde HIDBootloader.exe busque k50_hidbldr.hex, cargue y programe.  Desconecte y 
;* conecte nuevamente sin presionar RST (modo Run) y observe el funcionamiento de modificaciones.
;*****************************************************************************************

	LIST P=18F25K50		;directive to define processor
	#include "p18F25K50_fz.inc"	;processor specific variable definitions

#define nobootloader 0			;nobootloader = 1 =  prog with pickit3 or similar
					;nobootloader = 0 =  prog. with USB HID bootloader 2.91 microchip
;******************************************************************************
;//incluir OBLIGATORIAMENTE los siguientes archivos en Header Files del proyecto:
#include "25k50config.inc"  ;MCU configuration bits (misma bootloader recomendada)
#include "vectors.inc"		;vectors remapping for bootloader
	;I/O definitions for user app
;//el archivo 18F25k50_zhidbldr.lkr debe estar presente en el directorio y agregarse
;//a carpeta linker script o linker en mplabIDE o MPLABx respectivamente si nobootloader=0.
;//si nobootloader = 1, agregue 18f25k50_znobldr.lkr
;******************************************************************************
;Variable definitions
; These variables are only needed if low priority interrupts are used.
; More variables may be needed to store other special function registers used
; in the interrupt routines.

		CBLOCK	0x050   ;0x00 t0 0x5F --> gpr access ram (.96 positions)
		WREG_TEMP	;variable used for context saving
		STATUS_TEMP	;variable used for context saving
		BSR_TEMP	;variable used for context saving
		ENDC

		CBLOCK	0x000
		
	d1			;d1,d2,d3 usadas por delay05s
	d2
	d3
	
	EXAMPLE		;example of a variable in access RAM
		ENDC
;******************************************************************************
;Constant  definitions
;
		
		
		
;******************************************************************************
;EEPROM data
; Data to be programmed into the Data EEPROM is defined here

		ORG	0xf00000

		DE	"Test Data",0,1,2,3,4,5

;******************************************************************************


;Reset vector
; This code will start executing when a reset occurs.
Vectors:
R_vectors      code     REMAPPED_APP_RESET_VECTOR
RVReset:
		goto	Main		;go to start of main code

;******************************************************************************
;High priority interrupt vector
; This code will start executing when a high priority interrupt occurs or
; when any interrupt occurs if interrupt priorities are not enabled.

R_IntH        code    REMAPPED_APP_HIGH_ISR_VECTOR
RVIntH:
		bra	HighInt		;go to high priority interrupt routine

;******************************************************************************
;Low priority interrupt vector and routine
; This code will start executing when a low priority interrupt occurs.
; This code can be removed if low priority interrupts are not used.

R_IntL        code     REMAPPED_APP_LOW_ISR_VECTOR
RVIntL:
		movff	STATUS,STATUS_TEMP	;save STATUS register
		movff	WREG,WREG_TEMP		;save working register
		movff	BSR,BSR_TEMP		;save BSR register

;	*** low priority interrupt code goes here ***


		movff	BSR_TEMP,BSR		;restore BSR register
		movff	WREG_TEMP,WREG		;restore working register
		movff	STATUS_TEMP,STATUS	;restore STATUS register
		retfie

;******************************************************************************
;High memory PCL tables	
		
		
;******************************************************************************		
;High priority interrupt routine
; The high priority interrupt code is placed here to avoid conflicting with
; the low priority interrupt vector.

HighInt:

;	*** high priority interrupt code goes here ***


		retfie	FAST


;******************************************************************************
;Start of main program
; The main program code is placed here.

Main:
;	*** main code goes here ***
	call SetUpOsc
	
	call SETUPIO

;*******

    
LOOP:
	;			; repite indefinidamente

;******************************************************************************
;subroutines:
; Delay = 0.5 seconds
; Clock frequency = 16 MHz ??

; Actual delay = 0.5 seconds = 2000000 cycles
; Error = 0 %

	

Delay05s			;  ejemplo de retardo por subrutina (SW, generado con PICDelay pero
					;  ajustando código a PIC18F - PC alineado)
			;1999996 cycles
	movlw	0x11
	movwf	d1
	movlw	0x5D
	movwf	d2
	movlw	0x05
	movwf	d3
Delay05s_0
	decfsz	d1, f
	goto	$+6
	decfsz	d2, f
	goto	$+6
	decfsz	d3, f
	goto	Delay05s_0

			;4 cycles (including call)
	return

;*************SUBROUTINES******************************************************
SetUpOsc:
		movlw	0x80
		movf	OSCTUNE					; 3X PLL ratio mode selected
		movlw	0x72
		movwf	OSCCON					; Switch to 16MHz HFINTOSC
		movlw	0x10
		movwf	OSCCON2					; Enable PLL, SOSC, PRI OSC drivers turned off
#if 0	    ; habilitar solo si se usa PLL para oscildor interno
PLL_Redy_loop
		btfss	OSCCON2, PLLRDY
		bra		PLL_Redy_loop			; Wait for PLL lock
		movlw	0x90
		movwf	ACTCON
#endif
		
		RETURN

SetPines:
	
		
		RETURN
;******************************************************************************
;End of program

		END

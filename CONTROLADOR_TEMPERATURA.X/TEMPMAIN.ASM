;******************************************************************************
;   This file is a basic template for assembly code for a PIC18F25K50. Copy   *
;   this file into your project directory and modify or add to it as needed.  *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on the         *
;   features of the assembler.                                                *
;                                                                             *
;   Refer to the PIC18Fx5K5X Data Sheet for additional                        *
;   information on the architecture and instruction set.                      *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:   EjBlinkerPlantillaHID.asm                                    *
;    Date:         Febr 13 2018                                               *
;    File Version:  2.0                                                       *
;                                                                             *
;    Author:      FZAMORA                                                     *
;    Company:     CEX.com.co                                                  *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Files Required: p18F25K50_fz.INC                                         *
;                                                                             *
;******************************************************************************
;* Notas:  plantilla para trabajar con HID USB bootloader PIC18F25K50 en assembler
;* con board CEX 1.3 y 1.4. 
;* -Modo bootloader:  conectar a micro USB mientras se mantiene presionado RESET(RE3/MCLR)
;*  y RB2 y/o RB4 (botones en la board), luego liberar el RESET y luego RB2/RB4
;* hasta que el programa HIDBootloader.exe (win) reconozca el hardware.  El bootloader
;* ocupa memoria flash desde 0x000 hasta 0x7FF (2KB).
;* -Modo Run: para ejecutar programa de usuario cargado previamente con bootloader,
;* (desde 0x800 hasta 0x7FFF)...
;* conectar USB o cualquier otra fuente de alimentación soportada por board CEX
;* Presionar  RESET si el programa no inicia como se espera.
;* Demo Programa ejemplo (Versión 1): 
;* Conexiones CEX 1.3/4 requeridas (definido en hwconfig.inc): 
;* -Conecte D9 del shield con +5V (ánodo común R, G y B) (DIP SW 5)
;* - D2 conectado por defecto. (RA4 --> cátodo Green)	
;*Al energizar board modo run, led GREEN parpadea con frecuencia 
;* cercana a 1Hz. 
;* Versión 2:
;* - Conecte RC1 con D9 en JP2. (RC1 --> cátodo Red)
;* - Conecte RC2 con D6 en JP3. (RC2 --> cátodo Blue)
;* Si se presiona SW2, se enciende adicionalmente led BLUE, de fondo.
;* El parpadeo de BLUE ahora producirá una mezcla entre GREEN (Blue= off) y GREEN+BLUE
;* (Blue = on)a la frecuencia indiada cercana a 1Hz. Para modificar ejemplo abra proyecto 
;* o cree uno nuevo con archivo fuente .asm y archivos header (x4) mencionados aquí.
;* No olvide agregar el linker (script) requerido para bootloader o no bootloader.
;* Al modificar código ejemplo, ensamble todo (build all), conecte board en modo bootloader,
;* desde HIDBootloader.exe busque <nombremainASM>.hex, cargue y programe. 
;* Ruta del .hex en proyecto.X: .dist/default/production/ (*.cof, .hex, .map)	
;* Haga RESET desde la app windows del bootloader o el botón en la CEX board 
;* y observe el funcionamiento de modificaciones del programa.
;*****************************************************************************************

	LIST P=18F25K50		;directive to define processor
	
#include "p18f25k50_fz.inc"
	;processor specific variable definitions

#define nobootloader 1			;nobootloader = 1 =  prog with pickit3 or similar or simulation
#define version 2
#include "25k50config.inc"  ;MCU configuration bits (heredada de bootloader)
#include "vectors.inc"		;vectors remapping for bootloader
#include "hwconfig.inc"				
	;nobootloader = 0 =  prog. with USB HID bootloader 2.91 microchip
;******************************************************************************
;//incluir OBLIGATORIAMENTE los siguientes archivos en Header Files del proyecto:
	;I/O definitions for user app
;//el archivo 18F25k50_zhidbldr.lkr debe estar presente en el directorio y agregarse
;//a carpeta linker script o linker en mplabIDE o MPLABx respectivamente si nobootloader=0.
;//si nobootloader = 1, cambie linker file a 18f25k50_znobldr.lkr
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
	lect
	dato
	dato2
	Unidades
	Centenas
        Decenas
	UNIDADES1
	Centenas2
        Decenas2
	UNIDADES2
	puer
	rnu
	nu
	val
	nd
	unidad
        Boton1
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

;HighInt:
High_Interrupt:  ;Interrupcion de prioridad alta
  ; COmprobar 
    btfss Intcon3, .0 ; boton de temperatura
    bra $+4
    call Checkboton1; 
    ;btfss Incon3, 0 
    ;bra $+4
    ;call Checkboton2;    
    bcf Intcon3, .1
    ;bcf Intcon3, .0
    bsf Intcon3, .3
    ;bsf Incon3,  3
    retfie fast

 Checkboton1:  ; subrutijna averigua el estado boton Variable de medicion
  bcf Intcon3, .3
  DELAY1
  Btfss portB, .0
  bra $+4
  incf Boton1
  movlw 0x02
  cpfsgt Boton1
  bra $+4
  clrf Boton1
  return



;	*** high priority interrupt code goes here ***


		retfie	FAST


;******************************************************************************
;Start of main program
; The main program code is placed here.

;version equ 2		;versión 1 blinker básico o 2 doble led (requiere cablear)
		
Main:
;	*** main code goes here ***
	call SETUPOSC   ;configura oscilador interno 16MHz ?!
	call SETUPIO    ;configura LED1,2,3 y botones (pull ups)
	CALL SETUPADC
LOOP
	call CONVERSION
        call CONTROL
	CALL GENBCD
	CALL visual
	BRA LOOP

;*******

   ; BSF	 	pLED1			; apaga cátodo LED (Green)
			; repite indefinidamente

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

	
Delay01s			;  ejemplo de retardo por subrutina (SW, generado con PICDelay pero
				;  ajustando código a PIC18F - PC alineado)
			;1999996 cycles
	movlw	0xFF
	movwf	d1
	movlw	0x19
	movwf	d2
Delay01s_0
	decfsz	d1, f
	goto	$+6
	decfsz	d2, f
	goto	Delay01s_0

			;4 cycles (including call)
	return
	

DELAY1
    movlw 0x30
    movwf d1
DELAY1_0 decfsz d1,f
    goto DELAY1_0
    return

;*************SUBROUTINES******************************************************
SETUPOSC:
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
#if 1
SETUPIO:
	;CLRF    LATA
	;CLRF	LATB
	
	;BCF		anLED1		; con ayuda de definiciones hwconfig.inc se definen pines I/O
	;BCF		tLED1	;out

#if version==2	
    CLRF PORTA
    CLRF PORTB
    movlw 0xFD ; puerto para la interrupcion boton rb1
    movwf ANSELB
    movlw 0xFF
    movwf ADCON1
    movlw 0xFF
    movwf TRISB
    movlw 0x00
    movwf TRISA
    movlw 0x00
    movwf TRISC
    ;configura interrupcion
    movlw 0xF0
    movwf INTCON
    movlw 0xF0
    movwf INTCON2
 ;   bcf INTXON2, INTEDG0
    ;movwf INTCON2
    movlw  0xD8      ;0x11011000
    movwf INTCON3
    BCF ANSELB,.3
    
		
#endif
    
		
		RETURN
#endif

CONTROL:
;00101000
;00001111
        movlw 0x02
        cpfseq Boton1
        bra $+4
        call Maximo 
        movlw 0x01
        cpfseq Boton1
        bra $+4
        call Minimo
                RETURN 
Maximo:
        movlw 0x28
        movwf lect
                RETURN
Minimo:      
        movlw 0x0F
        movwf lect
                RETURN
		
SETUPADC:
	MOVLW b'00000101'
	MOVWF ADCON2
	MOVLW b'00000000'
	MOVWF ADCON1
	MOVLW b'00100101'
	MOVWF ADCON0
    
		RETURN
    
CONVERSION:
	BSF ADCON0,GO
espera 
	BTFSC ADCON0,GO
	BRA espera
	MOVF ADRESH,W
	MOVWF lect
	movlw d'50'
	movwf dato
	movlw d'5'
	movwf dato2
;	
		RETURN
		
GENBCD:
       CLRF Unidades
       clrf Decenas
       clrf Centenas
	    
       ;Comienza el proceso de otención de valores BCD 
       ;para Centenas, Decenas y unidades atraves de restas
       ;sucesivas.
CENTENAS1
       movf dato,W      ;W=d'100'
       subwf lect,W     ;Resto - d'100' (W)
       btfss STATUS,C    ;Resto menor que d'100'?
       goto DECENAS1     ;SI
       movwf lect       ;NO, Salva el resto
       movlw d'1'
       ADDWF Centenas,W
       movwf Centenas
       goto CENTENAS1    ;Realiza otra resta
       
DECENAS1
       movf dato2,W      ;W=d'10'
       subwf lect,W     ;Resto - d'10' (W)
       btfss STATUS,C    ;Resto menor que d'10'?
       goto UNIDADES10    ;Si
       movwf lect       ;No, Salva el resto
       movlw d'1'
       ADDWF Decenas,W
       movwf Decenas
       goto DECENAS1     ;Realiza otra resta
	   
UNIDADES10
       MOVF lect,W
       movwf Unidades
       clrf lect
f       movf Decenas,W
       ;movwf PORTA

       
    RETURN
    

TABLA: 

     ADDWF	PCL,F
    RETLW	b'0111111'
    RETLW	b'0000110'
    RETLW	b'1011011'
    RETLW	b'1001111'
    RETLW	b'1100110'
    RETLW	b'1101101'
    RETLW	b'1111101'
    RETLW	b'1000111'
    RETLW	b'1111111'  
    RETLW	b'1100111'  
    
    RETURN
 
    
    
visual:  
    
    RLNCF Decenas,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf LATA
    BSF LATC,.1
    CALL Delay01s
    BCF LATC,.1
    ;CALL Delay01s

    RLNCF Centenas,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf LATA
    BSF LATC,.0
    CALL Delay01s
    BCF LATC,.0
    ;CALL Delay01s
    
    RLNCF Unidades,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf LATA
    BSF LATC,.2
    CALL Delay01s
    BCF LATC,.2
    ;CALL Delay01s
    
    RETURN

    
;******************************************************************************
;End of program

		END

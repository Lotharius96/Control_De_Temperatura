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
;                                       se quiere se mata shakira                                      *
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

#define nobootloader 0
#define High_Voltage 0 
	
	
	;nobootloader = 1 =  prog with pickit3 or similar
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

	*********************************************
;VARIABLES 
	
	CBLOCK	0x000 ;si se necesita crear variables seguidas en la ram
	d1
	d2
	d3
	;%lect
	;dato
	Decimas
        Decenas
        Unidades
	;Centenas
	endc ;obligatorio poner
    CBLOCK  0x00f
      Temperatura ; registro de temperatura
      Humedad ; registro humedad
      temp;
      temp2;
      ref1
      ref2
      ref3
      Boton1
       Boton2
       Turn_On
   ;   Unity1; Registro_referencia 1
    ;  Unity2; Registro_referencia 2
    
    endc 
   
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
		bra	High_Interrupt		;go to high priority interrupt routine

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
;INTERRUPCIONES
High_Interrupt:  ;Interrupcion de prioridad alta
  ; COmprobar 
    bcf INTCON3, 3
    bcf INTCON3, 4
    btfss INTCON3, 1 ; boton de temperatura
    bra $+4
    call Checkboton1; 
    btfss INTCON3, 0 
    bra $+4
    call Checkboton2;    
    bcf INTCON3, 1; BORRO LAS FLAGS DE LAS INTERRUPCIONES
    bcf INTCON3, 0
    bsf INTCON3, 4;HABILITO LAS INTERRUPCIONES
    bsf INTCON3, 3
    retfie fast

 Checkboton1:  ; subrutijna averigua el estado boton Variable de medicion
  ;bcf Intcon3, 4
  call Delay_60ms
  Btfss portB, 1
  bra $+4
  incf Boton1
  movlw 0x01
  cpfsgt Boton1
  bra $+4
  clrf Boton1
  return
  
Checkboton2:
  ;bcf Intcon3, 3
   ; bcf Intcon3, 4
  call Delay_60ms
  Btfss portB, 2 
  bra $+4
  incf Boton2
  movlw 0x02
  cpfsgt Boton2
  bra $+4
  clrf Boton1
  return   
    
;interrupciones
;******************************************************************************
;**TABLA DE VALORES DE VISUALIZACION
#if High_Voltage == 1  
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
    RETLW	b'1111101'  
    RETLW	b'1110011'  
    
    RETURN
#endif
  ;****************************************************
  ;Subrutin DELAY ANTIRREBOTE********************************
Delay_60ms: 
    movlw 0x5A;
    movwf d1
    movlw 0x45
    movwf d2
    movlw 0x5
    movwf d3
Delay_S
    decfsz	d1, f
	bra	$+4	;ó en 18F bra $+4, goto $+2 en 16F
	decfsz	d2, f
	bra	$+4
	decfsz	d3, f
	bra	Delay_S
    return;

; 
;READ_HUMEDITY:

    
 ;   
 ;     return
READ_TEMP:
     ; RANGO DE MEDICION HASTA 45°
      ; clrf Decimas
       clrf Decenas
       clrf Unidades
       clrf Decimas
       movf ADRESL, W
       addwf ADRESL, w
       movwf temp
       movf ADRESH, w
       addwf ADRESH, w
       MOVWF temp2
       rrncf Temp
       rrncf Temp2
       ; movf ADRESH,W   
       ;addwf ADRESH,W     ;Dupilca el valor de ADRESH para 
       
      
DECENAS1
       ;movlw 0xA
       ;addwf 
       
       
       movlw d'100'      ;W=d'100'
       subwf temp,W     ;Resto - d'100' (W)
       btfss STATUS,C    ;Resto menor que d'100'?
       goto UNIDADES1     ;SI
       movwf temp       ;NO, Salva el resto
       incf Centenas,1   ;Incrementa el contador de centenas BCD
       goto DECENAS1    ;Realiza otra resta

UNIDADES1
       movlw d'10'       ;W=d'10'
       subwf temp,W     ;Resto - d'10' (W)
       btfss STATUS,C    ;Resto menor que d'10'?
       goto DECIMAS1    ;Si
       movwf temp       ;No, Salva el resto
       incf Unidades,1    ;Incrementa el contador de centenas BCD
       goto UNIDADES1     ;Realiza otra resta
       
DECIMAS1
       movf temp,W      ;El resto son la Unidades BCD
       movwf Decimas
   ;    clrf temp
 
        
       RETURN
    
;Conversion_Humedad:  
  
 ;    return
  ;;;;;*******************************************************
;delays
#if High_Voltage == 1
  DELAY1:
    movlw 0x30
    movwf d1
testbench 
    decfsz d1,f
    goto testbench
    return
;*************************subrutina delay de espera de datos    
;Delay2
#endif    

#if High_Voltage == 1
;Delay:
 ;       movlw	0x11
	;movwf	d1
;:	movlw	0x5D
;	movwf	d2
;	movlw	0x05
;	movwf	d3
;Delay_0
;	decfsz	d1, f
;	bra	$+4	;ó en 18F bra $+4, goto $+2 en 16F
;	decfsz	d2, f
;	bra	$+4
;	decfsz	d3, f
;	bra	Delay_0
			;4 cycles (including call)
;	return
;;;;;;;;;;;;;;;;;;;;

DELAY2:
       movlw	0xD3
	movwf	d1
	movlw	0x31
	movwf	d2
Delay_2
	decfsz	d1, f
	bra	$+4	;ó en 18F bra $+4, goto $+2 en 16F
	decfsz	d2, f
	bra	Delay_2
			;4 cycles (including call)
	return	
;*************************delay
#endif 	
#if High_Voltage == 1

RetDig: 
          movlw  0x2 
          movwf  d1 
Loop1 
          movlw  .50 
          movwf  d2 
Loop2 
          decfsz d2,F 
          goto   Loop2 
          decfsz d1,F 
          goto   Loop1 
          return 
    
#endif


#if High_Voltage ==1
 visual:  
    
    RLNCF Decenas,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf PORTA
    BTG PORTC,.5
    CALL RetDig
    BTG PORTC,.5

    RLNCF Centenas,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf PORTA
    BTG PORTC,.6
    CALL RetDig
    BTG PORTC,.6
    
    RLNCF Unidades,W   ;Imprime el dígito de las centenas
    call TABLA
    movwf PORTA
    BTG PORTC,.7
    CALL RetDig
    BTG PORTC,.7
 ;00000011 or 00000101 or 000000
    RETURN    
#endif
 ;******************************************************************
  ;Start of main program
; The main program code is placed here.
  ;*************************************************
SetUpInterrupt:
    movlw 0xC0
    MOVWF INTCON
    movlw 0xF0
    MOVWF INTCON2
    movlw 0XD8
    MOVWF INTCON
    movlw 
  
SETUPOSC:
    movlw 0x77
    movwf 0XFD3
    BSF 0XFD2,.5
    
waits BTFSS 0XFD3,.2
    GOTO waits
    RETURN
 ;*****************************CONFIGURACION OSCILADO
    
;**************LECTURA CONVERTIDOR ANALOGO DIGITAL****************
SETUPIO:
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF Boton1
    clrf boton2
    clrf Turn_On
    movlw 0x1F; CONFIGURA EL PUERO B COMO ENTRADA
    movwf TRISB
    BCF ANSELB,.3 ;PIN DE LECTURA DEL SENSOR DE TEMPERATURA
    bcf ANSELB,.4 ;PIN DE LECTURA DEL SENSOR DE HUMEDAD
    ;movlw 0x00
    clrf ADCON1
   ; movlw 0x1F; CONFIGURA EL PUERO B COMO ENTRADA
    :;movwf TRISB
    ;movlw 0x00
    clrf TRISA ; PUERTO B DE SALIDA ASOCIADO AL DISPLAY 7 SEGMENTOS
    ;movlw 0x00
    clrf TRISC  ;CONFIGURA EL PUERTO C
    
    RETURN
   ;*******CONFIGURACION OSCILADOR

    
;**************LECTURA CONVERTIDOR ANALOGO DIGITAL****************
START_ADC:
    movlw b'00000010'; configuro la tension de referencia interna positiva
    movwf ADCON1
    movlw b'10010000'; toma 4 ciclos de instruccion de adquisicion para contectar con el uerto de envio de datos y una justifacion de bits a la izquierda
    movwf ADCON2;
    BTFSC Boton1
    bra Humedad
    movlw '00100101'; configura el canal 9 en rb3
    movwf ADCON0;
    bra Proceso
    ;return
    
 Humedad
    movlw '00101101'; configura el puerto rb4 para canal 11
    movwf ADCON0
    bra Proceso
    
 Proceso
   ; BSF ADCON0,GO  btfsc Boton1, 0
    ;movlw
    ;movlw b'00100101' ; configura el canal analogico
    ;movwf ADCON0
    CALL DELAY1
    ;delay1 demora el tiempo de adquisicion de datos
espera BTFSC ADCON0,GO
    GOTO espera
    movf ADRESL,W
    addwf ADRESL,W
    ;movwf PORTB
    
;    addwf ADRESH,W
    CALL READ_TEMP
    RETURN
    ;RETURN
 ;*************
  ;*********************************
#if High_Voltage == 1
Disparo:
    movff Decimas, ref1
    movf Unidades, w
    mulwf ref1, w 
    movlw 0x18
    cpfseq ref1
    bra $+4
    bsf PORTC, 0
    movlw 0x05
    cpfseq ref1
    BRA $+4
    BCF PORTC, 0
    return
  
#endif  
  ;*****************************************
  
  
Main:
    CALL SETUPOSC
    CALL SETUPIO
    call SetUpInterrupt
    call Loop
    ;CALL START_ADC
    ;CALL visual
    ;CALL Delay1
Loop:
    CALL START_ADC
    CALL visual
    CALL Delay2
    ;call Boton2 ; Boton2 control de visualizacion
    call Disparo  ; Subrutina de enfriamiento........
;    END
    goto Loop		
		
		
		
		
		
		
		
		
		
;******************************************************************************
;subroutines:
; Delay = 0.5 seconds
; Clock frequency = 16 MHz ??

; Actual delay = 0.5 seconds = 2000000 cycles
; Error = 0 %
;*************************************

	
;***************************************************	
;Delay del convertidor analogo-digitak
END


 
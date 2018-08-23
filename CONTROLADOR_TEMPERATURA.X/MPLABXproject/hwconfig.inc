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
;    Filename:   hwconfig.inc                                                             *
;    Date:         March 10th 2015                                                           *
;    File Version:  1.0                                                          *
;                                                                             *
;    Author:      FZAMORA                                                            *
;    Company:     CEX.com.co                                                            *
;                                                                             *
;******************************************************************************
; definición de botones en la app:

#define	    pSW0    PORTA, RA5			; Boot Switch used by bootloader SAKA
#define     anSW0   ANSELA,.5     ;by FZamora for CEX 1.0 CS-RA5
#define     tSW0    TRISA,.5       ;by FZamora

#define	    pSW1    PORTB, RB2			; Boot Switch used by bootloader SAKA
#define     anSW1   ANSELB,.2      ;by FZamora for CEX 1.0 CS-RA5
#define     tSW1    TRISB,.2        ;by FZamora
#define	    wpSW1   WPUB,.2			;weak pull up 

#define	    pSW2    PORTB, RB4			; Boot Switch used by bootloader SAKA
#define     anSW2   ANSELB,.4      ;by FZamora for CEX 1.0 CS-RA5
#define     tSW2    TRISB,.4        ;by FZamora
#define     wpSW2   WPUB,.4		;weak pull up 


; definición de LED´s en la APP

#define		pLED1	LATA, LATA4			; Green LED
#define		pLED2	LATA, LATA2			; blue LED
#define		tLED1	TRISA, TRISA4		; Green LED
#define		tLED2	TRISA, TRISA2		; blue LED
#define		pLED3	LATA, LATA1			; red LED
#define		tLED3	TRISA, TRISA1		; red LED    

#define		anLED1  ANSELA,.4		;by FZamora
#define		anLED2	ANSELA,.2		;by FZamora
#define		anLED3	ANSELA,.1		;by FZamora    


;== end of file ====================================================;
                                 
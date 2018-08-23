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
;    Filename:   25k50config.inc                                                             *
;    Date:         March 10th 2015                                                           *
;    File Version:  1.0                                                          *
;                                                                             *
;    Author:      FZAMORA                                                            *
;    Company:     CEX.com.co                                                            *
;                                                                             *
;******************************************************************************
;                                    
;Configuration bits
;Microchip has changed the format for defining the configuration bits, please
;see the .inc file for futher details on notation.  Below are a few examples.
#if 0  ;mplabc18 bootloader k50 original config
        #pragma config PLLSEL   = PLL3X     // 3X PLL multiplier selected
        #pragma config CFGPLLEN = OFF       // PLL turned on during execution
        #pragma config CPUDIV   = NOCLKDIV  // 1:1 mode (for 48MHz CPU)
        #pragma config LS48MHZ  = SYS48X8   // Clock div / 8 in Low Speed USB mode
        #pragma config FOSC     = INTOSCIO  // HFINTOSC selected at powerup, no clock out
        #pragma config PCLKEN   = OFF       // Primary oscillator driver
        #pragma config FCMEN    = OFF       // Fail safe clock monitor
        #pragma config IESO     = OFF       // Internal/external switchover (two speed startup)
        #pragma config nPWRTEN  = OFF       // Power up timer
        #pragma config BOREN    = SBORDIS   // BOR enabled
        #pragma config nLPBOR   = ON        // Low Power BOR
        #pragma config WDTEN    = SWON      // Watchdog Timer controlled by SWDTEN
        #pragma config WDTPS    = 32768     // WDT postscalar
        #pragma config PBADEN   = OFF       // Port B Digital/Analog Powerup Behavior
        #pragma config SDOMX    = RB3       // SDO function location
        #pragma config LVP      = OFF       // Low voltage programming
        #pragma config MCLRE    = ON        // MCLR function enabled (RE3 disabled)
        #pragma config STVREN   = ON        // Stack overflow reset
        //#pragma config ICPRT  = OFF       // Dedicated ICPORT program/debug pins enable
        #pragma config XINST    = OFF       // Extended instruction set
#endif
;   ASSEMBLY Oscillator Selection:
 ;   CONFIG	FOSC = XT_XT         ;XT oscillator, XT used by USB
;******************************************************************************
;  general purpose bootloader inernal oscilator 16MHz config:
#if 0 
         config PLLSEL   = PLL3X     ; 3X PLL multiplier selected
          config CFGPLLEN = OFF       ; PLL turned on during execution
          config CPUDIV   = NOCLKDIV  ; 1:1 mode (for 48MHz CPU)
          config LS48MHZ  = SYS48X8   ; Clock div / 8 in Low Speed USB mode
          config FOSC     = INTOSCIO  ; HFINTOSC selected at powerup, no clock out
          config PCLKEN   = OFF       ; Primary oscillator driver
          config FCMEN    = OFF       ; Fail safe clock monitor
          config IESO     = OFF       ; Internal/external switchover (two speed startup)
          config nPWRTEN  = OFF       ; Power up timer
          config BOREN    = SBORDIS   ; BOR enabled
          config BORV     = 190		;BOR voltage 1.9 V nominal
		  config nLPBOR   = ON        ; Low Power BOR
          CONFIG WDTEN    = OFF      ; Watchdog Timer controlled by SWDTEN
          config WDTPS    = 32768     ; WDT postscalar
          config PBADEN   = OFF       ; Port B Digital/Analog Powerup Behavior
          config SDOMX    = RC7       ; SDO function location
          config LVP      = OFF       ; Low voltage programming
         ; config MCLRE    = ON        ; MCLR function enabled (RE3 disabled)
           config MCLRE    = OFF        ; MCLR function enabled (RE3 disabled) in target fw?
          config STVREN   = ON        ; Stack overflow reset
        ;  config ICPRT  = OFF       ; Dedicated ICPORT program/debug pins enable
          config XINST    = OFF       ; Extended instruction set
#endif
#if 1
;**** SAKA bootloader config image:
  CONFIG  PLLSEL = PLL3X        ; PLL Selection (3x clock multiplier)
  CONFIG  CFGPLLEN = ON         ; PLL Enable Configuration bit (PLL Enabled)
  CONFIG  CPUDIV = NOCLKDIV     ; CPU System Clock Postscaler (CPU uses system clock (no divide))
  CONFIG  LS48MHZ = SYS48X8     ; Low Speed USB mode with 48 MHz system clock (System clock at 48 MHz, USB clock divider is set to 8)
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection (Internal oscillator)
  CONFIG  PCLKEN = OFF          ; Primary Oscillator Shutdown (Primary oscillator shutdown firmware controlled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)
  CONFIG  nPWRTEN = ON          ; Power-up Timer Enable (Power up timer enabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable (BOR enabled in hardware (SBOREN is ignored))
  CONFIG  BORV = 285            ; Brown-out Reset Voltage (BOR set to 2.85V nominal)
  CONFIG  nLPBOR = ON           ; Low-Power Brown-out Reset (Low-Power Brown-out Reset enabled)
  CONFIG  WDTEN = SWON          ; Watchdog Timer Enable bits (WDT controlled by firmware (SWDTEN enabled))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscaler (1:32768)
  CONFIG  CCP2MX = RC1          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<5:0> pins are configured as digital I/O on Reset)
  CONFIG  T3CMX = RB5           ; Timer3 Clock Input MUX bit (T3CKI function is on RB5)
  CONFIG  SDOMX = RC7           ; SDO Output MUX bit (SDO function is on RC7)
  CONFIG  MCLRE = ON           ; Master Clear Reset Pin Enable (RE3 input pin enabled; external MCLR disabled)
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled)
  CONFIG  CP0 = OFF             ; Block 0 Code Protect (Block 0 is not code-protected)
  CONFIG  CP1 = OFF             ; Block 1 Code Protect (Block 1 is not code-protected)
  CONFIG  CP2 = OFF             ; Block 2 Code Protect (Block 2 is not code-protected)
  CONFIG  CP3 = OFF             ; Block 3 Code Protect (Block 3 is not code-protected)
  CONFIG  CPB = OFF             ; Boot Block Code Protect (Boot block is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protect (Data EEPROM is not code-protected)
  CONFIG  WRT0 = OFF            ; Block 0 Write Protect (Block 0 (0800-1FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Block 1 Write Protect (Block 1 (2000-3FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Block 2 Write Protect (Block 2 (04000-5FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Block 3 Write Protect (Block 3 (06000-7FFFh) is not write-protected)
  CONFIG  WRTC = OFF            ; Configuration Registers Write Protect (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protect (Boot block (0000-7FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protect (Data EEPROM is not write-protected)
  CONFIG  EBTR0 = OFF           ; Block 0 Table Read Protect (Block 0 is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Block 1 Table Read Protect (Block 1 is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Block 2 Table Read Protect (Block 2 is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Block 3 Table Read Protect (Block 3 is not protected from table reads executed in other blocks)
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protect (Boot block is not protected from table reads executed in other blocks)
#endif

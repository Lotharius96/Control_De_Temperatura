#include "stdio.h"
#include "stdlib.h"
#include "Arduino.h"
#include "Tabla_Lectura.h"
#include "Boton.h"
#include "Visualizacion.h"
#include "BCD_Conversion.h"

int Measure = 0; //medida del sensor de temperatura
float Value= 0;
int boton = 0;
int analogPin = 2;
int interruptButton =2;
void setup(){
//configuracion de pines para visualizar
int i;
 for(i=6;i<14;i++){
   pinMode(i,OUTPUT);
  }

//
 pinMode(interruptButton,INPUT);
 attachInterrupt(digitalPinToInterrupt(interruptButton),Interrupcion,RISING);
 analogReference(DEFAULT); //referencia de 5 voltios para el conversor analogo digital
 Serial.begin(9600); // lectura serial


}

void loop(){

  Measure=analogRead(analogPin);
  Value=((5*Measure)/1024);
  Visualizacion(Value);
}


//atend_Interrupt
void Interrupcion(){

 boton=Boton();

}

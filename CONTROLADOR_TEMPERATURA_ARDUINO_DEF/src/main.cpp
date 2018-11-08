#include "stadio.h"
#include "stdlib.h"

int Measure=0; //medida del sensor de temperatura

int analogPin = 2;
int interrupButton=2;
void setup(){
//configuracion de pines para visualizar
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


}

//atend_Interrupt
void Interrupcion(){


}

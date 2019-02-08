#include "stdio.h"
#include "stdlib.h"
#include "Arduino.h"
#include "Tabla_Lectura.h"
#include "Boton.h"
#include "Visualizacion.h"
#include "BCD_Conversion.h"

int Measure = 0; //medida del sensor de temperatura
float Value= 0;
int boton=0;
int analogPin = 2;
int interruptButton =13; //Boton_interrupcion_1
Boton botonX;
Visualizacion visualizacion;
//Tabla_Lectura tabla_lectura;

void Interrupcion(){
boton=botonX.Conteo();
}
void setup(){
//co                                                                                               nfiguracion de pines para visualizar
 int i;
 for(i=3;i<14;i++){
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
  Value=((5*Measure*0.1)/1024);
  visualizacion.GetBoton(boton);
  visualizacion.Visual(Value);
  delay(100);

}


//atend_Interrupt

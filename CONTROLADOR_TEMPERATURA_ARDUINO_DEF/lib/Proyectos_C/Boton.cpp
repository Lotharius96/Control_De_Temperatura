#include "Arduino.h"
#include "Boton.h"

int base=0;
int counter = 0;
Boton::Boton(){}
int Boton::Conteo(){
  counter++;
  if(counter >2){
      counter = 0;

  }
  return counter;
}

#include "Arduino.h"
#include "Boton.h"

int counter = 0;
void Boton::Boton(){



}

int Boton::Conteo(){
  counter++;
  if(counter >2){
      counter = 0;

  }
  return counter
}

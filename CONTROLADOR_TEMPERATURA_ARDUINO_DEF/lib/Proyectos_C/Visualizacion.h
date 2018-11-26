
#ifndef Visualizacion_H
#define Visualizacion_H
#include "Arduino.h"
/////
 class Visualizacion{
    public:
      Visualizacion();
      void GetBoton(int Boton_Value);
      void Visual(float Measure);
      void Visualizar(int x, int y, int z);
      void Matrix_Read(int *Matriz,bool Stble);
 };
#endif


#ifndef Visualizacion_H
#define Visualizacion_H
#include "Arduino.h"
/////
 class Visualizacion{
    public:
      void Visualizacion();
      void Visual(float Measure);
      void Visualizar(int x, int y, int z);
      void Matrix_Read(int Matriz[8],bool Stble);
 };
#endif

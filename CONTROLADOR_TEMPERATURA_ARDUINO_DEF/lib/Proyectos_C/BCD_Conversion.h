#ifndef BCD_Conversion_H
#define BCD_Conversion_H
#include "Arduino.h"
class BCD_Conversion
{
    public:
       BCD_Conversion();
       int Lectura_Centena(float Value);
       int Lectura_Decena(float Value);
       int Lectura_Unidad(float Value);


};
#endif

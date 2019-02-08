#include "Arduino.h"
#include "BCD_Conversion.h"

int Unidad,Decena,Centena=0;

BCD_Conversion::BCD_Conversion(){};
int BCD_Conversion::Lectura_Centena(float Value) {
  /* code */
//  float Temp=0;
  Centena=(int)(Value/100);
  return Centena;
  //Decena=(uint8_t)((Value-Centena*100)/10);
  //Unidad=(uint8_t)((Value-Centena*100-Decena*10))
}
int BCD_Conversion::Lectura_Decena(float Value) {
  /* code */
//  float Temp=0;
  //Centena=(uint8_t)(Value/100);
  Decena=(int)((Value-Centena*100)/10);
  return Decena;
  //Unidad=(uint8_t)((Value-Centena*100-Decena*10))
}

int BCD_Conversion::Lectura_Unidad(float Value) {
  /* code */
//  float Temp=0;
  //Centena=(uint8_t)(Value/100);
  //Decena=(uint8_t)((Value-Centena*100)/10);
  Unidad=(int)((Value-(Centena*100)-(Decena*10);
  return Unidad;
}

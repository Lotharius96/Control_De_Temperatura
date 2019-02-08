#include "Arduino.h"
#include "Visualizacion.h"
#include "Boton.h"
#include "BCD_Conversion.h"
#include "Tabla_Lectura.h"
#define MAX 42
#define MIN 13

//using namespace std;
//class Visualizacion{
  bool Control = false;
  int Boton_l=0;
  //Boton boton;
  BCD_Conversion conversionBCD;
  Tabla_Lectura tabla_lecturaT;

//  void  Visualizacion::Visual(float Measure);
  //void Visualizacion::GetBoton( int Boton_Value);
  //void Visualizacion::Visualizar(int x, int y, int z);
Visualizacion::Visualizacion(){};
void Visualizacion::GetBoton( int Boton_Value)
{
   Boton_l = Boton_Value;
}
void  Visualizacion::Visual(float Measure)
{
  int Unidad=0;
  int Decena=0;
  int Centena=0;
  if(Boton_l==0){
     Unidad=(int)(conversionBCD.Lectura_Unidad(Measure)/10);
     Decena=(int)(conversionBCD.Lectura_Decena(Measure)/10);
     Centena=(int)(conversionBCD.Lectura_Centena(Measure)/10);
  }else if(Boton_l==1){
     Unidad=conversionBCD.Lectura_Unidad(MAX);
     Decena=conversionBCD.Lectura_Decena(MAX);
     Centena=conversionBCD.Lectura_Centena(MAX);
   }else if(Boton_l==2){
     Unidad=conversionBCD.Lectura_Unidad(MIN);
     Decena=conversionBCD.Lectura_Decena(MIN);
     Centena=conversionBCD.Lectura_Centena(MIN);
  }
//////VISUALIZAR
Visualizar(Unidad,Decena,Centena);
}
/////
void Visualizacion::Visualizar(int x, int y, int z)
{
   int *Matriz;
   digitalWrite(3,HIGH);
   Matriz=tabla_lecturaT.Tabla_Read(x);
   Matrix_Read(Matriz,false);
  
   //delay(50);
   //digitalWrite(3,LOW);
   digitalWrite(4,HIGH);
   Matriz=tabla_lecturaT.Tabla_Read(y);
   Matrix_Read(Matriz,false);
   //digitalWrite(4,HIGH);
   //delay(50);
  // digitalWrite(4,LOW);
   digitalWrite(5,HIGH);
   Matriz=tabla_lecturaT.Tabla_Read(z);
   //digitalWrite(5,HIGH);
   Matrix_Read(Matriz,false);
   //digitalWrite(5,HIGH);
   delay(500);
   //digitalWrite(5,LOW);
   Matrix_Read(Matriz,true);
   digitalWrite(5,LOW);
   digitalWrite(4,LOW);
   digitalWrite(3,LOW);
  
 }

void Visualizacion::Matrix_Read(int *Matriz,bool Stble)
{
////
  int i;
  for(i=0;i<8;i++){
     if(Stble == false){
     digitalWrite(6+i,Matriz[i]);
     }else{
     digitalWrite(6+i,0);
     }
   }
///
}
//}

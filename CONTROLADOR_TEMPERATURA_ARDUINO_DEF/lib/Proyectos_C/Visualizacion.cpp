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
  Boton boton;
  BCD_Conversion conversion;
  Tabla_Lectura tabla_lectura;

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
     Unidad=conversion.Lectura_Unidad(Measure);
     Decena=conversion.Lectura_Decena(Measure);
     Centena=conversion.Lectura_Centena(Measure);
  }else if(Boton_l==1){
     Unidad=conversion.Lectura_Unidad(MAX);
     Decena=conversion.Lectura_Decena(MAX);
     Centena=conversion.Lectura_Centena(MAX);
   }else if(Boton_l==2){
     Unidad=conversion.Lectura_Unidad(MIN);
     Decena=conversion.Lectura_Decena(MIN);
     Centena=conversion.Lectura_Centena(MIN);
  }
//////VISUALIZAR
Visualizar(Unidad,Decena,Centena);
}
/////
void Visualizacion::Visualizar(int x, int y, int z)
{
   int *Matriz;
   Matriz=tabla_lectura.Tabla_Read(x);
   Matrix_Read(Matriz,false);
   delay(50);
   Matriz=tabla_lectura.Tabla_Read(y);
   Matrix_Read(Matriz,false);
   delay(50);
   Matriz=tabla_lectura.Tabla_Read(z);
   Matrix_Read(Matriz,false);
   delay(50);
   Matrix_Read(Matriz,true);
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

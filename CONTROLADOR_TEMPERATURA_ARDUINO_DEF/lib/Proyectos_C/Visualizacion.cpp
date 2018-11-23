#include "Arduino.h"
#include "Visualizacion.h"
#include "Boton.h"
#include "BCD_Conversion.h"
#define MAX 42
#define MIN 13

bool Control = false;
int Boton_l=0;
void Visualizacion::Visualizacion(){};
void Visualizacion::GetBoton( int Boton_Value){
   Boton_l = Boton_Value;
}
void Visualizacion::Visual(float Measure){
  int Unidad=0;
  int Decena=0;
  int Centena=0;
  if(Boton_l==0){
     Unidad=Lectura_Unidad(Measure);
     Decena=Lectura_Decena(Measure);
     Centena=Lectura_Centena(Measure);
  }else if(Boton_l==1){
     Unidad=Lectura_Unidad(MAX);
     Decena=Lectura_Decena(MAX);
     Centena=Lectura_Centena(MAX);
   }else if(Boton_l==2){
     Unidad=Lectura_Unidad(MIN);
     Decena=Lectura_Decena(MIN);
     Centena=Lectura_Centena(MIN);

}
//////VISUALIZAR
Visualizar(Unidad,Decena,Centena);
}

void Visualizacion::Visualizar(int x, int y, int z){
   int Matriz[8];
   Matriz=Tabla_Read(x);
   Matrix_Read(Matriz,false);
   delay(50);
   Matriz=Tabla_Read(y);
   Matrix_Read(Matriz,false);
   delay(50);
   Matriz=Tabla_Read(z);
   Matrix_Read(Matriz,false);
   delay(50);
   Matrix_Read(Matriz,true);

}

void Visualizacion::Matrix_Read(int Matriz[8],bool Stble){
////
  for(i=0;i<8;i++){
     if(Stble == false){
     digitalWrite(6+i,Matriz[i]);
     }else{
     digitalWrite(6+i,0);
     }
   }
///
}

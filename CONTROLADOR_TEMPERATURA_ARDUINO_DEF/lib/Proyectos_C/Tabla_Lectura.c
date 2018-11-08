//#include "Tabla_Lectura.h"
#include "stdio.h"
#include "stdlib.h"
#include "Tabla_Lectura.h"
int Tabla[10][8]={
  {0,0,1,1,1,1,1,1},//0
  {0,0,0,0,0,1,1,0},//1
  {0,1,0,1,1,0,1,1},//2
  {0,1,0,0,1,1,1,1},//3
  {0,1,1,0,0,1,1,0},//4
  {0,1,1,0,1,1,0,1},//5
  {0,1,1,1,1,1,0,1},//6
  {0,1,0,0,0,1,1,1},//7
  {0,1,1,1,1,1,1,1},//8
  {0,1,1,0,0,1,1,1}//9
  //{}
}
//byte Tabla_Read[8](int valor);

void Tabla_Lectura::Tabla_Lectura(){


}
int *Tabla_Lectura::Tabla_Read(int valor){
  int counter=0;
  int Salida[8];
  while(counter<8){
     Salida[counter]=Tabla[valor][counter];
     counter++;
  }
 return Salida;
}

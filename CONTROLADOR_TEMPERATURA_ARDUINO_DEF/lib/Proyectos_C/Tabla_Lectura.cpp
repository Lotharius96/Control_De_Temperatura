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
};

//byte Tabla_Read[8](int valor);

Tabla_Lectura::Tabla_Lectura(){};
int * Tabla_Lectura::Tabla_Read(int valor){
  int counter=0;
  int * Salida=(int *)malloc(8*sizeof(int));
  while(counter<0){
     Salida[counter]=Tabla[valor][7-counter];
     counter++;
  }
 return Salida;
}
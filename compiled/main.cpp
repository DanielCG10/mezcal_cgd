#include <cstdio>
 #include <iostream> 
 #include <string.h>
 using namespace std;
int main(int argc, char *argv[]){
	 int Numero;
while(Numero!=4){
	 cout << "      Menu     " << endl;
	 cout << "1 MENOR Y MAYOR" << endl;
	 cout << "2 LISTA ORDENADA" << endl;
	 cout << "3 MEDIA MEDIANA Y MODA" << endl;
	 cout << "4 SALIR" << endl;
	 cout << " " << endl;
	 cout << "SELECCIONE UNA OPCION" << endl;
	 cin >> Numero;
if(Numero==1){
	 cout << "MENOR Y MAYOR" << endl;
	 cout << "INGRESE CINCO NUMEROS" << endl;
	 int Serie[4];
	 int f;
	 int i;
	 int num;
for(f = 0;
f<5;f=f+1){
	 cout << "Dame un Numero" << endl;
	 cin >> num;
Serie[f] = num;
}
	 int min;
min= Serie[0] ;
for(i = 0;
i<5;i=i+1){
if(Serie[i] <min){
min= Serie[i] ;
}
}
	 cout << "El numero menor es "<< min << endl;
	 int may;
may= Serie[0] ;
for(i = 0;
i<5;i=i+1){
if(Serie[i] >may){
may= Serie[i] ;
}
}
	 cout << "El numro mayor es "<< may << endl;
}
 else if(Numero==2){
	 cout << "Lista Ordenada" << endl;
	 cout << "INGRESE DIEZ NUMEROS" << endl;
	 int Orden[9];
	 int f;
	 int i;
	 int h;
	 int num;
for(f = 0;
f<10;f=f+1){
	 cout << "Dame un Numero" << endl;
	 cin >> num;
Orden[f] = num;
}
for(f = 0;
f<10;f=f+1){
for(f = 0;
f<10;f=f+1){
}
}
}
 else if(Numero==3){
	 cout << "E 3" << endl;
}
 else if(Numero==4){
	 cout << "Nos vemos" << endl;
}
else {
	 cout << "Opcion invalida" << endl;
}
}

}


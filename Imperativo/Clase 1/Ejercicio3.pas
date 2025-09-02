{
Netflix ha publicado la lista de películas que estarán disponibles durante el mes de 
septiembre de 2025. De cada película se conoce: código de película, código de género (1: 
acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y 
puntaje promedio otorgado por las críticas.  
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos: 
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de 
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el 
código de la película -1.  
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje 
obtenido entre todas las críticas, a partir de la estructura generada en a).. 
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos 
métodos vistos en la teoría.  
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, 
del vector obtenido en el punto c).
}
program ejercicio3;
const   
    DF=8;
    FIN = -1;
type
    rango= 1..DF;
    
    pelicula= record
                codP:integer;
                codG:rango;
                puntaje:real;
             end;
             
    auxiliar= record
                codP:integer;
                puntaje:real;
              end;
             
    lista = ^nodo;
    nodo= record
            datos: auxiliar;
            sig:lista;
          end;
          
    VectorListas = array [rango] of lista;
    
    VectorGeneros = array [rango] of auxiliar;
    
//MODULOS

procedure ModuloA(var v:VectorListas);
    procedure InicializarListas(var v: VectorListas);
    var
      i: rango;
    begin
      for i := 1 to DF do
        v[i] := nil;
    end;
    procedure LeerPelicula(var p:pelicula);
    begin
        with p do
        begin
            writeln('Ingrese el codigo de pelicula -- FIN -1 --');
            readln(codP);
            if( codP <> FIN )then
            begin
                writeln('Ingrese el codigo de  genero --1 a 8--');
                readln(codG);
                writeln('Ingrese el puntaje');
                readln(puntaje);
            end;
        end;
    end;
    procedure TransladarDatos(p:pelicula; var a:auxiliar); {NO ES NECESARIO, QUEDA PROLIJO}
    begin
        a.codP:=p.codP;
        a.puntaje:=p.puntaje;
    end;
    procedure AgregarAdelante(var l:lista; a:auxiliar);
    var
        nue:lista;
    begin
        new(nue);
        nue^.datos:=a;
        nue^.sig:=l;
        l:=nue;
    end;
var 
    p:pelicula;
    a:auxiliar;
begin
    InicializarListas(v);
    LeerPelicula(p);
    while ( p.codP <> FIN ) do
    begin
        TransladarDatos(p,a);
        AgregarAdelante(v[p.codG],a);
        LeerPelicula(p);
    end;
end;

procedure ModuloB(v:VectorListas; var vec:VectorGeneros);
    procedure Maximo(var aux:auxiliar; punt:real;codP:integer);
    begin
        if ( punt > aux.puntaje )then
        begin
            aux.puntaje:=punt;
            aux.codP:=codP;
        end;
    end;
var
    aux:auxiliar;
    i:rango;
    l:lista;
begin
    for i:=1 to DF do
    begin
        aux.puntaje:=-1;
        {aux.codP:= -1; no es necesario inicializarlo}
        l:=v[i];
        while ( l <> nil ) do
        begin
            Maximo(aux, l^.datos.puntaje, l^.datos.codP);
            l:=l^.sig;
        end;
        vec[i]:=aux;
    end;
end;

procedure ModuloC(var v: VectorGeneros); {Ordenado por Insercion}
var
  i, j: integer;
  actual: auxiliar;
begin
  for i := 2 to DF do
  begin
    actual := v[i];
    j := i - 1;
    while (j > 0) and (v[j].puntaje > actual.puntaje) do
    begin
      v[j+1] := v[j];
      j := j - 1;
    end;
    v[j+1] := actual;
  end;
end;

procedure ModuloD(v: VectorGeneros);
var
    i:integer;
begin
  i:=1;
  while (v[i].puntaje = FIN )do i:=i+1; {PARA CONSIDERAR EL VERDADERO MAS CHICO, EL -1 NO ME SIRVE}
  writeln('Pelicula con menor puntaje: ', v[i].codP, ' (', v[i].puntaje:0:2, ')');
  writeln('Pelicula con mayor puntaje: ', v[DF].codP, ' (', v[DF].puntaje:0:2, ')');
end;

{NO LO PIDE, ES PARA PROBAR LOS MODULOS}
procedure MostrarVector(v: VectorGeneros);
var
  i: integer;
begin
  writeln('--- Vector de máximos por género ---');
  for i := 1 to DF do
    if (v[i].puntaje <> FIN )then
      writeln('Genero ', i, ': Pelicula ', v[i].codP,' - Puntaje: ', v[i].puntaje:0:2)
    else
      writeln('Genero ', i, ': sin peliculas');
end;

//PROGRAMA PRINCIPAL
var
    v:VectorListas;
    vec:VectorGeneros;
begin
    ModuloA(v);
    ModuloB(v,vec);
    
    writeln('Vector desordenado');
    MostrarVector(vec);
    
    writeln('Vector ordenado por Insercion');
    ModuloC(vec);
    MostrarVector(vec);
    
    ModuloD(vec);
end.

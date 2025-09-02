{
El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de 
las expensas de dichas oficinas.  
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos: 
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina 
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura 
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa. 
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la 
oficina. 
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}
program ejercicio2;
const   
    DF=300;
    FIN = -1;
type
    rango= 1..DF;
    
    oficina= record
                cod:integer;
                dni:integer;
                valorE:real;
             end;
             
    Vector = array [rango] of oficina;
//MODULOS
procedure ModuloA(var v:vector; var dimL:integer);
    procedure LeerOficina(var o:oficina);
    begin
        with o do
        begin
            writeln('Ingrese el codigo de identificación');
            readln(cod);
            if( cod <> FIN )then
            begin
                writeln('Ingrese el DNI');
                readln(dni);
                writeln('Ingrese el valor de la expensa');
                readln(valorE);
            end;
        end;
    end;
var 
    o:oficina;
begin
    dimL:=0;
    LeerOficina(o);
    while ( dimL < DF ) and ( o.cod <> FIN) do
    begin
        dimL:=dimL+1;
        v[dimL]:=o;
        LeerOficina(o);
    end;
end;

procedure ModuloB(var v: vector; dimL: integer);
var
  i, j: integer;
  actual: oficina;
begin
  for i := 2 to dimL do
  begin
    actual := v[i];
    j := i - 1;
    while (j > 0) and (v[j].cod > actual.cod) do
    begin
      v[j+1] := v[j];
      j := j - 1;
    end;
    v[j+1] := actual;
  end;
end;

{NO LO PIDE, ES PARA PROBAR LOS MODULOS}
procedure ImprimirVector(v: vector; dimL: integer);
var
  i: rango;
begin
  writeln('Listado de oficinas:');
  for i := 1 to dimL do
    writeln('Cod: ', v[i].cod, '  DNI: ', v[i].dni, '  Expensa: ', v[i].valorE:0:2);
end;

procedure ModuloC(var v: vector; dimL: integer);
var
  i, j, pos: integer;
  temp: oficina;
begin
  for i := 1 to dimL-1 do
  begin
    pos := i;
    for j := i+1 to dimL do
      if (v[j].cod < v[pos].cod) then
        pos := j;
    temp := v[pos];
    v[pos] := v[i];
    v[i] := temp;
  end;
end;
var
    v:vector;
    dimL:integer;
begin
    ModuloA(v,dimL);
    writeln('--- Vector Original ---');
    ImprimirVector(v, dimL);
    
    
    ModuloB(v,dimL);
    writeln('--- Vector Ordenado por Insercion ---');
    ImprimirVector(v, dimL);
    
    writeln('--- Vector Ordenado por Seleccion ---');
    ImprimirVector(v, dimL);
    ModuloC(v,dimL);
end.

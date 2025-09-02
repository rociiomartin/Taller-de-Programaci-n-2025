{
Una librería requiere el procesamiento de la información de sus productos. De cada 
producto se conoce el código del producto, código de rubro (del 1 al 6) y precio.  
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos: 
a. Lea los datos de los productos y los almacene ordenados por código de producto y 
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza 
cuando se lee el precio -1. 
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 20 elementos) con los productos del rubro 3. Considerar que 
puede haber más o menos de 20 productos del rubro 3. Si la cantidad de productos del rubro 3 
es mayor a 20, almacenar los primeros 20 que están en la lista e ignore el resto.  
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos 
métodos vistos en la teoría.  
e. Muestre los precios del vector resultante del punto d). 
f. Calcule el promedio de los precios del vector resultante del punto d).
}

program ejercicio4;
const   
    DF=6;
    DFR=20;
    FIN = -1;
type
    rango= 1..DF;
    rango2= 1..DFR;
    
    producto= record
                cod:integer;
                codR:rango;
                precio:real;
             end;
             
    auxiliar= record
                cod:integer;
                precio:real;
              end;
             
    lista = ^nodo;
    nodo= record
            datos: auxiliar;
            sig:lista;
          end;
          
    VectorListas = array [rango] of lista;
    
    VectorRubro3 = array [rango2] of auxiliar;
    

//MODULOS

procedure ModuloA(var v:VectorListas);
    procedure InicializarListas(var v: VectorListas);
    var
      i: rango;
    begin
      for i := 1 to DF do
        v[i] := nil;
    end;
    procedure LeerProducto(var p:producto);
    begin
        with p do
        begin
            writeln('Ingrese el precio -- FIN -1 --');
            readln(precio);
            if( precio <> FIN )then
            begin
                writeln('Ingrese el codigo de producto');
                readln(cod);
                writeln('Ingrese el codigo de rubro --1 a 6--');
                readln(codR);
            end;
        end;
    end;
    procedure TransladarDatos(p:producto; var a:auxiliar);
    begin
        a.cod:=p.cod;
        a.precio:=p.precio;
    end;
    procedure InsertarOrdenado(var l: lista; a:auxiliar);
    var
      nue, ant, act: lista;
    begin
      new(nue);
      nue^.datos:= a;
      act := l; ant:= l;
      while (act <> nil) and (act^.datos.cod < a.cod) do
      begin
        ant := act;
        act := act^.sig;
      end;
      if (ant = l) then l := nue
                   else ant^.sig := nue;
      nue^.sig := act;
    end;
var 
    p:producto;
    a:auxiliar;
begin
    InicializarListas(v);
    LeerProducto(p);
    while ( p.precio <> FIN ) do
    begin
        TransladarDatos(p,a);
        InsertarOrdenado(v[p.codR],a);
        LeerProducto(p);
    end;
end;


procedure ModuloB(v: vectorListas);
var
  i: integer;
begin
  for i := 1 to DF do
  begin
    writeln('Rubro ', i, ':');
    while (v[i] <> nil) do
    begin
        writeln('  Codigo: ', v[i]^.datos.cod, '  Precio: ', v[i]^.datos.precio:0:2);
        v[i]:= v[i]^.sig;
    end;
    if (v[i] = nil) then writeln('(sin productos)');
  end;
end;


procedure ModuloC(v:VectorListas; var vec:VectorRubro3; var dimL:integer);
begin
    dimL:=0;
    while ( v[3] <> nil) and (dimL < DFR)do
    begin
        dimL:=dimL+1;
        vec[dimL]:= v[3]^.datos;
        v[3]:=v[3]^.sig;
    end;
end;

procedure ModuloD (var v: VectorRubro3; dimL: integer); {POR INSERSION}
var
  i, j: integer;
  actual: auxiliar;
begin
  for i := 2 to dimL do
  begin
    actual := v[i];
    j := i - 1;
    while (j > 0) and (v[j].precio > actual.precio) do
    begin
      v[j+1] := v[j];
      j := j - 1;
    end;
    v[j+1] := actual;
  end;
end;

procedure ModuloE(v: VectorRubro3; dimL: integer);
var
  i: rango2;
begin
  writeln('--- Productos del rubro 3 ordenados por precio ---');
  for i := 1 to dimL do
    writeln('Codigo: ', v[i].cod, '  Precio: ', v[i].precio:0:2);
end;

procedure ModuloF(v:VectorRubro3; dimL:integer; var promedio:real);
var
    i:rango2;
    suma:real;
begin
    suma:=0;
    for i:=1 to DFR do  suma:=suma+ v[i].precio;
    if ( dimL > 0 ) then promedio:= suma / DFR
                    else promedio:=0;
end;

//PROGRAMA PRINCIPAL
var
    v:VectorListas;
    vec:VectorRubro3;
    dimL:integer;
    promedio:real;
begin
    ModuloA(v);
    ModuloB(v);
    ModuloC(v,vec,dimL);
    ModuloD(vec,dimL);
    ModuloE(vec,dimL);
    ModuloF(vec,dimL,promedio);
    writeln('El promedio de los precios del vector resultante del punto d)', promedio);
end.

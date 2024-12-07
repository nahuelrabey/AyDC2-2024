#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]

=== Ejercicio 2.a
Punto2D representa un punto en un plano. Debe contener las siguientes operaciones\
a) nuevoPunto\
b) mover\
c) distancia\
d) distanciaAlOrigen\

#pseudo[
  + TAD Punto2D {
    + obs x: $RR$
    + obs y: $RR$
    + proc nuevoPunto(in x: $RR$, in y:$RR$):
      + requiere {}
      + asegura {
        + $"res.x"=x and "res.y" = y$
      + }
    + proc mover(inout P: Punto2D, in dis_x: $RR$, dis_y: $RR$):
      + requiere {$P_0=P$}
      + asegura {
        + $"P.x" = P_0.x + x$
        + $"P.y" = P_0.x + y$
      + }
    + proc distancia(in P1: Punto2D, in P2 Punto2D):
      + requiere {}
      + asegura ${"res"=sqrt(("P1".x - "P2".x)^2+("P1".y-"P2".y)^2)}$
    + proc distanciaAlOrigen(in P1):
      + requiere {}
      + asegura ${"res"=sqrt(("P1".x - "P2".x)^2+("P1".y-"P2".y)^2)}$
 + }
]

=== Ejercicio 2.b
Crear el TAD Rectángulo2D, que representa un rectángulo en el plano. Debe contener las siguientes operaciones.

a) nuevoRectángulo\
b) mover\
c) escalar\
d) estaContenido\

#pseudo[
  + type Punto2D: struct$angle.l x:RR, y: RR angle.r$
  + TAD Rectangulo2D{
  + obs inf: Punto2D
  + obs sup: Punto2D
  + nuevoRectangulo(in inf: Punto2D, in sup: Punto2D):
    + asegura{
      + $"res.inf"="inf"$
      + $"res.sup"="sup"$
    }
  + mover(inout r: Rectangulo2D, in x: $RR$, in y: $RR$):
    + requiere{$r = R_0$}
    + asegura{
      + $"r.inf.x" = R_0."inf.x" + x$
      + $"r.sup.x" = R_0."sup.x" + x$
      + $"r.inf.y" = R_0."inf.y" + y$
      + $"r.sup.y" = R_0."sup.y" + y$
    + }
  + escalar(inout r: Rectangulo2D, in e: $RR$):
    + requiere{$r=R_0$}
    + asegura{
      + $"r.sup"$
    + }
  + }
  + aux diagonal(r: Rectangulo2D){
    $"res" = sqrt(("r."))$
  + }
]

=== Ejercicio 4
Especifique el TAD Diccionario\<K,V> con las siguientes operaciones:\
a) nuevoDiccionario
b) definir
c) obtener
d) 
#import "@preview/lovelace:0.3.0": *
#let colMath(x, color) = text(fill: color)[$#x$]
#let spc = $""$
#let al = $angle.l$
#let ar = $angle.r$
#let cmmt = $triangle.r$
#set page(columns: 2, margin: (x:1cm))
#set par(justify: true)

=== Especificación Cola

#pseudocode-list()[
  + *TAD* Cola\<T> {
  + obs s: seq\<T>
  + proc ColaVacía()
    + asegura {$"res.s" = al ar$}
  + }
  + pred Vacía(c: Cola){
    + $"c.s" = al ar$
  + }
  + pred encolar(c: Cola, e: T)
    + requiere{$"c" = "C"_0$}
    + asegura{
      + $"c.s" = "C"_0."elems" ++ <e>$
    + }
  + pred desencolar(c: Cola)
    + requiere{$"c" = "C"_0$}
    + requiere{$"c"."s" != al ar$}
    + asegura{$"c.s" = "subseq"(C_0."s",1,|C_0."s"|)$}
    + asegura {$"res" = C_0."s"[0]$}
  + pred proximo(c:Cola)
    + requiere{$"c"."s" != al ar$}
    + asegura{$"res" = c[c."s"[0]]$}
]
#text(fill: orange)[ESTA OBSERVACIÓN ES ERRÓNEA; CORREGIR Y EXPLICAR PORQUÉ]


*Obs 1*: Notemos que a este TAD le faltaría toda un "vuelta de tuerca", particularmente ¿cómo definimos la capacidad máxima? Esto en las diapos de la práctica no está dado, no me gusta cómo se encaró esa parte. ¿Vale la pena especificarlo más?

// #colbreak()
=== Implementación Cola Acotada
#pseudocode-list()[
  + Modulo ColaAcotada\<T> Implmenta Cola\<T>{
    + elems: Array\<T>
    + ini: int
    + fin: int
    + pred InvRep(c: ColaAcotada){
      + $0 < c."ini" <= c."elems.length" and_L$
      + $0<c."fin"<=c."elems.length"$
    + }
    + pred Abs(c: ColaAcotada, c': Cola){
      + $c'."cap" = c."elems"."length"-1 and_L$
      + $|c."fin" - c."ini"| mod c."elems.length " = |c'.s| and_L$
      + $(forall n: NN)(0<n<|c'.s|$
        + $->_L c'."set"[n] = c."elems"[(n+c."ini") mod c."elems.length"]$
      + $)$
    + }
    + proc ColaVacía(in tamaño: int):
      + {
        + res.elems = new Array\<T>(tamaño)
        + return res
      + }
      + asgura{$"invRep"("res") and_L "res.elems.length" = 0$}
    + proc encolar(inout c: ColaAcotada, e: T):
      + requiere{$"InvRep"(c)$}
      + requiere{$c = C_0$}
      + {
        + c.elems[c.fin] := e
        + c.fin = (c.fin + 1) mod c.elementos.length
      + }
      + asegura {$"InvRep"(c)$}
      + asegura {$c."elems"[C_0."fin"] = e$}
    
    + proc desencolar(inout c: ColaAcotada):
      + requiere($"InvRep"(c)$)
      + requiere($c = C_0$)
      + {
        + res = c.elems[c.ini]
        + c.fin = (c.fin + 1) mod c.elementos.length 
        + return res
      + }
      + asegura($"InvRep"(c)$)
      + asegura($"res" = C_0."elems"[C_0."ini"]$)
  + }
]

#text(fill: orange)[CORREGIR LAS OBSERVACIONES, PUES HE CORREGIDO LA IMPLEMENTACIÓN]

*Obs 2*: Sobre la _Obs 1_, notemos lo siguiente, en la línea 10 definimos la capacidad. No hace falta definirla en el TAD original. Limitamos todas las operaciones, la abstracción de la implementación, mediante este elemento lógico creado en el predicado.

Además, sobre la capacidad, si aplicamos módulo, se gira sobre los siguientes números: $[0,1,2,3,4,...,n-1]$, que contiene $n$ elementos
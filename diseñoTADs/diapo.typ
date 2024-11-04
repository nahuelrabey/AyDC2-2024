#import "@preview/lovelace:0.3.0": *

= Diseño de TADS

Algunas cuestiones básicas. La principal distinción es que los tipos de una especificación se da a partir de observadores; en un diseño dependen de las estructuras de las que disponemos. En esta cátedra

+ int, float, char
+ tupla, struct
+ array<T>
+ Modulos de otros TADs
+ otros #text(red)[(agregar!!)]

== Invariante de Representación
Es un pinchi predicado >:c, podrido estoy de esos. Bueno, se tiene que cumplir siempre que empieza y termina una implementación. Es decir, debe valer la siguiente tripla de Hoar.

${"InvRep"(p)} "procx"(p,...) {"InvRep(p)"}$

Veamo un ejemplo
#pseudocode-list(line-numbering: none)[
  + Modulo PuntoImpl implementa Punto {
    + rho: float
    + theta: float 
    + pred invRep(p': PuntoImpl)
      + ${-pi <= "p'.theta" <= pi}$
  + }
]

Para aclarar, vale decir que viene de 
#pseudocode-list(line-numbering: none)[
  + TAD Punto {
    + x: $RR$
    + y: $RR$
  + }
]

Cómo se ve con claridad, me puedo pasar bastante por dónde no sale la luz la especificación del TAD, PERO siempre la debe "respetar". O sea, en este caso, 'rho' y 'theta' representan un número real y un ángulo, respectivamente, que pueden usarse para construir las coordenadas $x$ e $y$

#pagebreak()
== Función de Abstracción
Chequea que una implementación respete su TAD.

En el caso anterior

#pseudocode-list(line-numbering: none)[
  + Modulo PuntoImpl implementa Punto {
    + rho: float
    + theta: float 
    + pred invRep(p': PuntoImpl)
      + ${-pi <= "p'.theta" <= pi}$
    + pred predAbs($p_0$: PuntoImpl, $p_1$: Punto)
      + ${p_1.x = p_0.rho dot cos(p_0.theta) and p_1.y = p_0.rho dot sin(p_0.theta)}$
  + }
]

#pagebreak()
== Ejemplos

=== CASBA

#pseudocode-list(line-numbering: none)[
  + TAD ConjuntoAcotado<$NN$>{
    + obs set: Conj<$NN$>
    + obs cota: $NN$

    + proc conjVacío(in cota: $NN$):
      + asgura{ $"res.set" = {} and "res.cota" = "cota"$ }
    
    + proc pertenece(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + requiere{ $c = C_0 and e<=C_0."cota"$ }
      + asegura{ $"res" = T <=> e in c."set"$ }
    
    + proc agregar(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + requiere{ $c = C_0 and e<=c."cota"$ }
      + asegura{ $c."set" = C_0."set" union angle.l e angle.r$}
  + }
]

#pseudocode-list(line-numbering: none)[
  + Modulo ConjuntoAcotadoSobreBitArray<$NN$>{
    set: Array<Bool>

    + pred invRep(c: CASBA)
      + ${ (forall n: NN)(0<=n<|c."set"| ->_L "def"(c."set"[e])) }$
    
    + pred funAbs($c_0$: CASBA, $c_1$:ConjuntoAcotado)
      + $
      {c_1."cota" = |c_0."set"| - 1 and (forall n in NN)(n in c_1."set" <=> (n<=|c_0."set"| and_L c_0."set"[n] = "True"))}
      $

    + proc conjVacío(in cota: $NN$):
      + "Creo array de elementos, todos en false"
    
    + proc pertenece(in c: CASBA, in e: $NN$):
      + *If* $e>|c."set"|$ *then*
        + *return* False
      + *return* c.set[e]
    
    + proc agregar(in e: $NN$):
      + c.set[e] = True
  + }
]


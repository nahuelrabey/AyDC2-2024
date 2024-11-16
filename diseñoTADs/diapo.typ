#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmmt = $triangle.r$

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

Es claro que el TAD no es la mismo que una implementación. En este caso, 'rho' y 'theta' representan un número real y un ángulo, respectivamente, *que pueden usarse para construir las coordenadas $x$ e $y$*. Atentos a esto último: hay algo que "transforma" mi implementación en el TAD. Y esto es...

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

== Ejemplos

=== CASBA

#pseudocode-list(line-numbering: none)[
  + TAD ConjuntoAcotado<$NN$>{
    + obs set: Conj<$NN$>
    + obs cota: $NN$

    + proc conjVacío(in cota: $NN$):
      + asgura{ $"res.set" = {} and "res.cota" = "cota"$ }

    + proc pertenece(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + asegura{ $"res" = T <=> e in c."set"$ }
    
    + proc agregar(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + requiere{ $c = C_0 and e<=c."cota"$ }
      + asegura{ $c."set" = C_0."set" union angle.l e angle.r$}
  + }
]

#pagebreak()
#pseudocode-list()[
  + Modulo ConjuntoAcotadoSobreBitArray<$NN$>{
    + set: Array<Bool>

    + pred invRep(c: CASBA){
      + $(forall n: NN)(0<=n<|c."set"| ->_L "def"(c."set"[n]))$
      + }
    + pred funAbs($c_0$: CASBA, $c_1$:ConjuntoAcotado)
      + $
      {c_1."cota" = |c_0."set"| - 1 and (forall n in NN)(n in c_1."set" <=> (n<|c_0."set"| and_L c_0."set"[n] = "True"))}
      $

    + proc conjVacío(in cota: $NN$):
      + *requiere* {True}
      + res.set = NewArray[cota+1][False]
      + *return* res
      + *asegura* {
        + $|"res.set"| = "cota"+1 and (forall n: NN)(0<=n<"cota" ->_L "res.set"[n] = F)$
        + }
    
    + proc pertenece(in c: CASBA, in e: $NN$):
      + *requiere* {invRep(c)}
      + *If* $e>=|c."set"|$ *then*
        + *return* False
      + *return* c.set[e]
      + *asegura* ${
        "invRep"(c) and_L (("res" = T) <=> e <= (|c."set"| and_L c."set"[e] = T))
      }$
    
    + proc agregar(in e: $NN$, inout c: CASB):
      + *requiere*{ $"invRep"(c) and c=C_0 and_L e < |c."set"|$ }
      + c.set[e] = True
      + *asegura* $
      {&"invRep"(c) and_L \ &(forall n in NN)(0<=n<|c."set"| -> (n != e and_L c."set"[n] = C_0."set"[n]) or (n = e and_L c."set"[n] = T)}$
  + }
]

He decidido agregar numeración a las líneas de la implementación para poder ver un poco en detalle cada cosa.

veamos que el `proc conjVacío` tiene un código utilizando `NewArray[n][V]`, dónde $n$ es el número de elementos y $V$ el valor inicial de cadda uno.

Además, $"wp"("9~10","asegura(conjVacío)") = T$ por definición de `NewArray`. Así cómo una $Theta(n)$ simepre.

Notemos que en el `proc pertenece` debimos garantizar en el requiere que vale la preposición $"invRep"(c)$ para poder utilizar el CASBA

#pagebreak()
=== Ejemplo con Memoria Dinámica

#pseudocode-list(line-numbering: none)[
  + TAD Conjunto<$P$>{
    + obs set: Conj<$P$>

    + proc conjVacío(in cota: $NN$):
      + asgura{ $"res.set" = {}$ }
    
    + proc pertenece(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + asegura{ $"res" = T <=> e in c."set"$ }

    + proc agregar(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + requiere{ $c = C_0$ }
      + asegura{ $c."set" = C_0."set" union angle.l e angle.r$}

    + proc borrar(in c: ConjuntoAcotado<$NN$>, in e: $NN$):
      + requiere{ $c=C_0 and e in C_0."set"$ }
      + asegura{
        + $
          c."set" = C_0."set" - angle.l e angle.r
          $
      + }
    +
  + }
]

Defino la estructura del Nodo, que se utilizará más adelante
#pseudocode-list(line-numbering: none)[
  + Nodo = Struct\<dato: $NN$, pxmo: Nodo>
]

Defino una preposición para afirmar que un Nodo $x$ tiene forma de lista
#pseudocode-list(line-numbering:none, indentation: 2em)[
  + List? (l: seq<$T$>, x: Nodo){
    + $
    & (x = "null" <=> l = <>) and_L\
    & (x != "null" => (x."dato" = "head"(l) and_L "list?"("tail"(l),x."pxmo")))
    $
  + }
]

Interpretemos esto. Si el nodo es nulo, la lsita debe ser vacía. Si el nodo no es nulo, entonces el dato del nodo debe ser el primer elemento de la lista, y además debe ser una lista válida la cola de la lista y el nodo próximo.

Una reflexión importante sobre el conector $and_L$: Nosotros estamos AFIRMANDO que se cumple $x = "null" <=> l = <>$. Esto es muy clave, porque AFIRMA que si $x!="null"$ entonces $l != <>$. Si tuvieramos un $or_L$, estaría abierta la posibilidad de que $x!="null"$ y $l=<>$, que es algo que no debe pasar, pues el nodo $x$ no representaría a la lista $l$. Un toque difícil, pero muy clave entenderlo.

De esto último hay que tener en cuenta la siguiente propiedad
$
(forall l,l': "Seq"<NN>)("List?"(l,x) and "List?"(l',x) => l=l')
$
En criollo, si un nodo $x$ tiene la forma de la lista $l$ y $l'$, entonces $l=l'$

AGORA SEM, puedo armar el diseño del conjunto 😎
#pagebreak()
#pseudocode-list()[
  + Modulo SLL Implementa Conjunto<$P$>{
    + root: Nodo
    + pred InvRep(sll: SSL){
      + $
      "sll" != "null" and_L (exists L:"Seq"<NN>)("List?"(L, "ssl.root"))
      $
    + }
    + pred Abs(c: SLL, c': Conjunto){
      + $
        c'."set" = "SetOf"("list"("sll.head"))
        $
    + }
    + proc conjVacío():
      + *var* res: SSL;
      + res := New(SSL);
      + res.head := null;
      + *_asgura_*{ $"InvRep"("res") and_L "res.head"="null"$ }

    + proc pertenece(in sll: SLL, in e: $NN$):
      + *_requiere_*{$"invRep"("sll") and_L l_0 = "list"("sll.root") and$ #text(fill: blue)[$"elems" = "SetOf"(l_0)$]}
      + #spc
      + *var* res: Bool; actual: Nodo
      + res := F
      + actual := sll.root
      + *while* $"actual" != "null" and "res"=F$ *do* 
        + *if* actual.value = e *then*
          + res := T
        + actual = actual.pxmo
      + *return* res
      + #cmmt TAREA: #text(fill: orange)[hacer el invariante de este ciclo]
      + #spc
      + *_asegura_*{
        + $
          "invRep"("sll") and_L l_0 = "list"("ssl.root") and_L ("res" = T <=> e in l_0)
          $
      + }
    
    + proc agregar(in sll: SLL, in e: $NN$):
      + *_requiere_*{ $"InvRep"("sll") and_L l_0 = "list"("sll"."head") and$ #text(fill: blue)[$"elems" = "SetOf"(l_0)$] }
      + #spc
      + $triangle.r$ Simplemente agrega un elemento al principio de la lista
      + *var* aux: Nodo
      + aux.dato = e 
      + aux.pxmo = sll.head 
      + sll.head = aux.head
      + *return*
      + #spc
      + *_asegura_*{ $"InvRep"("sll") and_l "list"("sll.root") = l_0++<e>$}
    + proc borrar(in sll: SLL, in e: $NN$):
      + *_requiere_* {$"InvRep"("sll") and_L l_0 = "list"("sll.root") and$ #text(fill: blue)[$"elems" = "SetOf"(l_0)$]}
      + #spc
      + *while* (sll.root != null && sll.root.dato ) *do*
        + sll.root := sll.root.pxmo
      + actual:= sll.root
      + *while* (actual != null && actual.pxmo != null)
        + *if* (actual.pxmo.dat = d) *then*
          + actual.pxmo = actual.pxmo.pxmo
        + *else* 
          + actual = actual.pxmo
      + *return*
      + #cmmt TAREA: #text(fill: orange)[hacer el invariante de este ciclo]
      + #spc
      + asegura{
        + $ 
          "InvRep"("sll") and_L "list"("sll"."root") = "Remove"(l_0,d)
          $
      + }
  + }
]



Obs 1: En la línea 1, `SLL` es pseudónimo para "Set Using Linked List".

Obs 2: El invariante de representación puede leerse así: "sll está definido en la memoria y el nodo raíz tiene la forma de una lista"

Obs 3: La función de abstración "Abs" utiliza $"list"("sll.head")$, que de un nodo que representa una lista, devuelve su lista. De ahí $"SetOf"(angle.l...angle.r)$ nos da el conjunto formado por los elementos de tal lista.

Obs 4: el códig en azul, en la línea 17 creo que podría no existir.


#cmmt TAREA: #text(fill: orange)[diapo 42, 45]
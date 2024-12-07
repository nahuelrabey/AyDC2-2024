#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmnt = $triangle.r$

=== Arbol Binario de Búsqueda - Rabey

Implementación propia de Nahuel Rabey de un Árbol de Búsqueda, respetando la sintáxis de la cátedra de Algoritmos y Estructura de Datos de FCEN-UBA

=== Especificación (¿es necesario?)

No es necesario, es una estructura, que puede o no utilizarse para implementar un TAD. Es decir, no puede haber un TAD de una estructura, porque una estructura non es un dato. "Tipo Abstracto de Dato" no tiene sentido en esto contexto. ¿Puedo crear un TAS: "Tipo Abstracto de Estructura"? Desconozco.

#pseudocode-list()[
  + TAD ABB_TAD{
    + obs conj\<int>
    + pred 
  + }
]

=== Implementación de un ConjuntoABB
Me aburrí, lo seguiré mañana
#pseudocode-list()[
  + Nodo = Struct\<val: int, izq: Nodo, der: Nodo>
  + modulo ConjuntoABB implementa Conjunto{
    + root: Nodo
    + pred pertenece(in e: int, in n: Nodo){
      + $n != "Nil" and_L$ 
      + $(e = n."val" or_L "pertenece"(e, n."izq") or_L "pertenece"(e,n."der"))$
    + }
    + pred esABB(in n: Nodo){
      + $n = "Nil" or_L$(
        + $(forall e: "int")("pertenece"(e,n."izq") ->_L e <= n."val") and_L$
        + $(forall e: "int")("pertenece"(e,n."der") ->_L e > n."val")$
      + )
    + }
    + pred #text(fill:green)[InvRep] (c: ConjuntoABB){
      + $"esArbolBinario"(c.root) and_L "esABB"(c.root)$
    + }
    + pred #text(fill: green)[Abs] (c: ConjuntoABB, c': Conjunto){
      + $(forall e: T)("pertenece(e,c.root)" <->_L e in c'."set")$
    + }
    + proc new():
      + res.root = Nil
      + *return* res
    + proc agregarRecursivo(inout n: Nodo, in e: int):
      + *if* n == Nil:
        + n = *new* Nodo()
        + n.izq = Nil
        + n.der = Nil
        + n.value = e
        + *return*
      + #spc
      + *if* e <= n.value:
        + agregarRecursivo(n.izq, e)
      + *else*:
        + agregarRecursivo(n.der, e)
      + #spc
      + *return*
    + proc agregarIterado(inout c: ConjuntoABB, in e: int):
      + *if* (c.root = Nil):
        + n = new Nodo
        + n.value =  e
        + *return*
      + actual = c.root
      + #cmnt cuando encuentre el nodo dónde agruegue el valor, ese nodo pasará a tener el mismo valor que estoy buscando. Esta propiedad será la guarda del bucle.
      + *while* actual.value != value:
        + *if* e < actual.value:
          + *if* actual.izq = Nil:
            + actual.izq = new Nodo
            + actual.izq.value = e
          + actual = actual.izq

        + *if* e > actual.value:
          + *if* actual.der = Nil:
            + actual.der = new Nodo
            + actual.der.value = e
          + actual = actual.der
      + *return*
      
    + proc quitar(inout n:Nodo, in e: int):
      + requiere{ pertenece(e, n) }
      + actual: Nodo = n
      + *while* True:
  + }
]


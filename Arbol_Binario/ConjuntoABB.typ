#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmmt = $triangle.r$

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
    + proc agregar(inout n: Nodo, in e: int):
      + *if* n == Nil:
        + n = *new* Nodo()
        + n.izq = Nil
        + n.der = Nil
        + n.value = e
        + *return*
      + #spc
      + *if* e <= n.value:
        + agregar(n.izq, e)
      + *else*:
        + agregar(n.der, e)
      + #spc
      + *return*
    + proc quitar(inout n:Nodo, in e: int):
      + actual: Nodo = n
      + *while* actual != Nil && actual.val != 
  + }
]
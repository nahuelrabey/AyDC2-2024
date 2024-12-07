#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmmt = $triangle.r$
#set page(columns: 2, margin: (x:1cm))
#set par(justify: true)
== Arbol Binario

=== Ejemplo definición matemática

```
<5,<Nil,Nil>>
```
```
<5,<<22,3>,<3,Nil>>>
```

=== Altura, con definición matemática

text(fill: green)[Codear un proc utilizando recursión para la definición matemática]

#pseudocode-list()[
+ Altura(Nil) = 0
+ Altura\<a,s> = 1 + $max_(i)("altura"(s_i))$
]

=== Arbol Binario de Búsqueda

Voy a usar un predicado para definirlo, lo entiendo mejor así, directamente

#pseudocode-list()[
+ pred esABB(a: ArbolBinario\<t>){
  + $a = "Nill" or $#text(fill: blue)[(]
    + $(forall e: T )(e in a."izq" -> e <= a."dato") and$
    + $(forall e: T)(e in a."der" -> e > a."dato") and$
    + $("esABB"(a."izq") and "esABB"(a."der"))$
  + #text(fill:blue)[)]
+ }
]

==== Implementamos


#pseudocode-list()[
+ Nodo = Struct \<dato: N, izq: Nodo, der: Nodo>
+ modulo ConjuntoABB implmenta Conjunto{
  + raíz: Nodo
  + pred invRep(c: ConjuntoABB){
    + $#text(fill: blue)[esArbol(c)] and "esABB"(c."raíz")$
  + }
  + pred Abs(c': ConjuntoABB, c: Conjunto){
    + $(forall e in T)("esAlcanzable"(e,c) <-> e in c')$
  + }
  + pred esABB(a: ArbolBinario\<t>){
    + $a = "Null" or $#text(fill: blue)[(]
      + $(forall e: T )(e in a."izq" -> e <= a."dato") or$
      + $(forall e: T)(e in a."der" -> e > a."dato") and$
      + $("esABB"(a."izq") and "esABB"(a."der"))$
    + #text(fill:blue)[)]
  + }
  + pred esAlcanzable(e: T, c: ConjuntoABB){
    + $c."raíz.dato" != "Null" or$
    + $e_L = c."raíz.dato" or$
    + $"esAlcanzable(e, c.raíz.izq)" or $
    + $"esAlcanzable(e,c.raíz.der)"$
  + }
  + proc ConjuntoVacío(): ConjuntoABB
    + res.raíz = Null
    + *return* res
  
  + proc agregar(inout c: ConjuntoABB, in e: int):
    + *if* c.raíz == Null:
      + c.raíz.dato = e
      + c.raíz.izq = Null
      + c.raíz.der = Null
      + *return*
    
    + *if* e <= c.raíz.dato:
      + agregar(c.raíz.izq, e)
    + *else*:
      + agregar(c.raíz.der, e)
    
    + *return*
+ }
]

=== Reflecciones

Me parece importante destacar lo siguiente, en este caso la estructura "Arbol Binario" está implícita en "ConjuntoABB". Pero, podríamos utilizar tres módulos: módulo Nodo, módulo ABB, módulo Conjunto.

Me gustaría intentar definir, de forma completa, estos tres, porque siento que en cada ejemplo se "mezclan" entre sí. No hay una separación clara de las cosas.

Veamos la línea 33 y 35, por ejemplo, llamamos recursivamente a "agregar" ¡Pero el argumento que le pasamos no es un ConjuntoABB, es un nodo! No está la función definida para trabajar sobre un nodo, sino sobre el árbol binario. Una manera "elegante" de resolver esto es crear también un módulo NodoABB, o que se ingreso cómo argumento, en vez de una instancia "conjuntoABB", una instancia "nodo". La primera requeriría crear un "Nodo" distinto; la segunda mantendría un "Nodo" general (con los tres elementos: valor, izq, der), pero sólo tendría una relación "abstracta" consigo misma la función agregar: no habría nada que la relacione con un objeto, ni con nada, sino con un módulo
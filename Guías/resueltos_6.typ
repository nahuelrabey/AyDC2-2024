#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmnt = $triangle.r$
#let la = $<$
#let ra = $>$
#let al = $angle.l$
#let ar = $angle.r$
#let req = text()[ *_requiere_* ]
#let asg = text()[ *_asegura_* ]

#set page(margin: (y: .5cm))

#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#codly(zebra-fill: none)
#codly(display-icon: false)
#codly(display-name: false)
#codly(stroke: none)


=== Ejercicio 1
#pseudocode-list(line-numbering: none)[
  + NodoLista$<T>$ es Struct #la
    + valor: T,
    + siguiente: NodoLista$<T>$
  + #ra
  + modulo ListaEnlazada$<T>$ implementa Secuencia$<T>${
    + ```java
    var primero:  NodoLista<T>
    var último:   NodoLista<T>
    var longitud: int
    ```
    + proc NuevaListaVacía(): ListaEnlazada$<T>$
      + ```java
      res := new ListaEnlazada<T>
      res.primero := null
      res.último := null
      res.longitud := 0
      return res
      ```
    + proc AgregarAdelante(inout L: ListaEnlazada$<T>$, in e:T):
      + ```java
      nodo := new NodoLista<T>()
      nodo.valor = e
      nodo.siguiente = null
      if L.longitud == 0:
        L.primero := nodo
        L.útlimo := nodo
      else
        nodo.siguiente .= L.primero
        L.primero = nodo.siguiente
      
      L.longitud = L.longitud + 1
      ```
    + proc Pertenece(in L: ListaEnlazada$<T>$, in e: T):
      + ```java
      res := false
      actual := L.primero
      while actual != null && res == false:
        if actual.valor == e:
          res := true
        actual := actual.siguiente
      return res
      ```
    + proc AgregarAtras(inout L: ListaEnlazada$<T>$, in e: T):
      + ```java
      nodo = new NodoLista()
      nodo.valor = e
      nodo.siguiente = null

      if L.longitud == 0:
        L.primero = nodo
        L.último = nodo

      else:
        L.útlimo.siguiente = nodo
        L.útlimo = nodo
      
      L.longitud = L.longitud + 1
      ```
    + proc Obtener1(in L: ListaEnlazada$<T>$, in e: T):
      + ```java
      res := false
      i := 0
      actual_ultimo := L.ultimo
      actual_primero := L.primero
      while (i <= (L.longitud / 2)) || res == false :
        if (actual_primero.value == e):
          res = true
        
        if (actual_ultimo.value == e):
          res = true
      
      return true
      ```
    + proc Obtener2(in L: ListaEnlazada$<T>$, in e: T):
      + ```java
      res := false
      i := 0
      actual = L.primero
      while (i <= L.longitud) || (res == false) :
        if (actual.value == e):
          res = true
      
      return true
      ```
    + proc Eliminar(inout L: ListaEnlazada$<T>$, in e: T):
      + #req{ $e in "SetOf(list(L.primero))"$ } 
      + ```java
      anterior := null
      actual := L.primero
      i := 0
      while (i<= L.longitud) || (actual.value == e):
        anterior := actual
        actual := actual.siguiente

      // if (actual == null):
      //   raise "No se encontró 'e' en la lista 'L'"
      anterior.siguiente = null
      ```
    + proc concatenar(inout L1: ListaEnlazada$<T>$, in L2: ListaEnlazada$<T>$):
      +```java
      L1.último = L2.primero
      ```
  + }

]


Analizamos el peor caso de cada proceso

+ $"NuevaListaVacía" -> Theta(4) equiv Theta(1)$
+ $"AgregarAdelante" -> Theta(7) equiv Theta(1)$
+ $"Pertenece" -> Theta(2 + 3n + 2 + 1) equiv Theta(n)$
+ $"AgregarAtras" -> Theta(7) equiv Theta(1)$
+ $"Obtener1" -> Theta(5 + (2n)/2 + 4) equiv Theta(n/2) equiv Theta(n)$
+ $"Obtener2" -> Theta(4 + (3n) + 1) equiv Theta(n) equiv Theta(n)$\
  ¡Eureka! En el peor de los casos, obtener 1 y obtener dos están en el mismo orden. Con cantidades de elementos lo suficientemente grandes y con un proecsador lo suficientemente potente, ambos algoritmos son equivalentes.
+ $"Eliminar" -> ... -> Theta(n)$

Ejercicio 2

#let T = text()[true]
#pseudocode-list(line-numbering: none)[
  + TAD ConjuntoAcotado$<T>${
    + obs elems: conj$<T>$
    + obs cap: $ZZ$
    + #spc
    + proc conjuntoVacío(in cap: $ZZ$):
      + #req {$"cap" > 0$}
      + #asg {$"res.elems" = al ar$}
      + #asg {$"res.cap"$}
    + proc pertenece(in e: T, in C: ConjuntoAcotado$<T>$)
      + #asg {$"res" = #T <-> e in C."elems"$}
    + proc agregar(in e: T, inout c: ConjuntoAcotado$<T>$)
      + #req { $c = C_o$ }
      + #req { #text(fill: blue)[$|c."elems"| < c."cap"$] }
      + #asg { $"c.cap" = C_0."cap"$ }
    + proc sacar(in: e: T, inout c: ConjuntoAcotado$<T>$)
      + #req { $c = C_0$ }
      + #asg { $c."elems" = C_0."elems" - {e}$ }
      + #asg { $c."cap" = C_0."cap"$ }
    + proc unir(inout $A$: ConjuntoAcotado$<T>$, in $B$: ConjuntoAcotado$<T>$)
      + #req { $A = A_0$ }
      + #req { $|A."elems" union B."elems"| <= |A."cap"|$ }
      + #asg { $A."elems" = A_0."elems" union B."elems"$ }
      + #asg { $A."capacidad" = A_0."capacidad"$ }
    + proc restar(inout A: ConjuntoAcotado, in B: ConjuntoAcotado)
      + #req { $A = A_0$ }
      + #asg { $A."elems" = A_0."elems" - B."elems"$ }
      + #asg { $A."capacidad" = A_0."capacidad"$ }
    + proc intersecar(inout A: ConjuntoAcotado, in B: ConjuntoAcotado)
      + #req { $A = A_0$ }
      + #asg { $A."elems" = A_0."elems" sect B."elems"$ }
      + #asg { $A."capacidad" = A_0."capacidad"$ }
    + proc agregarRápido(inout c: ConjuntoAcotado, in e: T)
      + #req { $c = C_0$ }
      + #req { $e in.not C_0."elems"$ }
      + #req { $|c."elems"| < c."cap"$ }
      + #asg { $c."elems" = C_0."elems" union {e}$ }
      + #asg { $c."cap" = C_0."cap"$ }
    + #cmnt triviales estas
    + proc tamaño(in c: ConjAcotado$<T>$)
    + proc capacidad(in c: ConjuntoAcotado)
  + }
]

#import "@preview/ouset:0.2.0": overset
$ overset(forall, infinity) $
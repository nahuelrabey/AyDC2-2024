#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmnt = $triangle.r$
#let la = $<$
#let ra = $>$
#let al = $angle.l$
#let ar = $angle.r$
#let req = text()[ *_requiere_* ]
#let asg = text()[ *_asegura_* ]
#let nil = text()[ *_Nil_* ]
#let T(tipo) = [$angle.l tipo angle.r$]


#set page(margin: (y: .5cm))

#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#codly(zebra-fill: none)
#codly(display-icon: false)
#codly(display-name: false)
#codly(stroke: none)

=== Ejercicio

#pseudocode-list(line-numbering: none)[
  + Nodo#T[T] = Struct#T[dato: T, izq: Nodo, der: Nodo]
  + modulo ArbolBinario#T[T] implementa ArbolBinario#T[T]{
    + var root: nodo
    + pred InvRep(A: ArbolBinario#T[T]){
      + #cmnt Cada nodo puede ser nulo, o tener dos hijos que sean ABB.
      + #cmnt No hay restricciones sobre el valor del nodo
      + esABB(A.root)
    }
    + pred esABB(n: Nodo#[T]){
      + $(n."izq" = "null" or "esABB"(n."izq")) and$
      + $(n."der" = "null" or "esABB"(n."der"))$
    }
    + proc altura(in arbol: ArbolBinario#T[T]):
      ```java
      return alturaNodo(arbol.root)
      ```
    + proc cantidadHojas(in arbol: ArbolBinario#T[T])
      ```java
      return cantidadHojasNodo(arbol.root)
      ```
    + proc esta(in arbol: ArbolBinario#T[T], in e: T)
      ```java
      return estaNodo(arbol.root, e)
      ```
    + proc cantidadDeApariciones(in arbol: ArbolBinario#T[T])
      ```java
      return cantidadDeAparicionesNodo(arbol.root, e)
      ```
    + proc alturaNodo(in nodo: Nodo#T[T]){
      ```java
      if (nodo == null):
        return 0

      if (nodo.izq == null && nodo.der == null):
        return 1

      if (nodo.izq != null && nodo.der != null):
        altura_izq = 1 + altura(nodo.izq)
        altura_der = 1 + altura(nodo.der)
        if (altura_izq > altura_der):
          return altura_izq
        else:
          return altura_der
      
      if (nodo.izq != null):
        return 1 + altura(nodo.izq)

      if (nodo.der != null):
        return 1 + altura(nodo.der)
      ```
    + }
    + proc cantidadHojasNodo(in nodo: Nodo#T[T]){
      ```java
      if (nodo == null):
        return 0
      if (nodo.izq == null && nodo.der == null):
        return 1
      if (nodo.izq != null && nodo.der != null):
        return cantidadHojas(nodo.izq) + cantidadHojas(nodo.der)
      if (nodo.izq != null):
        return cantidadHojas(nodo.izq)
      if (nodo.der != null):
        return cantidadHojas(nodo.der)
      ```
    + }
    + proc estaNodo(in nodo: Nodo#T[T], in e: T){
      ```java
      if (nodo == null):
        return false
      if (nodo.value == e):
        return true
      if (nodo.izq != null && nodo.der != null):
        return estaNodo(nodo.izq, e) && estaNodo(nodo.der, e)
      if (nodo.izq != null):
        return estaNodo(nodo.izq, e)
      if (nodo.der != null):
        return estaNodo(nodo.der, e)
      ```
    + }
    + proc cantidadDeAparicionesNodo(in nodo: Nodo#T[T], in e:T){
      ```java
      res = 0
      if (nodo.value == e):
        res = 1
      // if (nodo.izq == null && nodo.der == null):
      //   res = res
      if (nodo.izq != null && nodo.der != null):
        res = res + cantidadDeAparicionesNodo(nodo.izq) + cantidadDeAparicionesNodo(nodo.der)
      if (nodo.izq != null ):
        res = res + cantidadDeApariciones(nodo.izq)
      if (nodo.der != null):
        res = res + cantidad de cantidadDeApariciones
      return res
      ```
    + }
  + }
]

=== Ejercicio 2

#pseudocode-list(line-numbering: none)[
  + Nodo = Struct#T[val: T, izq: Nodo, der: Nodo]
  + aux elems(n: Nodo#T[T]){
    + *If* $n = "null"$ *Then* $emptyset$ *else* ${n."val"}union "elems"(n."izq") union "elems"(n."der")$
  + }
  + modulo ABB#T[T] implementa Arbol Binario de Búsqueda{
    + var root: Nodo
    + var tamaño: int
    + pred InvRep(A: ABB#T[T])
    + pred esABB(n: Nodo#T[T]){
      + $n = #nil or ($
        + $(forall e: T)(e in "elems"(n."izq") ->_L e <= n."val") and$
        + $(forall e: T)(e in "elems"(n."der") ->_L e > n."val") and$
        + $"esABB"(n."izq") and "esABB"(n."der")$
      + $)$
    + }
    + proc esta(in A: ABB#T[T], int e: T):
      ```java
      return nodo_esta(A.root, e)
      ```
    + proc nodo_esta(in n: Nodo#[T], int e:T):
      ```java
      if n == null:
        return false
      if n.val == e:
        return true
      if e < nodo.val:
        return false || estaNodo(nodo.izq)
      if e > nodo.val:
        return false || estaNodo(nodo.der)
      ```
    + proc cantidadApariciones(in A: ABB#T[T], int e:T):
      ```java
      return cantidadAparicionesNodo(A.root)
      ```
    + proc nodo_cantidadApariciones(in n: Nodo#T[T], int e: T):
      ```java
      if n == null:
        return 0
      if e <= n.value:
        return 1 + cantidadAparicionesNodo(n.izq)
      if e > n.value:
        return cantidadApariciones(n.der)
      ```
    + proc insertar(inout A: ABB#T[T], int e:T)
      ```java
      nodo_insertar(A.root, e)
      A.tamaño = A.tamaño + 1
      ```
    + proc nodo_insertar(inout n: Nodo#T[T], int e:T)
      ```java
      if n == null:
        n = new Nodo<T>()
        n.val = e
        n.izq = null
        n.der = null
      
      if e <= n.val:
        nodo_insertar(n.izq, e)

      if e > n.val:
        nodo_insertar(n.der, e)
      ```
    + proc eliminar(inout A: ABB#T[T], in e: T):
      ```java
      if A.root == null:
        return
      
      nodo = nodo_buscar(A.root, e)

      if (nodo.izq == null):
        nodo = nodo.der
      if (nodo.der == null):
        nodo = nodo.izq
      
      hijo_der = nodo.der
      predecesor = predecesor(nodo)
      predecesor.der = hijo_der
      nodo = nodo.izq // acá, el nodo queda borrado
      ```
    + proc nodo_buscar(in n: Nodo#T[T], in e: T):
      ```java
      if n == null:
        return null 
      if n.val == e:
        return n 
      if e < nodo.val:
        return nodo_buscar(nodo.izq)
      if e > nodo.val:
        return nodo_buscar(nodo.der)
      ```
    + proc predecesor(in n: Nodo#T[T]): Nodo#T[T]
      + #req { $n."izq" != "null"$ }
      + ```java
      return maximo(n.izq)
      ```
    + proc maximo(in n: Nodo#T[]): Nodo#T[]
      ```java
      if n.der == null:
        return n
      if n.der != null:
        return maximo(n.der)
      ```
    + proc inOrder(in A: ABB#T[T]): Array#T[T]
      ```java
      res = new Array<T>(A.tamaño)

      pila = new PilaSobreLista#T[Nodo#T[T]]
      encolarALaIzquierda(pila, A.root)
      i = 0
      while pila.lista.longitud > 0:
        elem = pila.desapilar()

        if(elem.izq != null):
          encolarALaIzquierda(pila)

        res[i]=elem.val
        i = i+1

      return res 
      ```
    + proc encolarALaIzquierda(inout pila: PilaSobreLista#T[Nodo#T[T]], in n: Nodo#T[T]):
      ```java
      if (n == null):
        return
      pila.apilar(n)
      encolarALaIzquierda(pila, n.izq)
      ```
  + }
]

FALTA: Calcular Complejidad

FALTA: ¿Qué pasa cuando se incertan valores repetidos? Corrgir.
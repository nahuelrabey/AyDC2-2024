#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmnt = $triangle.r$
#let la = $<$
#let ra = $>$
#let al = $angle.l$
#let ar = $angle.r$
#let req = text()[ *_requiere_* ]
#let asg = text()[ *_asegura_* ]
#let T(tipo) = [$angle.l tipo angle.r$]

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

#let True = text()[true]
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

#pseudocode-list(line-numbering: none)[
  + modulo ConjuntoArr#T([T]) implementa ConjuntoAcotado#T([T]){
    + var datos: Array#T([T])
    + var tamaño: int
    + pred InvRep(c: ConjuntoArr#T[T]){
      + #cmnt básicamente, datos.length es nuestro "cap" y el tamaño, literalmente, indica el tamaño del conjunto es el equivalente $c."tamaño" = |c'."elems"|$
      + $0<=c."tamaño" <= c."datos.length"$
    + }
    + pred Abs(c: ConjuntoArr#T[T], c': ConjuntoAcotado#T[T]){
      + $"c.datos.length" == c'."cap" and$
      + $(forall e: T)(e in c'."elems" <-> e in "subseq"(c."datos",0,c'."cap"))$
    + }
    + pred ConjuntoVacío(in cap: int):
      ```java
      res.datos = new Array<T>(cap)
      res.tamaño = 0
      return res
      ```
    + pred pertenece(in e: T, in c: ConjuntoArr#T[T]):
      ```java
      res = false
      index = 0
      while  index <= c.tamaño && res == false:
        if e == c.datos[index]:
          res = true
        index = index + 1
      return res
      ```
    + pred agregar(in e: T, inout c: ConjuntoArr#T[T]):
      ```java
      c.datos[c.tamaño] = e
      c.tamaño = c.tamaño + 1
      ```
    + pred unir(A: ConjuntoArr#T[T], B: ConjuntoArr#T[T]):
      ```java
      index = 0
      while index < B.tamaño:
        A.datos[A.tamaño + index] = B.datos[index]
        index = index + 1
      ```
    + pred intersecar(inout A: ConjuntoArr#T[T], in B: ConjuntoArr#T[T]):
      ```java
      nuevo_datos = new Array<T>(A.datos.length)
      i = 0
      while i < nuevo_datos.length:
        j = 0
        while j < B.datos.length:
          if A.datos[i] == B.datos[j]:
            nuevo_datos[i] =A.datos[i]
          j = j+1
        i = i+1
      A.datos = nuevo_datos
      ```
    + pred buscar(in e: T, inouc c: ConjuntoArr#T):
      ```java
      i = 0
      while i < c.tamaño and c.datos[i] != e:
        i = i + 1
      return i
      ```
    + pred sacar(in e: T, inout c: ConjuntoArr#T[T]):
      ```java

      i = buscar(e, c) 
      // si e no está en c.dato
      if i = c.tamaño:
        return

      // borro el dato
      c.datos[i] = null

      // es el último elemento
      if i = c.tamaño-1:
        return

      // muevo todo un lugar para atras
      j = i+1
      while j < c.tamaño:
        c.dato[j-1] = c.dato[j]
      
      c.tamaño = c.tamaño - 1
      ```
  + }
]

Complejidades que me importan (en el peor de los casos)
- $"agregar" -> Theta(1)$
- $"unir" -> Theta(n)$
- $"intersecar" -> Theta(n^2)$
- $"buscar" -> theta(n)$
- $"sacar" -> Theta(n)$

La función agregar ya es $Theta(1)$, no puede mejorarse. 

Para la función "sacar" podemos mejorar la función "buscar", si logramos que "c.datos" sea un arreglo ordenado, utilizando busqueda binaria nos puede quedar en $Theta(log(n))$. Sin embargo, seguimos teniendo $Theta(log(n)+n) equiv Theta(n)$ para sacar.

Otra función que puede mejorar muchísimo es unir, si utilizaramos una lista enlazada, tendría $Theta(1)$. Si esta lista, además, fuera ordenada, nos quedamos con con buscar en el orden de $Theta(log(n))$

Para la función sacar, la mejor forma de mejorarla sería utilizando un AVL, dónde tendríamos $O(log(n))$, en detrimento de agregar.

=== Ejercicio 3

#pseudocode-list(line-numbering: none)[
  + modulo ConjuntoLista#T[T] implementa Conjunto#T[T] {
    + var datos: ListaEnlazada#T[T]
    + var tamaño: int
    + pred InvRep(C: ConjuntoLista#T[T]){
      + $|"list"("C.datos.cabeza")| = C."tamaño"$
    + }
    + pred Abs(C: ConjuntoLista#T[T], C': Conjunto#[T]) {
      + $"C.tamaño" = |C'."elems"| and$
      + $"SetOf"("list"("C.datos.cabeza")) = C'."elems"$
    + }
    + proc ConjuntoVacío():
      ```java
      res.datos = new ListaEnlazada()
      res.tamaño = 0
      return res
      ```
    + proc pertenece(in c: ConjuntoLista#T[T], in e: T):
      ```java
      it = c.datos.iterador()
      res = false
      while it.haySiguiente() && res = false:
        if (e = it.siguiente()):
          res = true
      return res
      ```
    + proc agregar(inout c: ConjuntoLista#T[T], in e: T):
      ```java
      if (pertenece(c,e)){
        return
      }
      agregarAtras(e,c.datos)
      ```
    + proc agregarRápido(inout c: ConjuntoLista#T[T], in e: T):
      ```java
      agregarAtras(c.datos, e)
      ```
    + proc sacar(inout c: ConjuntoLista#T[T], in e: T):
      ```java
      eliminar(c.datos, e)
      ```
    + proc unir(inout A: ConjuntoLista#T[T], in B: ConjuntoLista#[T]):
      + #cmnt Alternativa A, debería ser $O(n)$
      + ```java
      primero_B =primero(B.datos)
      agregarAtras(A.datos, primero_B)
      ```
      + #cmnt Alternativa B, esta es $O(m)$ ¿$m = "largo A" times "largo B"$?
      + ```java
      concatenar(A.datos, B.datos)
      ```
    + proc intersecar(inout A: ConjuntLista#T[T], in B: ConjuntoLista#T[T])
      ```java
      it_a = A.datos.iterador()
      nueva_lista = new ListaEnlazada()
      nuevo_tamaño = 0
      while it_a.haySiguiente():
        value_a = it.siguiente()
        it_b = B.datos.iterador()
        while it_b.haySiguiente():
          value_b = it.siguiente()
          if (value_a = value_b):
            agregarAtras(nueva_lista, value_a)
            nuevo_tamaño = nuevo_tamaño + 1
      A.datos = nueva_lista
      A.tamaño = nuevo_tamaño
      ```
  + }
]

#pagebreak()
=== Ejercicio 4

No bueno, creo que lo hice todo mal jaja, vamos de nuevo
#pseudocode-list(line-numbering: none)[
  + modulo ConjuntoIndicado implementa Conjunto#T[$ZZ,ZZ,ZZ$]{
    + var indices: #T[ListaEnlazada#T[int],ListaEnlazada#T[int],ListaEnlazada#T[int]]
    + var datos: ListaEnlazada#T[int,int,int]
    + var tamaño: int
    + proc BuscarPor(inout C: ConjuntoIndicado, in indice: int, in posicion: int):
      + #req { $"posicion" < "C.tamaño"$ }
      + ```java
      indice_LE := C.indices[indice_objetivo]
      it := indice_LE.interador()
      res := null
      k = 0
      while it.haySiguiente() && k <= posicion:
        value = it.siguiente()
        if k = posicion:
          res = value
        k = k + 1
      return res
      ```
    + proc agregar(inout C: ConjuntoIndicado, in e: #T[int,int,int]){
      ```java
      C.datos[C.tamaño]  = e

      insertarEnOrden(C.indices[0], C, e[0], 0, C.tamaño)
      insertarEnOrden(C.indices[1], C, e[1], 1, C.tamaño)
      insertarEnOrden(C.indices[2], C, e[2], 2, C.tamaño)

      C.tamaño = C.tamaño + 1
      ```
    
    + proc insertarEnOrden(
      + inout lista: ListaEnlazada#T[int], 
      + in C: ConjuntoIndicado,
      + in valor: int, 
      + in orden: int,
      + in puntero: int
      + ):
      + #cmnt "lista" es la lista de punteros ordenados por la componente que representa el orden
      + #cmnt "valor" es el valor de la componente, sirve para ordenar
      + #cmnt "orden" el índice de la componente sobre la que vamos a ordenar
      + #cmnt "puntero" la posición en `C.datos` dónde se encuentra la tupla que queremos agregar
      + ```java
        principio = lista.cabeza
        actual = principio
        siguiente = actual.siguiente
        
        while C.datos[actual.val] < valor:
          actual = siguiente
          siguiente = actual.siguiente
        
        // ahora, actual.val >= value
        nuevo_nodo = new NodoLista<int>()
        nuevo_nodo.val = value
        // inserto el nuedo antes del actual
        nuevo_nodo.anterior = actual.anterior
        actual.anterior.siguiente = nuevo_nodo
        nuevo_nodo.siguiente = actual
        actual.anterior = nuevo_nodo
        return
      ```
    + }
  + }
]

=== Ejercicio 5
#pseudocode-list()[
  + modulo BufferCircular#T[T] implementa Cola#T[T]{
    + var data: Array#T[T]
    + var cabeza: int
    + var cola: int 
    + pred InvRep(B: BufferCircular#T[T]){
        + $"B.data.length" > 0 and$
        + $ 0 <= "B.cola" <= "B.data.length" and$
        + $ 0 <= "B.cabeza" <= "B.data.length" and$
    + }
    + pred Abs(B: BufferCircular#T[T], C: Cola#T[T]){
      + $B".data.length" = |C.s| and$
      + $(B."cabeza" - B."cola") mod B".data.length" = |C.s|$
      + $(forall e: T)(0 <= n <|C.s| ->_L ($
        + $C.s[n] = B."data"[(n + B."cabeza") mod B."data.length"]$
      + $)$
    + }
    + proc encolar(inout B: BufferCircular#T[T], in e: $T$):
      ```java
        nueva_cabeza = (B.cabeza + 1) mod B.data.length
        B.data[nueva_cabeza] = e
      ```
    + proc desencolar(inout B:BufferCircular):
      ```java
        res = B.data[B.cola]
        nueva_cola = (B.cola + 1) mod B.data.length
        B.data[nueva_cola] = null
        return res
      ```
  + }
]

=== Ejercicio 6
#text(fill:blue)[Hacer las de lista enlazada cuando repase este temar]
#pseudocode-list(line-numbering: none)[
  + modulo PilaArr#T[T] implementa Pila{
    + var datos: Array#T[T]
    + var tamaño: int
    + pred InvRep(p: PilaArr#T[T]){
      + $0 <= p."tamaño" <= p."datos.length"$
    + }
    + pred Abs(p: PilaArr#T[T], p': Pila#T[T]){
      + $p."tamaño" = |p'.s| and$
      + $|p'.s| <= p."datos.length" and$
      + $(forall n: NN)(0 <= n <|p'.s| ->_L (p."datos"[n] = p'.s[n]))$
    + }
    + proc pilaVacía(in capacidad: int)
      ```java
      res.datos = new Array<T>(capacidad)
      res.tamaño = 0
      return res
      ```
    + proc vacía(in p: PilaArr#[T]):
      ```java
      return res.tamaño == 0
      ```
    + proc apilar(inout p: PilaArr#[T], in e: T):
      + #req { $p."tamaño" < p."datos.length"$ }
      + ```java
      p.datos[p.tamaño] = e
      p.tamaño = p.tamaño + 1
      ```
    + proc desapilar(inout p: PilaArr#[T], in e:T):
      ```java
      res = p.datos[p.tamaño-1]
      p.datos[p.tamaño-1] = null
      p.tamaño = p.datamño - 1
      return res
      ```
    + proc tope(in p: PilaArr#[T]):
      ```java
      return p.data[p.tamaño - 1]
      ```
  + }
]

#pseudocode-list()[
  + modulo Diccionario#T[K,V] 
]
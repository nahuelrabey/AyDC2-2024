#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let eqq = $equiv$
#let T(body) = [$angle.l #body angle.r$]

#import "@preview/codly:1.0.0": *
#codly(zebra-fill: none)
#codly(display-icon: false)
#codly(display-name: false)
#codly(stroke: none)
#show: codly-init.with()

== Algoritmos de Ordenamiento

#pseudo[
  + proc ordenar(inout a: seq#T[$T_<$]){
    + requiere {$a=a_0$}
    + asegura  {$"permutacion"(a,a_0) and "ordenado"(a)$}
  + }
  + pred ordenado(s: seq#T[$T_<$]){
    + $(forall k,j:ZZ)(0<=k<j<|s| -> s[k]<s[j])$
  + }
  + pred permutacion(x: seq#T[T], y: seq#T[T]){
    + $(forall e)("apariciones"(e,x) = "apariciones"(e,y))$ 
  + }
]

=== Selection Sort
```java
selectionSort(s){
  i = 0
  while i<|s|-1:
    min = seleccionarMin(s,i)
    swap(s,i,min)
    i++
}
```
Atención! En la línea 3 hacemos $|s|-1$ porque necesitamos reservar un lugar siempre para ejecutar _seleccionarMin(s,i)_

```java
seleccionarMin(s,i){
  min = i 
  j = i + 1
  while j < |s|:
    if (s[j] < s[min]):
      min = j
    j++
}
```
Si no huberamos hecho el primer ciclo $|s|-1$, entonces no podríamos ejecutar seleccionarMin(s,i) en la última iteración, pues nos quedaría $j=|s|$, lo cual indefine $s[j]$.

```java
swap(s, a, b){
  tmp = s[a] 
  s[a]=s[b]
  s[b]=tmp
}
```
La función _swap_ es trivial, la implementé de gede.

==== Invariante
+ Los elementos entre la posición 0 y la $i-1$ se encuentran ordenadaos.
+ Los elementos entre la posición 0 y la $i-1$ son los $i$ elementos más pequeños del arreglo original.
+ En todo momento, el arreglo que tenemos es una permutación del original.

El tercer punto implica que los elementos entre $i$ y $|s|-1$ son $|s|-1-i$ elementos mayores del arreglo original. En criollo, son más grandes que cualquier elemento que esté entre $0$ e $i$

Que paja armar un invariante formal de esto jaja.

==== Costo
$
  sum_(i = 0)^(n-2)(n-i-1) = sum_(i=0)^(n-1)i = (n(n-2))/2
$

=== Insertion Sort
```java
insertionSort(s){
  i = 1
  while i < |s|:
    insert(s,i)
    i++
}
```

```java
insert(){
  j = i-1
  x = s[i]
  while j>=0 && s[j]>x:
    s[j+1]=s[j]
    j--
  s[j+1]=x
}
```

==== ¿Invariante?
+ Entre la posición 0 e $i$ está ordenada
+ Entre la posición 0 y $j+1$ está ordenada. Además, entre $j+2 e i+1$ son todos $> x$.
+ Entre $i+1$ y $|s|-1$ es narnia. ??

=== Costo

$
  sum_(i=1)^(n-1) (i-1)=((n-1)(n-2))/2
$
*_Obs 1_*: Si el arreglo está parcialmente ordenado, "las cosas mejoran" (QUE URA SIGNIFICA ESTO, ¿¡QUE MEJORA¡? ¿$Theta,O,Omega$? I hate this so much).

== Estabilidad
Un algoritmo es estable si mantiene el orden de las claves entre elementos de igual valor... this is unteresting. ¿Porqué importa?

Ejemplo
$
  vec((2,1),(3,4),(1,1),(1,2)) -> vec((1,1),(1,2),(2,1),(3,1))
$

Y uno inestable
$
  vec((2,1),(3,4),(1,1),(1,2)) -> vec((1,2),(1,1),(2,1),(3,1))
$

== Merge Sort
No hay un código "copiable" en las diapos de la materia, mepa que lo voy a investigar bien mañana.
== QuickSort
```java
QuickSort(A,l,r){
  if l < r:
    p = partition(A,l,r)
    QuickSort(A,l,p-1)
    QuickSort(A,p+1,r)
}
```

```java
partition(A,l,r){
  i = l - 1
  j = l
  for j < r-1:
    if A[j] < A[r]:
      i = i+1
      swap(A,i,j)
    j = j+1
  swap(A,i+1,r)
  return i + 1
}
```

Es un chino barbaro este algoritmo, creo que lo único que vale realmente la pena entender del mismo es esto:

==== Costo
- Mejor caso: $O(log(n))$
- Caso promedio : $O(log(n))$
- Peor caso : $O(n^2)$

== Rnadomized QuickSort
Bueno, se fuerza que lo que busquemos ordenar esté dentro del promedio. En criollo, o en el contexto este del QuickSort, agarramos un "pivot" aleatorio. Posta no entiendo nada de esto, y me da una japa total.

== Bucket Sort

Supone que los elementos se pueden ordenar en $M$ categorías ordenadas. O sea, tengo la categoría $A$ y la categoría $B$, y se relación tal que $A<B$ en todos sus elementos. Un ejemplo de esto son los números, los de que tienen tres cifras su centena es 9, son mayores que las de centena 8. Entonces si ordeno las de 8 y luego las de 9, y las concateno, después las puedo juntar.

¿Cómo funca esto? 
+ Construyo un arreglo con M elementos (la cantidad de categorías ordenadas). 
+ En cada elemento creo una lista enlazada, dónde inserto los elementos de cada categoría. 
+ Ordeno cada lista enlazada por separado. Fin.


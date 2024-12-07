#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let eqq = $equiv$
#let qvq = text(fill: blue)[QVQ]
#let qvq_n(n) = text(fill: blue)[$"QVQ"_(#n)$]
#let lqv = text(fill: blue)[#h(.5em) L$Q^2$V]
#let lqv_n(n) = text(fill: blue)[#h(.5em) $L Q^2V_(#n)$]
#let vale = text(fill: blue)[Vale y es Trivial]

=== E1 TADs y especificación de problemas [35pts]

Se quiere modelar una biblioteca en la cual los libros se organizan en estantes. Cada estante puede alojar una cierta cantidad de libros. Al abrir la biblioteca, se indica la cantidad de estantes que tiene y cuantos libros puede alojar en cada uno (cada estante puede alojar una cantidad diferente de libros). A partir de ese momento no pueden agregarse ni eliminarse estantes.

Los libros se identifican por un código (ISBN) que es único. Cuando ingresa un libro a la biblioteca, se indica en qué estante se va a guardar, y el libro se hubica en la primera posición libre de dicho estante. Cuando se retira un libro se indica el número del estante y la posición. En dicho estante, todos los libros a la derecha del que se retiró se corren a la izquierda para tapar la posición que queda libre.

Se desea conocer, para una determinada posición de un estante particular, qué libro se encuentra guardado en esa posición.

#set table(rows: 15pt)
#set box(stroke: 1pt + black, width: 50pt, height: 15pt, inset: 3pt)
#let lista(values) = for n in values [#box[#n]]
Ejemplo:\
_Estado inicial_\
estante 0: #lista((111,2864,6946,none,none,none))\
estante 2: #lista((none,none,none))\
estante 3: #lista((12423,23453,12,5407,none))

_Agrego el libro 975 al 0_\
estante 0: #lista((111,2864,6946,975,none,none))\
estante 2: #lista((none,none,none))\
estante 3: #lista((12423,23453,12,5407,none))

_Saco libro 1 posición 2_\
estante 0: #lista((111,2864,6946,975,none,none))\
estante 2: #lista((none,none,none))\
estante 3: #lista((12423,12,5407,none))


#let struct(body) = [$angle.l #body angle.r$]
#let seq(body) = [$angle.l #body angle.r$]
#set enum(numbering: "a)")
+ Indique las operaciones (procs) del TAD con todos sus parámetros

  #set enum(numbering: "1.")
  + nuevaBiblioteca(in cap_estantes: #seq[$NN$])
  + guardar(in estanteId: $NN$, in libro: ISBN)
  + retirar(in estanteId: $NN$, in posición: $NN$): ISBN
  + buscar(in estanteId: $NN$, in posición: $NN$): ISBN

+ Describa el TAD en forma completa, indicando sus observadores, los requiere y asegura de las operaciones. Puede agregar los predicados y funciones auxiliares que necesite, con su correspondiente definición.

#pseudo[
  + posiciónLibro = $NN$
  + Estante = $NN$
  + ISBN = $NN$
  + Estantería = seq\<Estante>
  + TAD Biblioteca{
    + obs estanterías: seq\<Estantentería>
    + obs tamaños: seq\<$NN$>
    + proc nuevaBiblioteca(in tamaños: seq\<$NN$>): Biblioteca{
      + asegura{
        + $"res.tamaños" = "tamaños" and$
        + $|"res.estanterías"| = |"tamaños"| and$
        + $(forall i: $ZZ$)(0 <= i < |"tamaños"| ->_L "res.estanterías[i]"=<>)$
      + }
    + }
    + proc agregar(inout B: Biblioteca, in E: Estante, in L: ISBN):
      + requiere {$B = B_0$}
      + requiere {$0<=E<|B_0."estanterías"|$}
      + requiere {$|B_0."estanterías"[E]| < B_0."tamaños"[E]$}
      + asegura{$B."estanterías"[E] = B_0."estanterías"[E] + <L> and$}
      + asegura{IgualesMenosUno($B."estanterías"$, $B_0."estanterías"$, E)}
    + proc quitar(inout B: Biblioteca)
  + }
]

=== Precondición más débil [20pts]
Dado el siguiente condicional determinar la Precondición más débil que permite hacer valer la poscondición ($Q$) propuesta
```java
if (a mod 3 = 0)
    a := abs(a) + 1
else:
    a := abs(a) * 3
```
$Q equiv (exists j: ZZ)(j>=0 and j dot 3 = a)$
+ Escriba la WP esperada y justifique brevemente en castellano
+ Derivarla a partir de los axiomas de precondición más débil. Para obtener el puntaje máximo deberá simplificarla lo más posible.

=== Correctitud del Ciclo [35 pts]
Dado el siguiente programa con su especificación

$P_c equiv {n > 0 and "res" = 0 and i = 0 and j = 1}$
```java
while (i < n)
    res := res + j
    j := j*2
    i := i+1
```
$Q_c equiv {"res" = sum_(k = 0)^(n-1)(2^k)}$

Contamos con el siguiente invariante, que sabemos es incorrecto:\
$I equiv {0<=i<=n and j = 2^(2i) and "res" = sum_(k=1)^(i)2k}$
+ Indique para cada axioma del teorema del invariante si se cumple o no. Si es verdadero demuestrelo fromalmente. Si es falso de un contraejemplo.

  #qvq $P_c => I$
  $
    {i = 0 and j = 1 and "res"=0} => {0<=i<=n and j = 2^(2i) and "res" = sum_(k=1)^(i)2k} #lqv
  $

  #qvq $I and not B => Q_c$
  $
  I and not B &eqq {i = n and j = 2^(2i) and "res" = sum_(k=1)^(i)2k} \
    &=> {"res" = sum_(k=1)^(n)2^k}\
    &arrow.double.not {"res" = sum_(k=1)^(n-1)2^k}
  $
  No vale, contrajemenplo. $n = 3$, entonces $I and not B => "res" = sum_(k=1)^(3)2^k = 2+4+8 != 2+4 = sum_(k=1)^(3-1)2^k$

  #qvq ${I and B}$ S ${I}$
  #let wp_1 = [wp(`i := i+1`, I)]
  #let wp_2 = [wp(`j := j*2`, $"wp"_1$)]
  #let wp_3 = [wp(`res := res + j`, $"wp"_2$)]
  $
    I and B eqq {0<=i<=n-1 and ...}
  $
  Investigamos la precondición más débil
  $
    #wp_1 &eqq {0<=i<=n and j = 2^(2i) and "res" = sum_(k=1)^(i)2^k}\
    "wp"_1 &eqq {-1<=i<=n-1 and j = 2^(2(i+1)) and "res" = sum_(k=1)^(i+1)2^k}\
    #wp_2 &eqq {-1<=i<=n-1 and j dot 2 = 2^(2i+21)) and "res" = sum_(k=1)^(i+1)2^k}\
    "wp"_2 &eqq {-1<=i<=n-1 and j = 2^(2i+2-1) and "res" = sum_(k=1)^(i+1)2^k}\
        &eqq {-1<=i<=n-1 and j = 2^(2i+1) and "res" = sum_(k=1)^(i+1)2^k}\
    #wp_3 &eqq {-1<=i<=n-1 and j = 2^(2i+1) and "res" + j = sum_(k=1)^(i+1)2^k}\
    "WP" &eqq {-1<=i<=n-1 and j = 2^(2i+1) and "res" + 2^(2i+1) = sum_(k=1)^(i+1)2^k}\
  $
  Claramento $I and B arrow.double.not "WP"$ .
  $
    I and B equiv {0<=i<=n-1 and j = 2^(2i) and "res" = sum_(k=1)^(i)2^k}
  $
  Contraejemplo: si $i = 4$
  $
    {j = 2^9 != 2^8 and "res" = 2+4+8+16 != 2+4+8+16-2^(9)}
  $

+ Escriba un invariante que resulte correcto, indicando las partes que cambió. No es necesario demostrar formalmente su correctitud.
    $
    I eqq {0<=i<=n and j = 2^i and "res"=sum_(k=0)^(i-1)2^k}
    $

    Cambié el valor de j, de esta forma en la demo de la tripla de Hoare, me quedará $"res"+2^n = sum_(k=0)^(n)2^k => "res"=sum_(k=0)^(n-1)2^k$.

    Además, restringe el límite superior de la suma, para que siempre se mantuviera en el rango $0<=i<n$, en el que se ejecuta el cuerpo del ciclo.

    Finalmente, el primer elemento que debe estar en la suma es el 1, luego la suma debe empezar desde $k=0$.
+ Decida si las siguientes funciones variantes son válidas o no, y explique porqué.
    #set enum(numbering: "I.")
    + $f_v = n$
    + $f_v = n-i$
    + $f_v = n-1-i$

    $n = 4 => "res" = 1+2+4+8 = 15$
    #table(
        columns: 7,
        [iteracion],[i],[j],[res],[$f_v=n$],[$f_v=n-i$],[$f_v = n-1-i$],
        [0],[0],[1],[0],[4],[4],[3],
        [1],[1],[2],[1],[4],[3],[2],
        [2],[2],[4],[3],[4],[2],[1],
        [3],[3],[8],[7],[4],[1],[0],
        [4],[4],[16],[15],[4],[0],[-1],
    )

    Elijo $f_v=n-i$

    #qvq ${I and B and f_v=v_0}$S${f_v < v_0}$
    #let wp_1 = [wp(`i := i+1`, $n-i < v_0$)]
    #let wp_2 = [wp(`j := j*2`, $"wp"_1$)]
    #let wp_3 = [wp(`res := res + j`, $"wp"_2$)]

    $
    #wp_1 &eqq {n-i-1<v_0}\
    #wp_2 &eqq {n-i-1<v_0}\
    #wp_3 &eqq {n-i-1<v_0}\
    "WP" &eqq {n-i-1<v_0}\
    $

    Por lo tanto #qvq ${I and B and f_v = v_0} => "WP"$
    $
    {n-i = v_0} => {n-i-1<v_0} &eqq {n-i-1<n-i}\
        &eqq{-1<0}\
        &eqq T #lqv
    $

    #qvq $I and not B => {f_v <= 0}$
    $
    {i = n and ...} => {n-i = 0} => {f_v = 0} => {f_v <= 0} #lqv
    $
    

=== Conceptuales [10pts]

PIPO
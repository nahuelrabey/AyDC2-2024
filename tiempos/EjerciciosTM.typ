#import "@preview/lovelace:0.3.0": *

==== Algunos $"Big" O$ ordenados por complejidad
+ O(log(log(n)))
+ O(log(n))
+ O(n)
+ O(n*log(n))
+ O(n^2)
+ O(2^n)
+ O(n!)
+ O((n!)^2)
+ O((2n)!)

=== Búsqueda lineal
#pseudocode-list[
+ *function* _busquedaLineal_(A: Int[], e: Int)
  + n = Long(A)
  + *for* i = 0..n *do*
    + *if* A[i] = e *then* 
      + *return* true
  + *return* false
]
En el mejor de los casos asignamos una vez, entramos al loop una vez, chequeamos una vez y retornamos una vez
$
f_("mejor") = Theta(1)+Theta(1)+Theta(1)+Theta(1) = Theta(max{1,1,1,1}) = Theta(1)
$
En el peor de los casos, tengo que recorrer toodo el loop
$
f_("peor") &= Theta(1) + sum_(i=0)^(i<n)(Theta(1)) + Theta(1) \
f_("peor") &= Theta(1) + Theta(n) + Theta(1)\
f_("peor") &= Theta(n)\
$

=== Demostrar que
1. $n^2+5n+3 in Omega(n)$
Facilon\
$(forall n in NN)(n^2+5n+3 >= n) => n^2+5n+3 in Omega(n)$

2. $n^2+5n+3 in 0=(n)$
También, re trivial\
$(forall n in NN)(n^2+5n+3 >= n) => (exists.not n in NN)(n^2+5n+3 < n) => f in.not O(n)$

Juguemos con la propiedad de límites

$
l &=  lim_(n->infinity)(n^2+5n+3)/(n)\
  &=  lim_(n->infinity)(n+5+3/n)\
  &=  infinity\
$

De esto podemos afirmar que $f in Omega(n)$ y $f in.not O(n)$

=== Encontrar la peor y la mejor ejecución

*1.* Se tiene una matriz $A$, de $n times n$ números naturales, de manera que
$A[i, j]$ representa al elemento en la fila $i$ y columna $j$ ($1 <= i, j <= n$). Se sabe que el acceso a un elemento cualquiera se realiza en tiempo $O(1)$, así como la obtención de la dimensión de la matriz (función `Long`). Una matriz en degradé es una en la que todos los elementos de la matriz son distintos y que todas las filas y columnas de la matriz están ordenadas de forma creciente (es decir, $i < n => A[i, j] < A[i + 1, j]$ y $j < n => A[i, j] < A[i, j + 1]$), como se aprecia en los ejemplos $A_1$ y $A_2$ de más abajo.

#pseudocode-list[
+ *function* valorEnMatriz(Matriz de naturales A, Natural val)
  + n = Long(A)
  + i = 0

  + *while* $i < n$ and $A[0, i] <= "val"$ *do*
    + i = i + 1
  + colLim = i - 1

  + i = 0
  + *while* $i < n$ and $A[i, 0] <= "val"$ *do*
    + i = i + 1

  + filLim = i - 1

  + *for* i = 0 to filLim *do*
    + *for* j = 0 to colLim *do*
      + *if* A[i, j] = val *then*
        + *return* true

  + *return* false
]

Encontrar el mejor caso, y el peor caso.

En el mejor de los casos el número que quiero está en la primer celda de la matriz. Ergo, es $Theta(1)$
En el peor de los casos debo recorrer dos listas de $n$ elementos. Luego, tendría que
$
  f_("peor") &= sum_(i=0)^(i<n)(Theta(1)) + sum_(i=0)^(i<n)(Theta(1)) + sum_(i=0)^(i<n)(sum_(i=0)^(i<n)(Theta(1)))\
    &= 2Theta(n) + Theta(n^2)\
    &= Theta(n^2)
$

#pagebreak()
*2.*
#pseudocode-list[
+ function busquedaBinaria(Arreglo de Enteros A, Natural e)
  + n = Long(A)
  + i = 0
  + j = n - 1
  + while i ≠ j do
    + m = (i + j) / 2
    + if A[m] > e then
      + j = m - 1
    + else
      + i = m
  + devolver A[i] == e
]

Notemos que el peor de los casos ocurre cuando $i=j$, veamos un caso "elemental" de esto, a ver a dónde llegamos

$
i = j &<=> 0 = n - 1\
  &<=> n = 1
$

La única matriz que cumple esto es $n = 1$, es decir, $A=[[k]]$.
Bueno, si $n = 1 -> f in Theta(1)$, que además es $Theta(n)$, para este caso particular. Sigan viendo

Supongamos un caso dónde esto no se cumpla, o sea, veamos $forall n in NN$

#table(
  columns: 4,
  stroke: stroke(.5pt + gray),
  [],[m],[i],[j],
  [0°],[$(i+j)/2$],[0],[n-1],
  [1°],[$(n-1)/2$],[$ 0 | (n-1)/2$],[$(n-3)/2 | n-1$],
  [2°],[$(n-3)/4|((n-1)+(n-3))/4=(2n-4)/4=(n-2)/2 | n-1 | $],[...],[...]
)
Bueno, me imagino que esto me diría algo, pero creo que un mejor razonamiento es este:

En la primer iteración, me va a quedar la mitad de la lista por revisar $(|A|)/2$. En la segunda $(|A|)/2^2$. En la tercera $(|A|)/2^2$ ... Bueno, así hasta que me al llegar al final (cuando queda un elemento), tengo $(|A|)/2^k$. Cómo debe quedarme un elemento, puedo pensar la siguiente ecuación.

$
(|A|)/2^k &= 1\
|A| &= 2^k\
log_(2)(|A|) & = k
$

Es decir, en general, para una lista con $n$ elementos, vamos a tener $log(n)$ pasos. Podemos ignorar la base del logaritmo pues es mayor que uno, por propiedad.

Luego, $f in Theta(log(n))$




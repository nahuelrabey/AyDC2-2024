
#import "@preview/lovelace:0.3.0": *

=== Demostrar que
*1.* $f in O(g) => k dot f in O(g)$
Por definición está re chill
$
f in O(g) &<=> (forall n in NN)(f(n) < c g(n))\
$
Veamos que 
$
f(n) &< c g(n)\
k f(n) & < (k dot c) g(n)\
k f(n) & < q g(n)\
$

Luego, está dentro de la definición de, pues
$
k dot f in O(g) <=> (forall n in NN)(k dot f(n)< q g(n))
$
Es bastante trivial

*2.* $O(n^2) sect Omega(1) != Theta(n)$
Veamos, también, por definición
$
f in O(n^2)sect Omega(1) &equiv f in O(n^2) and f in Omega(1)\
  &equiv f(n) <= n^2 and f(n) >= 1\
  &equiv 1 <= f(n) <= n^2
$
Este conjunto tiene mayor cardinalidad que $n<f(n)<n equiv f in Theta(n)$. De hecho, puedo varias funciones que cumplan esto, $f = log(n)n$, $f=n$, $f=log(n)$, etc.

Por contraejemplo, vimos que no. $qed$

=== Justificar verdadero o falso
*1* $2^n = O(1)$ \
Falso, pues $forall n in NN, 2^n > 1$. $qed$

*2* $Omega(n) subset.eq O(n^2)$ FALSO

Veamos que $Omega(n) = {f:NN->RR^+ | forall n in NN,  f(n) >= n}$

A su vez, $O(n^2) = {f:NN->RR^+ | forall n in NN, f(n) <= n^2}$

Luego, $n^3 in Omega(n)$ pero $n^3 in.not O(n^2)$. Por contraejemplo vimos  que $Omega(n) subset.eq.not O(n^2)$
$qed$

*3* $O(n) subset.eq Omega(n)$ FALSO\
Tampoco, y podemos verlo con un contraejemplo

$log(n) in O(n) and log(n) in.not Omega(n)$
=== Demostrar que (la revancha)
Sea $f(n)=n^2+5n+3$, demostrar que $f(n) in Omega(n)$ pero $f(n) in.not O(n)$

Por propiedades, sabemos que 

$
Omega(f) = Omega(max{n^2,5n,3}) = Omega(n^2)
$
Pero, cómo $n^2 > n => Omega(n^2) subset Omega(n)$ Tenemos que $f in Omega(n)$ \
$[w^5]$

Además, tenemos que
$
O(f) = O(max{n^2,5n,3})=O(n^2)
$

Luego, cómo $n^2 > n => n^2 in.not O(n) => O(n^2) subset.not O(n) => f in.not O(n)$. Vale aclarar, que tampoco se intersecan nunca, por definición Big O notation.

=== Analizar el siguiente algoritmo

Precondición $|A|>0$

#pseudocode-list(booktabs: true, title: [*Algorithm* BusquedaSecuencial(A: arreglo(nat), e: nat) $->$ bool])[
+ *var* i: nat, n: nat
+ n = tam(A)
+ i = 0
+ *While* $i<n and A[i]!=e$ *d*
  + i = i + 1
+ *return* (i$<n$)
]
Observaciones importantes del ciclo. Si somos estrictos, vemos que tiene 4 operaciones: 2 comparaciones, una suma y una asignación. Pero lo principal, *se ejecuna n+1 veces*, cómo máximo, esto pues sale del ciclo cuando $i = n+1$, y comienza a ejecutarse cuando $i = 0$. Cómo sabemos, el conjunto ${0..n}$ tiene $n+1$ elementos. De ahí viene perreque 😎

En el mejor de los casos, se encuentra en el primer elemento del ciclo *While*, entonces tenemos $Theta(1)$.

En el peor de los casos, se encuentra en el último elemento del arreglo, y tenemos
$Theta(n)$, dónde $n$ es el tamaño del arreglo

#pseudocode-list(booktabs: true, title: [*Algorithm* HaceAlgo(A: arrgelo(Nat))])[
  + i = 0
  + suma = 1; count = 0
  + *While* $i<= "tam"(A)$ *do*
    + *If* $i!=A[i]$ *do*
      + count = count + 1
    + j = 1
    + *While* $j <= "count" $ *do*
      + k = 1
      + *While* $k<="tam"(A)$ do 
        + suma = suma + k
        + k  = $k dot 2$ 
      + j = j + 1
    + i = i + 1
  + *return* suma
]

Veamos que, entre 9~11 hay un ciclo particular. $k$ va avanzando hasta que sea del tamaño de $A$. Pero, multiplicándose "de dos en dos", siendo más claros, tomando las potencias de 2 menores que $|A|$. Es decir, su valor máximo es

$
  2^k &= |A|\
  log_(2)(2^k) &  = log_(2)(|A|)\
  k &= log_(2)(|A|)
$

Luego, este ciclo, en el peor de los casos, toma un valor de $Theta(log(n))$

Entre las líneas 7~12 podemos tomar que, en el peor de los casos, todos $i<=|A|$ *NO* están en el arreglo. Luego, se ejecuta |A| veces el ciclo. Por lo tanto, tenemos un $Theta(n log(n))$, dado que incluye también el ciclo 9~11.

Finalmente, el ciclo 3~13 se ejecuta $|A|$ veces. Dándonos en suma, con los ciclos interiores, una complejidad de $Theta(n^2 log(n))$ en el peor de los casos.

En el mejor, $|A| = 1$, tenemos $Theta(1)$
#import "@preview/lovelace:0.3.0": *
#let eqq = $equiv$
#let qvq = text(fill: blue)[QVQ]
#let lqv = text(fill: blue)[#h(.5em) L$Q^2$V]

=== Condicionales

```java
if i mod 2 = 0
  s[i] = 2 * s[i]
else 
  s[0] = 3
```
$Q_c = {(forall j: ZZ)(0<=j<|s| ->_L s[j] mod 2 = 0)}$

#set enum(numbering:"a.")
// #set pseudocode-list(line-numbering: none)list
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
+ Describir en palabras la WP esperada:\
  La segunda bifurcación no tiene sentido, porque no se cumpliría le poscondición. Luego, debe ser necesario que en la precondición se cumpla $i mod 2 = 0$.

+ Derivarla usando los axiomas.
  
  Primero busco las WP de cada rama. Voy a presuponer que s está definido para escribir menos, luego aclaro esto al final.
  #pseudo[
  + wp(`S[0] = 3`, $Q_c$) $eqq$\
    + def(s[0]) $and_l (forall j: ZZ)(0<=j<|s| ->_L "setAt"(s,0,3)[j] mod 2 = 0) eqq$
    + $(forall j: ZZ)(0<=j<|s| and j != 0 ->_L s[j] mod 2 = 0) and "setAt"(s,0,3)[0] mod 2 = 0 eqq$
    + $(forall j: ZZ)(0<=j<|s| and j != 0 ->_L s[j] mod 2 = 0) and 3 mod 2 = 0 eqq$
    + $F$
    + ¡Pero esto es absurdo!
    + Luego, la guarda *debe cumplirse siempre*
  + wp(`s[i] = 2 * s[i]`, $Q_c$) $eqq$ 
    + def(s[i]) $and_L (forall j: ZZ)(0<=j<|s| ->_L "setAt"(s,i,s[i]*2)[j] mod 2 = 0)$
    + $(forall j: ZZ)(0<=j<|s| and j != i ->_L s[j] mod 2 = 0) and "setAt"(s,i,s[i]*2)[i] mod 2 = 0 eqq$
    + $(forall j: ZZ)(0<=j<|s| and j != i ->_L s[j] mod 2 = 0) and s[i]*2 mod 2 = 0 eqq$
    + $(forall j: ZZ)(0<=j<|s| and j != i ->_L s[j] mod 2 = 0) and T eqq$
    + $(forall j: ZZ)(0<=j<|s| and j != i ->_L s[j] mod 2 = 0)$
    + Tiene sentido, cuando i mod 2 vale (que igual vale siempre por el absurdo anterior), luego se modifica la lista para que cumpla condición con $j=i$
  ]

  Ahora usamos el absurdo para matar la 2da rama
  #pseudo[
  + $i mod 2 != 0 and$ wp(`S[0] = 3`, $Q_c$) $eqq$\
    + $i mod 2 != 0 and F eqq F$
  ]

  Nos queda la primera
  #pseudo[
  + $i mod 2 = 0 and$ wp(`S[i] = 2*s[i]`, $Q_c$) $eqq$\
    + $i mod 2 = 0 and (forall j: ZZ)(0<=j<|s| and j != i ->_L s[i] mod 2 = 0)$
  ]

  Finalmente
  #pseudo[
    + wp(`S`, $Q_c$) $eqq$
      + $(i mod 2 = 0 and (forall j: ZZ)(0<=j<|s| and j != i ->_L s[i] mod 2 = 0)) or$
        + $i mod 2 != 0 and F eqq$
      + $(i mod 2 = 0 and (forall j: ZZ)(0<=j<|s| and j != i ->_L s[i] mod 2 = 0)) or F eqq$
      + $(i mod 2 = 0 and (forall j: ZZ)(0<=j<|s| and j != i ->_L s[i] mod 2 = 0))$
  ] 

=== Ciclos

$P_c equiv {n > 0 and n mod 2 = 0 and i = 1 and "res" = 1}$
```java
while (i <= n/2){
  res := res * i * (n+1-i);
  i := i + 1
}
```
$Q_c equiv {"res" = n!}$

Invarianten propuesto. Es incorrecto, tenemos que corregirlo
$
I eqq {1 <= i <= n/2 +1 and "res" = product_(k = 1)^(2(i-1))k}
$

Esto ocurre cuando lo ejecutamos con n = 10
```
value of n: 10
   i      res
0  1        1
1  2       10
2  3      180
3  4     4320
4  5   120960
5  6  3628800
3628800
```

Probemos cosas \
#qvq $P_c => I$
$
i = 1 and "res" = 1 => 1<=i<=n/2+1 and "res" product_(k=1)^(2(i-1)) k = 1 
$#lqv

#qvq $I and not B => Q_c$
#pseudo[
  + $not B eqq i >= n/2 + 1$
  + Por lo tanto
  + $
    I and not B &eqq {i = n/2 +1 and "res" = product_(k=1)^(2(i-1))k }\
      &eqq {i = n/2 + 1 and "res" = product_(k=1)^(2(n/2)) k}\
      &eqq {i = n/2 + 1 and "res" = product_(k=1)^(n) k}\
      &=> {"res" = n!}
  $ #lqv
]

#qvq ${I and B}S{I}$
Primero, y lo más, clave, en cada iteración debe cumplirse el invariante. Tenemos una pista, la productoria usada en el invariante es distinta a la productoria usada en el código. Podemos encontrar un caso en el que no se cumpla.

$n = 6$
#table(
  columns: 4,
  table.header(
    [iteracion],[i],[res],[invariante]
  ),
  [0],[1],[1],[],
  [1],[2],[6],[2],
  [2],[3],[#{6*(2*(6+1-2))}],[#{4*3*2}],
  [3],[4],[#{60*(3*(6+1-3))}],[#{6*5*4*3*2}],
)

Se llega al mismo resultado, pero el invariante no es válido para todos los ciclos.

Nueva propuesta de invariante.

#let RES = $product_(k = 1)^(i-1)k(n+1-k)$

$
I eqq {1 <= i <= n/2 and "res" = RES}
$

Mboeno, probemos todo desde 0

#qvq $P_c => I$
$
  {i = 1 and "res" = 1} => {1 <= i <= n/2+1 and "res" = RES}
$
#lqv

#qvq $I and not B => Q_c$
$
  I and not B &eqq {i = n/2+1 and "res" = RES\
    &eqq {i = n/2+1 and "res" = RES}\
$

Uff esta productoria sólo la puedo demostrar usando inducción... que reverga. Pero tengo una demo informal

#let cdots = $dot dot dot$

si no usamos n/2 tenemos
$
"res" = n dot 2(n-1) dot 3(n-2) cdots 3(n-2) dot 2(n-1) dot n
$

Luego, si usamos n/2 esto va "hasta la mitad". Ejemplo n = 6 va hasta 3

$
"res" = 6 dot 2(6-1) dot 3(6-2) = 6 (6 (6-1)  (6-2)) = 6 dot 6 dot 5 dot 4 = 6!
$
 
Se puede hacer más formal, seguramente usando algún tipo de inducción.

$I and not B => {i = n/2 + 1 and "res" = n!}$ #lqv

#qvq ${I and B}$ s ${I}$
#pseudo[
  + Vamos despacio
  + Primmero veamos le precondición
    + $I and B equiv {1 <= i <= n/2 and "res" = ...}$
  + Ahora vemos la wp, de abajo hacia arriba
    + wp(`i := i + 1`, I) $eqq {1 <= i+1 <= n/2 +1 and "res" = RES}$
    + wp(`i := i + 1`, I) $eqq {0 <= i <= n/2 and "res" = RES}$
    + I' $eqq {0 <= i <= n/2 and "res" = RES}$
  + Seguimos con la siguiente línea
    + wp(`res := res * i * (n+1-i)`, I') $eqq {0 <= i <= n/2 and "res" i (n+1-i) = product_(k = 1)^(i)k(n+1-k)}$
    + wp(`res := res * i * (n+1-i)`, I') $eqq {0 <= i <= n/2 and "res" = RES}$
    + WP $eqq {0 <= i <= n/2 and "res" = RES}$
  + Excelente, porque la precondición es una versión más restrictiva que la WP, es decir que si vale la precondición, vale la WP, y el ciclo (si termina) es correcto.
    + $I and B => "WP"$ #lqv
]

Bien perron la cosa. Bueno, ahora tengo que ver lo siguiente, _la función variante_

$n = 6$
#table(
  columns: 5,
  table.header(
    [iteracion],[i],[$f_v = n/2 +1 -i$],[$f_v = n/2 - i$], [res]
  ),
  [0],[1],[3],[2],[1],
  [1],[2],[2],[1],[6],
  [2],[3],[1],[0],[#{6*(2*(6+1-2))}],
  [3],[4],[0],[#text(fill: red)[*-1*]],[#{60*(3*(6+1-3))}]
)

La función (al menos una) que termina cuando llegamos al resultado final, es $f_v = n/2 +1 - i$

#qvq $I and {f_v = 0} => not B$

$
I and {f_v = 0} &eqq {0 <= i <= n/2 + 1 and "res" = ... and n/2 + 1 - i = 0}\
  &eqq {0 <= i <= n/2 + 1 and "res" = ... and n/2 + 1 = i}\
  &eqq {i = n/2 + 1 and "res" = ...}\
  & => {i >= n/2 + 1} eqq not B #lqv
$

#qvq ${I and B and f_v = v_0}$ S ${f_v < v_0}$
#let wp_1 = [wp(`i: i+1`, $n/2+1-i < v_0$) ]
#let wp_2 = [wp(`res: res * i * (n+1-i)`, #wp_1 ]
#let wp_2bis= [wp(`res: res * i * (n+1-i)`, T )]
#let wp_2bb= [wp(`res: res * i * (n+1-i)`, ${n/2-i<v_0}$ )]
#pseudo[
  + Otra vez me hace bailar.
  + Primero estudio la precondción.
    + $I and B and f_v = v_0 eqq {1 <= i <= n/2 and "res" = RES and n/2+1-i = v_0}$
  + Ahora estudiamos cómo va la WP 
    // + #let wp_1 = wp(`i: i+1`, $n/2+1-i < v_0$) $eqq {n/2+1-(i+1)<v_0}$
    + $
    #wp_1 &eqq {n/2-i<v_0}\
      &eqq {n/2 -i < n/2 + 1 - i}\
      &eqq {0 < 1}\
      &eqq T
    $
    + Bueno, puedo seguir subiendo, pero es trivial
    + $
      #wp_2 eqq #wp_2bis
    $
    + Por propiedad
    + $
      #wp_2bis eqq T
    $
    + Luego, no importa que haya en la precondción, si vale, entonces vale Wp, pues
    + $
      {I and B and f_v = v_0} => T
    $
    + Sólo deja de valer si la precondición no se cumple, y nosotro estamos afirmando que se cumple. Luego, vale la tripla de Hoare. #lqv
]

AVER, pruebo cómo dice el pana ernesto


#pseudo[
  + Primero estudio la precondción.
    + $I and B and f_v = v_0 eqq {1 <= i <= n/2 and "res" = RES and n/2+1-i = v_0}$
  + Ahora estudiamos cómo va la WP 
    + $
    #wp_1 &eqq {n/2-i<v_0}\
    $
    + Subo a la siguiente línea
    + $
    #wp_2 eqq \ #wp_2bb
    $
    + Estudio esta equivalencia
    + $
    "WP" eqq #wp_2bb eqq {n/2-i < v_0} 
    $
    + Ok, ahora me interesa que la precondición implique esto
    + $
    {1 <= i <= n/2 and "res" = RES and n/2+1-i = v_0} &=> {n/2 - i= v_0 - 1}\ 
      &=> {n/2 - i < v_0 } eqq "WP" #lqv
    $
]

Eh agora, un melange, a good one, the ones who I like the most. The SCHIZO Melange 👽

#pseudo[
  + Primero estudio la precondción.
    + $I and B and f_v = v_0 eqq {1 <= i <= n/2 and "res" = RES and n/2+1-i = v_0}$
  + Ahora estudiamos cómo va la WP 
    + $
    #wp_1 &eqq {n/2-i<v_0}\
    $
    + Subo a la siguiente línea
    + $
    #wp_2 eqq \ #wp_2bb
    $
    + Estudio esta equivalencia
    + $
    "WP" eqq #wp_2bb eqq {n/2-i < v_0} 
    $
    + Ok, ahora me interesa que la precondición implique esto
    + $
    {f_v = v_0} eqq {n/2+1-i=v_0} => {n/2 - i < n/2+1-i}
    $
    + Buen, ta tudu bem
]

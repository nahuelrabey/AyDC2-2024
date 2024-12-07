#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let eqq = $equiv$
#let qvq = text(fill: blue)[QVQ]
#let qvq_n(n) = text(fill: blue)[$"QVQ"_(#n)$]
#let lqv = text(fill: blue)[#h(.5em) L$Q^2$V]
#let lqv_n(n) = text(fill: blue)[#h(.5em) $L Q^2V_(#n)$]
#let vale = text(fill: blue)[Vale y es Trivial]
=== Correctitud de Ciclo

```
while (i<=n/2){
  res := res * i * (n+1-i);
  i := i+1
}
```

$
P_c   &eqq {n>0 and n mod 2 = 0 and i = 1 and "res" = 1}\
Q_c   &eqq {"res" = n!}\
B     &eqq {i<=n/2}\
not B &eqq {n > n/2}\
$

Invariante, sabemos que es incorrecto
$
I eqq {1<=i<=n/2+1 and "res" = product_(k=1)^(2(i-1)) k}
$

a) Señale los axiomas del Invariante que no se cumplen. Justifique con palabras en forma precisa (osea, dar un contraejemplo).

#qvq $P_c => I$ Vale, es trivial
#qvq $I and not B => Q_c$
$
  I and not B eqq {i = n/2 + 1 and "res" = product_(k=1)^(2(i-1))k} => {"res" = product_(k=1)^(2(n/2+1-1))k =product_(k=1)^(n)k=n!} eqq Q_c
$

Pero esta productoria no vale para cada ciclo. 

n = 6
#let f(i) = { i*(6+1-i)}
#let i1 = {f(1)}
#let i2 = {f(1)*f(2)}
#let i3 = {f(1)*f(2)*f(3)}
#let i4 = {f(1)*f(2)*f(3)*f(4)}
#table(
  columns: 4,
  [interacion],[i],[res],[$product_(k=1)^(2(i-i))k$],
  [0],[1],[1],[1],
  [1],[2],[#i1],[#{1*2}],
  [2],[3],[#i2],[#{1*2*3*4}],
  [3],[4],[#i3],[#{1*2*3*4*5*6}],
)

b) Escriba una invariante que resulte correcto
$
  I eqq {1<=i<=n/2 + 1 and "res" = product_(k=1)^(i-1)k(n+1-k)}
$
n = 6
#table(
  columns: 4,
  [interacion],[i],[res],[$product_(k=1)^(i-i)k(n+1-k)$],
  [0],[1],[1],[1],
  [1],[2],[#i1],[#{1*(6+1-1)}],
  [2],[3],[#i2],[#{6*2*(6+1-2)}],
  [3],[4],[#i3],[#{60*3*(6+1-3)}],
)
God, cuadra perfecto.\
c) Proponga una función variante y demuestre formalmente que es correcta\
n = 6
#table(
  columns: 4,
  [interacion],[i],[$f_v=n/2-i$],[$f_v=n/2+1-i$],
  [0],[1],[#{3-1}],[#{3+1-1}],
  [1],[2],[#{3-2}],[#{3+1-2}],
  [2],[3],[#{3-3}],[#{3+1-3}],
  [3],[4],[#{3-4}],[#{3+1-4}],
)

me quedo con $f_v = n/2+1-i$\
#qvq ${I and B and f_v=v_0} S {f_v < v_0}$
#let wp_1 = [wp(`i:=i+1`,$n/2+1-i<v_0$)]
#let wp_2 = [wp(`res:=res*i*(n+1-i)`,$"wp"_1$)]

$
  #wp_1 &eqq {n/2+1-i-1 < v_0}\
  "wp"_1 &eqq {n/2-i<v_0}\
  #wp_2 &eqq{n/2-i<v_0}\
  "WP" &eqq{n/2-i<v_0}\
$

Nuevamente, #qvq ${I and B and f_v=v_0} => "WP"$
$
  {n/2+1-i=v_0} => {n/2-i<n/2+1-i} eqq {0<1} #lqv
$

Tapperfecto, me da paja demostrar el resto, pero yo soy super anti paja, soy ANTI TODO DALE NENE DALEEEEE

#qvq $I and not B => f_v <= 0$
$
 I and not B eqq {i = n/2+1} => {n/2+1-i = n/2+1-n/2-1 = 0 <= 0} #lqv
$


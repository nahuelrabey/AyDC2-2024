#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let eqq = $equiv$
#let qvq = text(fill: blue)[QVQ]
#let qvq_n(n) = text(fill: blue)[$"QVQ"_(#n)$]
#let lqv = text(fill: blue)[#h(.5em) L$Q^2$V]
#let lqv_n(n) = text(fill: blue)[#h(.5em) $L Q^2V_(#n)$]
#let vale = text(fill: blue)[Vale y es Trivial]
=== Ejercicio 1

_Especificacion_
#pseudo[
  + proc sumar(in s: array<$ZZ$>): $ZZ${
    + requiere ${T}$
    + asegura ${"res" = sum_(k=0)^(|s|-1)s[k]}$
  + }
]

_Implementación_
```java
res := 0
i := 0
while (i < s.size()):
  res := res + s[i]
  i := i + 1
```

$
I eqq {0<=i<=|s| and_L "res" = sum_(k=0)^(i-1)s[k]}
$

a) Escribir la precondición y la poscondición del ciclo:

$P_c eqq {"res" = 0 and i = 0}$\
$Q_c eqq {i >= |s| and_L "res" = sum_(k=0)^(|s|-1)s[k]}$

b) ¿Qué punto falla en la demostración si el primer término del invariante se reemplaza por $0<=i<|s|$

$
I_2 eqq {0<=i<|s| and_L "res" = sum_(k=0)^(i-1)s[k]}
$

#qvq $P_c => I$ Vale, es trivial.\
#qvq $not B and I => Q_c$
$
  not B and I &eqq {i>=|s| and 0<=i<|s| and ...} #h(1em)&\
    &eqq {F and ...}\
    &eqq F &<-"Se rompe cualquier implicancia"
$

Si no se cumple la guarda, y el invariante es válido, todo es falso y no se cumple la implicancia.

c) ¿Qué punto falla en la demostración si el límite superior de la sumatoria $(i-1)$ se reemplaza por $i$.

$
I_3 eqq {0<=i<=|s| and_L "res" = sum_(k=0)^(i)s[k]}
$

#qvq $P_c => I$. Vale, es trivial
#qvq $not B and I => Q_c$
$
  not B and I &eqq {i >= |s| and 0<=i<=|s| and_L ...} #h(1em)&\
    &eqq {i = |s| and_L "res" = sum_(k=0)^(i)s[k]}\
    &=> {i >= |s| and_L "res" = sum_(j=0)^(|s|)s[k]} &<-s[s."length"] = perp\
    &=> {i >= |s| and_L perp}\
    &=> perp
$
Por lo tanto $not B and I arrow.r.double.not Q_c$

#text(fill: orange)[*En realidad no valía la primera jaja*]

d) ¿Qué punto falla en la demostración de corrección si se invierte el orden de las dos instrucciones del cuerpo del ciclo?

```java
res := 0
i := 0
while (i < s.size()):
  i := i + 1
  res := res + s[i]
```

Me la juego a que es la tripla de Hoare. Vamo ahí a verlo.
$
& I eqq {0<=i<=|s| and_L "res" = sum_(k=0)^(i-1)s[k]}\
& P_c eqq {"res" = 0 and i = 0}\
& Q_c eqq {i >= |s| and_L "res" = sum_(k=0)^(|s|-1)s[k]}\
& B eqq {i >= |s|}
$

#qvq ${I and B}$S${I}$
#let wp_1 = [wp(`res:=res+s[i]`, I)]
#let wp_2 = [wp(`i:=i+1`, $"wp"_1$)]
#pseudo[
  + Prmero lo primero
  + $"WP" eqq #wp_2$ y
  + $"wp"_1 eqq #wp_1$
  + Ahora sí, empecemos de abajo hacia arriba
  + $#wp_1 eqq {0<=i<=|s| and_L "res"+s[i] = sum_(k=0)^(i-1)s[k]}$
  + Pero el segundo término se indefine, pues $s[i]=perp <=> i=|s|$. Ojo.
  + $#wp_2 eqq {-1<=i<|s| and_L "res"+s[i+1] = sum_(k=0)^(i)s[k]}$.
  + Sigue estando indefinido $s[i+1] <=> i = |s| - 1$.
  + Bueno, seguir con esta demo no tiene sentido, ya encontré un caso particular dónde se romp etodo.
]

e) Mostrar la corrección parcial del ciclo
#vale $P_c => I$\
#qvq $not B and I => Q_c$
$
  not B and I &eqq {i = |s| and_L "res" = sum_(k=0)^(i-1)s[k]}\
    &=>{"res" = sum_(k=0)^(|s|-1)s[k]} eqq Q_c #lqv
$
#qvq ${I and B}$ s ${I}$
#let wp_1 = [wp(`i:=i+1`, I)]
#let wp_2 = [wp(`res:=res+s[i]`, $"wp"_1$)]
#pseudo[
  + $"WP" eqq #wp_2$
  + $"wp"_1 eqq #wp_1$
  + Desarrollo $"wp"_1$
  + $
    #wp_1 &eqq {0<=i+1<=|s| and_L "res" = sum_(k=0)^(i)s[k]}\
    "wp"_1 &eqq {-1 <= i <=|s|-1 and_L "res" = sum_(k=0)^(i)s[k]}
  $
  + Desarrollo $"WP"$
  + $
    #wp_2 &eqq {-1 <= i <=|s|-1 and_L "res"+s[i] = sum_(k=0)^(i)s[k]}\
    "WP" &eqq {-1 <= i <=|s|-1 and_L "res" = sum_(k=0)^(i-1)s[k]}
  $
  + Pruebo que $I and B => "WP"$.
  + $
    I and B &eqq {0 <= i <= |s|-1 and_L "res" = sum_(k=0)^(i-1)s[k]}\
      &=> {-1 <= i <= |s|-1 and_L} eqq "WP" #lqv
  $
]

#let res(i) = [$sum_(k=0)^(#i -1)s[k]$]

Sea $|s| = 4$
#table(columns: 5, 
[iteración],[i],[res],[$f_v = |s|-i$],[$f_v = |s|-1-i$],
[0],[0],[0],[4],[3],
[1],[1],[#res(1)],[3],[2],
[2],[2],[#res(2)],[2],[1],
[3],[3],[#res(3)],[1],[0],
[4],[4],[#res(4)],[0],[-1]
)

Propongo $f_v = |s|-i$
#let wp_1 = [wp(`i := i+1`, $|s|-i = v_0$)]
#let wp_2 = [wp(`res=res+s[i]`, $"wp"_1$)]

#qvq ${I and B and f_v = v_0}$s{$f_v < v_0$}
#pseudo[
  + $
  "wp"_1 &eqq #wp_1\
    &eqq {|s|-(i+1)<v_0}\
    &eqq {|s|-1-i<v_0}\
  $
  + $
  "WP"  eqq #wp_2 eqq "wp"_1
  $
  + Finalmente, no squeda ver que ${f_v=v_0}=>"WP"$
    + $
      {|s|-i = v_0} &=> {|s|-1-i<|s|-i}\
        &eqq {-1 < 0}\
        &eqq T #lqv
    $
]

#qvq ${I and not B} => {f_v <= 0}$
$
  I and not B &eqq {i = |s|}\
    & => {|s|-i <= 0}\
    &eqq {|s|-|s|<=0}\
    &eqq {0<=0}\
    &eqq T #lqv\
$


#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let eqq = $equiv$
#let qvq = text(fill: blue)[QVQ]
#let qvq_n(n) = text(fill: blue)[$"QVQ"_(#n)$]
#let lqv = text(fill: blue)[#h(.5em) L$Q^2$V]
#let lqv_n(n) = text(fill: blue)[#h(.5em) $L Q^2V_(#n)$]
#let vale = text(fill: blue)[Vale y es Trivial]

=== Correctitud de Ciclos

$P_c eqq {|s| mod 2 = 0}$
```java
i := 0
suma := 0
while(**COMPLETAR**){
  **COMPLETAR**
}
res := suma > 5
```
$Q_c eqq {"res" eqq T <-> sum_(j=0)^(|s|-1)s[j]>0}$

Tenemos un invariante, que sabemos es correcto
$
I eqq {"EnRango"(i) and "suma"=sum_(j=0)^(i-1)s[j]+sum_(k=|s|-i)^(|s|-1)s[k]}
$

a) Escriba el predicado EnRango y complete el código en base al invariante y la especificación.

Bueno, supongamos que hay 4 elementos. Luego $|s| = 4$, y tenemos los siguientes índices: $i in {0,1,2,3}$. Además, tenemos una suma ultra gede, que va hacia el centro, tal que así:\ ${0,1,3-1,3-0}$. Hay que darle átomos viejita.

Propongo el siguiente código, y el siguiente predicado
```java
i := 0
suma := 0
while(i < |s|/2){
  suma := suma + s[i]
  suma := suma + s[|s|-1-i]
  i := i + 1
}
res := suma > 5
```
$
"EnRango(i)" eqq {0 <= i <= (|s|)/2-1}
$

Veamo un ejemplito, a ver si funca
$s = angle.l 1,2,3,4,5,6 angle.r$
#table(
  columns: 3,
  [interacion],[i],[res],
  [0],[0],[0],
  [1],[1],[$s[0]+s[5]$],
  [2],[2],[$s[0]+s[1]+s[4]+s[5]$],
  [3],[3],[$s[0]+s[1]+s[2]+s[3]+s[4]+s[5]$],
)


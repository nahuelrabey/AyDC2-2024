#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#codly(zebra-fill: none)
#codly(display-icon: false)
#codly(display-name: false)
#codly(stroke: none)

=== Apuntes sobre AVL

Factor de Balanceo:
$"fbd"(n) = "altura"(n."der") - "altura"(n."izq")$, dónde n es un nodo

```java
proc insertAvl(inout p: NodoAVL, in x:int):
  if p == null:
    p = new NodoAVL(x)
  if x < p.val:
    insertAvl(p.izq, x)
  if x > p.val:
    insertAvl(p.der, x)
  else error "Ya se encuentra en el arbol"
  rebalance(p)
```

```java
proc rebalancear(inout nodo: NodoAvl):
  actualizarAltura(nodo)

  if (fdb(nodo) < -1) && (fdb(nodo.izq) <= 0):
    // fbd(nodo) <-1 -> altura izq > altura der
    // fbd(nodo.izq) <= 0 -> altura izq.izq >= altura izq.der
    // en criollo, hubo una inserción II
    rotacionDerecha(nodo)
  if (fdb(nodo) > 1) && (fdb(nodo.der) >= 0):
    // hubo una inservión DD
    rotacionIzquierda(nodo)
  
  if (fdb(nodo) < -1) && (fdb(nodo.izq) > 0) :
    // hubo inserción ID
    rotaciónDerechaIzquierda(nodo)

  if (fdb(nodo) > 1) && (fdb(nodo.der) < 0):
    // hubo inserción DI
    rotacionIzquierdaDerecha(nodo)
```
Duda: ¿Porqué en el caso ID y DI no se utiliza $gt.eq.lt$, mientras que en el de II y DD sí?
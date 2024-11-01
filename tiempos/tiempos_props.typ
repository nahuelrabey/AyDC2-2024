=== Resúmen de las propiedades
==== Cota Superior $O$
+ $forall f:NN->RR^+ => f in O(f)$
+ $f in O(g) => O(f) subset.eq O(g)$
+ $O(f)=O(g) <=> f in O(g) and g in O(f)$
+ $f in O(g) and g in O(h) => f in O(h)$
+ $f in O(g) and f in O(h) => f in O(min{g,h})$
+ $O(f+g) = O(max{f,g})$
+ $f_1 in O(g) and f_2 in O(h) => f_1 dot f_2 in O(g dot h)$
+ Regla del Límite
  + $lim_(n->infinity)f(n)/g(n) in RR^+ => f(n) in O(g(n)) and g(n) in O(f(n))$

  + $lim_(n->infinity)f(n)/g(n) = 0 => f(n) in O(g(n)) and g(n) in.not O(f(n))$

  + $lim_(n->infinity)f(n)/g(n) = +infinity => f(n) in.not O(g(n)) and g(n) in O(f(n))$
+ Otra formulación (¿son distintas?)
  
  $lim_(n->infinity)f(n)/g(n)=k$
  + $k!=0 and k<infinity => O(f)=O(g)$
  + $k=0 => f in O(g) and g in.not O(f)$

Observación $7.1 equiv 8.1$ y $7.2 equiv 8.2$, PERO no hay una equivalencia para $7.3$

==== Cota Inferior $Omega$
+ $forall f:NN->RR^+ => f in Omega(f)$
+ $f in Omega(g) => Omega(f) subset Omega(g)$
+ $Omega(f)=Omega(g) <=> f in Omega(g) and g in Omega(f)$
+ $f in Omega(g) and g in Omega(h) => f in Omega(h)$
+ $f in Omega(g) and f in Omega(h) => f in O(max{g,h})$
+ $f_1 in Omega(g) and f_2 in Omega(h) => f_1+f_2 = Omega(f+g)$
+ $f_1 in Omega(g) and f_2 in Omega(h) => f_1 dot f_2 in Omega(g dot h)$
+ Regla del Límite
+ Otra formulación (¿son distintas?)
  $lim_(n->infinity)f(n)/g(n)=k$
  + $k!=0 and k<infinity => Omega(f)=Omega(g)$
  + $k=0 => g in Omega(f) and g in.not O(f) <-$ Siento que esto último está roto


==== Orden exacto $Theta$
+ $forall f:NN->RR^+ => f in Theta(f)$
+ $f in Theta(g) => Theta(f) subset Theta(g)$
+ $Theta(f) = Theta(g) <=> f in Theta(g) and g in Theta(f)$
+ $f in Theta(g) and g in Theta(h) => f in Theta(h)$
+ $f in Theta(g) and f in Theta(h) => f in Theta(max{g,h})$
+ $f_1 in Theta(g) and f_2 in Theta(h) => f_1+f_2 in Theta(max{g,h})$
+ $f_1 in Theta(g) and f_2 in Theta(h) => f_1 dot f_2 in Theta(g dot h)$
+ Regla del límite
  + $lim_(n->infinity)f(n)/g(n) in RR^+ => f(n) in Theta(f(n))$

  + $lim_(n->infinity)f(n)/g(n) = 0 => f(n) in O(g(n)) and g(n) in.not Theta(f(n))$

  + $lim_(n->infinity)f(n)/g(n) = +infinity => f(n) in Omega(g(n)) and g(n) in.not Theta(f(n))$
+ Otra formulación\
  $lim_(n->infinity)f(n)/g(n)=k$
  + $k!=0 and k<infinity => Theta(f)=Theta(g)$
  + $k=0 => Theta(f) != Theta(g) <-$ Siento que esto es poco útil


=== OTRA F\#CKING PROP DE LIMITE
Sean $f,g:NN->RR^+$
$
lim_(n->+infinity)f/g = l in RR^+ union {+infinity}
$
+ $f in Theta(g) <=> 0<l<+infinity$
+ $f in O(g) and f in.not Omega(g) <=> l = 0$
+ $f in Omega(g) and f in.not O(g) <=> l = +infinity$
=== TAREA
Identificar Reflexión, Transición y Simetría.

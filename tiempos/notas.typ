#let numbered_eq(content) = math.equation(
    block: true,
    numbering: "(1)",
    content,
)

== Tiempos de ejecución
(Agregar el principio de invariancia)

- el peor escenario $<-$ utilizado en aplicaciones críticas
- el mejor escenario $<-$ utilizado nunca jaja
- el escenario promedio $<-$ utilizado cuando hay múltiples ejecuciones en distintas instancias

=== El mejor y el peor caso 
Bueno, primero se refier a los algoritmos. El mejor caso de un loop es aquel en el que no se ejecuta, o se ejecuta una sóla vez, o un número constante de veces. O sea, que no dependa del tamaño de la entrada. El peor caso de un loop es en el que se recorre por completo.

La idea es, para cada caso, encontrar una asíntota que nos permita entender el costo de computarla. Puede ser "su menor costo", "su mayor costo", o su complejidad (si el menor y el mayor costo son el mismo). Esto serían las notaciones Big O, $Omega$ y $Theta$, respectivamente

=== Escenario promedio

Para el escenario promedio, en un algoritmo que requieren $n$ elementos, se deben tomar en consideración $n!$ combinaciones posibles.

El mal viaje de esta medición es que, en casos dónde buscamos ordenar una lista, si está parcialmente ordenada no te sirve cómo vara para medir que pasa, pues toma el promedio de las $n!$ combinaciones posibles, y acá no hay ningúna distribución normal, sino que, justamente, puede haber una mayoría de listas parcialmente ordenadas. Bueno, para más data repasar media-mediana-moda y campana de Gauss.

=== Operaciones elementales
- suma
- resta
- multiplicación
- división
- resto
- comparación
- asignación
En general, se considera con un costo unitario a la suma, resta, la multiplicación, división, módulo, comparaciones y asignaciones. Igual esto depende de qué estemos haciendo, el sistema en el que estamos trabajando, el lenguaje, etc, pero en teoría valen 1, y dsp se usa la razón para determinar si hay alguna complejidad oculta

=== Orden de operaciones.

Por el principio de invariancia, sabemos que dos implementaciones de un mismo algoritmos difieren en tiempo de ejecución por una constante $t(n)<= c dot t(n)$. Bajo el mismo concepto, podemos determinar el orden de algoritmo, en relación con una funcion $t:NN->RR^(>=0)$

Por ejemplo, tenemos un algoritmo con $t(n)=24n^2+6n+1/2$. Sabemos que, para un $n_0$ lo suficientemente grande, existe un $n>=n_0$ tal que

$
t(n)&=24n^2+6n+1/2 \
&<=24n^2+6n^2+1/2n^2\
&<=61/2n^2
$

luego, nuestro algoritmo pertenece al orden de $n^2$, por el principio de invariancia, pues $24n^2+6n+1/2 <= c dot n^2$, en particular $c=61/2$, pero este número puede cambiar si elegimos un $n_0$ distinto.

=== Big $O(f(n))$
(clarificar la _treshhold rule_ ??)

Decimos que Big $O(f(n))$ es el conjunto de todas las funciones que cumplen $t:NN->RR^(>=0)|t(n)<=c dot t(n)$ para cualquier implementación del algoritmo.

$
O(f(n))={
  t:NN->RR^(>=0)|
  (exists c in RR^+)(forall^(oo) " " n in NN)[t(n)<=c dot t(n)]
}
$

Notemos que, además de esto, cómo $O(f(n))$ es el análisis asintótico de una función $NN->RR^+$, podemos agregar un umbral, un 'límite' a partir del cual una función sea mayor que otra, y por lo tanto, también pertenezca a $O(f(n))$. Por ejemplo

$n^3-3n^2-n-8 in O(n^3)$, aunque si $n<=3 => t(n)<0$. La notación $(forall^(oo) n in NN)$ hace referencia justamente a esto. Traduciendo a una lógica proposicional, nos quedaría así:

$
O(f(n))={
  t:NN->RR^(>=0)|
  (exists c in RR^+)(exists n_0 in NN)(forall n > n_0)[t(n)<=c dot t(n)]
}
$

==== Prove that $t(n) in O(t(n))$
Completar, pag 102. Creo que no es muy necesario 🤔

Pero yo lo haría de la siguiente forma (a chequear esto eh, que me lo estoy inventando)
+ Probar la existencia de un $n_0$ tal que $t(n)>0$. Este $n_0$ es nuestro candidato
+ Luego, ver qué función elemental mínima cumple que $t(n)<f(n), forall n > n_0$.

En este último paso, podemos reafirmar nuestro $n_0$ candidato, o encontrar otro distinto.

==== Maximum Rule
Sean $f,g:NN->RR^(>=0)$, entonces $O(f(n)+g(n)) = max{f(n),g(n)}$.

Además, sean $p,q:NN->RR^(>=0) | p(n)=f(n)+g(n) and q(n)=max{f(n),g(n)}$. Entonces, si $t(n) in O(p(n)) => t(n) in O(q(n))$

Ejemplos

#numbered_eq({
$
O(n^3+n^2+n) &= O(n^3)\
$
})
#numbered_eq({
$
O(n^2-n^2+n) &!= O(n^2)\
$
})
#numbered_eq({
  $
  O(n^3log(n) + n^3 - n^2 + 3) &= O(max{n^3log(n),(n^3-n^2), 3})\
  &=O(n^3log(n))
  $
})

Notemos que (2) no funca, porque no cumple la definición de la regla máxima, pues $f(n)=-n^2 in.not f:NN->RR^(>=0)$

En (3) vemos un "workaround" para trabajar esta situación, de forma tal que podamos agrupar todas nuestras funciones en algo de la forma $f:NN->RR^(>=0)$

#numbered_eq({
  $
  O(t(n)) &= O(11n^3log(n)+n^3log(n)-5n^2+log^2(n)+36)\
    &= O(max{11n^3log(n),n^3log(n)-5n^2,log^2(n)+36})\
    &= O(n^3log(n))
  $
})

==== Sobre los logaritmos en la notación asintótica
No nos interesa su base, pues
$
log_(a)(n)=log_(a)(b) times log_(b)(n), forall a,b,n > 0 and a,b!=1
$
Además, cómo
$
log_(a)(b)>0 forall a,b > 1
$
Por lo tanto, sabemos que $log_(a)(n)$ y $log_(b)(n)$ se diferencian sólo por un factor positivo
$
log_(a)(n) = k log_(b)(n), "con " k>0
$

No entendí ni madres, pero la conclusión se parece mucho al principio de invariancia. Luego, no nos importa la base que escojamos 👽.

Esto no vale para $log_(f(n))(n)$, ni para $k^(log(n))$, ni ninguna variante rara. Tampoco para $a,b<1$

==== Reflexividad
Bueno, bastante trivial
- $f(n) in O(f(n))$

Demostrarlo es facilon perreque: $f(n) < k f(n), forall n in NN and forall k > 1$

==== Transitividad
Sean $f,g,h: NN -> RR^+$, si
- $f(n) in O(g(n))$
- $g(n) in O(g(n))$
Entonces $f(n) in O(g(n))$

==== Demostrar que no pertecene
Se hace por contradicción, no lo voy a estudiar de no ser necesario. En el primer capítulo hay un resúmen de cómo hacer estas demos.

==== Limmit Rule
+ $lim_(n->infinity)f(n)/g(n) in RR^+ => f(n) in O(g(n)) and g(n) in O(f(n))$

+ $lim_(n->infinity)f(n)/g(n) = 0 => f(n) in O(g(n)) and g(n) in.not O(f(n))$

+ $lim_(n->infinity)f(n)/g(n) = +infinity => f(n) in.not O(g(n)) and g(n) in O(f(n))$

=== Notación Omega
$
Omega(f(n)) = {t: NN -> RR^(>=0) | (exists d in RR^+)(forall n in NN)[t(n) >= d f(n)]}
$

==== Duality rule 
$
t(n) in O(f(n)) <=> f(n) in Omega(t(n))
$

==== Particularidades

No entendí ni madres, en el libro página 86 explican algo, pero tiene toda la pinta de que se entiende mejor con ejercicios y ejemplos concretos. La idea es que es la cota inferior de una ejecución.

=== Notación Theta

$
Theta(f(n)) = O(f(n)) sect Omega(f(n)) 
$

Es decir 

$
Theta(f(n)) = {t: NN -> RR^(>=0) | (exists d,c in RR^+)(forall n in NN)[d f(n)<= t(n) <= c f(n)]}
$

=== Limit Rule

+ $lim_(n->infinity)f(n)/g(n) in RR^+ => f(n) in Theta(f(n))$

+ $lim_(n->infinity)f(n)/g(n) = 0 => f(n) in O(g(n)) and g(n) in.not Theta(f(n))$

+ $lim_(n->infinity)f(n)/g(n) = +infinity => f(n) in Omega(g(n)) and g(n) in.not Theta(f(n))$
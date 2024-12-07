#import "@preview/lovelace:0.3.0": *
#let pseudo(body) = pseudocode-list(line-numbering:none)[#body]
#let T(body) = [$angle.l #body angle.r$]

== Ejercicio 1

Sean $f,g,h: ZZ -> ZZ$. Indique si las siguientes afirmaciones son verdaderas o falsas. En caso de ser verdaderas, justifique formalmente con las definiciones o propiedades vistas en clase. En caso de ser falsas, dé un contraejemplo.

#set enum(numbering: "a.")
+ Si $f times g in Theta(h) => h in O(g)$
+ $f in O(g) => O(g) sect Omega(f) != emptyset$
+ Si el mejor caso de un algoritmo es $Theta(n)$, el peor no puede ser $Omega(log(n))$

== Ejercicio 2
#pseudo[
  + TAD CitasCientíficas{
    + obs publicaciones: dict#T[Paper, seq#T[Científico]]
    + obs citas: dict#T[Paper, conj#T[Paper]]
    + proc iniciarSistema(): CitasCientíficas
      + asegura{el sistema comienza con ambos diccionarios vacíos}
    + proc registrarPaper(inout cc: CitasCientíficas, in p: Paper, in cs: seq#T[Científicos])
      + 
  + }
]
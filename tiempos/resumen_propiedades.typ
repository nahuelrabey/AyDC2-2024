#import emoji: face
#let asym = sym.suit.diamond
=== Analísis Asintótico - El Resúmen #face.cool
+ $f in asym(g) => asym(f) subset.eq asym(g)$
+ $asym(f) = asym(g) <=> f in asym(g) and g in asym(f)$
+ Regla de la Suma (sum) \
  $
  f_1 in asym(g) and f_2 in asym(h) => asym(f_1+f_2) = cases(
    O(max{g,h}),
    Omega(min{g,h}),
    Theta(max{g,h})
  )
  $
+ Regla de la Suma (sum) --¿distinta?--\
  $
  f_1 in asym(g) and f_2 in asym(h) => asym(f_1+f_2) = asym(max{g,h})
  $
+ Regla del producto
  $
    f_1 in asym(g) and f_2 in asym(h) => f_1 dot f_2 in asym(f_1 dot f_2c)
  $
+ Reflexiva\
  $f in asym(f)$
+ Transitiva\
  $f in asym(g) and g in asym(h) => f in asym(h)$
+ Simétrica\
  $f in Theta(g) <=> g in Theta(f)$

Observación $Theta(f)$ es una relación de equivalencia, pues es _reflexica, transitiva y simétrica_.


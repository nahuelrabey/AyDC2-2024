#import emoji: face
#let asym = sym.suit.diamond
=== Analísis Asintótico - El Resúmen #face.cool
+ Reflexiva\
  $f in asym(f)$
+ $f in asym(g) => asym(f) subset asym(g)$
+ $asym(f) = asym(g) <=> f in asym(g) and g in asym(f)$
+ Transitiva\
  $f in asym(g) and g in asym(h) => f in asym(h)$
+ Regla de la Suma (sum) \
  $
  f_1 in asym(g) and f_2 in asym(h) => asym(f_1+f_2) = cases(
    O(max{g,h}),
    Omega(min{g,h}),
    Theta(max{g,h})
  )
  $
+ Regla del producto
  $
    f_1 in asym(g) and f_2 in asym(h) = 
  $


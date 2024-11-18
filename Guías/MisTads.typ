#import "@preview/lovelace:0.3.0": *
#let spc = $""$
#let cmnt = $triangle.r$
#let la = $<$
#let ra = $>$
#let req = text()[ *_requiere_* ]
#let asg = text()[ *_asegura_* ]

#pseudocode-list(line-numbering: none)[
  + TAD ConjuntoAcotado$<T>${
    + obs elems: conj$<T>$
    + obs capacidad: $ZZ$
    + #spc
    + proc conjuntoVacío(in cap: $ZZ$):
      + #asg { $"res.elems" = {} and "res.capacidad" = "cap"$ }
    + proc pertenece(in e: T, in C: ConjuntoAcotado$<T>$)
      + #req {$"C.elemns" != {} and "C.capacidad" > 0$}
      + #asg {$"res" = "True" <-> e in "C.elems"$}
    + proc agregar(in e: T, inout C: ConjuntoAcotado$<T>$)
      + #req { $(C = C_0)$ }
      + #req { $e in.not C_0."elems"$ }
      + #req { $|C_0."elems"| + 1 <= C_0."capacidad"$ }
      + #asg {$C."elems" = C_0."elems" union {e}$}
      + #asg {$C."capacidad" = C_0."capacidad" + 1$}
      + #req { $|C."elems"| <= C."capacidad"$ }
    + proc sacar(in: e: T, inout C: ConjuntoAcotado$<T>$)
      + #req { $(C=C_0)$ }
      + #req { $(e in C_0."elems")$ }
      + #asg { $C = C_0."elems" - {e}$ }
      + #asg { $C = C_0."capacidad" - 1$ }
    + proc unir(inout $A$: ConjuntoAcotado$<T>$, in $B$: ConjuntoAcotado$<T>$)
      + #req {$A = A_0 and B = B_0$}
      + #req { $|A_0."elems" union B_0."elems"| <= A_0."capacidad"$ }
      + #asg {$A."elems" = A_0."elems" union B_0."elems"$}
      + #asg {$|A."elems"| = |A_0."elems"|+|B_0."elems"| - |A_0."elems" sect B_0."elems"|$}
    + proc restar(inout A: ConjuntoAcotado, in B: ConjuntoAcotado)
      + #req {$A = A_0 and B = B_0$}
      + #asg {$A."elems" = A_0."elems" - B_0."elems"$}
    + proc intersecar(inout A: ConjuntoAcotado, in B: ConjuntoAcotado)
      + #req {$A = A_0 and B = B_0$}
      + #asg {$A = A_0."elems" sect B_0."elems"$}
    + proc agregarRápido()
    + proc tamaño(in c: ConjAcotado$<T>$)
      + #asg {$"res" = |c."elems"|$}
    + proc capacidad()
      + #asg {$"res" = c."capacidad"$}
  + }
]
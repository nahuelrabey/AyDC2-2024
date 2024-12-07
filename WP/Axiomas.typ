=== Axiomas de Weakest Precondition
+ wp(`x = E`, Q) = def(E) $and_L$ Q[x $<-$ E]
+ wp(`S1; S2`, Q) = wp(S1, wp(S2, Q))
+ wp(`if B then S1 else S2 endif`, Q) = def(B) $and_L$ ((B $and$ wp(`S1`, Q)) $or$ ($not$ B $and$ wp(`S2`, Q)))

=== Correctitud de ciclos
+ $P_c => I$
+ ${I and B}$ S ${I}$
+ $I and not B => Q_c$
+ ${I and B and f_v = v_0}$ S ${f_v < v_0}$
+ ${I and f_v <= 0} => not B$
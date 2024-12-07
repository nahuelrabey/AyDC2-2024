```java
i = 0
while (i < s.len && s[i]!=x) do
  i = i + 1
return i < s.len
```
#let eqq = $equiv$
$I eqq  { 0 <= i < |s| and (forall j: ZZ)(0 <= j < i ->_L s[j] != x)}$
$P_c eqq {i = 0}$
$Q_c eqq {(i < |s|) <-> (exists j: ZZ)(0<=j<|s| and_L s[j] = x)}$
$B eqq {i < |s| and s[i] != x}$
$not B eqq {i >= |s| or s[i] == x}$
$f_v = |s| - i$

Demostrar los axiomas, memgo muemio
QvQ $P_c => I$
$
&P_c eqq {i = 0} \
&{i=0}=>{ 0<= i <|s| }
$
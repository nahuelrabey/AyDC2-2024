```
proc russe(A,B):
    arrays X,Y
    X[0] := A
    Y[0] := B
    i := 0

    while X[i]<0 do
        X[i+1] := X[i] / 2
        Y[i+1] := Y[i]+Y[i]
        i = i+1
    
    prod := 0
    while i > 0 do
        if i mod 2 == 1 then
            prod = prod + Y[i]
        fi
        i--
    return prod
```
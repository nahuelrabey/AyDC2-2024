== Select Sort

Busca el elemento más pequeño del arreglo. Luego, lo mueve al primer lugar. Busca el segundo más pequeño, lo mueve al segundo lugar. Así, sucesivamente.

```
proc select(T[1..n])
  for i=1 to n
    // inicio suponiendo que 
    // el "índice mínimo" es i, y el
    // "valor mínimo" es T[i]
    minj = i
    minx = T[i]

    // corrijo si esto no es así
    for j=i+1 to n
      if T[j] < minx
        minj = j
        minx = T[j]
    
    // intercambio los valores
    // cómo minj > i (pues j > i)
    // asigno T[i] a minj, y así 
    // me queda el mayor con el mayor
    T[minj] = T[i]

    // luego, al índice menor (i),
    // le asigno el valor menor (minx)
    T[i] = minx
```

Ejecución con $V=[1,3,4,1,5,9,2,6,5,3]$

+ $T=[1, 3, 4, 1, 5, 9, 2, 6, 5, 3]$
+ $T=[1, 1, 4, 3, 5, 9, 2, 6, 5, 3]$
+ $T=[1, 1, 2, 3, 5, 9, 4, 6, 5, 3]$
+ $T=[1, 1, 2, 3, 5, 9, 4, 6, 5, 3]$
+ $T=[1, 1, 2, 3, 3, 9, 4, 6, 5, 5]$
+ $T=[1, 1, 2, 3, 3, 4, 9, 6, 5, 5]$
+ $T=[1, 1, 2, 3, 3, 4, 5, 6, 9, 5]$
+ $T=[1, 1, 2, 3, 3, 4, 5, 5, 9, 6]$
+ $T=[1, 1, 2, 3, 3, 4, 5, 5, 6, 9]$
+ $T=[1, 1, 2, 3, 3, 4, 5, 5, 6, 9]$

Observación:
La clausula `T[j]<minx` se ejecuta *siempre*. Esto hace que el tiempo de Ejecución sea siempre *cuadrático*
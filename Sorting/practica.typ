== Resumen de Algoritmos de Ordenamiento
+ Insertion Sort
  + $O(n^2)$ En el peor caso.
  + Compara cada elemento con los anteriores, y lo inserta en el lugar correcto.
  + *Es estable.*
+ Selection Sort 
  + $O(n^2)$
  + Busca el mínimo entre la posición i y el final.
  + Buscar cuesta $O(n)$, iterar cuesta $O(n)$, en cada iteración hay una búsqueda $->$ es $O(n^2)$
  + *No es estable*
+ Merge Sort 
  + $O(log(n))$
  + Ordena dos mitades y las fusiona recursivamente.
  + *Es estable*
+ QuickSort
  + $O(n^2)$ - peor caso
  + $O(n log(n))$ - caso promedio
  + Elije un pivote, separa entre menores y mayores a él, vuelve a ejecutar esto en cada parte.
  + *No es estable*
+ HeapSort
  + $O(n log(n))$
  + Arma el Heap en $O(n)$ y va retirando los elementos en $O(n log(n))$. 
  + *No es estable.*
+ 
  
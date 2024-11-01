size = 10000+1
def pigeonhole(T:list):
    # crea "el nido"
    U = [0 for x in range(1,size)]

    # ubica cada elemento de i en el lugar indicado
    for i in range (0, len(T)):
        k = T[i]
        # U[k] debería ser 1
        U[k] = U[k]+1

    i = 0
    for k in range (0, size):
        while U[k]!=0:
            i = i+1
            T[i] = k
            U[k] = U[k]-1
    print(U[0:10]) 
    print(T)
    return T

# Nota, esta bestia sólo funca con listas de 10000 elementos. No recomendable.

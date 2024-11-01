
def russe(A,B):
    X = [0]
    Y = [0]
    i = 0
    X[0] = A
    Y[0] = B
    
    while X[i] > 1:
        X.append(X[i]//2)
        Y.append(Y[i]+Y[i])
        i = i+1
    
    prod = 0
    while i > 0:
        prod = (prod + Y[i]) if X[i] % 2 == 1 else 0
        i = i-1
        
    return prod

print(russe(2,5))
def insert(T: list):
    print(f"Initial T:={T}")
    for i in range(1,len(T)):
        x = T[i]
        j = i - 1
        print(f"i:={i}")

        # print(f"\n\ni:={i}\nx:={x}\nj:={j}")
        while j>=0 and x < T[j]:
            T[j+1] = T[j]
            j = j - 1
            # print(f"\tT[j+1]:={T[j]}\n\tj:={j}")
        T[j+1] = x
        # print(f"T[j+1]:={T[j+1]}\nj:={j}")
        print(f"T:={T}")

insert([6,5,4,3,2,1])


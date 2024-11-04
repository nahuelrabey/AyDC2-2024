def select(T: list):
    for i in range (0,len(T)):
        minj = i
        minx = T[i]
        # print(f"\ni:={i}")
        # print(f"T[i]:={T[i]}")
        # print(f"minj:={minj}")
        # print(f"minx:={minx}")
        for j in range (i+1,len(T)):
            # print(f"\tj:={j}")
            # print(f"\tT[j]:={T[j]}")
            if T[j]<minx:
                minj = j
                minx = T[j]
                # print(f"\tminj:={minj}")
                # print(f"\tminx:={minx}")
        T[minj] = T[i]
        T[i] = minx
        # print(f"T[minj]:={T[minj]}")
        # print(f"T[i]:={T[i]}")
        # print(f"minx:={minx}")
        print(f"{i+1}° - T:={T}")

# select([1,2,3,4,5,6])
# select([4,3,2,1])
select([3,1,4,1,5,9,2,6,5,3])
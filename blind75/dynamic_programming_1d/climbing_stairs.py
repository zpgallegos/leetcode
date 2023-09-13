


def climbStairs(n):
    m = {1: 1, 2: 2}
    def step(n):
        if n in m:
            return m[n]
        else:
            m[n] = step(n - 1) + step(n - 2)
            return m[n]
    return step(n)


    

    

cpdef func(int a, int b):
    return pure_c(a,b)
cdef pure_c(int a, int b):
    return a+b

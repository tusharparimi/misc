def fib(n,x,y):
    if n==0:
        print(0)
    elif n==1:
        print(0)
        print(1)
    else:
        print(x)
        if x+y>=n:
            print(y)
            return n
        return fib(n,y,x+y)
    
if __name__ == '__main__':
    fib(10,0,1)

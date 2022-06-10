
# -------------------------------------------------------------------
# Print below pattern
# *
# **
# ***
# ****
# *****
# -------------------------------------------------------------------


n=5
start=1
while start<=5:
    
    for i in range(0,start):
        print('*',end='')
    print('\n')
    start=start+1
    
    



# -------------------------------------------------------------------
# Print below pattern
# 1
# 12
# 123
# 1234
# 12345
# -------------------------------------------------------------------

n=5
start=1
while start<=n:
    
    for i in range(1,start+1):
        print(i,end='')
    print('\n')
    start=start+1


    
    
    
    
    
# -------------------------------------------------------------------
# Python 
# -------------------------------------------------------------------

#!/bin/python3

import math
import os
import random
import re
import sys



# write your code here
def avg(*argv):
    sum=0
    c=0
    for arg in argv:
        sum=sum+arg
        c=c+1
    return sum/c
    
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')
    
    nums = list(map(int, input().split()))
    res = avg(*nums)
    
    fptr.write('%.2f' % res + '\n')

    fptr.close()

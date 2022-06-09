



# -------------------------------------------------------------------
# 
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

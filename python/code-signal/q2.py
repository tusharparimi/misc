'''Given an array of words and a length l, format the text such that each line has exactly l characters and is fully justified on both the left and the right. Words should be packed in a greedy approach; that is, pack as many words as possible in each line. Add extra spaces when necessary so that each line has exactly l characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right. For the last line of text and lines with one word only, the words should be left justified with no extra space inserted between them.

Example

For
words = ["This", "is", "an", "example", "of", "text", "justification."]
and l = 16, the output should be

solution(words, l) = ["This    is    an",
                               "example  of text",
                               "justification.  "]
Input/Output

[execution time limit] 4 seconds (py3)

[input] array.string words

An array of words. Each word is guaranteed not to exceed l in length.

Guaranteed constraints:
1 ≤ words.length ≤ 150,
0 ≤ words[i].length ≤ l.

[input] integer l

The length that all the lines in the output array should be.

Guaranteed constraints:
1 ≤ l ≤ 60.

[output] array.string

The formatted text as an array containing lines of text, with each line having a length of l.

[Python 3] Syntax Tips

# Prints help message to the console
# Returns a string
def helloWorld(name):
    print("This prints to the console when you Run Tests")
    return "Hello, " + name'''


# words = ["This", "is", "an", "example", "of", "text", "justification."]
# l = 16
#return a list of strings each string having length 'l'
#fit as many words in each string of returned list as possible
#extra spaces should be filled with spaces between words (left and right should be a word)
#each extra space should be equal or the left space must be greater
#last line must be left adjusted and also string with only one word must be left adjusted
 
def solution(words, l):
    
    solution=[]
    temp=[]
    lstring=''
    
    each=eachlength(words) #[4,2,2,7,2,4,...]
    group=grouping(each,l) #[2,5]
    gindex=0
    flag=0
    for i in range(0,len(group)):
        temp=words[gindex:group[i]+1]
        gindex=group[i]+1
        #print(temp)
        tlsw=tlensw(temp)
        #print('tlsw:',tlsw)
        res=formatting(temp,tlsw,l,flag)
        solution.append(res)
    tlsw=tlensw(words[gindex:])
    res=formatting(words[gindex:],tlsw,l,1)
    solution.append(res)
    #print(solution)
    last=[]
    
    
    
    #print('last:',last)
    return solution
                
            
        
            
def eachlength(words):
    each=[]
    for word in words:
        each.append(len(word))
    return each        
    
def grouping(each,l):
    sum=0
    group=[]
    k=0
    for i in range(0,len(each)):
        if(sum+each[i]+k<=l):
            sum=sum+each[i]
            print(sum)
        else:
            group.append(i-1)
            sum=each[i]
            k=0
        k=k+1
    return group
    
def tlensw(selectwords):
    tlsw=0
    for i in range(0,len(selectwords)):
        tlsw=tlsw+len(selectwords[i])
    return tlsw
         
def formatting(selectwords,tlsw,l,flag):
    res=''
    space=[]
    n=0
    r=0
    if(len(selectwords)==1):
        res=selectwords[0]
        for i in range(0,l-tlsw):
            res=res+' '
    elif(flag==1):
        for i in range(0,len(selectwords)):
            if i<len(selectwords)-1:
                res=res+selectwords[i]+' '
            else:
                res=res+selectwords[i]
        for i in range(0,l-tlsw-(len(selectwords)-1)):
            res=res+' '
    else:
        space=[]
        for i in range(0,len(selectwords)-1):
            space.append(1)
        #print("space:",len(space))
        n=(l-tlsw-len(space))//len(space)
        #print('nume:',(l-tlsw-len(space)))
        #print('l:',l)
        #print(tlsw)
        #print("n:",n)
        for i in range(0,len(space)):
            space[i]=space[i]+n
        r=(l-tlsw-len(space))%len(space)
        #print(space)
        #print("r:",r)
        for i in range(0,r):
            space[i]=space[i]+1
        #print(space)
        
        for i in range(0,len(selectwords)):
            res=res+selectwords[i]
            if(i<len(selectwords)-1):
                for j in range(0,space[i]):
                    res=res+" "
            
    
    return res

'''Avoid using built-in functions to solve this challenge. Implement them yourself, since this is what you would be asked to do during a real interview.

Implement a function that takes two strings, s and x, as arguments and finds the first occurrence of the string x in s. The function should return an integer indicating the index in s of the first occurrence of x. If there are no occurrences of x in s, return -1.

Example

For s = "CodefightsIsAwesome" and x = "IA", the output should be
solution(s, x) = -1;
For s = "CodefightsIsAwesome" and x = "IsA", the output should be
solution(s, x) = 10.
Input/Output

[execution time limit] 4 seconds (py3)

[input] string s

A string containing only uppercase or lowercase English letters.

Guaranteed constraints:
1 ≤ s.length ≤ 106.

[input] string x

String, containing only uppercase or lowercase English letters.

Guaranteed constraints:
1 ≤ x.length ≤ 106.

[output] integer

An integer indicating the index of the first occurrence of the string x in s, or -1 if s does not contain x.

[Python 3] Syntax Tips

# Prints help message to the console
# Returns a string
def helloWorld(name):
    print("This prints to the console when you Run Tests")
    return "Hello, " + name'''

def solution(s, x):
    if x not in s:
        return -1
    if(len(s)==len(x) and s==x):
        return 0
    
    for i in range(0,len(s)-len(x)+1):
        #print(i)
        #print(s[i:i+len(x)])
        if(s[i:i+len(x)]==x):
            return i
    
    '''dict={}
    for i in range(0,len(s)-len(x)+1):
        if s[i:i+len(x)] not in dict:
            dict[s[i:i+len(x)]]=i
        
    if x in dict:
        return dict[x]
    return -1'''

#String reversal 
students = ["Hannah", "Peter", "Luke"]
new=[s[len(s)::-1] for s in students ]
print(new)

#Removing nth character from a string
def nth_char(s,n=None):
    if n is None:
        return "no input"
    if(n>=len(s) or n<0):
        return "input not valid"
    if n==len(s)-1:
        return s[0:n]
    return s[0:n]+s[n+1:]
    
print(nth_char("Laadu",3))

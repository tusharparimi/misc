#------------------------------------------------------
# ispalindrome but input as singly linked list
#------------------------------------------------------

def isPalindrome(self, head: Optional[ListNode]) -> bool:
        lst1=[]
        while head.next!=None:
            lst1.append(head.val)
            head=head.next
        lst1.append(head.val)
        print(lst1)
        lst2=[]
        for i in range(0,len(lst1)):
            lst2.append(lst1[len(lst1)-1-i])
        
        for i in range(0,len(lst1)):
            if lst1[i]!=lst2[i]:
                return False 
        return True


#------------------------------------------------------
# ispalindrome for number without changing to string
#------------------------------------------------------

def isPalindrome(self, x: int) -> bool:
        if x<0:
            return False
        q=x
        n=0
        lst1=[]
        lst2=[]
        while q>0:
            r=q%10
            lst1.append(r)
            q=q//10
            n=n+1
        for i in range(0,len(lst1)):
            lst2.append(lst1[len(lst1)-1-i])
        print(lst1)
        print(lst2)
        for i in range(0,len(lst1)):
            if lst1[i]!=lst2[i]:
                return False 
        return True
        
        
        '''if x<0:
            return False
        q=x
        n=0
        while q>0:
            q=q//10
            r=x%10
            n=n+1
        #print(n)
        s=x
        list1=[]
        list2=[]
        for i in range(0,n//2):
            r=x%10
            list1.append(r)
            x=x//10
        #print(x)
        if n%2!=0:
            x=x//10
        #print(x)
        for i in range(0,n//2):
            r=x%10
            list2.append(r)
            x=x//10
            
        for i in range(0,n//2):
            #print(i)
            #print(len(list2)-1-i)
            #print(list2)
            if list1[i]!=list2[len(list2)-1-i]:
                return False
        return True'''

        
      
#------------------------------------------------------
# Reversing linked list
#------------------------------------------------------  
        def reverseList(self, head):
        curr = head 
        prev = None
        while curr :
            tmp = curr.next 
            curr.next = prev
            prev = curr
            curr = tmp
        return prev


        def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        
        if head==None:
            return None
        lst1=[]
        
        while head.next!=None:
            lst1.append(head.val)
            head=head.next
        lst1.append(head.val)
        
        lst2=[]
        for i in range(0,len(lst1)):
            lst2.append(lst1[len(lst1)-1-i])
        
        res=[]
        
        tail=ListNode(lst2[0])
        
        x=tail
        
        for i in range(1,len(lst2)):
            x.next=ListNode(lst2[i])
            
            x=x.next
        
        return tail

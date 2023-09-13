# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def hasCycle(self, head):
      if not head.next:
        return False
      
      l = head
      r = head

      while r:
        r = r.next
        if not r.next:
          return -1
        else:
          r = r.next

        l = l.next

        if r == l:
          C = 1
          r = r.next
          while r != l:
            r = r.next
            C += 1
          l = head
          r = head
          N = 0
          for _ in range(C):
            r = r.next
          while l != r:
            l = l.next
            r = r.next
            N += 1
          return N
          
      return -1


  
s = Solution()

        

class ListNode:
  def __init__(self, x):
    self.val = x
    self.next = None

a = ListNode(3)
b = ListNode(2)
c = ListNode(0)
d = ListNode(-4)

a.next = b
b.next = c
c.next = d
d.next = b
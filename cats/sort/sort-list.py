# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def sortList(self, head):
      if not head or not head.next:
        return head

      n = float("inf")

      while n > 0:
        node = head
        i = 0
        while node and i < n:
          if node.next:
            i += 1
            if node.val > node.next.val:
              nxt = ListNode(node.val)
              nxt.next = node.next.next
              node.val, node.next = node.next.val, nxt
          node = node.next
        n = i - 1
      
      return head

s = Solution()

def print_list(head):
  while head:
    print(head.val)
    head = head.next
  

class ListNode:
  def __init__(self, x):
    self.val = x
    self.next = None

a = ListNode(4)
b = ListNode(2)
c = ListNode(1)
d = ListNode(3)
e = ListNode(100)
f = ListNode(-10)
g = ListNode(12)

a.next = b
b.next = c
c.next = d
d.next = e
e.next = f
f.next = g
class Solution:
    def do(self, n):
      n = str(n)
      n = [int(n[i]) for i in range(len(n))]
      return sum([x ** 2 for x in n])

    def isHappy(self, n):
      seen = set([n])
      while True:
        d = self.do(n)
        if d == 1:
          return True
        elif d in seen:
          return False
        else:
          seen.add(d)
          n = d

s = Solution()
        
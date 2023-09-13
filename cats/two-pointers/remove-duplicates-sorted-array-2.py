class Solution:
    def removeDuplicates(self, nums):
      l = 0
      r = 0
      n = 0
      c = None
      on = None
      while r < len(nums):
        if on == nums[r]:
          c += 1
        else:
          on = nums[r]
          c = 1
        if c <= 2:
          nums[l] = nums[r]
          l += 1
          n += 1
        r += 1
      return n

s = Solution()
        






x = [0,0,1,1,1,1,2,3,3]
x = [1,1,1,2,2,3]
    [1,1

x = [1,1,1,2,2,3]

s.removeDuplicates(x)
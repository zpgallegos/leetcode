from collections import deque


class Solution:
    """brute, works but times out"""
    def maxSlidingWindow(self, nums, k):
        if not nums:
            return []
        
        left, right = 0, k
        out = []
        while right <= len(nums):
            out.append(max(nums[left:right]))
            left += 1
            right += 1
        
        return out


from collections import deque


class Solution:
    def maxSlidingWindow(self, nums, k):
        if not nums:
            return []
        
        out = []
        d, idx = deque(), deque()
        for i, num in enumerate(nums):
            if idx and i - k >= idx[0]: # current max fell out of window
                d.popleft()
                idx.popleft()
            
            # maintain deque in descending order
            # next value to return is therefore always d[0]
            # lesser values are popped because once a higher value is encountered
            # to the right of it, it will no longer be needed as part of the output
            while d and num >= d[-1]:
                d.pop()
                idx.pop()
            d.append(num)
            idx.append(i)

            if i >= k - 1: # beginning of viable windows
                out.append(d[0])
        
        return out
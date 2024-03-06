class Solution:
    def lengthOfLongestSubstring(self, s):
        n = len(s)
        if n <= 1:
            return n

        out = 1
        sub = s[0]
        r = 1
        while r < n:
            char = s[r]
            sub = sub[sub.find(char) + 1:]

            sub = sub + char
            if len(sub) > out:
                out = len(sub)
            
            r += 1
        
        return out

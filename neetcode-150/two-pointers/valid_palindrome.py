# https://leetcode.com/problems/valid-palindrome/


class Solution:
    @staticmethod
    def preprocess(s: str):
        return "".join([c for c in s.lower() if c.isalnum()])

    def isPalindrome(self, s: str) -> bool:
        s = self.preprocess(s)

        i = 0
        j = len(s) - 1

        while i < j:
            if s[i] != s[j]:
                return False
            i += 1
            j -= 1
        
        return True
    

if __name__ == "__main__":
    

    s = "A man, a plan, a canal: Panama"

    Solution().isPalindrome(s)

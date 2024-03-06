

class Solution:
    def isValid(self, s):
        _map = {
            ")": "(",
            "]": "[",
            "}": "{",
        }

        opens = []
        for char in s:
            if char in _map:
                if not opens or not _map[char] == opens.pop():
                    return False
            else:
                opens.append(char)
        
        return True if not opens else False
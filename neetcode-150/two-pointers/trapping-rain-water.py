# https://leetcode.com/problems/trapping-rain-water/description/


class Solution:
    """works, but times out on the final adversarial testcases"""

    @staticmethod
    def volume(left, right, level, heights):
        w = right - left - 1
        h = min(heights[left], heights[right])
        mid = heights[left + 1 : right]
        disp = sum([max(level, min(k, h)) for k in mid])
        return w * h - disp

    def trap(self, height):
        if len(height) < 3:
            return 0

        n = len(height)

        out = 0
        level = 0
        for left in range(n - 2):
            if height[left] <= level:
                continue

            for right in range(n - 1, left + 1, -1):
                if height[right] > level:
                    vol = self.volume(left, right, level, height)
                    out += vol
                    level = min(height[left], height[right])
                    if level == height[left]:
                        break
            else:
                return out

        return out


class Solution:
    """passes"""

    def trap(self, height):
        n = len(height)
        if n < 3:
            return 0
        
        max_right = 0
        max_rights = []
        for i in range(n - 1, -1, -1):
            h = height[i]
            max_rights.append(max_right)
            if h > max_right:
                max_right = h
        max_rights = max_rights[::-1]

        out = 0
        max_left = 0
        for i, h in enumerate(height):
            out += max(0, min(max_left, max_rights[i]) - h)
            if h > max_left:
                max_left = h
        
        return out


if __name__ == "__main__":
    height = [4, 2, 3]  # 1
    height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]  # 6
    height = [4, 2, 0, 3, 2, 5]  # 9
    height = [5, 5, 1, 7, 1, 1, 5, 2, 7, 6]  # 23, 4+6+6+2+5
    
    height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
    Solution().trap(height)

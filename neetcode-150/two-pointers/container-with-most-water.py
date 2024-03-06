# https://leetcode.com/problems/container-with-most-water/


class Solution:
    @staticmethod
    def get_volume(left, right, heights):
        width = right - left
        height = min(heights[left], heights[right])
        return width * height

    def maxArea(self, height):
        left = 0
        right = len(height) - 1

        out = 0
        while left < right:
            vol = self.get_volume(left, right, height)
            if vol > out:
                out = vol

            if height[left] < height[right]:
                left += 1
            else:
                right -= 1

        return out


if __name__ == "__main__":
    height = [1, 8, 6, 2, 5, 4, 8, 3, 7]
    Solution().maxArea(height)

# https://leetcode.com/problems/longest-consecutive-sequence/


class Solution:
    def longestConsecutive(self, nums):
        s = set(nums)

        out = 0
        for num in s:
            if (num + 1) in s:
                continue

            i = 1
            while (num - 1) in s:
                i += 1
                num -= 1
            out = max(out, i)

        return out


if __name__ == "__main__":
    nums = [100, 4, 200, 1, 3, 2]

    s = set(nums)

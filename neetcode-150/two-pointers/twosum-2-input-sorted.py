# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/


class Solution:
    def twoSum(self, numbers, target):
        l = 0
        r = len(numbers) - 1

        while True:
            sm = numbers[l] + numbers[r]
            if sm == target:
                return [l + 1, r + 1]
            elif sm < target:
                l += 1
            else:
                r -= 1
        

if __name__ == "__main__":

    Solution().twoSum([2, 7, 11, 15], 9)


        
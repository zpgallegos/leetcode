// https://leetcode.com/problems/jump-game/

// top-down
var canJump = function(nums) {
  const end = nums.length - 1;
  const memo = [...Array(nums.length).keys()].map(_ => 0);
  memo[end] = true;

  const canJumpFromPosition = (position, nums) => {
    if(memo[position] !== 0) return memo[position];
  
    const furthestJump = Math.min(position + nums[position], end);
    for(let i = furthestJump; i > position; --i) {
      if(canJumpFromPosition(i, nums)) {
        memo[i] = true;
        return true;
      }
    }
    memo[position] = false;
    return false;
  }

  return canJumpFromPosition(0, nums);
};

canJump([1,2,2])
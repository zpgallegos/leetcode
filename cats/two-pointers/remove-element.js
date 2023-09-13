/**
 * @param {number[]} nums
 * @param {number} val
 * @return {number}
 */

var removeElement = function(nums, val) {
  let p1 = 0;
  for(let p2 in nums) {
    if(nums[p2] !== val) {
      nums[p1] = nums[p2];
      p1++;
    }
  }
  return p1;
};
/**
 * @param {number[]} nums
 * @return {void} Do not return anything, modify nums in-place instead.
 */
var sortColors = function(nums) {
  let p1 = 0;
  let p2 = nums.length;
  while(p1 < p2) {
    if(nums[p1] === 0) {
      nums.splice(p1, 1);
      nums.unshift(0);
      p1++;
    }
    else if(nums[p1] === 2) {
      nums.splice(p1, 1);
      nums.push(2);
      p2--;
    } else {
      p1++;
    }
  }
};

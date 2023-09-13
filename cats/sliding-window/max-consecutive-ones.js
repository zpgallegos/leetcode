/**
 * @param {number[]} nums
 * @return {number}
 */
var findMaxConsecutiveOnes = function(nums) {
  let inSeq = false;
  let maxSeq = 0;
  let seq = 0;
  for(let i in nums) {
    inSeq = nums[i] === 1;
    if(inSeq) seq++;
    else seq = 0;
    if(seq > maxSeq) maxSeq = seq;
  }
  return maxSeq;
};
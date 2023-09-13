/**
 * @param {number[]} nums1
 * @param {number} m
 * @param {number[]} nums2
 * @param {number} n
 * @return {void} Do not return anything, modify nums1 in-place instead.
 */
var merge = function(nums1, m, nums2, n) {
  let j = m + n - 1;
  let i = m - 1;
  let k = n - 1;

  while(j >= 0) {
    if(k < 0) {
      nums1[j] = nums1[i];
      i--;
    } else if(i < 0) {
      nums1[j] = nums2[k];
      k--;
    } else {
      if(nums2[k] > nums1[i]) {
        nums1[j] = nums2[k];
        k--;
      } else {
        nums1[j] = nums1[i];
        i--;
      }
    }
      j--;
  }
};
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[][]}
 */
var fourSum = function(nums, target) {
    nums.sort((a, b) => a < b ? -1 : 1);
    let p1 = 0;
    let p2 = 1;
    let p3 = 2;
    let p4 = 3;
    let sum;

    for(let p1 = 0; p1 < p2; p1++) {
      for(let p2 = 1; p2 < p3; p2++) {
        for(let p3 = 2; p3 < p4; p3++) {
          for(let p4 = 3; p4 < nums.length; p4++) {
            console.log(p1, p2, p3, p4);
            sum = nums[p1] + nums[p2] + nums[p3] + nums[p4];
            // console.log(`${[nums[p1], nums[p2], nums[p3], nums[p4]]}, ${sum}`);
          }
          console.log(p1, p2, p3, p4);
          sum = nums[p1] + nums[p2] + nums[p3] + nums[p4];
          // console.log(`${[nums[p1], nums[p2], nums[p3], nums[p4]]}, ${sum}`);
        }
        console.log(p1, p2, p3, p4);
        sum = nums[p1] + nums[p2] + nums[p3] + nums[p4];
        // console.log(`${[nums[p1], nums[p2], nums[p3], nums[p4]]}, ${sum}`);
      }
      console.log(p1, p2, p3, p4);
      sum = nums[p1] + nums[p2] + nums[p3] + nums[p4];
      // console.log(`${[nums[p1], nums[p2], nums[p3], nums[p4]]}, ${sum}`);
    }
};
// https://leetcode.com/problems/container-with-most-water/

const area = ([i1, a1], [i2, a2]) => {
  const length = Math.abs(i2 - i1);
  const height = Math.min(a1, a2);
  return length * height;
}

// brute force
var maxArea = function(height) {
  let max = 0;
  for(let i = 0; i < height.length - 1; i++) {
    for(let j = i + 1; j < height.length; j++) {
      let a = area([i, height[i]], [j, height[j]]);
      if(a > max) {
        max = a;
      }
    }
  }
  return max;
};

// smarter way
// start with pointers at opposite ends of the array
// this way you remove one variable from the equation because you know for all combinations you
// try next, width will be monotonically decreasing
// so given two current bars, the only way you can try to increase the area is by picking a bar
// with a height that produces more area. you're always limited by the smaller by, so if you move
// the larger bar, you change nothing. so move the smaller bar

var maxArea = function(height) {
  let max = 0;
  let i = 0;
  let j = height.length - 1;
  while(i < j) {
    const a = area([i, height[i]], [j, height[j]]);
    if(a > max) max = a;
    if(height[i] < height[j]) i++;
    else j--;
  }
  return max;
}

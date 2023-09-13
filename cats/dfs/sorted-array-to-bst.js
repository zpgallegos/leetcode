/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {number[]} nums
 * @return {TreeNode}
 */

class TreeNode {
  constructor(val) {
    this.val = val;
    this.left = this.right = null;
  }
}

const makeNode = arr => {
  if(!arr.length) return null;

  const mid = Math.floor(arr.length / 2);
  const node = new TreeNode(arr[mid]);

  const toLeft = arr.slice(0, mid);
  const toRight = arr.slice(mid + 1);
  node.left = makeNode(toLeft);
  node.right = makeNode(toRight);

  return node;
}

var sortedArrayToBST = function(nums) {
  return makeNode(nums)
};

const a = sortedArrayToBST([-10,-3,0,5,9]);